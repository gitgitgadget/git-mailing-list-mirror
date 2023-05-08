Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF39DC77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 22:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbjEHWAR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 18:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234471AbjEHWAL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 18:00:11 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3A47EFA
        for <git@vger.kernel.org>; Mon,  8 May 2023 15:00:01 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-55a76ed088aso76171997b3.2
        for <git@vger.kernel.org>; Mon, 08 May 2023 15:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683583200; x=1686175200;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/wB4zu9ImKbyCdyVEKtkbU9Q3qjrKZMrVMOOvObJe/Q=;
        b=QSwEPjwHyEq95pFBVcIATrvyo/oKHiw/YHlz00G1tKerB865jfxKffw25URsyUD1fT
         ye4s/ivRukASuSw2KBsrRBbuYGDrrQRlVleIidqObxaqflZYqQf1pk0VzDRgrKXQ7R2R
         wQ/vF13xa2S5a0Kg77Te/1Nh8yupmlyeuZKGy8B1TELDApq5UNK1Y5uKxZa/aPsIxY/A
         lxXeerbHtjiqiPmHjF8mRWskYk0js4GfKSl8rAi0rFIum1XIg9Tq0qTh4fr0AB/T6Ct5
         45xwlOI7uK+puXUHBC+e9sQ/FlrypcNDIBYjYmIVf8gwweqUtQo5bimyaA6j8/HLQ9Pf
         TR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683583200; x=1686175200;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/wB4zu9ImKbyCdyVEKtkbU9Q3qjrKZMrVMOOvObJe/Q=;
        b=jiddvTeLNc7oR6YIRP2vOy7z5f077T8KfhkyvdQnlPxpwxnOzpMaPNqcF61J9jCa/p
         4R7eiHFYNs1bLhZyDiWoXlt9iBC9kQPdL2Pwcp6/OZonrQ586luxUz7t9A2XYj97k4v+
         croraFsoOQgf2xHsb3Al9I0SKXLhABNONlpna1mgGJ0VvrjDCFCYZjMo6MLHyvudyYta
         2U2PdM2CWUjbJBMo1GG6H7cxWCpO/qY3gMwknRZw7vBhPwf3aCMV+xrpJ93wbAurCFop
         FrbzIchZggNaLuv3yM+eS3Knf/MymR42u13dKp8jcnlGPtxONy5YogykcBjs+lwsYHZP
         w5VA==
X-Gm-Message-State: AC+VfDxrIjsG4rNGy2UbB2hdXLpkhb7yfOq8qpEfzbLZXiON3o/n6GpL
        jDfRZbUmhIF+CUJOlqFCEjgLZOcAoYQmRF+kaYz7QA==
X-Google-Smtp-Source: ACHHUZ5HzcgkeFUybjk1x3cCe9VjVmY25KhpKDcBRfnRITuLqtBNheVUhk3O9Y5e/M1DFFyoKiVXdA==
X-Received: by 2002:a0d:db49:0:b0:55a:314d:afdc with SMTP id d70-20020a0ddb49000000b0055a314dafdcmr13346687ywe.37.1683583200054;
        Mon, 08 May 2023 15:00:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n1-20020a0dcb01000000b0055a503ca1e8sm2777385ywd.109.2023.05.08.14.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 14:59:59 -0700 (PDT)
Date:   Mon, 8 May 2023 17:59:58 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 06/15] builtin/for-each-ref.c: add `--exclude` option
Message-ID: <ea5c0ddc10cd484c2af8505b8078697896ff3bad.1683581621.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1683581621.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using `for-each-ref`, it is sometimes convenient for the caller to
be able to exclude certain parts of the references.

For example, if there are many `refs/__hidden__/*` references, the
caller may want to emit all references *except* the hidden ones.
Currently, the only way to do this is to post-process the output, like:

    $ git for-each-ref --format='%(refname)' | grep -v '^refs/hidden/'

Which is do-able, but requires processing a potentially large quantity
of references.

Teach `git for-each-ref` a new `--exclude=<pattern>` option, which
excludes references from the results if they match one or more excluded
patterns.

