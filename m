Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F81C64E7A
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EA372465E
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaFx1ji5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgKQVgI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgKQVgH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 16:36:07 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83C9C0617A6
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:36:05 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id t11so24012309edj.13
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D5QPhMjYOYZA0kT+wtHZpymZhEACpt3XCZfdWnjrcd4=;
        b=FaFx1ji5Emu5Sedaa5AwuyWzRwhZ9nKwOf8ty9LdkUNFDCL90BGwAu0jmiyoXuIzTg
         cStfpnVfI+GnEf4RlLCp3Wyj+GTMXb8U7AC2/uWxGtdw2FJX0SkZ8zkmfzx5eNtrcyCZ
         3TCSqo+X3A6v2n5S9vQKsCoHRrOunTbeCdX1sjU+5lOB/FxbEfE10Y5d1sooS8OSxHUk
         //tTHty1kJbji6+7E7sAR3pAZ2W2GGpSJXe4WBN/fb0mCVZ4dZuXsHatmb5IEBcVDdrS
         oBVtPG9sj8wlXh7l7j4G+NA5u7f79sCIzJtKaqgHQnK3jLyuUw7x/84mFsJu/Jg5Zkpw
         Z2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D5QPhMjYOYZA0kT+wtHZpymZhEACpt3XCZfdWnjrcd4=;
        b=DsNBZNM3je9g+on/D65Juy01d7Rkt6xH98qvcX51YEWvYjl8z0TKBbVEbzADgyBIE8
         rqgG8lGs35Ha0TNQ/oiLp68QGumlgZAFvvxyh1L201dH1yLbI4qyg/S1uMHb3sW5cx+h
         vuOKd3LgsmtqlApexh0LSnUdB6D36Y5BBnA5fcE5TThdf+oEjJUujyaUnRVpk1VK1kN2
         E9Hl1CPOKQ/Wehs7AJQU4X9AObUkJ6lbIMpXL8EjeaHezYmB7B7p7nTWH0CO1TncaMne
         eNzJsYResT/ALEzNbxv81XqHEl2OlM1WBwWsfuMxOJKMiQ7yd32bGLp+iKChOAARMlpF
         VkFg==
X-Gm-Message-State: AOAM533rPnHtS9SD3vntCscBSchWZGkuxXHUHPelosApdOF79O+DAYSP
        rihPViCeIbVxHO3Hfqdxz3Q=
X-Google-Smtp-Source: ABdhPJxRSRGEBw4FVVxwxoynaaZyqVPKRuW0KLbcfXKCI5u28Wm3ugyKCj1mQzOGV4hPU82UGt2MAw==
X-Received: by 2002:aa7:d890:: with SMTP id u16mr22951175edq.159.1605648964469;
        Tue, 17 Nov 2020 13:36:04 -0800 (PST)
Received: from localhost.localdomain (178.115.129.143.wireless.dyn.drei.com. [178.115.129.143])
        by smtp.gmail.com with ESMTPSA id by8sm12623417edb.49.2020.11.17.13.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 13:36:03 -0800 (PST)
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, newren@gmail.com, peff@peff.net,
        Johannes Altmanninger <aclopte@gmail.com>
Subject: [PATCH 2/3] range-diff: ignore context-only changes
Date:   Tue, 17 Nov 2020 22:35:50 +0100
Message-Id: <20201117213551.2539438-3-aclopte@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201117213551.2539438-1-aclopte@gmail.com>
References: <xmqqmtzvikwi.fsf@gitster.c.googlers.com>
 <20201117213551.2539438-1-aclopte@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

range-diff compares matching commits by comparing their patches against
each other. When two patches only differ in their context lines, that
difference would still show up in range-diff's output.

This commit uses diff's new -I/--ignore-matching-lines regex logic to ignore
diff hunks that only consist of changes to context lines in the input diffs.

Thanks to the previous commit, lines like "## file => renamed-file ##"
are not considered context lines because they no longer have a leading space.

This gives some extra @@ lines because we now always calculate
two diffs: one for the patch metadata, like the commit message,
and another one for the actual file changes.
This is because the former contains lines with leading spaces that are not
context lines, so we never want to ignore them.
---
 range-diff.c          | 58 +++++++++++++++++++++++++-----
 t/t3206-range-diff.sh | 83 ++++++-------------------------------------
 2 files changed, 60 insertions(+), 81 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 72660453bd..df2147ef79 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -363,6 +363,31 @@ static void get_correspondences(struct string_list *a, struct string_list *b,
 	free(b2a);
 }
 
