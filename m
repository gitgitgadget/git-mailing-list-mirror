From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/7] diff: add --rename-file
Date: Wed, 20 Jan 2016 18:06:04 +0700
Message-ID: <1453287968-26000-4-git-send-email-pclouds@gmail.com>
References: <1453287968-26000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 12:07:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLqbM-0003Vn-8C
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 12:07:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbcATLGs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jan 2016 06:06:48 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34969 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964817AbcATLGn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 06:06:43 -0500
Received: by mail-pf0-f194.google.com with SMTP id 65so260897pff.2
        for <git@vger.kernel.org>; Wed, 20 Jan 2016 03:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=FYuaHIvgtdmHz+xwda89E6LPuDe6OXBjcbyZV47+KXY=;
        b=FQYFzGaxaiSH+T8AH+TlsxyBm1Iz6M2mfSgVl4StOsxQY1FsjcBQvxCGV/lq0H8pug
         4tKS6J1MkZC/wbAK3rZYJ7kAql1Tl6aIyLpn4VW7wzARd+k7eC/liKZE+p0K3Z2PS4st
         GQ0CAtcl3wB2SkmNJpXbeo0InZn1VXYNSIjgQE6l6Cirqe4D3IasUsx6p1xRmlsUIrhl
         BjM7XEutYEDaCMEtmZ5rSHotJj9MPblEvDH7sEzThl8W+JNzZ5scj35Spcp/f8t9ri3k
         oVmvrEnzUNLPWrMFnTTX16lNTqIrUL/ArSaKJSr7zySvhQncCLAhPWmWr1V24KoBZjmR
         ITQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=FYuaHIvgtdmHz+xwda89E6LPuDe6OXBjcbyZV47+KXY=;
        b=i71eQXSqEK4lkq0nZJo4ddszfden7qHQxIsXDbn+NBJpGM61yFZBjGnsxnytJzc0uc
         jlucT38oTuWptr0+YUbEVLI1B0P2kdAYpzvy2qzsWRg1moEQ49mB/DzIwyy5+J1OUMOm
         Oi6KkRIfEW/GhFdF11EJxrxlKNJfSFNiR8lwn6a1gj5FL+lBZtzkUksPX5N+egb15wCe
         Hfpf93707wzcQqQcNu0U/jFSbai9uJI/5+HQGRPB5naXBIQQ5nifC3UuPE1Fl/WlkxBl
         ULtam6ngIViEC+Kh1hGtPrISnXy8iHdw3Mk0myabz25cuFJjyPD3bhKK5RCG9eG6PBwF
         V8Xg==
X-Gm-Message-State: ALoCoQnPoUWXUr7hep4AMxTpY2NHufJZr2nfyQ0Y/mOjea/PE8hVh3GkwKJgARa2e9MctQ6AvTKsbcUoybiew6a/2TPYbKHjpQ==
X-Received: by 10.98.8.14 with SMTP id c14mr51252199pfd.42.1453288003193;
        Wed, 20 Jan 2016 03:06:43 -0800 (PST)
Received: from lanh ([115.72.43.83])
        by smtp.gmail.com with ESMTPSA id v75sm47955366pfa.60.2016.01.20.03.06.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jan 2016 03:06:41 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 20 Jan 2016 18:06:38 +0700
X-Mailer: git-send-email 2.7.0.125.g9eec362
In-Reply-To: <1453287968-26000-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284450>

Git's heuristics to detect renames or copies works most of the time.
This option can be used to correct the result when it goes wrong.
Matching pairs get max rename score and override even exact rename
detection.

Note that --rename-file does not try to break existing diff pairs. So
if you have "abc =3D> def" in your file, but they are already paired up
(e.g. "abc =3D> abc" and "def =3D> def") and not broken down by -B, the=
n
nothing happens.

An assumption is made in this patch, that the rename file only contains
a couple rename pairs, not thousands of them. Looping through all
rename source and destination for each rename line will not affect
performance and we can keep the code simple.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/diff-options.txt |  7 +++++
 diff.c                         | 10 +++++++
 diff.h                         |  1 +
 diffcore-rename.c              | 64 ++++++++++++++++++++++++++++++++++=
++++++--
 t/t4001-diff-rename.sh         | 33 ++++++++++++++++++++++
 5 files changed, 113 insertions(+), 2 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
index 306b7e3..7ae04a0 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -380,6 +380,13 @@ endif::git-log[]
 	projects, so use it with caution.  Giving more than one
 	`-C` option has the same effect.
=20
+--rename-file=3D<path>::
+	The given file contains explicit rename pairs that override
+	automatic detected renames. Each line contains a rename pair
+	in the following format:
++
+<source path> <space> "=3D>" <space> <destination path>
+
 -D::
 --irreversible-delete::
 	Omit the preimage for deletes, i.e. print only the header but not
