From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 07/27] upload-pack: use skip_prefix() instead of starts_with()
Date: Sun, 12 Jun 2016 17:53:49 +0700
Message-ID: <20160612105409.22156-8-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
 <20160612105409.22156-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 12 12:55:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bC33A-0003Hu-RA
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jun 2016 12:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753223AbcFLKzW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jun 2016 06:55:22 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36349 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753045AbcFLKzV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2016 06:55:21 -0400
Received: by mail-pa0-f66.google.com with SMTP id fg1so8409470pad.3
        for <git@vger.kernel.org>; Sun, 12 Jun 2016 03:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1NMFX4twBtybHtVFmt8h9jAX+Z62IkXHpAfkvuQqErA=;
        b=PQNKxZniXdYF3/546d3QiHSMAA4CJRrhfIBul4Vpxwlxb2w7S+UjFQMfY5wQjuo0xj
         ecbdOv9SrNBLL2a0nt2BZb0XGu2/WhAPi2CypD5dUIH6Lz7S1axZkIiSSDxiLTJMbQ7M
         spniM5KK9kdwmAKxROPXcHMhGBHwqCu2ayDWNQdN3plXNgljAf0SKL56pOV5wuMvxpcc
         B56KmN01ywXUelTKMYfbyi7057qSmD5rciV2lWggOPXyQmSqP4O4OcFxuaSqVxmMBuVt
         bSSqIgrVo+gEbkBsfKhEPTpD4iOyTJkfj3+WF6O1rhlHU53HajQBQPWRCwX8l2e9DjU7
         HbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1NMFX4twBtybHtVFmt8h9jAX+Z62IkXHpAfkvuQqErA=;
        b=cjUpLxKWJjRoqO4AALLX3c/rCJ1xMWhWFDH6TDgAdR3l7dM4Z8ZxtyiaqtkT4GCjTY
         Zzu9Y9iIFLAaUwLaq94a3vXI90TUESdsdo6D7dtVF9Sxo+kz5VxwuQ0M9J+wGJpHg9gh
         LTeP5NJl63NztJBeczLUp67Ej9D9eZIJ93gRdoYB3ElBuDSfQFKI1lo842oofnB4AUA/
         EwQtHjzZP2oIZFG85eJuU7gAwFSzKIUY8AGYyfHSoFxm3CR4I3wVIxxxkc833bHFD7nm
         C8q9R/6b1E53bsttY4aBd2IY0irbmhPBEkvfmzGBzx95CmJsdv6xXViXsJ7g+SJPduF+
         zssA==
X-Gm-Message-State: ALyK8tIiCnhtNdXIN9t2gakEOFm4cJfQj7UO5rJznQP5TofP7UQpCMKiQCxKb0HglM1g9A==
X-Received: by 10.66.142.199 with SMTP id ry7mr14737997pab.14.1465728920310;
        Sun, 12 Jun 2016 03:55:20 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id 81sm8763525pfo.74.2016.06.12.03.55.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2016 03:55:19 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 12 Jun 2016 17:55:15 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160612105409.22156-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297114>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 upload-pack.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 73a8b28..fa7ce09 100644
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
@@ -620,14 +622,16 @@ static void receive_needs(void)
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
@@ -640,19 +644,19 @@ static void receive_needs(void)
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
@@ -859,7 +863,7 @@ int main(int argc, char **argv)
 	check_replace_refs =3D 0;
=20
 	for (i =3D 1; i < argc; i++) {
-		char *arg =3D argv[i];
+		const char *arg =3D argv[i];
=20
 		if (arg[0] !=3D '-')
 			break;
@@ -875,8 +879,8 @@ int main(int argc, char **argv)
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
