From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 5/9] Clear CE_NO_CHECKOUT on checked out entries.
Date: Fri, 15 Aug 2008 21:26:18 +0700
Message-ID: <20080815142618.GA10721@laptop>
References: <cover.1218807249.git.pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 15 16:27:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU0HE-0005Vq-5O
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 16:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755305AbYHOO0e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Aug 2008 10:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755255AbYHOO0d
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 10:26:33 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:38471 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755154AbYHOO0c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 10:26:32 -0400
Received: by wa-out-1112.google.com with SMTP id j37so532517waf.23
        for <git@vger.kernel.org>; Fri, 15 Aug 2008 07:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=BhFs2B+a5owvBBAM+EktjSmjc7xwrAIgNzFlfSgkDo0=;
        b=lp9nRX29GXJ7CYBr9LviwhmCFB8rvl4VErv0bY7vQrAAJZWHAWfWLz6kU43FYxS48C
         lO6McGbHhgex8672LkXvj6Ycw1dgLD8Wlwcdbsc3sh3uGoaCpoMVYunqU7z+WIQ48w9k
         g43Y3P6j7oV+S+PBpjrJtNLkL5L0YuOU/YsnA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=SPpxO9ftxv771sa8ARP/k4OYpiQBUcrDz07BQSoobH415gVguFBIA59aohFtBuiBkG
         jgCDeIiC9jl7cqjoS++3D8NBz0n0wxG93xq8twqNPf4cvtTR4jr//kcCsXWC/Vq8NG+H
         kvn68DY+Q6uzThPyFwtP3jyWM2dMtog7muVcE=
Received: by 10.115.110.1 with SMTP id n1mr2555027wam.66.1218810392331;
        Fri, 15 Aug 2008 07:26:32 -0700 (PDT)
Received: from pclouds@gmail.com ( [125.234.152.212])
        by mx.google.com with ESMTPS id m29sm356949poh.4.2008.08.15.07.26.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Aug 2008 07:26:31 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 15 Aug 2008 21:26:18 +0700
Content-Disposition: inline
In-Reply-To: <cover.1218807249.git.pclouds@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92477>

With this you can just do "git checkout some-files" to
widen your checkout. On caveat though: caller must save
the index.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 entry.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/entry.c b/entry.c
index 222aaa3..c1c01f4 100644
--- a/entry.c
+++ b/entry.c
@@ -230,5 +230,6 @@ int checkout_entry(struct cache_entry *ce, const st=
ruct checkout *state, char *t
 	} else if (state->not_new)
 		return 0;
 	create_directories(path, state);
+	ce_mark_checkout(ce);
 	return write_entry(ce, path, state, 0);
 }
--=20
1.6.0.rc3.250.g8dd0
