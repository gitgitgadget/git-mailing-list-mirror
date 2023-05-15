Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759BEC7EE24
	for <git@archiver.kernel.org>; Mon, 15 May 2023 19:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245015AbjEOTXx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 15:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245080AbjEOTXb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 15:23:31 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B382312EA2
        for <git@vger.kernel.org>; Mon, 15 May 2023 12:23:27 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-55af4277904so194846617b3.1
        for <git@vger.kernel.org>; Mon, 15 May 2023 12:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1684178607; x=1686770607;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+dWxzIPgbFoHSCOULBFXWPtGTeSCjHYBNL5SJqJ9fNM=;
        b=UsgYkkc2R7merPzOOohXL37F6lsa5boBZZDeWIEirZuw2eZtkc71KIfH3v7Bt7S7Sd
         dk3PoB9bytFOmQLOvWz8iVwyd2v3f2f1b+7dFfbPd3YA7XDftAtSbqeCW97AY50WL9Xx
         7cPE7M/SzCy2mScmJRL6D45mXxdUg7/gCaVUUHqKYyTwrUGOobaUlTrrQDpYyqT/r1kO
         HG4op8M1Glb9hxTEritNAf4Uxg8JTu2MqGRv6ZwqqAtl617ixHwSIf9HTBZVe+vQOd7d
         c7SGbAgMNZsYs2RPMxlVDzz2iKN2RVTjpA11ZHsHd4AUk8lWNCuwdSt44ZWP7UNCCy66
         AZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684178607; x=1686770607;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+dWxzIPgbFoHSCOULBFXWPtGTeSCjHYBNL5SJqJ9fNM=;
        b=OfOZOfPaqSBL/oP6wjq6YRbmiyV9WJDpun22KQ2X0MjUA31UD1ovBvrVSlTGOgzGwI
         O+pdV45L3987SoPTjEYcpfhe1YAUmEyv5+C7XZ5ANSNI9V4NZpaQPgqu+N0GT5piiDXM
         NHPREbtncmsmU88XzdZgAnq2c+p7iicAQ8iTPbLv5rCok7KVlb3QQqe95qA3eFSax/s+
         K4CfFH/bJBKr5hNGrhi0mPg1a5dsIW96a0O/+87gycFnxkNGP5DpmF6OspsaC7KwT8Ag
         qklnRZXtzTart0O/G4OsKkK1g4f4Cw9JbrkiL++ZY8Hq+driDsQlGoJaMElGQIkT8enC
         E7VA==
X-Gm-Message-State: AC+VfDygks2Ck03s64FL3cFogMNbmACubcK5TH+x0OX82VEZN1R6STjm
        wSlirKUN9vEsCayC9N3y846RC+o19KiqjN/0hAjPCA==
X-Google-Smtp-Source: ACHHUZ4VJOCYjdSK5x78/b7wrNBVjSNxulSYR4ephDEiELWQLMQRENE69W0xZndJwaLvMO7g1xBBOQ==
X-Received: by 2002:a0d:db47:0:b0:55a:1cb0:b255 with SMTP id d68-20020a0ddb47000000b0055a1cb0b255mr31938939ywe.37.1684178606756;
        Mon, 15 May 2023 12:23:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v125-20020a816183000000b0055a72f6a462sm32231ywb.19.2023.05.15.12.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 12:23:26 -0700 (PDT)
Date:   Mon, 15 May 2023 15:23:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 06/16] builtin/for-each-ref.c: add `--exclude` option
Message-ID: <1a3371a0a7511a7b47cffdf7094c51b027dd005b.1684178576.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1684178576.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1684178576.git.me@ttaylorr.com>
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
2.40.1.572.g5c4ab523ef

