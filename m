From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 10/25] fetch-pack: use skip_prefix() instead of starts_with()
Date: Tue, 23 Feb 2016 20:44:48 +0700
Message-ID: <1456235103-26317-11-git-send-email-pclouds@gmail.com>
References: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 14:46:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYDHq-0000JV-7E
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 14:45:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752775AbcBWNpw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 08:45:52 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35936 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239AbcBWNpv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 08:45:51 -0500
Received: by mail-pf0-f181.google.com with SMTP id e127so112867440pfe.3
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 05:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=bptfn+yVvzgv2VhUwp2r9y60IYTiEDHDY8nNZUa9H1Q=;
        b=Sm3iVgTh6iG4o1SQTgz4bYtM0cl6M0s2eiKLlDsmzXIt9QWBbqGE+34x90dwMX548S
         UBnAucxNKaDyc2Y6Seb11DCecXYY+dUGqcK+5twZ0dr4waIuEQ8L8yGiGIrXrCcC1qJG
         omZUTOkXLjfsBVwhAB0Ymg/lyWo8rydrTRZ8Ffh9UdbaC9E74BCdPsxzENzJxXMzP3/U
         Nm526PFjdy3YELKN6I896ilWbSkrRCGnvpgfCYKUBPlJdoptGTNB4YbJlnlPBOnIdEtX
         UL8XFj2JX3BH5bnrRovT6hqZ4NVl+NqSBv1EOlQ4iI9olHfMx/9VNjrCbuTlZppUHpH4
         sXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=bptfn+yVvzgv2VhUwp2r9y60IYTiEDHDY8nNZUa9H1Q=;
        b=GboXYqID9gnfRIgrAMydGjHHHibj2qNQuyUQ2N8EfM16LjcvwwF3jfzXUY/5uoRrrQ
         avJUTm+B82MeoRhUqLifhqqCWd8K7eqUY39DlWs3CbCqlAvdB03CvRovW9o4GN5orsWj
         N8favUHEizElgr0OFSvPd22V5OUPypRqoJROdxndu1ZAe5yWRr1anyCA536ZrCMT3Ypu
         eBEnRCOmKLlZSz9PtJqUT5yHKM0RMmOpJ2LLZbpJHjl3sbTK49MmFke5a9hxFdW/rnLV
         /sJGqaVxdto4fusJbCqsXDC+ushrRhRLxKbzGXOlOs4cUnheBCRBDQxGJYJi2Ig9KaFF
         3LPw==
X-Gm-Message-State: AG10YOT6kuVEuXgQGKbZdFXsRsRtVmTSjGXaX5JgPPfrszD3Ltp5zh4UqADjiU9Jxi4rnA==
X-Received: by 10.98.15.19 with SMTP id x19mr46484985pfi.60.1456235150713;
        Tue, 23 Feb 2016 05:45:50 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id 3sm44408501pfn.59.2016.02.23.05.45.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2016 05:45:49 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 23 Feb 2016 20:46:18 +0700
X-Mailer: git-send-email 2.7.1.532.gd9e3aaa
In-Reply-To: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287060>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fetch-pack.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 9b2a514..8332d3d 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -59,12 +59,12 @@ int cmd_fetch_pack(int argc, const char **argv, con=
st char *prefix)
 	for (i =3D 1; i < argc && *argv[i] =3D=3D '-'; i++) {
 		const char *arg =3D argv[i];
=20
-		if (starts_with(arg, "--upload-pack=3D")) {
-			args.uploadpack =3D arg + 14;
+		if (skip_prefix(arg, "--upload-pack=3D", &arg)) {
+			args.uploadpack =3D arg;
 			continue;
 		}
-		if (starts_with(arg, "--exec=3D")) {
-			args.uploadpack =3D arg + 7;
+		if (skip_prefix(arg, "--exec=3D", &arg)) {
+			args.uploadpack =3D arg;
 			continue;
 		}
 		if (!strcmp("--quiet", arg) || !strcmp("-q", arg)) {
@@ -100,8 +100,8 @@ int cmd_fetch_pack(int argc, const char **argv, con=
st char *prefix)
 			args.verbose =3D 1;
 			continue;
 		}
-		if (starts_with(arg, "--depth=3D")) {
-			args.depth =3D strtol(arg + 8, NULL, 0);
+		if (skip_prefix(arg, "--depth=3D", &arg)) {
+			args.depth =3D strtol(arg, NULL, 0);
 			continue;
 		}
 		if (!strcmp("--no-progress", arg)) {
--=20
2.7.1.532.gd9e3aaa
