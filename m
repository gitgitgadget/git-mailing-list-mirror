Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8803C07E9D
	for <git@archiver.kernel.org>; Sat, 24 Sep 2022 16:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbiIXQOZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Sep 2022 12:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbiIXQOW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2022 12:14:22 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9AA78208
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 09:14:16 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id g3so4173654wrq.13
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 09:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date;
        bh=hsAbm98EskmAfO8pS7jv8FfI/hG9idUYrAx8kT1AZCM=;
        b=eyW96pkq3mfRZnYUpLIBuBizAA+92IIVp5peTYPp3WPMspIb+6OlhHHY2VHuk2Z2e8
         23zYZXXM7Zzj3sqO4dMK4PerR4vclMnjcm2YzRHnFXweXONNZPIsNzDN+Iy2nyIi6gsL
         6tZUN9BunDm3QKMQfgQ+tzreHrROdMq31HAXqqIzyz2aJk447MgLwnxH3/+TIsWvihl5
         a36FleMt2ElKjeYm2ZhY7+MAtfnHOOp4OA5eQuPoRi36oSOaHjonNw0cRFaq+YQPZeAY
         9z8oDylsF4RoPqB8cu+lTzQDuaDxxKt+6nDtJNrzmfDDXJLwrfuiWRvqfqxG8t4QW7yJ
         tUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=hsAbm98EskmAfO8pS7jv8FfI/hG9idUYrAx8kT1AZCM=;
        b=Zp1uF6C68eIgDoLyLhgPY0VXBEP+o5GFP6qTR8x2KvrsgbLqUj3zEohXKtFf5HpdRx
         ic6gfXFhYzX9/fTvNjsVNSgKsuxIBImABwVx3tdHwzJc8bB8E0plRsYk6b8ACT7MK4Nn
         a0MgpUajkre6pb+RvWl83609Nn6zOZFWPzqOiblEpTXxKqXo26fg135oGZKvHADSRrGi
         AMImtTPv2NDNRTOQR0boin0ZQPRsgUM0JFSb7NsIpXitlyK/DJbIeqcOdPfx37w82usB
         iJiHb2fQ9OOlEMDHg1SAsiuUA8yRVE/0n2SUz056qhjZoJQDJhcXWRFYK89Db7hUIWiM
         MF6g==
X-Gm-Message-State: ACrzQf3KjJjyNfIBqoxpB+4gpIJpkGgb4j1OMYhamCIZANZFB1wdpuku
        VZKQXdw+dTMrVB/5+466FZ50vK+ukz0=
X-Google-Smtp-Source: AMsMyM4sC3knwxySrPkU2muPamOXX+CC4tnRaE20+DanNXiuQeZnIVKhCVeCleRJQzk6UH1Bar4+Bw==
X-Received: by 2002:a5d:6301:0:b0:226:d87b:b55c with SMTP id i1-20020a5d6301000000b00226d87bb55cmr8153841wru.560.1664036054451;
        Sat, 24 Sep 2022 09:14:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id iv14-20020a05600c548e00b003a6a3595edasm5853252wmb.27.2022.09.24.09.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 09:14:13 -0700 (PDT)
Message-Id: <pull.1368.git.1664036052741.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 24 Sep 2022 16:14:12 +0000
Subject: [PATCH] diff: introduce --restrict option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

When we use sparse-checkout, we often want the set of files
that some commands operate on to be restricted to the
sparse-checkout cone(s).

So introduce the `--restrict` option to git diff, which can
restrict diff filespec to the sparse-checkout cone(s).

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    diff: introduce --restrict option
    
    In [1], we discovered that users working on different sparse-checkout
    cone(s) may download unnecessary blobs from each other's cone(s) in
    collaboration. And in [2] Junio suggested that maybe we can restrict
    some git command's filespec in sparse-checkout cone(s) to elegantly
    solve this problem above.
    
    So this patch is attempt to do this thing on git diff:
    
    v1:
    
     1. add --restrict option to git diff, which restrict diff filespec in
        sparse-checkout cone(s).
    
    [1]:
    https://lore.kernel.org/git/CAOLTT8SHo66kGbvWr=+LQ9UVd1NHgqGGEYK2qq6==QgRCgLZqQ@mail.gmail.com/
    [2]: https://lore.kernel.org/git/xmqqzgeqw0sy.fsf@gitster.g/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1368%2Fadlternative%2Fzh%2Fdiff-restrict-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1368/adlternative/zh/diff-restrict-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1368

 Documentation/diff-options.txt           |  4 ++
 diff.c                                   | 57 ++++++++++++++++++++++++
 diff.h                                   |  1 +
 t/t1092-sparse-checkout-compatibility.sh | 30 +++++++++++++
 4 files changed, 92 insertions(+)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 3674ac48e92..8ee5b6b4603 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -631,6 +631,10 @@ Also, these upper-case letters can be downcased to exclude.  E.g.
 Note that not all diffs can feature all types. For instance, copied and
 renamed entries cannot appear if detection for those types is disabled.
 
+--restrict::
+	Restrict the diff filespec in the sparse-checkout cone(s).
+	See linkgit:git-sparse-checkout[1] for more details.
+
 -S<string>::
 	Look for differences that change the number of occurrences of
 	the specified string (i.e. addition/deletion) in a file.
