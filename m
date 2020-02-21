Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CE3C35669
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 22:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB322072C
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 22:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ocfn5I3u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbgBUWqI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 17:46:08 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:44408 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgBUWqH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 17:46:07 -0500
Received: by mail-lj1-f178.google.com with SMTP id q8so3819891ljj.11
        for <git@vger.kernel.org>; Fri, 21 Feb 2020 14:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=XdaKl3sDy2RDBf8F2T9jnrFblXsKWE/S+Xv3hY9JU5k=;
        b=ocfn5I3uLN/hwmwVZNs4oBd4r2ZPuD0igAKfkt4ymvmwL+B86C4qf9cM7sFn88bJ/f
         bjHKwyXmO+qX9MqnAGM6eTg93rqp/rhDDcNuZ9y5YgKDSrBIJp5lA+SPS/P4FiEMa4rE
         NnjakTE3vyLc18FmuaIplumFobPXyaUe57le8yD3CgZ9AvamKtv3igqgSpb7Y7tSgeL+
         R9OZAwQdQiYRCJMnAFLLz453y+bgeVK7HwesU4VdtRT7DMmL9HTIQAUqwzWcH7+PAcB8
         WSqIkshaqJ4Nbuyn6w08fqAshF3NcSK7MyfELxJIXxF6Z5eE5WPrXhmBpP/Frrf9sx4P
         Bepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=XdaKl3sDy2RDBf8F2T9jnrFblXsKWE/S+Xv3hY9JU5k=;
        b=tdG9lvfG6hly/1Es9PVTIHGSRRQykXV9GRHdyN1/gTbFfnjETgUqGdmf4zwucmTv5P
         T+pzlGIEU65lBYUJKdUcabfryVh0LLP8UbYseIedYaOG+d8M0b4UANYCLs5CDqFL/pPT
         2KC6Mi9u+n1IheiVmYSZ2JUWxai//LlzVx6SyUIe8JdzeAPSfkaIcuO8/ujUQEYU871N
         fCs+1FzF9Bd3jdp6+vsc2wP1Q27AeBjLFmLWlYBP3kMMpRYtmdG6CxfCtga9NtjVnBcM
         FSPoHse/F/Cx5kwVWHaVDaX8H24NS3f38SPiA6nMwiyKgw3daeetQUShPmHdzXKZTWBH
         hong==
X-Gm-Message-State: APjAAAXK77y7fToRvZpzcelHvJ7ONkBLFa944AzaAg4x60FsFsq5iOGv
        8DQm9nO5jYBf3ouTJM1GotU=
X-Google-Smtp-Source: APXvYqykvRBmw/csG04OsrbN0YGYiFtWIeju8Kg6yKEoUZzmgaXhm5R5Sq8Sv5GDrNHOTzNDhvoJRQ==
X-Received: by 2002:a2e:9090:: with SMTP id l16mr23866633ljg.281.1582325164763;
        Fri, 21 Feb 2020 14:46:04 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id u16sm2335917ljl.34.2020.02.21.14.46.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Feb 2020 14:46:03 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Garima Singh <garimasigit@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH v2 10/11] revision.c: use Bloom filters to speed up path based revision walks
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
        <77f1c561e8205c0598b57bf572640d21d64757f8.1580943390.git.gitgitgadget@gmail.com>
