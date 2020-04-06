Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E708BC2BA80
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 17:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30D121841
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 17:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caYsfObo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbgDFRAL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:00:11 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:39001 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729521AbgDFRAK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 13:00:10 -0400
Received: by mail-ed1-f54.google.com with SMTP id a43so371692edf.6
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 10:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZsHUaVtS2qOnoUjyOO9pvlAfuFOOP8BOHJQ/886lGO4=;
        b=caYsfObolnfBGl7vRcnhVWquzT//5ZJmkdE84naTwoBl738o+785hqVNeZc31sseah
         nD25ZER10wANPQkuAI0Iao/DnibAkXoNy9MSErF1GcgAr5ZJWEBCwLLW3loAVf0pmGYf
         yiHoMKcOhXRNym8SaH3jEXXtX1+MYTQo6k13MjWXI9qIzAC8h14MwOrq+5pJMMRVghjr
         Xg7vvxqxCt8k5hbvmMolLnIn98aJamW3EioLEANnVLPGZ2vKidr3G8YCUL0yxVoQQUBn
         494tEQbpYwhStDXS9k5rkanukKsP+hDVrBAmG4e+RTphjhscaadkcJl2bmiiz/UtaCn0
         z4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZsHUaVtS2qOnoUjyOO9pvlAfuFOOP8BOHJQ/886lGO4=;
        b=i6ZmTTmngJXlqTUalGZWrjZXKU5S5jA6A6T2nm86h8f71W/6BmkB6H605T/TkREg2V
         pe/E+4UAOy79JSacXlIweBiJe1VGHtzEHADz0dmT4j/L8RzUgv/zcGv6UTmePBHIZ4b7
         +JD2n5nTl69v1ZdPv7GFNu5F8jDvKjoNMOP2xz86nIFxI5SwnXz5JORXiA52owNVWHlB
         3V7DTqi4kdosE27fD6C+8tRbzRETn0et3Zyo/eX3mdsQoL2wQwoKADzF1lRsSNintdl1
         NtodUpB0H4wYuqXtruLYsuhtWeWvukTjlsQ8MfYDNb+8Aep+7AvP1jPbiIDA0IJd955K
         8ywg==
X-Gm-Message-State: AGi0PubrxSTwuqsar86MPPHn/7WptSHcDvBSoISTSql4Xlxt+Et/DYO2
        x0n0FCr5dtk/9X5rm/7pb78YgNm4
X-Google-Smtp-Source: APiQypLVXNlbMOAVh3Q2Z/fq158wY84DLSbBeB7blpxEye7H71AStZfsDxZPyl5UGMLr77jNC+Q6YA==
X-Received: by 2002:a05:6402:1655:: with SMTP id s21mr20033695edx.295.1586192407497;
        Mon, 06 Apr 2020 10:00:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b15sm2486178edn.69.2020.04.06.10.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 10:00:07 -0700 (PDT)
Message-Id: <b899df5c98e302c23cc50ee2b2d187dfde4e1e7f.1586192395.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
References: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
        <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Apr 2020 16:59:54 +0000
Subject: [PATCH v4 14/15] t4216: add end to end tests for git log with Bloom
 filters
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>,
        Garima Singh <garima.singh@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Garima Singh <garima.singh@microsoft.com>

These tests exercises writing commit graph with Bloom filters
and exercises 'git log -- path' with all the applicable
options. They check that the output is the same with and
without Bloom filters, confirm Bloom filters were used by
checking if trace2 statistics were logged correctly.

