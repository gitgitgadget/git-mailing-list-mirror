From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 17/19] grep: use match_pathspec_depth() for cache/worktree grepping
Date: Mon, 13 Dec 2010 16:46:54 +0700
Message-ID: <1292233616-27692-18-git-send-email-pclouds@gmail.com>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 13 10:50:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS52k-0005JJ-Tv
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 10:50:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800Ab0LMJuB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 04:50:01 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:35818 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289Ab0LMJuA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 04:50:00 -0500
Received: by pzk6 with SMTP id 6so479719pzk.19
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 01:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=yCXA0HUkyfbQp1iivfpB0xaGSl9i52HeMQyObKcb01c=;
        b=lrQPKaKx0f9zddrhj0JkSMioN/FD0aPlbILqrki/K8Ia90i8Y+odDewWy29Myfx3oV
         jBk2jCa7q/WLCYREFTDWLGVBNtNqrH/I8b8MdfMOQFZ2j9U0/xaXSUPp0mstg3IU1YpK
         iKtClkUa6ddz4ieT4zBN7/wZGhkZEXlLTW1gY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=lPCLb4MRP4xk+d4vE0M+s8l0Splb8fEDm/fpoAGx0LA7dY6M7LCuqEKIFsGHpBTmlH
         iinjuwalhnGjb8FXfNri9jTFY5+QzwRGuSX2Dv6EI/GaYocEH5N7QqYHKqIgrj6BjSor
         eB3+BU9Jzwy47rbY3aa0J7mjY/w1xfEENvu4E=
Received: by 10.142.170.19 with SMTP id s19mr3037269wfe.30.1292233800538;
        Mon, 13 Dec 2010 01:50:00 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.178])
        by mx.google.com with ESMTPS id f5sm8678178wfg.14.2010.12.13.01.49.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Dec 2010 01:49:59 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 13 Dec 2010 16:49:08 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163543>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/grep.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 4179af8..1646e15 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -595,7 +595,8 @@ static int grep_cache(struct grep_opt *opt, const s=
truct pathspec *pathspec, int
 		struct cache_entry *ce =3D active_cache[nr];
 		if (!S_ISREG(ce->ce_mode))
 			continue;
-		if (!pathspec_matches(pathspec->raw, ce->name, opt->max_depth))
+		if (!match_pathspec_depth(pathspec->raw, opt->max_depth,
+					  ce->name, ce_namelen(ce), 0, NULL))
 			continue;
 		/*
 		 * If CE_VALID is on, we assume worktree file and its cache entry
--=20
1.7.3.3.476.g10a82
