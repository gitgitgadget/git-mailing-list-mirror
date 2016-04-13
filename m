From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/26] upload-pack: use skip_prefix() instead of starts_with()
Date: Wed, 13 Apr 2016 19:54:51 +0700
Message-ID: <1460552110-5554-8-git-send-email-pclouds@gmail.com>
References: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 14:55:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKKr-00046X-G3
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 14:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030656AbcDMMzt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 08:55:49 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34162 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030495AbcDMMzr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 08:55:47 -0400
Received: by mail-pf0-f196.google.com with SMTP id d184so4063458pfc.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 05:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9LwZ898pBoiCj1IM39I2yk0zB1jn6dRDFvgR9Og0mvc=;
        b=Buxgp5KBEIqUjozTeoAWwcREm9/AaBgbLx9+aYqMYerKkINs/jtkSa6xYAIBhLOzl6
         22Xih8pw2OH/ZsFCjueZt+GlQc3+tlHB1g7vdalKTQ3t46ficUFHJwSgt84frZurYtMC
         UW0P4TwLGbRuxvf38ZZskQA5PjhRIzfP+Ub+noELV5VTdsJKWD627I+vnr14AJwNwhEu
         x6+Nouz79pay3xrEqfZetRgH+i7D0AHGGj0RJQ8JnckN4RB5cvW8EVZqX5QUMDaRalLt
         K5ZhuS8J2l3BIwGAi/TLVVV2S2UxJa4p1BTE/oFpiTvSwKPa7hC2vW5Uwr1FRuGwMntB
         ANBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9LwZ898pBoiCj1IM39I2yk0zB1jn6dRDFvgR9Og0mvc=;
        b=B2260KOnYu1hEgJzzSUL2OcGcxeRCnemqNeDGBDAQ9U2wI8iOywusX2TjR0cv4m9Ig
         digWU8KlaEaZ3bYupeXrXTH2Zz3EFJ06tHdTeLdd4XL8UQRRN/y23bCOddhooIWLUP5y
         VpeTyU7O/NkTqzwUvi3fwNAEN1o4z7SPHR4eJHK7HZgHXgrcrKJypqMsPrXLU9ZjSyya
         SwB9c86QTbM2QjzF8O8KRDl0Bdv4Ox2EfptxQOxzqLoqmPDJNPlqjwnjQyn/p7FFvkuB
         TcJ7N1qU2cdBvVhCWQm7vNTDlvCjWUrA0tHV+bb0RnK2CcST7V8N8CsUv5R8lO7ztV8t
         dRZw==
X-Gm-Message-State: AOPr4FW4o/LfLK/mkki2wz0x84PaCb+TroNBS8Y4lshKgJAZFD6rXIxREmpBT9GpfOY5JA==
X-Received: by 10.98.102.15 with SMTP id a15mr7296506pfc.90.1460552146494;
        Wed, 13 Apr 2016 05:55:46 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id m10sm51042052pfi.32.2016.04.13.05.55.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 05:55:45 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 19:55:52 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291400>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 upload-pack.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index bfb7985..257ad48 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -276,7 +276,7 @@ static void create_pack_file(void)
 	die("git upload-pack: %s", abort_msg);
 }
=20
-static int got_sha1(char *hex, unsigned char *sha1)
+static int got_sha1(const char *hex, unsigned char *sha1)
 {
 	struct object *o;
 	int we_knew_they_have =3D 0;
@@ -382,6 +382,8 @@ static int get_common_commits(void)
=20
 	for (;;) {
 		char *line =3D packet_read_line(0, NULL);
+		const char *arg;
+
 		reset_timeout();
=20
 		if (!line) {
@@ -403,8 +405,8 @@ static int get_common_commits(void)
 			got_other =3D 0;
 			continue;
 		}
-		if (starts_with(line, "have ")) {
-			switch (got_sha1(line+5, sha1)) {
+		if (skip_prefix(line, "have ", &arg)) {
+			switch (got_sha1(arg, sha1)) {
 			case -1: /* they have what we do not */
 				got_other =3D 1;
 				if (multi_ack && ok_to_give_up()) {
@@ -616,14 +618,16 @@ static void receive_needs(void)
 		const char *features;
 		unsigned char sha1_buf[20];
 		char *line =3D packet_read_line(0, NULL);
+		const char *arg;
+
 		reset_timeout();
 		if (!line)
 			break;
=20
-		if (starts_with(line, "shallow ")) {
+		if (skip_prefix(line, "shallow ", &arg)) {
 			unsigned char sha1[20];
 			struct object *object;
-			if (get_sha1_hex(line + 8, sha1))
+			if (get_sha1_hex(arg, sha1))
 				die("invalid shallow line: %s", line);
 			object =3D parse_object(sha1);
 			if (!object)
@@ -636,19 +640,19 @@ static void receive_needs(void)
 			}
 			continue;
 		}
-		if (starts_with(line, "deepen ")) {
+		if (skip_prefix(line, "deepen ", &arg)) {
 			char *end;
-			depth =3D strtol(line + 7, &end, 0);
-			if (end =3D=3D line + 7 || depth <=3D 0)
+			depth =3D strtol(arg, &end, 0);
+			if (end =3D=3D arg || depth <=3D 0)
 				die("Invalid deepen: %s", line);
 			continue;
 		}
-		if (!starts_with(line, "want ") ||
-		    get_sha1_hex(line+5, sha1_buf))
+		if (!skip_prefix(line, "want ", &arg) ||
+		    get_sha1_hex(arg, sha1_buf))
 			die("git upload-pack: protocol error, "
 			    "expected to get sha, not '%s'", line);
=20
-		features =3D line + 45;
+		features =3D arg + 40;
=20
 		if (parse_feature_request(features, "multi_ack_detailed"))
 			multi_ack =3D 2;
--=20
2.8.0.rc0.210.gd302cd2
