Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDDDC77B7A
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 10:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239592AbjFGKlc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 06:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235774AbjFGKl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 06:41:28 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E191BF1
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 03:41:22 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-565a022ef06so89217577b3.3
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 03:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1686134481; x=1688726481;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pxUhHxgCb3k8K3Mm4mImHmG5APfQpZgBAyrHM4+IEvg=;
        b=oXyyXDET6akHsqfVUFlUPdJZ3dw5ttem7YOFzz06DOc+D3WUa1f6cunuGni7jzf3VM
         buN7QxXrY9VMlBTshStsdtwCL3MozHDr2w1gsNEx5mlK8qdikFn7GFx8/HEJomE5/kQs
         9M1rEJFGx0JtdyjAe5nSsxusks4e4TV6i3S2G2BI6goHPhMJ/MZLVp1l7nQKJs40sxS7
         qNjkkQdypsCr1Sfx84FGDbTIgGh9ok4j/mRDtRwVRIGARPWPZjhDs7pxg+YchXpidX7n
         FqDgSQJdWyuhMP6+Vf25DkbCNiqfgsgY3vsHUKH/aHy6eNJ3oQyRUEzQGH7vYMuJutd5
         ZiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686134481; x=1688726481;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pxUhHxgCb3k8K3Mm4mImHmG5APfQpZgBAyrHM4+IEvg=;
        b=IqY+dVtj26U6Nabdi3S3lNR99hLZ+ouLB3xU0yxf9hW84bEM8564ODZ8S/JhgSS128
         9RTmMcs2INbTrWd+hdGvWgYtK5StLyJhoY7jquECF2wbdDOIetsZox0DytiA6ZHKilPw
         t1+ZRAVOcWuZrQNUrjbzw/DGXzlJjuMGZ7fqKEDBGpphpKQe6L2PE+SORL9Xj8/eeFE0
         XsCNRXn69aC8zKKu1mYMCHny6LQSfXz7aQFWAcZapYzGd69H2qq9xWFLpYx+v5hxZRRJ
         f++chwtJB9T98o+qdrpPg0T4ukXqU0RYvy/g4Ce8bMYpYC7/ErCv8O1aD2PKCC+3abyJ
         Cceg==
X-Gm-Message-State: AC+VfDy/G6HYOimC7f3Zv07hIGXP0NA0AmiLB7vT1jexU/DREKdVYoCD
        LT/fDSeASQwaQt1S3kZ2DFYHoTNUAnzQIVTvgSKARdkm
X-Google-Smtp-Source: ACHHUZ5ldFyM3uext0e98xmH3SaRAXMBhVsTEI6sx5rl2shGvcKS6RjjdlAUCtRWfCFV9BwQ2NAqRw==
X-Received: by 2002:a0d:e291:0:b0:569:ff01:41b8 with SMTP id l139-20020a0de291000000b00569ff0141b8mr3955963ywe.15.1686134481442;
        Wed, 07 Jun 2023 03:41:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w205-20020a817bd6000000b005569567aac1sm4633473ywc.106.2023.06.07.03.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 03:41:21 -0700 (PDT)
Date:   Wed, 7 Jun 2023 06:41:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 06/16] builtin/for-each-ref.c: add `--exclude` option
Message-ID: <60d85aa4ad10cf57c7694e6a07d6bf2d8f6984eb.1686134440.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1686134440.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1686134440.git.me@ttaylorr.com>
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
 builtin/for-each-ref.c             |  1 +
 ref-filter.c                       | 13 +++++++++++
 ref-filter.h                       |  6 +++++
 t/t6300-for-each-ref.sh            | 35 ++++++++++++++++++++++++++++++
 5 files changed, 61 insertions(+)

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
index c01fa6fefe..3384987428 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -47,6 +47,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_INTEGER( 0 , "count", &maxcount, N_("show only <n> matched refs")),
 		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to use for the output")),
 		OPT__COLOR(&format.use_color, N_("respect format colors")),
+		OPT_REF_FILTER_EXCLUDE(&filter),
 		OPT_REF_SORT(&sorting_options),
 		OPT_CALLBACK(0, "points-at", &filter.points_at,
 			     N_("object"), N_("print only refs which points at the given object"),
diff --git a/ref-filter.c b/ref-filter.c
index 6d91c7cb0d..d44418efb7 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2171,6 +2171,15 @@ static int filter_pattern_match(struct ref_filter *filter, const char *refname)
 			     filter->ignore_case);
 }
 
+static int filter_exclude_match(struct ref_filter *filter, const char *refname)
+{
+	if (!filter->exclude.nr)
+		return 0;
+	if (filter->match_as_path)
+		return match_name_as_path(filter, filter->exclude.v, refname);
+	return match_pattern(filter->exclude.v, refname, filter->ignore_case);
+}
+
 /*
  * This is the same as for_each_fullref_in(), but it tries to iterate
  * only over the patterns we'll care about. Note that it _doesn't_ do a full
@@ -2338,6 +2347,9 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	if (!filter_pattern_match(filter, refname))
 		return 0;
 
+	if (filter_exclude_match(filter, refname))
+		return 0;
+
 	if (filter->points_at.nr && !match_points_at(&filter->points_at, oid, refname))
 		return 0;
 
@@ -2877,6 +2889,7 @@ void ref_filter_init(struct ref_filter *filter)
 
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
2.41.0.16.g26cd413590

