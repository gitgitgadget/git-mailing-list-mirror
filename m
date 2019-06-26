Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 581931F461
	for <e@80x24.org>; Wed, 26 Jun 2019 22:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfFZWlv (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 18:41:51 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:45136 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfFZWlv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 18:41:51 -0400
Received: by mail-yw1-f67.google.com with SMTP id m16so229008ywh.12
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 15:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Ghqhlt6eA3uJMfqO8FEXRedh+Tpks/1xN6A3c4RWLs0=;
        b=PWSHu4LtPEsBLTJpbfjyfoxwf3t0cHArdsqqatPaBq8+6nxBr8o70h0lLiaE+kO8iY
         SbjGpboZMi3IdJTVv1APq3yx/OrWQ6ILwIzD6oH/7EArR6uoQM18xf4AwLXapCOvlvMe
         JJV3fHr/tHlhGmc9VFEsyL0ImIyIE8ewvpW8G0SbQxmO8cZiQJuwjf89kW4+9rT7Azy5
         u7NW09d2OUFIinlXjuvCvYQMAfLszq+nYKuNXAhePMOksgvY0pPQBLfCtmuPd4iDiHxS
         ZSrY5lkBt4FWSERwcGwx6rfvNB5ILzv1XMZN3IYme8xewwGjTSv+ulnSOXfpNHzQAW39
         XHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Ghqhlt6eA3uJMfqO8FEXRedh+Tpks/1xN6A3c4RWLs0=;
        b=Yz7XR9I2AM5eGDghM1kMg3vYIDMhlh74UBfaBNJVB26c2D6aJgYPqq0sfLcdbMKQov
         o0oTzvRs4KbdSEaCsOQ1FG+oP7YyyKQgF0CVPP9uujv5LG6MTzKtQUWwNnlGmKVNTC2Z
         RpMU/flRiHaLDCV3KQzNO3G2oNdwgjoJzKVTUUM8EJRvcvaehxfQD9SUnYfbfifoOtCK
         2dtUFpIsDnHIjk5eoUS5jEn1gSd0y3+pi3N5sVQFPrl2jOJ4YpoZIszLLlILfSbpdHZz
         vORLIpCUJ7711QSQ/WpUlAu6HfvPoBwt2QLTNcVIXfzRnBHixi0ohykZE/rsxSHLUet+
         dm8Q==
X-Gm-Message-State: APjAAAW898oYUB9KwhtFSZh2VqFLBNi46Qopte1//TW66yhbs5/h6yAy
        M5DatxvOZ8Xa7hDTVZe4ugJ85QeVWKd/Ng==
X-Google-Smtp-Source: APXvYqwJt2G1g8+ssNOa2p01xOpYAwG3iIGVyTn2iGQ+oiFxjD5eBhj7JAcPdFzVdHnYPVCZ0ddc8A==
X-Received: by 2002:a81:574b:: with SMTP id l72mr315409ywb.210.1561588909232;
        Wed, 26 Jun 2019 15:41:49 -0700 (PDT)
Received: from localhost ([2600:1700:6e90:7930:a495:edeb:abca:f993])
        by smtp.gmail.com with ESMTPSA id d9sm97097ywa.69.2019.06.26.15.41.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 15:41:48 -0700 (PDT)
Date:   Wed, 26 Jun 2019 17:41:48 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net
Subject: [PATCH 1/1] ref-filter.c: find disjoint pattern prefixes
Message-ID: <e41db267f7b7086126e9fd3fd5b1a02e38c8c077.1561588479.git.me@ttaylorr.com>
References: <cover.1561588479.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1561588479.git.me@ttaylorr.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since cfe004a5a9 (ref-filter: limit traversal to prefix, 2017-05-22),
the ref-filter code has sought to limit the traversals to a prefix of
the given patterns.

That code stopped short of handling more than one pattern, because it
means invoking 'for_each_ref_in' multiple times. If we're not careful
about which patterns overlap, we will output the same refs multiple
times.

For instance, consider the set of patterns 'refs/heads/a/*',
'refs/heads/a/b/c', and 'refs/tags/v1.0.0'. If we naïvely ran:

  for_each_ref_in("refs/heads/a/*", ...);
  for_each_ref_in("refs/heads/a/b/c", ...);
  for_each_ref_in("refs/tags/v1.0.0", ...);

we would see 'refs/heads/a/b/c' (and everything underneath it) twice.

Instead, we want to partition the patterns into disjoint sets, where we
know that no ref will be matched by any two patterns in different sets.
In the above, these are:

  - {'refs/heads/a/*', 'refs/heads/a/b/c'}, and
  - {'refs/tags/v1.0.0'}

Given one of these disjoint sets, what is a suitable pattern to pass to
'for_each_ref_in'? One approach is to compute the longest common prefix
over all elements in that disjoint set, and let the caller cull out the
refs they didn't want. Computing the longest prefix means that in most
cases, we won't match too many things the caller would like to ignore.

The longest common prefixes of the above are:

  - {'refs/heads/a/*', 'refs/heads/a/b/c'} -> refs/heads/a/*
  - {'refs/tags/v1.0.0'}                   -> refs/tags/v1.0.0

We instead invoke:

  for_each_ref_in("refs/heads/a/*", ...);
  for_each_ref_in("refs/tags/v1.0.0", ...);

Which provides us with the refs we were looking for with a minimal
amount of extra cruft, but never a duplicate of the ref we asked for.

Implemented here is an algorithm which accomplishes the above, which
works as follows:

  1. Lexicographically sort the given list of patterns.

  2. Initialize 'prefix' to the empty string, where our goal is to
     build each element in the above set of longest common prefixes.

  3. Consider each pattern in the given set, and emit 'prefix' if it
     reaches the end of a pattern, or touches a wildcard character. The
     end of a string is treated as if it precedes a wildcard. (Note that
     there is some room for future work to detect that, e.g., 'a?b' and
     'abc' are disjoint).

  4. Otherwise, recurse on step (3) with the slice of the list
     corresponding to our current prefix (i.e., the subset of patterns
     that have our prefix as a literal string prefix.)

This algorithm is 'O(kn + n log(n))', where 'k' is max(len(pattern)) for
each pattern in the list, and 'n' is len(patterns).

By discovering this set of interesting patterns, we reduce the runtime
of multi-pattern 'git for-each-ref' (and other ref traversals) from
O(N) to O(n log(N)), where 'N' is the total number of packed references.

Running 'git for-each-ref refs/tags/a refs/tags/b' on a repository with
10,000,000 refs in 'refs/tags/huge-N', my best-of-five times drop from:

  real    0m5.805s
  user    0m5.188s
  sys     0m0.468s

to:

  real    0m0.001s
  user    0m0.000s
  sys     0m0.000s

On linux.git, the times to dig out two of the latest -rc tags drops from
0.002s to 0.001s, so the change on repositories with fewer tags is much
less noticeable.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ref-filter.c            | 89 +++++++++++++++++++++++++++++------------
 t/t6300-for-each-ref.sh | 26 ++++++++++++
 2 files changed, 89 insertions(+), 26 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 8500671bc6..3e10fd647b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -20,6 +20,7 @@
 #include "commit-slab.h"
 #include "commit-graph.h"
 #include "commit-reach.h"
+#include "argv-array.h"
 
 static struct ref_msg {
 	const char *gone;
@@ -1790,21 +1791,62 @@ static int filter_pattern_match(struct ref_filter *filter, const char *refname)
 	return match_pattern(filter, refname);
 }
 
-/*
- * Find the longest prefix of pattern we can pass to
- * `for_each_fullref_in()`, namely the part of pattern preceding the
- * first glob character. (Note that `for_each_fullref_in()` is
- * perfectly happy working with a prefix that doesn't end at a
- * pathname component boundary.)
- */
-static void find_longest_prefix(struct strbuf *out, const char *pattern)
+static int qsort_strcmp(const void *va, const void *vb)
 {
-	const char *p;
+	const char *a = *(const char **)va;
+	const char *b = *(const char **)vb;
 
-	for (p = pattern; *p && !is_glob_special(*p); p++)
-		;
+	return strcmp(a, b);
+}
 
-	strbuf_add(out, pattern, p - pattern);
+static void find_longest_prefixes_1(struct string_list *out,
+				  struct strbuf *prefix,
+				  const char **patterns, size_t nr)
+{
+	size_t i;
+
+	for (i = 0; i < nr; i++) {
+		char c = patterns[i][prefix->len];
+		if (!c || is_glob_special(c)) {
+			string_list_append(out, prefix->buf);
+			return;
+		}
+	}
+
+	i = 0;
+	while (i < nr) {
+		size_t end;
+
+		/*
+		* Set "end" to the index of the element _after_ the last one
+		* in our group.
+		*/
+		for (end = i + 1; end < nr; end++) {
+			if (patterns[i][prefix->len] != patterns[end][prefix->len])
+				break;
+		}
+
+		strbuf_addch(prefix, patterns[i][prefix->len]);
+		find_longest_prefixes_1(out, prefix, patterns + i, end - i);
+		strbuf_setlen(prefix, prefix->len - 1);
+
+		i = end;
+	}
+}
+
+static void find_longest_prefixes(struct string_list *out,
+				  const char **patterns)
+{
+	struct argv_array sorted = ARGV_ARRAY_INIT;
+	struct strbuf prefix = STRBUF_INIT;
+
+	argv_array_pushv(&sorted, patterns);
+	QSORT(sorted.argv, sorted.argc, qsort_strcmp);
+
+	find_longest_prefixes_1(out, &prefix, sorted.argv, sorted.argc);
+
+	argv_array_clear(&sorted);
+	strbuf_release(&prefix);
 }
 
 /*
@@ -1817,7 +1859,8 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 				       void *cb_data,
 				       int broken)
 {
-	struct strbuf prefix = STRBUF_INIT;
+	struct string_list prefixes = STRING_LIST_INIT_DUP;
+	struct string_list_item *prefix;
 	int ret;
 
 	if (!filter->match_as_path) {
@@ -1843,21 +1886,15 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 		return for_each_fullref_in("", cb, cb_data, broken);
 	}
 
-	if (filter->name_patterns[1]) {
-		/*
-		 * multiple patterns; in theory this could still work as long
-		 * as the patterns are disjoint. We'd just make multiple calls
-		 * to for_each_ref(). But if they're not disjoint, we'd end up
-		 * reporting the same ref multiple times. So let's punt on that
-		 * for now.
-		 */
-		return for_each_fullref_in("", cb, cb_data, broken);
+	find_longest_prefixes(&prefixes, filter->name_patterns);
+
+	for_each_string_list_item(prefix, &prefixes) {
+		ret = for_each_fullref_in(prefix->string, cb, cb_data, broken);
+		if (ret)
+			break;
 	}
 
-	find_longest_prefix(&prefix, filter->name_patterns[0]);
-
-	ret = for_each_fullref_in(prefix.buf, cb, cb_data, broken);
-	strbuf_release(&prefix);
+	string_list_clear(&prefixes, 0);
 	return ret;
 }
 
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index d9235217fc..ab69aa176d 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -345,6 +345,32 @@ test_expect_success 'Verify descending sort' '
 	test_cmp expected actual
 '
 
+cat >expected <<\EOF
+refs/tags/testtag
+refs/tags/testtag-2
+EOF
+
+test_expect_success 'exercise patterns with prefixes' '
+	git tag testtag-2 &&
+	test_when_finished "git tag -d testtag-2" &&
+	git for-each-ref --format="%(refname)" \
+		refs/tags/testtag refs/tags/testtag-2 >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<\EOF
+refs/tags/testtag
+refs/tags/testtag-2
+EOF
+
+test_expect_success 'exercise glob patterns with prefixes' '
+	git tag testtag-2 &&
+	test_when_finished "git tag -d testtag-2" &&
+	git for-each-ref --format="%(refname)" \
+		refs/tags/testtag "refs/tags/testtag-*" >actual &&
+	test_cmp expected actual
+'
+
 cat >expected <<\EOF
 'refs/heads/master'
 'refs/remotes/origin/master'
-- 
2.21.0.203.g358da99528
