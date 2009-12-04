From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v8 6/7] fast-import: allow for multiple --import-marks= arguments
Date: Fri,  4 Dec 2009 18:06:59 +0100
Message-ID: <1259946420-8845-7-git-send-email-srabbelier@gmail.com>
References: <1259946420-8845-1-git-send-email-srabbelier@gmail.com>
 <1259946420-8845-2-git-send-email-srabbelier@gmail.com>
 <1259946420-8845-3-git-send-email-srabbelier@gmail.com>
 <1259946420-8845-4-git-send-email-srabbelier@gmail.com>
 <1259946420-8845-5-git-send-email-srabbelier@gmail.com>
 <1259946420-8845-6-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	<vcs-fast-import-devs@l
X-From: git-owner@vger.kernel.org Fri Dec 04 18:15:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGbdG-000621-BL
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 18:07:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbZLDRHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 12:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbZLDRHa
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 12:07:30 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:50369 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932271AbZLDRHT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 12:07:19 -0500
Received: by mail-ew0-f219.google.com with SMTP id 19so3051335ewy.1
        for <git@vger.kernel.org>; Fri, 04 Dec 2009 09:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/Adh9GUkBiRCXqrsGr0mtltWqTDDfTYx2UYn655eDmY=;
        b=aUcra7Z8upYrXNLvXQ81eDyoCPm4HEWB04pgLLgV4e7oTrpHvnUIe9QehjvrJUAo/Z
         P/B/lpga6ijoAerZZdIZpHawwrFg6+kG2E1Zd5OVQm0CFeV6tJrZ6tAtyd5tYdfMBX4s
         /TuAucA7JiHC/+397uD9kjD7Ie701EWneCrCU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rogEt64rTH0Mp12XavCILBmPDXLNRWJNvtdXIflealHnHUTssCsUViL4xuXB2AhbxQ
         c1mvF99WIWa4wSPn/r21Eyj2viv/u52bS2Zbk8noxA5likTW9OOJOJfdWbJ0t10JajFD
         +PK/2xAZ8atg4y0xMLMaNq+US2V+Io7lYs87E=
Received: by 10.213.109.86 with SMTP id i22mr3504411ebp.20.1259946445281;
        Fri, 04 Dec 2009 09:07:25 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 16sm1980184ewy.14.2009.12.04.09.07.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Dec 2009 09:07:24 -0800 (PST)
X-Mailer: git-send-email 1.6.5.3.164.g07b0c
In-Reply-To: <1259946420-8845-6-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134547>

The --import-marks= option may be specified multiple times on the
commandline and should result in all marks being read in. Only one
import-marks feature may be specified in the stream, which is
overriden by any --import-marks= commandline options.

If one wishes to specify import-marks files in addition to the one
specified in the stream, it is easy to repeat the stream option as a
--import-marks= commandline option.

Also verify this behavior with tests.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	New in this series. Without this it is no longer possible to specify
	multiple --import-marks= options on the commandline.

 Documentation/git-fast-import.txt |    8 +++++++-
 fast-import.c                     |   21 ++++++++++++++++-----
 t/t9300-fast-import.sh            |   22 ++++++++++++++++++++++
 3 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 2d5f533..752f85c 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -867,7 +867,8 @@ it does not.
 The <feature> part of the command may be any string matching
 ^[a-zA-Z][a-zA-Z-]*$ and should be understood by fast-import.
 
-Feature work identical as their option counterparts.
+Feature work identical as their option counterparts with the
+exception of the import-marks feature, see below.
 
 The following features are currently supported:
 
@@ -876,6 +877,11 @@ The following features are currently supported:
 * export-marks
 * force
 
+The import-marks behaves differently from when it is specified as
+commandline option in that only one "feature import-marks" is allowed
+per stream. Also, any --import-marks= specified on the commandline
+will override those from the stream (if any).
+
 `option`
 ~~~~~~~~
 Processes the specified option so that git fast-import behaves in a
diff --git a/fast-import.c b/fast-import.c
index ab099b6..4c3406e 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -322,6 +322,7 @@ static struct object_entry *object_table[1 << 16];
 static struct mark_set *marks;
 static const char *export_marks_file;
 static const char *import_marks_file;
+static int import_marks_file_from_stream;
 
 /* Our last blob */
 static struct last_object last_blob = { STRBUF_INIT, 0, 0, 0 };
@@ -2469,9 +2470,19 @@ static void parse_progress(void)
 	skip_optional_lf();
 }
 
-static void option_import_marks(const char *marks)
+static void option_import_marks(const char *marks, int from_stream)
 {
+	if (import_marks_file) {
+		if (from_stream)
+			die("Only one import-marks command allowed per stream");
+
+		/* read previous mark file */
+		if(!import_marks_file_from_stream)
+			read_marks();
+	}
+
 	import_marks_file = xstrdup(marks);
+	import_marks_file_from_stream = from_stream;
 }
 
 static void option_date_format(const char *fmt)
@@ -2538,12 +2549,12 @@ static int parse_one_option(const char *option)
 	return 1;
 }
 
-static int parse_one_feature(const char *feature)
+static int parse_one_feature(const char *feature, int from_stream)
 {
 	if (!prefixcmp(feature, "date-format=")) {
 		option_date_format(feature + 12);
 	} else if (!prefixcmp(feature, "import-marks=")) {
-		option_import_marks(feature + 13);
+		option_import_marks(feature + 13, from_stream);
 	} else if (!prefixcmp(feature, "export-marks=")) {
 		option_export_marks(feature + 13);
 	} else if (!prefixcmp(feature, "force")) {
@@ -2562,7 +2573,7 @@ static void parse_feature(void)
 	if (seen_data_command)
 		die("Got feature command '%s' after data command", feature);
 
-	if (parse_one_feature(feature))
+	if (parse_one_feature(feature, 1))
 		return;
 
 	die("This version of fast-import does not support feature %s.", feature);
@@ -2618,7 +2629,7 @@ static void parse_argv(void)
 		if (parse_one_option(a + 2))
 			continue;
 
-		if (parse_one_feature(a + 2))
+		if (parse_one_feature(a + 2, 0))
 			continue;
 
 		die("unknown option %s", a);
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 74dff11..ba92775 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1286,6 +1286,15 @@ test_expect_success 'R: abort on receiving feature after data command' '
 '
 
 cat >input << EOF
+feature import-marks=git.marks
+feature import-marks=git2.marks
+EOF
+
+test_expect_success 'R: only one import-marks feature allowed per stream' '
+	test_must_fail git fast-import <input
+'
+
+cat >input << EOF
 feature export-marks=git.marks
 blob
 mark :1
@@ -1324,6 +1333,19 @@ test_expect_success \
     'cat input | git fast-import --import-marks=marks.out &&
     test_cmp marks.out marks.new'
 
+
+cat >input <<EOF
+feature import-marks=nonexistant.marks
+feature export-marks=combined.marks
+EOF
+
+test_expect_success 'R: multiple --import-marks= should be honoured' '
+    head -n2 marks.out > one.marks &&
+    tail -n +3 marks.out > two.marks &&
+    git fast-import --import-marks=one.marks --import-marks=two.marks <input &&
+    test_cmp marks.out combined.marks
+'
+
 cat >input << EOF
 option git quiet
 blob
-- 
1.6.5.3.164.g07b0c