This patch provides a naive implementation where the `ref_filter` still
sees all references (including ones that it will discard) and is left to
check whether each reference matches any excluded pattern(s) before
emitting them.

By culling out references we know the caller doesn't care about, we can
avoid allocating memory for their storage, as well as spending time
sorting the output (among other things). Even the naive implementation
provides a significant speed-up on a modified copy of linux.git (that
has a hidden ref pointing at each commit):

    $ hyperfine \
      'git.compile for-each-ref --format="%(objectname) %(refname)" | grep -vE "[0-9a-f]{40} refs/pull/"' \
      'git.compile for-each-ref --format="%(objectname) %(refname)" --exclude refs/pull/'
    Benchmark 1: git.compile for-each-ref --format="%(objectname) %(refname)" | grep -vE "[0-9a-f]{40} refs/pull/"
      Time (mean ± σ):     820.1 ms ±   2.0 ms    [User: 703.7 ms, System: 152.0 ms]
      Range (min … max):   817.7 ms … 823.3 ms    10 runs

    Benchmark 2: git.compile for-each-ref --format="%(objectname) %(refname)" --exclude refs/pull/
      Time (mean ± σ):     106.6 ms ±   1.1 ms    [User: 99.4 ms, System: 7.1 ms]
      Range (min … max):   104.7 ms … 109.1 ms    27 runs

    Summary
      'git.compile for-each-ref --format="%(objectname) %(refname)" --exclude refs/pull/' ran
        7.69 ± 0.08 times faster than 'git.compile for-each-ref --format="%(objectname) %(refname)" | grep -vE "[0-9a-f]{40} refs/pull/"'

Subsequent patches will improve on this by avoiding visiting excluded
sections of the `packed-refs` file in certain cases.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-for-each-ref.txt |  6 +++++
 builtin/for-each-ref.c             |  2 ++
 ref-filter.c                       | 13 +++++++++++
 ref-filter.h                       |  6 +++++
 t/t6300-for-each-ref.sh            | 35 ++++++++++++++++++++++++++++++
 5 files changed, 62 insertions(+)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 1e215d4e73..5743eb5def 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -14,6 +14,7 @@ SYNOPSIS
 		   [--points-at=<object>]
 		   [--merged[=<object>]] [--no-merged[=<object>]]
 		   [--contains[=<object>]] [--no-contains[=<object>]]
+		   [--exclude=<pattern> ...]
 
 DESCRIPTION
 -----------
@@ -102,6 +103,11 @@ OPTIONS
 	Do not print a newline after formatted refs where the format expands
 	to the empty string.
 
+--exclude=<pattern>::
+	If one or more patterns are given, only refs which do not match
+	any excluded pattern(s) are shown. Matching is done using the
+	same rules as `<pattern>` above.
+
 FIELD NAMES
 -----------
 
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index c01fa6fefe..449da61e11 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -14,6 +14,7 @@ static char const * const for_each_ref_usage[] = {
 	N_("git for-each-ref [--points-at <object>]"),
 	N_("git for-each-ref [--merged [<commit>]] [--no-merged [<commit>]]"),
 	N_("git for-each-ref [--contains [<commit>]] [--no-contains [<commit>]]"),
+	N_("git for-each-ref [--exclude=<pattern> ...]"),
 	NULL
 };
 
@@ -47,6 +48,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_INTEGER( 0 , "count", &maxcount, N_("show only <n> matched refs")),
 		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to use for the output")),
 		OPT__COLOR(&format.use_color, N_("respect format colors")),
+		OPT_REF_FILTER_EXCLUDE(&filter),
 		OPT_REF_SORT(&sorting_options),
 		OPT_CALLBACK(0, "points-at", &filter.points_at,
 			     N_("object"), N_("print only refs which points at the given object"),
diff --git a/ref-filter.c b/ref-filter.c
index 6c5eed144f..93dc9b331f 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2169,6 +2169,15 @@ static int filter_pattern_match(struct ref_filter *filter, const char *refname)
 	return match_pattern(filter, filter->name_patterns, refname);
 }
 