diff --git a/diff.c b/diff.c
index 8d38fe8..36cf08b 100644
--- a/diff.c
+++ b/diff.c
@@ -3773,6 +3773,16 @@ int diff_opt_parse(struct diff_options *options,
 		DIFF_OPT_SET(options, RENAME_EMPTY);
 	else if (!strcmp(arg, "--no-rename-empty"))
 		DIFF_OPT_CLR(options, RENAME_EMPTY);
+	else if (skip_prefix(arg, "--rename-file=3D", &arg)) {
+		struct strbuf sb =3D STRBUF_INIT;
+		const char *path =3D arg;
+
+		if (prefix)
+			path =3D prefix_filename(prefix, strlen(prefix), path);
+		if (strbuf_read_file(&sb, path, 0) =3D=3D -1)
+			die(_("unable to read %s"), path);
+		options->manual_renames =3D strbuf_detach(&sb, NULL); /* leak */
+	}
 	else if (!strcmp(arg, "--relative"))
 		DIFF_OPT_SET(options, RELATIVE_NAME);
 	else if (skip_prefix(arg, "--relative=3D", &arg)) {
diff --git a/diff.h b/diff.h
index 76b5536..37179ba 100644
--- a/diff.h
+++ b/diff.h
@@ -176,6 +176,7 @@ struct diff_options {
 	diff_prefix_fn_t output_prefix;
 	int output_prefix_length;
 	void *output_prefix_data;
+	const char *manual_renames;
=20
 	int diff_path_counter;
 };
diff --git a/diffcore-rename.c b/diffcore-rename.c
index af1fe08..79beec8 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -346,8 +346,11 @@ static int find_exact_renames(struct diff_options =
*options)
 		insert_file_table(&file_table, i, rename_src[i].p->one);
=20
 	/* Walk the destinations and find best source match */
-	for (i =3D 0; i < rename_dst_nr; i++)
+	for (i =3D 0; i < rename_dst_nr; i++) {
+		if (rename_dst[i].pair)
+			continue; /* dealt with exact match already. */
 		renames +=3D find_identical_files(&file_table, i, options);
+	}
=20
 	/* Free the hash data structure and entries */
 	hashmap_free(&file_table, 1);
@@ -355,6 +358,61 @@ static int find_exact_renames(struct diff_options =
*options)
 	return renames;
 }
=20
+static int manual_rename(const char *src, int srclen,
+			 const char *dst, int dstlen)
+{
+	int src_index, dst_index;
+
+	for (src_index =3D 0; src_index < rename_src_nr; src_index++) {
+		const char *path =3D rename_src[src_index].p->one->path;
+		if (strlen(path) =3D=3D srclen && !strncmp(path, src, srclen))
+			break;
+	}
+	if (src_index =3D=3D rename_src_nr)
+		return 0;
+
+	for (dst_index =3D 0; dst_index < rename_dst_nr; dst_index++) {
+		const char *path =3D rename_dst[dst_index].two->path;
+		if (strlen(path) =3D=3D dstlen && !strncmp(path, dst, dstlen))
+			break;
+	}
+	if (dst_index =3D=3D rename_dst_nr)
+		return 0;
+
+	record_rename_pair(dst_index, src_index, MAX_SCORE);
+	return 1;
+}
+
+static int find_manual_renames(struct diff_options *options)
+{
+	int renames =3D 0;
+	const char *p, *end;
+
+	if (!options->manual_renames)
+		return 0;
+
+	p =3D options->manual_renames;
+	end =3D p + strlen(p);
+	while (p < end) {
+		const char *line_end =3D strchr(p, '\n');
+		const char *arrow =3D strstr(p, " =3D> ");
+		const char *src =3D p, *dst;
+
+		if (!line_end)
+			line_end =3D end;
+		p =3D line_end + 1;
+
+		if (!arrow || arrow >=3D line_end)
+			continue;
+
+		dst =3D arrow + strlen(" =3D> ");
+		renames +=3D manual_rename(src, arrow - src,
+					 dst, line_end - dst);
+	}
+
+	return renames;
+}
+
 #define NUM_CANDIDATE_PER_DST 4
 static void record_if_better(struct diff_score m[], struct diff_score =
*o)
 {
@@ -500,11 +558,13 @@ void diffcore_rename(struct diff_options *options=
)
 	if (rename_dst_nr =3D=3D 0 || rename_src_nr =3D=3D 0)
 		goto cleanup; /* nothing to do */
=20
+	rename_count =3D find_manual_renames(options);
+
 	/*
 	 * We really want to cull the candidates list early
 	 * with cheap tests in order to avoid doing deltas.
 	 */
-	rename_count =3D find_exact_renames(options);
+	rename_count +=3D find_exact_renames(options);
=20
 	/* Did we only want exact renames? */
 	if (minimum_score =3D=3D MAX_SCORE)
diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index 2f327b7..ab9a666 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -156,4 +156,37 @@ test_expect_success 'rename pretty print common pr=
efix and suffix overlap' '
 	test_i18ngrep " d/f/{ =3D> f}/e " output
 '
=20
+test_expect_success 'manual rename correction' '
+	test_create_repo correct-rename &&
+	(
+		cd correct-rename &&
+		echo one > old-one &&
+		echo two > old-two &&
+		git add old-one old-two &&
+		git commit -m old &&
+		git rm old-one old-two &&
+		echo one > new-one &&
+		echo two > new-two &&
+		git add new-one new-two &&
+		git commit -m new &&
+		git diff -M --summary HEAD^ | grep rename >actual &&
+		cat >expected <<-\EOF &&
+		 rename old-one =3D> new-one (100%)
+		 rename old-two =3D> new-two (100%)
+		EOF
+		test_cmp expected actual &&
+
+		cat >correction <<-\EOF &&
+		old-one =3D> new-two
+		old-two =3D> new-one
+		EOF
+		git diff -M --rename-file=3Dcorrection --summary HEAD^ | grep rename=
 >actual &&
+		cat >expected <<-\EOF &&
+		 rename old-two =3D> new-one (100%)
+		 rename old-one =3D> new-two (100%)
+		EOF
+		test_cmp expected actual
+	)
+'
+
 test_done
--=20
2.7.0.125.g9eec362
