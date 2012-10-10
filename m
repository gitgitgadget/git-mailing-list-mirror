From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 12/12] t3070: disable two fnmatch tests that have different results on different libc
Date: Wed, 10 Oct 2012 17:40:51 +0700
Message-ID: <1349865651-31889-13-git-send-email-pclouds@gmail.com>
References: <1349865651-31889-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 10 12:42:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLtkC-0003BM-EM
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 12:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755755Ab2JJKmS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2012 06:42:18 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:49272 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755738Ab2JJKmP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 06:42:15 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so466174pad.19
        for <git@vger.kernel.org>; Wed, 10 Oct 2012 03:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9ZPv/ORxsJR/pI3nk2wCWhRzTw6eNU7VpcpDSfUZYQ0=;
        b=Tf/AZ21fZGBKNJwOZ4S1oR1aIo4OrcJb1krA9ZGjpy3Gnx4YS8v8XwNCOkMFdDWTjp
         ob3tSWlMJlOu760AVTnTrQNS5p2Zu7my68myukQ2tttQrf43DVbqDNnBGUmRCsFnBA+z
         Gx+oktNGG8ohwQpVOzC4pEWC8PxPcjlrNyvD/apBEkEGdwK6LxYXj6gg0QcTDy5qKQM1
         UmsWmMIKdNl6lGu7haLclNwTaSheoCwmnJhfYOmR8c2Vwfr0T8B5SmL8Obm/cqTWe2cE
         4mKzElm+MjTuNNAirSCpUrYidmAcxARkDsjNVoULnSa0NgXwdOp7qJexM8p07zSp82LQ
         zSFg==
Received: by 10.68.211.99 with SMTP id nb3mr73293553pbc.16.1349865735689;
        Wed, 10 Oct 2012 03:42:15 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.82])
        by mx.google.com with ESMTPS id it6sm851968pbc.14.2012.10.10.03.42.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 10 Oct 2012 03:42:15 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 10 Oct 2012 17:42:07 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
In-Reply-To: <1349865651-31889-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207397>

fnmatch on glibc-2.12.1 returns no match. glibc-2.15 returns ok.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t3070-wildmatch.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index f21da6c..38042eb 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -13,6 +13,8 @@ match() {
 	fi &&
 	if [ $2 =3D 1 ]; then
 	    test-wildmatch fnmatch '$3' '$4'
+	elif [ $2 =3D x ]; then
+	    true
 	else
 	    ! test-wildmatch fnmatch '$3' '$4'
 	fi
@@ -129,8 +131,8 @@ match 1 1 ']' '[\]]'
 match 0 0 '\]' '[\]]'
 match 0 0 '\' '[\]]'
 match 0 0 'ab' 'a[]b'
-match 0 1 'a[]b' 'a[]b'
-match 0 1 'ab[' 'ab['
+match 0 x 'a[]b' 'a[]b'
+match 0 x 'ab[' 'ab['
 match 0 0 'ab' '[!'
 match 0 0 'ab' '[-'
 match 1 1 '-' '[-]'
--=20
1.7.12.1.406.g6ab07c4
