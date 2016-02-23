From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 07/25] upload-pack: use skip_prefix() instead of starts_with()
Date: Tue, 23 Feb 2016 20:44:45 +0700
Message-ID: <1456235103-26317-8-git-send-email-pclouds@gmail.com>
References: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 14:47:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYDJ0-0001Fa-MQ
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 14:47:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382AbcBWNrE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 08:47:04 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34986 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589AbcBWNpc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 08:45:32 -0500
Received: by mail-pf0-f174.google.com with SMTP id c10so116381196pfc.2
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 05:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=nVsmptvx7zps22DtUpoAUXOvsnQB7CPDtbuX3/Ss2aI=;
        b=TdQwHChi4ScfvKvxPpNWiPwkFVYRCvlm+xeJkBH2rVyCz0o0vST1UiBezYM3KXkKaU
         M0hdzlcSHBHQ30iyi22AyjVkOoGOpsASPwZ/+xN9Hmk5B2VdnKN2vZ8NyHt+2odfXi6F
         43mjP+dGg60zAxg7+cPx2t4fO+4yHR91jQ0c7NGObO/NZ8r7wxeql2u/HLL0Gb+yS3tM
         7NXwNxBi/DALYndaqwQMPkO3nMJsvYR5pKW+GcnylUz6JmBGdbq+ty7RuAJNb210ySzb
         0P9rleWcQSoxvJ4fwHgoqSLSO/IKdvgLGwK3nqh2QkdnXMxdm0fUaUI+uAKQsHyKRhYq
         SSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=nVsmptvx7zps22DtUpoAUXOvsnQB7CPDtbuX3/Ss2aI=;
        b=bQOIQRi2ki2tZuiB74iCw6xExEEC1mxamfJsAOFMHAhVTw8XVnY/vR4FtIHTWzG3Yx
         nwmBQbqHN5XqTUzCZzlSPtf35tkMDK7V4lPem+VFywRvitm4T8VAntQiOHHGv6uCv0gn
         eOc3DHzUDvWQs8qjN5myJNgeAxA3XcOVIsF6XFi60dPOu4vyk+vnWdXJfI9CowD2+iAQ
         jY/M1E+5V0qNfHBY7UllBnt9qX+wRlKd6grPacMjeEV/61NQz7Y/tADLkU6uRsHq1APG
         eXyseCWiv+iNT3IivnuwyRfhB8Y4ISXxdUCjIdA03OHU2hfwp+Kk3XD4/gGee1zkGe/P
         pixw==
X-Gm-Message-State: AG10YOTESc27rF8tpllfAJ8wugDSViRAlRITtzmx366Chl0L8XeMA/BV5aUzD5EYy+1fXw==
X-Received: by 10.98.64.132 with SMTP id f4mr45864260pfd.159.1456235131821;
        Tue, 23 Feb 2016 05:45:31 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id fk9sm5029355pad.9.2016.02.23.05.45.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2016 05:45:30 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 23 Feb 2016 20:46:00 +0700
X-Mailer: git-send-email 2.7.1.532.gd9e3aaa
In-Reply-To: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287071>

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
2.7.1.532.gd9e3aaa