diff --git a/diff.c b/diff.c
index 648f6717a55..95e13607041 100644
--- a/diff.c
+++ b/diff.c
@@ -4923,6 +4923,19 @@ static int diff_opt_diff_filter(const struct option *option,
 	return 0;
 }
 
+static int diff_opt_diff_restrict(const struct option *option,
+				const char *optarg, int unset)
+{
+	struct diff_options *opt = option->value;
+
+	BUG_ON_OPT_NEG(unset);
+	CALLOC_ARRAY(opt->sparse_checkout_patterns, 1);
+
+	if (get_sparse_checkout_patterns(opt->sparse_checkout_patterns) < 0)
+		FREE_AND_NULL(opt->sparse_checkout_patterns);
+	return 0;
+}
+
 static void enable_patch_output(int *fmt)
 {
 	*fmt &= ~DIFF_FORMAT_NO_OUTPUT;
@@ -5660,6 +5673,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "diff-filter", options, N_("[(A|C|D|M|R|T|U|X|B)...[*]]"),
 			       N_("select files by diff type"),
 			       PARSE_OPT_NONEG, diff_opt_diff_filter),
+		OPT_CALLBACK_F(0, "restrict", options, NULL,
+			       N_("restrict files in sparse-checkout patterns"),
+			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG, diff_opt_diff_restrict),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
@@ -6601,6 +6617,24 @@ free_queue:
 	}
 }
 
+
+static int match_sparse_checkout_patterns_by_spec(const struct diff_options *options, struct diff_filespec *spec) {
+	int dtype = DT_REG;
+
+	if (!spec)
+		return 0;
+
+	return path_matches_pattern_list(spec->path, strlen(spec->path),
+					 "", &dtype, options->sparse_checkout_patterns,
+					 the_repository->index) > 0;
+}
+
+static int match_sparse_checkout_patterns(const struct diff_options *options, const struct diff_filepair *p)
+{
+	return match_sparse_checkout_patterns_by_spec(options, p->one) ||
+	       match_sparse_checkout_patterns_by_spec(options, p->two);
+}
+
 static int match_filter(const struct diff_options *options, const struct diff_filepair *p)
 {
 	return (((p->status == DIFF_STATUS_MODIFIED) &&
@@ -6612,6 +6646,28 @@ static int match_filter(const struct diff_options *options, const struct diff_fi
 		 filter_bit_tst(p->status, options)));
 }
 
+static void diffcore_apply_restrict(struct diff_options *options)
+{
+	int i;
+	struct diff_queue_struct *q = &diff_queued_diff;
+	struct diff_queue_struct outq;
+
+	DIFF_QUEUE_CLEAR(&outq);
+
+	if (!options->sparse_checkout_patterns)
+		return;
+
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		if (match_sparse_checkout_patterns(options, p))
+			diff_q(&outq, p);
+		else
+			diff_free_filepair(p);
+	}
+	free(q->queue);
+	*q = outq;
+}
+
 static void diffcore_apply_filter(struct diff_options *options)
 {
 	int i;
@@ -6827,6 +6883,7 @@ void diffcore_std(struct diff_options *options)
 		/* See try_to_follow_renames() in tree-diff.c */
 		diff_resolve_rename_copy();
 	diffcore_apply_filter(options);
+	diffcore_apply_restrict(options);
 
 	if (diff_queued_diff.nr && !options->flags.diff_from_contents)
 		options->flags.has_changes = 1;
diff --git a/diff.h b/diff.h
index 8ae18e5ab1e..f651216da13 100644
--- a/diff.h
+++ b/diff.h
@@ -396,6 +396,7 @@ struct diff_options {
 	struct repository *repo;
 	struct option *parseopts;
 	struct strmap *additional_path_headers;
+	struct pattern_list *sparse_checkout_patterns;
 
 	int no_free;
 };
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index b9350c075c2..4c416ef8e82 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -504,6 +504,36 @@ test_expect_success 'diff --cached' '
 	test_all_match git diff --cached
 '
 
+test_expect_success 'diff --restrict' '
+	init_repos &&
+
+	test_all_match mkdir modules &&
+	test_all_match touch modules/a &&
+	test_all_match touch deep/b &&
+	test_all_match git rm deep/a &&
+	test_all_match git add --sparse modules deep &&
+	run_on_all git diff --restrict --staged --stat &&
+	cat >expect <<-EOF &&
+	 deep/a | 1 -
+	 deep/b | 0
+	 2 files changed, 1 deletion(-)
+	EOF
+	test_cmp expect sparse-checkout-out &&
+	cat >expect <<-EOF &&
+	 deep/a | 1 -
+	 deep/b | 0
+	 2 files changed, 1 deletion(-)
+	EOF
+	test_cmp expect sparse-index-out &&
+	cat >expect <<-EOF &&
+	 deep/a    | 1 -
+	 deep/b    | 0
+	 modules/a | 0
+	 3 files changed, 1 deletion(-)
+	EOF
+	test_cmp expect full-checkout-out
+'
+
 # NEEDSWORK: sparse-checkout behaves differently from full-checkout when
 # running this test with 'df-conflict-2' after 'df-conflict-1'.
 test_expect_success 'diff with renames and conflicts' '

base-commit: dda7228a83e2e9ff584bf6adbf55910565b41e14
-- 
gitgitgadget
