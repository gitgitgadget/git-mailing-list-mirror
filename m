From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/27] upload-pack: use skip_prefix() instead of starts_with()
Date: Fri, 10 Jun 2016 19:26:54 +0700
Message-ID: <20160610122714.3341-8-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 14:30:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBLY7-0000hK-2i
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 14:28:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932601AbcFJM20 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 08:28:26 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36325 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932150AbcFJM2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 08:28:25 -0400
Received: by mail-pa0-f65.google.com with SMTP id fg1so5021488pad.3
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 05:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0aLCA7NIr/rCKTa6gKloVI+XYDczQ0npmx0iKtDnD7U=;
        b=PPeM+FIb55HWimFRS4a7/UkQpfEqX2OO+USntuXCXpoPbiHEEEmibXn4V3UdqTFT6B
         FlalhmxWYoLbKz0Yr/OIUsRYNceJf+riebRUrpnMvpuowA7HHm/bC/H5V+rZvGTzvmMx
         rgVbOSTtj3PliXNjPyuhq7GpILUqNH44G8llMBJePLqrKIEJCli1g4kO7pL7Et6UQJX2
         yVaaEkvp1mVk6ZGQIf0mFdBNJHfnqqFBcxh8YvlfVDWQUkI4KoQFs8zzLNoFeUAq7q5O
         mq1QtZL/J6k0PoSKHYeU/ThoJDG+y8tsWPqNQ01TIyIbigugpbPuXIYeOmwvWvDT685L
         rWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0aLCA7NIr/rCKTa6gKloVI+XYDczQ0npmx0iKtDnD7U=;
        b=M/KSIl58zlb9cCiV/kyyDqfYlJaX6AusdTjcVqYLhj8Th5sZpQHBg+I4k5WXy4E/kQ
         flVgw0QJFlCYP4j/4fKuUFdJn2YvK3y0YYUuvKFU2hIxAzo2O7O3dKtRLFAB5xIa/xb7
         i4U8C69yFZ0ATQoD2b0VG75YSAoDyHgLCZpTqshj27jkpl3nWsTuxB30ucAK0nieWTrW
         5/vm2mfNp+sMMlDsLtH3hAXa1HN4tpAR/Wu4aycWKo0p/SVEAGC34sfC8Ec3cOSPG4y0
         8556plSPRBM2J/RrlkLIK0puVF/BxRIuZT2N/mAQT0ui8zhAjocEvc9CnakcCk6hVc8l
         edKw==
X-Gm-Message-State: ALyK8tKSXhtjFAsTSqT8Xeot5IvjRmsDInNWVPTcH0zKA20xqZmzEDcUo0TmDlaFvNjp8g==
X-Received: by 10.66.14.227 with SMTP id s3mr2128226pac.12.1465561705019;
        Fri, 10 Jun 2016 05:28:25 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id y205sm17580089pfb.13.2016.06.10.05.28.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jun 2016 05:28:24 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 10 Jun 2016 19:28:20 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160610122714.3341-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296984>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 upload-pack.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index bfb7985..615bfb2 100644
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
@@ -855,7 +859,7 @@ int main(int argc, char **argv)
 	check_replace_refs =3D 0;
=20
 	for (i =3D 1; i < argc; i++) {
-		char *arg =3D argv[i];
+		const char *arg =3D argv[i];
=20
 		if (arg[0] !=3D '-')
 			break;
@@ -871,8 +875,8 @@ int main(int argc, char **argv)
 			strict =3D 1;
 			continue;
 		}
-		if (starts_with(arg, "--timeout=3D")) {
-			timeout =3D atoi(arg+10);
+		if (skip_prefix(arg, "--timeout=3D", &arg)) {
+			timeout =3D atoi(arg);
 			daemon_mode =3D 1;
 			continue;
 		}
--=20
2.8.2.524.g6ff3d78