Date:   Fri, 21 Feb 2020 23:45:51 +0100
In-Reply-To: <77f1c561e8205c0598b57bf572640d21d64757f8.1580943390.git.gitgitgadget@gmail.com>
        (Garima Singh via GitGitGadget's message of "Wed, 05 Feb 2020 22:56:29
        +0000")
Message-ID: <86r1ynbluo.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Garima Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

This is a second part of my response, focusing solely on tests of the
Bloom filters feature.

[...]
> diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
> index d2884efe0a..aff597c7a3 100644
> --- a/t/helper/test-read-graph.c
> +++ b/t/helper/test-read-graph.c
> @@ -45,6 +45,10 @@ int cmd__read_graph(int argc, const char **argv)
>  		printf(" commit_metadata");
>  	if (graph->chunk_extra_edges)
>  		printf(" extra_edges");
> +	if (graph->chunk_bloom_indexes)
> +		printf(" bloom_indexes");
> +	if (graph->chunk_bloom_data)
> +		printf(" bloom_data");
>  	printf("\n");
>

All right, that is simple extension of 'test-helper read-graph'.

>  	UNLEAK(graph);
> diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
> new file mode 100755
> index 0000000000..19eca1864b
> --- /dev/null
> +++ b/t/t4216-log-bloom.sh
> @@ -0,0 +1,140 @@
> +#!/bin/sh
> +
> +test_description=3D'git log for a path with bloom filters'
> +. ./test-lib.sh
> +
> +test_expect_success 'setup test - repo, commits, commit graph, log outpu=
ts' '
> +	git init &&
> +	mkdir A A/B A/B/C &&
> +	test_commit c1 A/file1 &&
> +	test_commit c2 A/B/file2 &&
> +	test_commit c3 A/B/C/file3 &&
> +	test_commit c4 A/file1 &&
> +	test_commit c5 A/B/file2 &&
> +	test_commit c6 A/B/C/file3 &&
> +	test_commit c7 A/file1 &&
> +	test_commit c8 A/B/file2 &&
> +	test_commit c9 A/B/C/file3 &&
> +	git checkout -b side HEAD~4 &&
> +	test_commit side-1 file4 &&
> +	git checkout master &&
> +	git merge side &&
> +	test_commit c10 file5 &&

Unfortunately this might be not enough for Git's heuristic similarity
based rename detection, as it creates 'file5' file with content 'c10'.

[Checking something].  Well, actually it looks like it works, even with
not much contents.  I thought you would need to use something like

  +	test_write_lines 1 2 3 4 5 6 7 8 9 >file5 &&
  +	git add file5 &&
  +	git commit -m c10 &&

But it turns out that it is, s far as I have checked, not necessary.

> +	mv file5 file5_renamed &&
> +	git add file5_renamed &&
> +	git commit -m "rename" &&
> +	git commit-graph write --reachable --changed-paths
> +'

Hmmm... there is no test for file that was present in history but got
deleted.  Might be important (because of pre-image vs post-image name
issues).


Very minor issue: following the style used in t/test-lib-functions.sh
and the style guide in CodingGuidelines, it should be

  +graph_read_expect () {

and the same for the following functions.


https://github.com/git/git/blob/master/Documentation/CodingGuidelines#L144

 - We prefer a space between the function name and the parentheses,
   and no space inside the parentheses. The opening "{" should also
   be on the same line.

	(incorrect)
	my_function(){
		...

	(correct)
	my_function () {
		...

> +graph_read_expect() {
> +	OPTIONAL=3D""
> +	NUM_CHUNKS=3D5
> +	cat >expect <<- EOF
> +	header: 43475048 1 1 $NUM_CHUNKS 0
> +	num_commits: $1
> +	chunks: oid_fanout oid_lookup commit_metadata bloom_indexes bloom_data

Either OPTIONAL remains unused, and should be removed, or we leave it
for possible future extension, and we write

  +	chunks: oid_fanout oid_lookup commit_metadata bloom_indexes bloom_data$=
OPTIONAL

like in t/t5318-commit-graph.sh.

> +	EOF
> +	test-tool read-graph >output &&
> +	test_cmp expect output

Why 'output', and not 'actual'?

> +}
> +
> +test_expect_success 'commit-graph write wrote out the bloom chunks' '
> +	graph_read_expect 13
> +'

All right, that is sanity-checking 'git commit-graph write --changed-paths'.

> +
> +setup() {

I wonder if we can come up with a better name... setup_log(),
setup_log_bloom(), log_compare()?

> +	rm output

This shouldn't be here, in this function.  Or perhaps it shouldn't even
be used at all; having 'output' doesn't hinder anything.

> +	rm "$TRASH_DIRECTORY/trace.perf"

All right, this cleanup is needed.

> +	git -c core.commitGraph=3Dfalse log --pretty=3D"format:%s" $1 >log_wo_b=
loom
> +	GIT_TRACE2_PERF=3D"$TRASH_DIRECTORY/trace.perf" git -c core.commitGraph=
=3Dtrue log --pretty=3D"format:%s" $1 >log_w_bloom

All right, we prepare for comparing version without Bloom filters
(reference) and with Bloom filters, and for checking if Bloom filters
were used.

> +}

This setup() function above is missing the && chain.

It should then in my opinion read:

  +setup () {
  +	rm "$TRASH_DIRECTORY/trace.perf" &&
  +	git -c core.commitGraph=3Dfalse log --format=3D"%s" $1 >log_wo_bloom &&
  +	GIT_TRACE2_PERF=3D"$TRASH_DIRECTORY/trace.perf" \
  +	git -c core.commitGraph=3Dtrue log --format=3D"%s" $1 >log_w_bloom
  +}

Also, perhaps we should add at the beginning of this test file, outside
anu test_expect_success block, the following (see t/*trace2*.sh files):

  # Turn off any inherited trace2 settings for this test.
  sane_unset GIT_TRACE2 GIT_TRACE2_PERF GIT_TRACE2_EVENT
  sane_unset GIT_TRACE2_PERF_BRIEF
  sane_unset GIT_TRACE2_CONFIG_PARAMS

> +
> +test_bloom_filters_used() {
> +	log_args=3D$1
> +	bloom_trace_prefix=3D"statistics:{\"filter_not_present\":0,\"zero_lengt=
h_filter\":0,\"maybe\""
> +	setup "$log_args"

Missing && chain.

> +	grep -q "$bloom_trace_prefix" "$TRASH_DIRECTORY/trace.perf" && test_cmp=
 log_wo_bloom log_w_bloom

Why no line break after &&?

> +}

Ugh, examining JSON output with regexp is in my opinion quite fragile.
Though I am not sure if requiring Perl and JSON module installed like
t/t0212-trace2-event.sh is any better.

> +
> +test_bloom_filters_not_used() {
> +	log_args=3D$1
> +	setup "$log_args"
> +	!(grep -q "statistics:{\"filter_not_present\":" "$TRASH_DIRECTORY/trace=
.perf") && test_cmp log_wo_bloom log_w_bloom

We should also check that "$TRASH_DIRECTORY/trace.perf" file exist with
test_path_is_file.

Also, testing that something was not found is a bit fragile, but I don't
have any better idea on how to do this test without negating grep exit
value.

> +}
> +
> +for path in A A/B A/B/C A/file1 A/B/file2 A/B/C/file3 file4 file5_renamed

NOTE: file5 is missing from this list!

I suspect that adding it might cause the test to fail.

> +do
> +	for option in "" \
> +		      "--full-history" \
> +		      "--full-history --simplify-merges" \
> +		      "--simplify-merges" \
> +		      "--simplify-by-decoration" \
> +		      "--follow" \
> +		      "--first-parent" \
> +		      "--topo-order" \
> +		      "--date-order" \
> +		      "--author-date-order" \
> +		      "--ancestry-path side..master"
> +	do
> +		test_expect_success "git log option: $option for path: $path" '
> +			test_bloom_filters_used "$option -- $path"

All right, this tests that Bloom filters were used *and* that the
command run with Bloom filters and without Bloom filters (without
commit-graph) produces the same output.

> +		'
> +	done
> +done
> +
> +test_expect_success 'git log -- folder works with and without the traili=
ng slash' '
> +	test_bloom_filters_used "-- A" &&
> +	test_bloom_filters_used "-- A/"
> +'

All right.

I wonder if we should test for insane test case, namely pathname to an
ordinary file that ends with slash:

  +	test_bloom_filters_used "-- file4" &&
  +	test_bloom_filters_used "-- file4/"

The latter should produce no output, being treated as not existing file.

> +
> +test_expect_success 'git log for path that does not exist. ' '
> +	test_bloom_filters_used "-- path_does_not_exist"
> +'

All right.

> +
> +test_expect_success 'git log with --walk-reflogs does not use bloom filt=
ers' '
> +	test_bloom_filters_not_used "--walk-reflogs -- A"
> +'

All right, but why is it so?

> +
> +test_expect_success 'git log -- multiple path specs does not use bloom f=
ilters' '
> +	test_bloom_filters_not_used "-- file4 A/file1"
> +'

All right, though this is limitation of current code, not limitation of
technique, so _maybe_ it would be better to test_expect_failure that for
multiple pathspecs bloom_filters_used...

> +
> +test_expect_success 'git log with wildcard that resolves to a single pat=
h uses bloom filters' '
> +	test_bloom_filters_used "-- *4" &&
> +	test_bloom_filters_used "-- *renamed"
> +'
> +
> +test_expect_success 'git log with wildcard that resolves to a multiple p=
aths does not uses bloom filters' '
> +	test_bloom_filters_not_used "-- *" &&
> +	test_bloom_filters_not_used "-- file*"
> +'

Same here.

> +
> +test_expect_success 'setup - add commit-graph to the chain without bloom=
 filters' '
> +	test_commit c14 A/anotherFile2 &&
> +	test_commit c15 A/B/anotherFile2 &&
> +	test_commit c16 A/B/C/anotherFile2 &&
> +	GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=3D0 git commit-graph write --reacha=
ble --split &&
> +	test_line_count =3D 2 .git/objects/info/commit-graphs/commit-graph-chain
> +'
> +
> +test_expect_success 'git log does not use bloom filters if the latest gr=
aph does not have bloom filters.' '
> +	test_bloom_filters_not_used "-- A/B"
> +'

All right... though I would try to come up with a shorter test name :-)

> +
> +test_expect_success 'setup - add commit-graph to the chain with bloom fi=
lters' '
> +	test_commit c17 A/anotherFile3 &&
> +	git commit-graph write --reachable --changed-paths --split &&
> +	test_line_count =3D 3 .git/objects/info/commit-graphs/commit-graph-chain
> +'
> +
> +test_bloom_filters_used_when_some_filters_are_missing() {
> +	log_args=3D$1
> +	bloom_trace_prefix=3D"statistics:{\"filter_not_present\":3,\"zero_lengt=
h_filter\":0,\"maybe\":6,\"definitely_not\":6"

Perhaps a better solution would be to use (enhanced) 'test-tool bloom'
to check which commits have Bloom filters and which do not.

> +	setup "$log_args"
> +	grep -q "$bloom_trace_prefix" "$TRASH_DIRECTORY/trace.perf" && test_cmp=
 log_wo_bloom log_w_bloom
> +}

Why broken && chain between setup() and the resr, and why && is not
followed by line break (as before)?

> +
> +test_expect_success 'git log uses bloom filters if they exist in the lat=
est but not all commit graphs in the chain.' '
> +	test_bloom_filters_used_when_some_filters_are_missing "-- A/B"
> +'
> +
> +test_done

All right... though the description of this test is a bit long.


Thank you for your work on this series.

Best,
--=20
Jakub Nar=C4=99bski
