From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v8 7/7] fast-import: add (non-)relative-marks feature
Date: Fri,  4 Dec 2009 18:07:00 +0100
Message-ID: <1259946420-8845-8-git-send-email-srabbelier@gmail.com>
References: <1259946420-8845-1-git-send-email-srabbelier@gmail.com>
 <1259946420-8845-2-git-send-email-srabbelier@gmail.com>
 <1259946420-8845-3-git-send-email-srabbelier@gmail.com>
 <1259946420-8845-4-git-send-email-srabbelier@gmail.com>
 <1259946420-8845-5-git-send-email-srabbelier@gmail.com>
 <1259946420-8845-6-git-send-email-srabbelier@gmail.com>
 <1259946420-8845-7-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	<vcs-fast-import-devs@l
X-From: git-owner@vger.kernel.org Fri Dec 04 18:14:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGbdG-000621-Sh
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 18:07:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbZLDRHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 12:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbZLDRHf
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 12:07:35 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:58084 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932270AbZLDRHU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 12:07:20 -0500
Received: by mail-ew0-f219.google.com with SMTP id 19so3051396ewy.1
        for <git@vger.kernel.org>; Fri, 04 Dec 2009 09:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=1NUq7IrW1gHbcW4mwZbN59aH/jzXzVdo2haV/agL8k4=;
        b=SQyJOPy1z27c3hw92leagHo/TzrfXEpebLDbfdLfKzG+GVWQ3w8EwCdh/JKLnwN5bs
         vgcMHkiCB4D1VJ0+qs0I8+CYb4U6BM1gsdUzZhH3ZsY9T40oUc1R2zDdGQN56v+ayq5e
         goFCNwnhuEz9ihYj/XtPwew0D9RFwowIcE9vU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=M5d+Y9newoRdxc2t6FRtQFlsbnd9jcEaah1IrneSBmHdKnXDnlLQ9WL6azLfcMf1ZQ
         cALAyQc+YFXPPevbgfir0iuB2xKkWVF5On1yAG2roEV6MUgp87lvAJLb4IlCwdUMZTji
         QUDffb+OufeT616If5tWzMe7wtxYIDaXXBTGE=
Received: by 10.213.98.140 with SMTP id q12mr4761134ebn.1.1259946447225;
        Fri, 04 Dec 2009 09:07:27 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 16sm1980184ewy.14.2009.12.04.09.07.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Dec 2009 09:07:26 -0800 (PST)
X-Mailer: git-send-email 1.6.5.3.164.g07b0c
In-Reply-To: <1259946420-8845-7-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134541>

After specifying 'feature relative-marks' the paths specified with
'feature import-marks' and 'feature export-marks' are relative to an
internal directory in the current repository.

In git-fast-import this means that the paths are relative to the
'.git/info/fast-import' directory. However, other importers may use a
different location.

Add 'feature non-relative-marks' to disable this behavior, this way
it is possible to, for example, specify the import-marks location as
relative, and the export-marks location as non-relative.

Also add tests to verify this behavior.

Cc: Daniel Barkalow <barkalow@iabervon.org>
Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	As requested by Daniel, it is now possible to have the marks be
	relative to a constant directory. We might want to consider making
	this the default at some point.

	This patch opens the way for remote-helpers to use the marks feature
	without poluting the work tree, which I think is very important.

 Documentation/git-fast-import.txt |   16 ++++++++++++++++
 fast-import.c                     |   19 +++++++++++++++++--
 t/t9300-fast-import.sh            |   25 +++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 752f85c..1a63835 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -75,6 +75,20 @@ OPTIONS
 	set of marks.  If a mark is defined to different values,
 	the last file wins.
 
