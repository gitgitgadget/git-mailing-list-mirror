From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 17/21] grep: use match_pathspec_depth() for cache/worktree grepping
Date: Wed, 15 Dec 2010 22:02:52 +0700
Message-ID: <1292425376-14550-18-git-send-email-pclouds@gmail.com>
References: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 16:06:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSsvo-0001Nt-I6
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 16:06:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754811Ab0LOPGH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Dec 2010 10:06:07 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:48972 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754717Ab0LOPGE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 10:06:04 -0500
Received: by mail-gy0-f174.google.com with SMTP id 11so1071230gyb.19
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 07:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=EnTph+BsE/R5ViUCyAScod97b2W7th4WXSrBoRzCH0g=;
        b=MKOfA/okmaVks48jLjUDdL4Y0RcYhbnzjfjLGbIrnt55jERuX7bf7FUCP7n1eRuucx
         VFuFgPsEK/8qV3vKf4FvzdsprNOpSJPtW9M8/uRd0YsivKZVKrvy7HH64m0DnsxHjRUR
         S4cXYo+GKrSia+lxlhKib6SEfvS9Q9bWZ/PPI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=rNR40K+ZJU7xk6EPQZobvSuRiXByU+HrqbhYG8rAliHvtVg/C1fx2bxoLo9Pzu45rp
         uxa//3WkM/CXSG+yWEx3EYyjUQwmNngT1N9oTis8s7h74KJF/BXzNIAqsLzRuYA6U4KC
         lCsP/BIxs1MAuYFDVKbfshWDFAfdjOKIYzVFw=
Received: by 10.42.167.136 with SMTP id s8mr6026570icy.8.1292425564123;
        Wed, 15 Dec 2010 07:06:04 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.209.213])
        by mx.google.com with ESMTPS id he5sm850567icb.10.2010.12.15.07.06.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Dec 2010 07:06:03 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 15 Dec 2010 22:05:11 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163771>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/grep.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 4179af8..fbc7d02 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -595,7 +595,7 @@ static int grep_cache(struct grep_opt *opt, const s=
truct pathspec *pathspec, int
 		struct cache_entry *ce =3D active_cache[nr];
 		if (!S_ISREG(ce->ce_mode))
 			continue;
-		if (!pathspec_matches(pathspec->raw, ce->name, opt->max_depth))
+		if (!match_pathspec_depth(pathspec, ce->name, ce_namelen(ce), 0, NUL=
L))
 			continue;
 		/*
 		 * If CE_VALID is on, we assume worktree file and its cache entry
--=20
1.7.3.3.476.g10a82