Also confirms cases where Bloom filters are not used:
1. Multiple path specs,
2. --walk-reflogs (see patch titled 'revision.c: use Bloom filters...'
   for details,
3. If the latest commit graph does not have Bloom filters

Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 t/helper/test-read-graph.c |   4 +
 t/t4216-log-bloom.sh       | 155 +++++++++++++++++++++++++++++++++++++
 2 files changed, 159 insertions(+)
 create mode 100755 t/t4216-log-bloom.sh

diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index f8a461767ca..4223ff32fb6 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -45,6 +45,10 @@ int cmd__read_graph(int argc, const char **argv)
 		printf(" commit_metadata");
 	if (graph->chunk_extra_edges)
 		printf(" extra_edges");
+	if (graph->chunk_bloom_indexes)
+		printf(" bloom_indexes");
+	if (graph->chunk_bloom_data)
+		printf(" bloom_data");
 	printf("\n");
 
 	UNLEAK(graph);
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
new file mode 100755
index 00000000000..38accd272df
--- /dev/null
+++ b/t/t4216-log-bloom.sh
@@ -0,0 +1,155 @@
+#!/bin/sh
+
+test_description='git log for a path with Bloom filters'
+. ./test-lib.sh
+
+GIT_TEST_COMMIT_GRAPH=0
+GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
+
+test_expect_success 'setup test - repo, commits, commit graph, log outputs' '
+	git init &&
+	mkdir A A/B A/B/C &&
+	test_commit c1 A/file1 &&
+	test_commit c2 A/B/file2 &&
+	test_commit c3 A/B/C/file3 &&
+	test_commit c4 A/file1 &&
+	test_commit c5 A/B/file2 &&
+	test_commit c6 A/B/C/file3 &&
+	test_commit c7 A/file1 &&
+	test_commit c8 A/B/file2 &&
+	test_commit c9 A/B/C/file3 &&
+	test_commit c10 file_to_be_deleted &&
+	git checkout -b side HEAD~4 &&
+	test_commit side-1 file4 &&
+	git checkout master &&
+	git merge side &&
+	test_commit c11 file5 &&
+	mv file5 file5_renamed &&
+	git add file5_renamed &&
+	git commit -m "rename" &&
+	rm file_to_be_deleted &&
+	git add . &&
+	git commit -m "file removed" &&
+	git commit-graph write --reachable --changed-paths
+'
+graph_read_expect () {
+	NUM_CHUNKS=5
+	cat >expect <<- EOF
+	header: 43475048 1 1 $NUM_CHUNKS 0
+	num_commits: $1
+	chunks: oid_fanout oid_lookup commit_metadata bloom_indexes bloom_data
+	EOF
+	test-tool read-graph >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'commit-graph write wrote out the bloom chunks' '
+	graph_read_expect 15
+'
+
+# Turn off any inherited trace2 settings for this test.
+sane_unset GIT_TRACE2 GIT_TRACE2_PERF GIT_TRACE2_EVENT
+sane_unset GIT_TRACE2_PERF_BRIEF
+sane_unset GIT_TRACE2_CONFIG_PARAMS
+
+setup () {
+	rm "$TRASH_DIRECTORY/trace.perf"
+	git -c core.commitGraph=false log --pretty="format:%s" $1 >log_wo_bloom &&
+	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.perf" git -c core.commitGraph=true log --pretty="format:%s" $1 >log_w_bloom
+}
+
+test_bloom_filters_used () {
+	log_args=$1
+	bloom_trace_prefix="statistics:{\"filter_not_present\":0,\"zero_length_filter\":0,\"maybe\""
+	setup "$log_args" &&
+	grep -q "$bloom_trace_prefix" "$TRASH_DIRECTORY/trace.perf" && 
+	test_cmp log_wo_bloom log_w_bloom &&
+    test_path_is_file "$TRASH_DIRECTORY/trace.perf"
+}
+
+test_bloom_filters_not_used () {
+	log_args=$1
+	setup "$log_args" &&
+	!(grep -q "statistics:{\"filter_not_present\":" "$TRASH_DIRECTORY/trace.perf") && 
+	test_cmp log_wo_bloom log_w_bloom
+}
+
+for path in A A/B A/B/C A/file1 A/B/file2 A/B/C/file3 file4 file5 file5_renamed file_to_be_deleted
+do
+	for option in "" \
+              "--all" \
+		      "--full-history" \
+		      "--full-history --simplify-merges" \
+		      "--simplify-merges" \
+		      "--simplify-by-decoration" \
+		      "--follow" \
+		      "--first-parent" \
+		      "--topo-order" \
+		      "--date-order" \
+		      "--author-date-order" \
+		      "--ancestry-path side..master"
+	do
+		test_expect_success "git log option: $option for path: $path" '
+			test_bloom_filters_used "$option -- $path"
+		'
+	done
+done
+
+test_expect_success 'git log -- folder works with and without the trailing slash' '
+	test_bloom_filters_used "-- A" &&
+	test_bloom_filters_used "-- A/"
+'
+
+test_expect_success 'git log for path that does not exist. ' '
+	test_bloom_filters_used "-- path_does_not_exist"
+'
+
+test_expect_success 'git log with --walk-reflogs does not use Bloom filters' '
+	test_bloom_filters_not_used "--walk-reflogs -- A"
+'
+
+test_expect_success 'git log -- multiple path specs does not use Bloom filters' '
+	test_bloom_filters_not_used "-- file4 A/file1"
+'
+
+test_expect_success 'git log with wildcard that resolves to a single path uses Bloom filters' '
+	test_bloom_filters_used "-- *4" &&
+	test_bloom_filters_used "-- *renamed"
+'
+
+test_expect_success 'git log with wildcard that resolves to a multiple paths does not uses Bloom filters' '
+	test_bloom_filters_not_used "-- *" &&
+	test_bloom_filters_not_used "-- file*"
+'
+
+test_expect_success 'setup - add commit-graph to the chain without Bloom filters' '
+	test_commit c14 A/anotherFile2 &&
+	test_commit c15 A/B/anotherFile2 &&
+	test_commit c16 A/B/C/anotherFile2 &&
+	GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0 git commit-graph write --reachable --split &&
+	test_line_count = 2 .git/objects/info/commit-graphs/commit-graph-chain
+'
+
+test_expect_success 'Do not use Bloom filters if the latest graph does not have Bloom filters.' '
+	test_bloom_filters_not_used "-- A/B"
+'
+
+test_expect_success 'setup - add commit-graph to the chain with Bloom filters' '
+	test_commit c17 A/anotherFile3 &&
+	git commit-graph write --reachable --changed-paths --split &&
+	test_line_count = 3 .git/objects/info/commit-graphs/commit-graph-chain
+'
+
+test_bloom_filters_used_when_some_filters_are_missing () {
+	log_args=$1
+	bloom_trace_prefix="statistics:{\"filter_not_present\":3,\"zero_length_filter\":0,\"maybe\":8,\"definitely_not\":6"
+	setup "$log_args" &&
+	grep -q "$bloom_trace_prefix" "$TRASH_DIRECTORY/trace.perf" && 
+	test_cmp log_wo_bloom log_w_bloom
+}
+
+test_expect_success 'Use Bloom filters if they exist in the latest but not all commit graphs in the chain.' '
+	test_bloom_filters_used_when_some_filters_are_missing "-- A/B"
+'
+
+test_done
\ No newline at end of file
-- 
gitgitgadget

