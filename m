From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 08/25] upload-pack: use skip_prefix() instead of starts_with() when possible
Date: Thu,  4 Feb 2016 16:03:44 +0700
Message-ID: <1454576641-29615-9-git-send-email-pclouds@gmail.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 10:05:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRFqo-00063F-Q7
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 10:05:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965435AbcBDJFB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 04:05:01 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34917 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965407AbcBDJE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 04:04:59 -0500
Received: by mail-pf0-f169.google.com with SMTP id 65so38477077pfd.2
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 01:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=xajGSUpA0OvHgM6T4RttXbn7CZDFEJmdH8AlxgzbZ4g=;
        b=DcqmGCZwD2Xi92KtfOWLCiaE0Rrgt3y34BD9vQhh5+jmYNaWSsDvXJFnwwuxBy78mg
         hNPYtlRqz+ldgXZr2LTvvxVTSI4hukDkt/wqtKFycvomG/TNbWv1oykZxPIeURZLW+dk
         r5oKFN3xtiO88z18BX/Pb+cO3LpPUb5BgdRNX1W/hkCGbO4sR0r5sa1kLlsMDpL89WwI
         PmVbpgb/qBYe7wA+GUypvNoWGDZfIVVwaYfGerqunymDCIDsM9Vlm/GIsDGxYU95bwv5
         YELoXW0+PIK/8dLnni9iQylW+Vi0eMU8VbxdtbhxBIKFb+fJt4I9BRTJ3vKtsn+S4Ako
         r2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=xajGSUpA0OvHgM6T4RttXbn7CZDFEJmdH8AlxgzbZ4g=;
        b=errV+sIwAkQWbMAFf9zMT7lsl00M3l6X4qjYgW0urQuzqFNdUl4wTkfD6jVWl0+1y4
         bwNk58xF7O8DUubyP33RNBEyIS/7hcdog4aouKRdTu9t7JTxXvDR+A01ReYcJ8P3uYO5
         LWLZvQfiu54oBF4N35zW6RcGSBrI/IX6ZDJzAtO1wn81aRCD5e6AvikeUi32XrlXBFzt
         eE5XWTPuOPXYeQFXjoXyL9bST+IYKuTB/rLdxEvxN/romFNBjdCIHaEOZuDU0wdKuH8B
         5/hqZI4DDdqHHgW3jcHxXSAlEFxV/HDoP6MnV+uWRK2Jn7ehVgh3CIaTMnHy9WZLDYxl
         aaMg==
X-Gm-Message-State: AG10YOQ4KN7FEUeW/1NrwM22/mb38KPmyCRBgOXQC8N89Ud4YyicSq+KT90DPVw9eezhXg==
X-Received: by 10.98.93.27 with SMTP id r27mr9181216pfb.57.1454576698644;
        Thu, 04 Feb 2016 01:04:58 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id 6sm15360955pfo.58.2016.02.04.01.04.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2016 01:04:57 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 04 Feb 2016 16:05:11 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285422>

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
2.7.0.377.g4cd97dd