+static int are_diffs_equivalent(const char *a_diff, const char *b_diff) {
+	for (
+		const char
+			*a_eol = strchr(a_diff, '\n'),
+			*b_eol = strchr(b_diff,	'\n');
+		(a_eol = strchr(a_diff,	'\n')) &&
+		(b_eol = strchr(b_diff,	'\n'));
+		a_diff = a_eol + 1, b_diff = b_eol + 1
+	) {
+		if (!!a_eol != !!b_eol)
+			return 0;
+
+		// Ignore context lines.
+		if (a_diff[0] == ' ' &&	b_diff[0] == ' ')
+			continue;
+
+		size_t a_len = a_eol - a_diff;
+		size_t b_len = b_eol - b_diff;
+		if (a_len != b_len || strncmp(a_diff, b_diff, a_len))
+			return 0;
+	}
+
+	return 1;
+}
+
 static void output_pair_header(struct diff_options *diffopt,
 			       int patch_no_width,
 			       struct strbuf *buf,
@@ -390,8 +415,10 @@ static void output_pair_header(struct diff_options *diffopt,
 	} else if (!a_util) {
 		color = color_new;
 		status = '>';
-	} else if (strcmp(a_util->patch, b_util->patch)) {
-		color = color_commit;
+	} else if (a_util->diff_offset != b_util->diff_offset
+		   || strncmp(a_util->patch, b_util->patch, a_util->diff_offset)
+		   || !are_diffs_equivalent(a_util->diff, b_util->diff)) {
+		color =	color_commit;
 		status = '!';
 	} else {
 		color = color_commit;
@@ -436,13 +463,13 @@ static struct userdiff_driver section_headers = {
 		      "^.?@@ (.*)$", REG_EXTENDED }
 };
 
-static struct diff_filespec *get_filespec(const char *name, const char *p)
+static struct diff_filespec *get_filespec(const char *name, const char *p, size_t size)
 {
 	struct diff_filespec *spec = alloc_filespec(name);
 
 	fill_filespec(spec, &null_oid, 0, 0100644);
 	spec->data = (char *)p;
-	spec->size = strlen(p);
+	spec->size = size;
 	spec->should_munmap = 0;
 	spec->is_stdin = 1;
 	spec->driver = &section_headers;
@@ -450,11 +477,11 @@ static struct diff_filespec *get_filespec(const char *name, const char *p)
 	return spec;
 }
 
-static void patch_diff(const char *a, const char *b,
+static void patch_diff(const char *a, size_t size_a, const char *b, size_t size_b,
 		       struct diff_options *diffopt)
 {
 	diff_queue(&diff_queued_diff,
-		   get_filespec("a", a), get_filespec("b", b));
+		   get_filespec("a", a, size_a), get_filespec("b", b, size_b));
 
 	diffcore_std(diffopt);
 	diff_flush(diffopt);
@@ -467,6 +494,14 @@ static void output(struct string_list *a, struct string_list *b,
 	int patch_no_width = decimal_width(1 + (a->nr > b->nr ? a->nr : b->nr));
 	int i = 0, j = 0;
 
+	regex_t regex;
+	if (regcomp(&regex, "^ ", REG_EXTENDED | REG_NEWLINE))
+		BUG("invalid regex");
+	ALLOC_GROW(diffopt->ignore_regex, diffopt->ignore_regex_nr + 1,
+		   diffopt->ignore_regex_alloc);
+	diffopt->ignore_regex[diffopt->ignore_regex_nr] = &regex;
+	size_t ignoring_context_only_changes = diffopt->ignore_regex_nr + 1;
+
 	/*
 	 * We assume the user is really more interested in the second argument
 	 * ("newer" version). To that end, we print the output in the order of
@@ -504,9 +539,14 @@ static void output(struct string_list *a, struct string_list *b,
 			a_util = a->items[b_util->matching].util;
 			output_pair_header(diffopt, patch_no_width,
 					   &buf, &dashes, a_util, b_util);
-			if (!(diffopt->output_format & DIFF_FORMAT_NO_OUTPUT))
-				patch_diff(a->items[b_util->matching].string,
-					   b->items[j].string, diffopt);
+			if (!(diffopt->output_format & DIFF_FORMAT_NO_OUTPUT)) {
+				patch_diff(a_util->patch, a_util->diff_offset, 
+						b_util->patch, b_util->diff_offset, diffopt);
+			        diffopt->ignore_regex_nr = ignoring_context_only_changes;
+				patch_diff(a_util->diff, strlen(a_util->diff), 
+						b_util->diff, strlen(b_util->diff), diffopt);
+			        diffopt->ignore_regex_nr = ignoring_context_only_changes - 1;
+			}
 			a_util->shown = 1;
 			j++;
 		}
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index f875843b5e..9a63388bee 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -223,16 +223,7 @@ test_expect_success 'changed commit' '
 	      12
 	      13
 	      14
-	4:  $(test_oid t4) ! 4:  $(test_oid c4) s/12/B/
-	    @@ file
-	     @@ file: A
-	      9
-	      10
-	    - B
-	    + BB
-	     -12
-	     +B
-	      13
+	4:  $(test_oid t4) = 4:  $(test_oid c4) s/12/B/
 	EOF
 	test_cmp expect actual
 '
@@ -243,7 +234,7 @@ test_expect_success 'changed commit with --no-patch diff option' '
 	1:  $(test_oid t1) = 1:  $(test_oid c1) s/5/A/
 	2:  $(test_oid t2) = 2:  $(test_oid c2) s/4/A/
 	3:  $(test_oid t3) ! 3:  $(test_oid c3) s/11/B/
-	4:  $(test_oid t4) ! 4:  $(test_oid c4) s/12/B/
+	4:  $(test_oid t4) = 4:  $(test_oid c4) s/12/B/
 	EOF
 	test_cmp expect actual
 '
@@ -256,9 +247,7 @@ test_expect_success 'changed commit with --stat diff option' '
 	3:  $(test_oid t3) ! 3:  $(test_oid c3) s/11/B/
 	     a => b | 2 +-
 	     1 file changed, 1 insertion(+), 1 deletion(-)
-	4:  $(test_oid t4) ! 4:  $(test_oid c4) s/12/B/
-	     a => b | 2 +-
-	     1 file changed, 1 insertion(+), 1 deletion(-)
+	4:  $(test_oid t4) = 4:  $(test_oid c4) s/12/B/
 	EOF
 	test_cmp expect actual
 '
@@ -278,16 +267,7 @@ test_expect_success 'changed commit with sm config' '
 	      12
 	      13
 	      14
-	4:  $(test_oid t4) ! 4:  $(test_oid c4) s/12/B/
-	    @@ file
-	     @@ file: A
-	      9
-	      10
-	    - B
-	    + BB
-	     -12
-	     +B
-	      13
+	4:  $(test_oid t4) = 4:  $(test_oid c4) s/12/B/
 	EOF
 	test_cmp expect actual
 '
@@ -304,16 +284,14 @@ test_expect_success 'renamed file' '
 	    -    s/4/A/
 	    +    s/4/A/ + rename file
 	    Z
+	    @@
 	    -## file ##
 	    +## file => renamed-file ##
 	    Z@@
 	    Z 1
 	    Z 2
 	3:  $(test_oid t3) ! 3:  $(test_oid n3) s/11/B/
-	    @@ Metadata
-	    Z ## Commit message ##
-	    Z    s/11/B/
-	    Z
+	    @@
 	    -## file ##
 	    -@@ file: A
 	    +## renamed-file ##
@@ -322,10 +300,7 @@ test_expect_success 'renamed file' '
 	    Z 9
 	    Z 10
 	4:  $(test_oid t4) ! 4:  $(test_oid n4) s/12/B/
-	    @@ Metadata
-	    Z ## Commit message ##
-	    Z    s/12/B/
-	    Z
+	    @@
 	    -## file ##
 	    -@@ file: A
 	    +## renamed-file ##
@@ -348,8 +323,6 @@ test_expect_success 'file with mode only change' '
 	    -    s/4/A/
 	    +    s/4/A/ + add other-file
 	    Z
-	    Z## file ##
-	    Z@@
 	    @@ file
 	    Z A
 	    Z 6
@@ -364,8 +337,6 @@ test_expect_success 'file with mode only change' '
 	    -    s/11/B/
 	    +    s/11/B/ + mode change other-file
 	    Z
-	    Z## file ##
-	    Z@@ file: A
 	    @@ file: A
 	    Z 12
 	    Z 13
@@ -389,8 +360,6 @@ test_expect_success 'file added and later removed' '
 	    -    s/4/A/
 	    +    s/4/A/ + new-file
 	    Z
-	    Z## file ##
-	    Z@@
 	    @@ file
 	    Z A
 	    Z 6
@@ -405,8 +374,6 @@ test_expect_success 'file added and later removed' '
 	    -    s/11/B/
 	    +    s/11/B/ + remove file
 	    Z
-	    Z## file ##
-	    Z@@ file: A
 	    @@ file: A
 	    Z 12
 	    Z 13
@@ -434,9 +401,6 @@ test_expect_success 'changed message' '
 	    Z
 	    +    Also a silly comment here!
 	    +
-	    Z## file ##
-	    Z@@
-	    Z 1
 	3:  $(test_oid t3) = 3:  $(test_oid m3) s/11/B/
 	4:  $(test_oid t4) = 4:  $(test_oid m4) s/12/B/
 	EOF
@@ -453,9 +417,6 @@ test_expect_success 'dual-coloring' '
 	:     <RESET>
 	:    <REVERSE><GREEN>+<RESET><BOLD>    Also a silly comment here!<RESET>
 	:    <REVERSE><GREEN>+<RESET>
-	:     ## file ##<RESET>
-	:    <CYAN> @@<RESET>
-	:      1<RESET>
 	:<RED>3:  $(test_oid c3) <RESET><YELLOW>!<RESET><GREEN> 3:  $(test_oid m3)<RESET><YELLOW> s/11/B/<RESET>
 	:    <REVERSE><CYAN>@@<RESET> <RESET>file: A<RESET>
 	:      9<RESET>
@@ -466,16 +427,7 @@ test_expect_success 'dual-coloring' '
 	:      12<RESET>
 	:      13<RESET>
 	:      14<RESET>
-	:<RED>4:  $(test_oid c4) <RESET><YELLOW>!<RESET><GREEN> 4:  $(test_oid m4)<RESET><YELLOW> s/12/B/<RESET>
-	:    <REVERSE><CYAN>@@<RESET> <RESET>file<RESET>
-	:    <CYAN> @@ file: A<RESET>
-	:      9<RESET>
-	:      10<RESET>
-	:    <REVERSE><RED>-<RESET><FAINT> BB<RESET>
-	:    <REVERSE><GREEN>+<RESET><BOLD> B<RESET>
-	:    <RED> -12<RESET>
-	:    <GREEN> +B<RESET>
-	:      13<RESET>
+	:<YELLOW>4:  d966c5c = 4:  8add5f1 s/12/B/<RESET>
 	EOF
 	git range-diff changed...changed-message --color --dual-color >actual.raw &&
 	test_decode_color >actual <actual.raw &&
@@ -537,8 +489,6 @@ test_expect_success 'range-diff compares notes by default' '
 	    -    topic note
 	    +    unmodified note
 	    Z
-	    Z## file ##
-	    Z@@ file: A
 	EOF
 	test_cmp expect actual
 '
@@ -584,8 +534,6 @@ test_expect_success 'range-diff with multiple --notes' '
 	    -    topic note2
 	    +    unmodified note2
 	    Z
-	    Z## file ##
-	    Z@@ file: A
 	EOF
 	test_cmp expect actual
 '
@@ -644,11 +592,8 @@ test_expect_success 'format-patch --range-diff with --notes' '
 	    Z ## Notes ##
 	    -    topic note
 	    +    unmodified note
-	    Z
-	    Z## file ##
-	    Z@@ file: A
 	EOF
-	sed "/@@ Commit message/,/@@ file: A/!d" 0000-* >actual &&
+	sed "/@@ Commit message/,/unmodified note\$/!d" 0000-* >actual &&
 	test_cmp expect actual
 '
 
@@ -673,11 +618,8 @@ test_expect_success 'format-patch --range-diff with format.notes config' '
 	    Z ## Notes ##
 	    -    topic note
 	    +    unmodified note
-	    Z
-	    Z## file ##
-	    Z@@ file: A
 	EOF
-	sed "/@@ Commit message/,/@@ file: A/!d" 0000-* >actual &&
+	sed "/@@ Commit message/,/unmodified note\$/!d" 0000-* >actual &&
 	test_cmp expect actual
 '
 
@@ -709,11 +651,8 @@ test_expect_success 'format-patch --range-diff with multiple notes' '
 	    Z ## Notes (note2) ##
 	    -    topic note2
 	    +    unmodified note2
-	    Z
-	    Z## file ##
-	    Z@@ file: A
 	EOF
-	sed "/@@ Commit message/,/@@ file: A/!d" 0000-* >actual &&
+	sed "/@@ Commit message/,/unmodified note2\$/!d" 0000-* >actual &&
 	test_cmp expect actual
 '
 
-- 
2.29.2