+static int filter_exclude_match(struct ref_filter *filter, const char *refname)
+{
+	if (!filter->exclude.nr)
+		return 0;
+	if (filter->match_as_path)
+		return match_name_as_path(filter, filter->exclude.v, refname);
+	return match_pattern(filter, filter->exclude.v, refname);
+}
+
 /*
  * This is the same as for_each_fullref_in(), but it tries to iterate
  * only over the patterns we'll care about. Note that it _doesn't_ do a full
@@ -2336,6 +2345,9 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	if (!filter_pattern_match(filter, refname))
 		return 0;
 
+	if (filter_exclude_match(filter, refname))
+		return 0;
+
 	if (filter->points_at.nr && !match_points_at(&filter->points_at, oid, refname))
 		return 0;
 
@@ -2875,6 +2887,7 @@ void ref_filter_init(struct ref_filter *filter)
 
 void ref_filter_clear(struct ref_filter *filter)
 {
+	strvec_clear(&filter->exclude);
 	oid_array_clear(&filter->points_at);
 	free_commit_list(filter->with_commit);
 	free_commit_list(filter->no_commit);
diff --git a/ref-filter.h b/ref-filter.h
index 160b807224..1524bc463a 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -6,6 +6,7 @@
 #include "refs.h"
 #include "commit.h"
 #include "string-list.h"
+#include "strvec.h"
 
 /* Quoting styles */
 #define QUOTE_NONE 0
@@ -59,6 +60,7 @@ struct ref_array {
 
 struct ref_filter {
 	const char **name_patterns;
+	struct strvec exclude;
 	struct oid_array points_at;
 	struct commit_list *with_commit;
 	struct commit_list *no_commit;
@@ -94,6 +96,7 @@ struct ref_format {
 
 #define REF_FILTER_INIT { \
 	.points_at = OID_ARRAY_INIT, \
+	.exclude = STRVEC_INIT, \
 }
 #define REF_FORMAT_INIT {             \
 	.use_color = -1,              \
@@ -112,6 +115,9 @@ struct ref_format {
 #define OPT_REF_SORT(var) \
 	OPT_STRING_LIST(0, "sort", (var), \
 			N_("key"), N_("field name to sort on"))
+#define OPT_REF_FILTER_EXCLUDE(var) \
+	OPT_STRVEC(0, "exclude", &(var)->exclude, \
+		   N_("pattern"), N_("exclude refs which match pattern"))
 
 /*
  * API for filtering a set of refs. Based on the type of refs the user
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 5c00607608..7e8d578522 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -447,6 +447,41 @@ test_expect_success 'exercise glob patterns with prefixes' '
 	test_cmp expected actual
 '
 
+cat >expected <<\EOF
+refs/tags/bar
+refs/tags/baz
+refs/tags/testtag
+EOF
+
+test_expect_success 'exercise patterns with prefix exclusions' '
+	for tag in foo/one foo/two foo/three bar baz
+	do
+		git tag "$tag" || return 1
+	done &&
+	test_when_finished "git tag -d foo/one foo/two foo/three bar baz" &&
+	git for-each-ref --format="%(refname)" \
+		refs/tags/ --exclude=refs/tags/foo >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<\EOF
+refs/tags/bar
+refs/tags/baz
+refs/tags/foo/one
+refs/tags/testtag
+EOF
+
+test_expect_success 'exercise patterns with pattern exclusions' '
+	for tag in foo/one foo/two foo/three bar baz
+	do
+		git tag "$tag" || return 1
+	done &&
+	test_when_finished "git tag -d foo/one foo/two foo/three bar baz" &&
+	git for-each-ref --format="%(refname)" \
+		refs/tags/ --exclude="refs/tags/foo/t*" >actual &&
+	test_cmp expected actual
+'
+
 cat >expected <<\EOF
 'refs/heads/main'
 'refs/remotes/origin/main'
-- 
2.40.1.477.g956c797dfc

