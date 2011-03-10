From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/5] match_pathspec_depth: support negative pathspec
Date: Thu, 10 Mar 2011 10:13:36 +0700
Message-ID: <1299726819-5576-3-git-send-email-pclouds@gmail.com>
References: <1299726819-5576-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 10 04:15:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxWLJ-0008P2-9E
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 04:15:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662Ab1CJDPI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Mar 2011 22:15:08 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50979 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256Ab1CJDPH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 22:15:07 -0500
Received: by gyh20 with SMTP id 20so483757gyh.19
        for <git@vger.kernel.org>; Wed, 09 Mar 2011 19:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=T0mt7aprcwBQs5IaotTRxrtR3kEq+w3qgcxR9vpceSY=;
        b=RwK/ryYPJJB7Bo3g+luIwJmI5cWWvvnXdRvvrtqyeNuU4k6JB+O43X9DFvi780VeaX
         kLOUsu7+T8X57nFygZ0AgA7ItiD/clsEacUOTE75L6kGtqT22vGYSu6OaYjezvL+SQQh
         0ZZp2Wr1pspE/14zPRr1ou9r2eymtaqVViy2k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=bueQHkKNSAc0gpvd+02GjGWqp+2+MLBASbamUUXRLDRFGIk77Gjs/M7bHrKbIKjNOA
         ubAReygBmh6Ae15EO0rIXzN1HuB9fRdtcq/zf21yKLJnZZ1VsC13wsgwslJ958pmc5iA
         opoPHy5Sw1JuoDCsEXNPw2vh6ljUPoJ8HNIeA=
Received: by 10.100.17.10 with SMTP id 10mr3275323anq.21.1299726905435;
        Wed, 09 Mar 2011 19:15:05 -0800 (PST)
Received: from pclouds@gmail.com ([118.69.34.31])
        by mx.google.com with ESMTPS id i10sm3246728anh.32.2011.03.09.19.15.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2011 19:15:04 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 10 Mar 2011 10:14:02 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1299726819-5576-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168781>

The return value of this function is bugging me, as well as seen[]
array. Not really sure how to do with them when a negative pathspec is
matched.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/dir.c b/dir.c
index 168dad6..75c4a8f 100644
--- a/dir.c
+++ b/dir.c
@@ -279,6 +279,11 @@ int match_pathspec_depth(const struct pathspec *ps=
,
 				how =3D 0;
 		}
 		if (how) {
+			if (ps->items[i].to_exclude) {
+				if (seen && seen[i] < how)
+					seen[i] =3D how;
+				return 0;
+			}
 			if (retval < how)
 				retval =3D how;
 			if (seen && seen[i] < how)
--=20
1.7.3.1.256.g2539c.dirty