+--relative-marks::
+	After specifying --relative-marks= the paths specified
+	with --import-marks= and --export-marks= are relative
+	to an internal directory in the current repository.
+	In git-fast-import this means that the paths are relative
+	to the .git/info/fast-import directory. However, other
+	importers may use a different location.
+
+--no-relative-marks::
+	Negates a previous --relative-marks. Allows for combining
+	relative and non-relative marks by interweaving
+	--(no-)-relative-marks= with the --(import|export)-marks=
+	options.
+
 --export-pack-edges=<file>::
 	After creating a packfile, print a line of data to
 	<file> listing the filename of the packfile and the last
@@ -875,6 +889,8 @@ The following features are currently supported:
 * date-format
 * import-marks
 * export-marks
+* relative-marks
+* no-relative-marks
 * force
 
 The import-marks behaves differently from when it is specified as
diff --git a/fast-import.c b/fast-import.c
index 4c3406e..8d50a1e 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -323,6 +323,7 @@ static struct mark_set *marks;
 static const char *export_marks_file;
 static const char *import_marks_file;
 static int import_marks_file_from_stream;
+static int relative_marks_paths;
 
 /* Our last blob */
 static struct last_object last_blob = { STRBUF_INIT, 0, 0, 0 };
@@ -2470,6 +2471,16 @@ static void parse_progress(void)
 	skip_optional_lf();
 }
 
+static char* make_fast_import_path(const char *path)
+{
+	if (!relative_marks_paths || is_absolute_path(path))
+		return xstrdup(path);
+
+	struct strbuf abs_path = STRBUF_INIT;
+	strbuf_addf(&abs_path, "%s/info/fast-import/%s", get_git_dir(), path);
+	return strbuf_detach(&abs_path, NULL);
+}
+
 static void option_import_marks(const char *marks, int from_stream)
 {
 	if (import_marks_file) {
@@ -2481,7 +2492,7 @@ static void option_import_marks(const char *marks, int from_stream)
 			read_marks();
 	}
 
-	import_marks_file = xstrdup(marks);
+	import_marks_file = make_fast_import_path(marks);
 	import_marks_file_from_stream = from_stream;
 }
 
@@ -2516,7 +2527,7 @@ static void option_active_branches(const char *branches)
 
 static void option_export_marks(const char *marks)
 {
-	export_marks_file = xstrdup(marks);
+	export_marks_file = make_fast_import_path(marks);
 }
 
 static void option_export_pack_edges(const char *edges)
@@ -2557,6 +2568,10 @@ static int parse_one_feature(const char *feature, int from_stream)
 		option_import_marks(feature + 13, from_stream);
 	} else if (!prefixcmp(feature, "export-marks=")) {
 		option_export_marks(feature + 13);
+	} else if (!prefixcmp(feature, "relative-marks")) {
+		relative_marks_paths = 1;
+	} else if (!prefixcmp(feature, "no-relative-marks")) {
+		relative_marks_paths = 0;
 	} else if (!prefixcmp(feature, "force")) {
 		force_update = 1;
 	} else {
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index ba92775..a1b8c2b 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1346,6 +1346,31 @@ test_expect_success 'R: multiple --import-marks= should be honoured' '
     test_cmp marks.out combined.marks
 '
 
+cat >input <<EOF
+feature relative-marks
+feature import-marks=relative.in
+feature export-marks=relative.out
+EOF
+
+test_expect_success 'R: feature relative-marks should be honoured' '
+    mkdir -p .git/info/fast-import/ &&
+    cp marks.new .git/info/fast-import/relative.in &&
+    git fast-import <input &&
+    test_cmp marks.new .git/info/fast-import/relative.out
+'
+
+cat >input <<EOF
+feature relative-marks
+feature import-marks=relative.in
+feature no-relative-marks
+feature export-marks=non-relative.out
+EOF
+
+test_expect_success 'R: feature no-relative-marks should be honoured' '
+    git fast-import <input &&
+    test_cmp marks.new non-relative.out
+'
+
 cat >input << EOF
 option git quiet
 blob
-- 
1.6.5.3.164.g07b0c
