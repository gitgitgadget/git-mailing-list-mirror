Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A29C2BB1D
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 04:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E135206E9
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 04:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="eXRQ6LoS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405081AbgDNEEd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 00:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405073AbgDNEEc (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 00:04:32 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F96C0A3BDC
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 21:04:32 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id k15so5503904pfh.6
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 21:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Aut8rMJV0jp/BNl6D8qmcJnjFg6A4MxBxy2OkAM1n24=;
        b=eXRQ6LoSL1SPK/Job0BfTE+nOHijKwRZpIinxYdRbhzR5CApydH++6rdcr/fNedsxJ
         8Cx+YEmH+adhewC/0uCdPVU/m9C63FMxR1J3ilKT+KEkmBFN321xsTWctKnLIgSu8cEA
         wwVkEfGAX6RLrCBtJR3H/QYZCSlZguZZsTZzdczMks3REjeak4p+sC/xRk7FEZbf70Jc
         XoQfYPCgjvw7n6wPpQmmzMBLI3hiG2zWTt+SI2UqVplPtAHUT6PJe6NWvyBZbtaO79CR
         uoOF9Ba3mlQvsdgWXigOwdqe/XvoldwlrT8QAsXrlcp8RAsv44AP1BGxHG+fpeelzwcC
         MDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Aut8rMJV0jp/BNl6D8qmcJnjFg6A4MxBxy2OkAM1n24=;
        b=d0oa0VurlvHPViizjPeeQxEorbgo5MyfjuTuZyFZDjqpnx3tGF9ilob+7eTkrrJBCf
         s8iF0Puuyn8jtPsmM1L35y/AuxwzgNgp6V4L5DMNA1LZa9ZAsld/6b41sDep04HOaJf2
         ZTkSzvZE4+AZapbHiH2qz6rFRvWbm13fsEGi3DG7KrCZArBuxMXQBezg+nUhJFYPntHT
         bw7uYAC7fFjcrPROmZaP3VygXXJ8YRU23o0huvoOJNbB47ECvruPbT0YmCOkzXwqAD82
         TgT51Wm2iLKMJ0Mc3doVd0yTbmlxEz7bEsLmGlG1Lw3ZyD9EjlvuzW8+9moVmgA8qzFX
         bW+g==
X-Gm-Message-State: AGi0PuZ8rJbINqgzBIO7kASUU5YK11rhgPiUrCh3B2QMSZZsPXLiecvX
        +JbA+56uq2GP7fglB80s4+rdff6jBJz+KPIu
X-Google-Smtp-Source: APiQypKjIuKXEmwHPjMRriH+6usqf+AEtZHanj3o74zdrsn90nMI89G/RnwQvVJsX6Z1VDg/gLvNEg==
X-Received: by 2002:a63:296:: with SMTP id 144mr20017590pgc.110.1586837071373;
        Mon, 13 Apr 2020 21:04:31 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id x186sm9872502pfb.151.2020.04.13.21.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 21:04:30 -0700 (PDT)
Date:   Mon, 13 Apr 2020 22:04:29 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, szeder.dev@gmail.com
Subject: [PATCH 7/7] commit-graph.c: introduce '--[no-]check-oids'
Message-ID: <1ff42f4c3d568dd25889d2808cda3edf38a36cb9.1586836700.git.me@ttaylorr.com>
References: <cover.1586836700.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1586836700.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When operating on a stream of commit OIDs on stdin, 'git commit-graph
write' checks that each OID refers to an object that is indeed a commit.
This is convenient to make sure that the given input is well-formed, but
can sometimes be undesirable.

For example, server operators may wish to feed the refnames that were
updated during a push to 'git commit-graph write --input=stdin-commits',
and silently discard refs that don't point at commits. This can be done
by combing the output of 'git for-each-ref' with '--format
%(*objecttype)', but this requires opening up a potentially large number
of objects.  Instead, it is more convenient to feed the updated refs to
the commit-graph machinery, and let it throw out refs that don't point
to commits.

Introduce '--[no-]check-oids' to make such a behavior possible. With
'--check-oids' (the default behavior to retain backwards compatibility),
'git commit-graph write' will barf on a non-commit line in its input.
With 'no-check-oids', such lines will be silently ignored, making the
above possible by specifying this option.

No matter which is supplied, 'git commit-graph write' retains the
behavior from the previous commit of rejecting non-OID inputs like
"HEAD" and "refs/heads/foo" as before.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-commit-graph.txt |  5 +++++
 builtin/commit-graph.c             | 11 ++++++++---
 t/t5318-commit-graph.sh            | 28 ++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 46f7f7c573..91e8027b86 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -82,6 +82,11 @@ tip with the previous tip.
 Finally, if `--expire-time=<datetime>` is not specified, let `datetime`
 be the current time. After writing the split commit-graph, delete all
 unused commit-graph whose modified times are older than `datetime`.
++
+The `--[no-]check-oids` option decides whether or not OIDs are required
+to be commits. By default, `--check-oids` is implied, generating an
+error on non-commit objects. If `--no-check-oids` is given, non-commits
+are silently discarded.
 
 'verify'::
 
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index c69716aa7e..2d0a8e822a 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -11,7 +11,7 @@ static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
 	N_("git commit-graph write [--object-dir <objdir>] [--append] "
 	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] "
-	   "[--[no-]progress] <split options>"),
+	   "[--[no-]progress] [--[no-]check-oids] <split options>"),
 	NULL
 };
 
@@ -23,7 +23,7 @@ static const char * const builtin_commit_graph_verify_usage[] = {
 static const char * const builtin_commit_graph_write_usage[] = {
 	N_("git commit-graph write [--object-dir <objdir>] [--append] "
 	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] "
-	   "[--[no-]progress] <split options>"),
+	   "[--[no-]progress] [--[no-]check-oids] <split options>"),
 	NULL
 };
 
@@ -36,6 +36,7 @@ static struct opts_commit_graph {
 	int split;
 	int shallow;
 	int progress;
+	int check_oids;
 } opts;
 
 static struct object_directory *find_odb(struct repository *r,
@@ -163,6 +164,8 @@ static int graph_write(int argc, const char **argv)
 			N_("allow writing an incremental commit-graph file"),
 			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
 			write_option_parse_split),
+		OPT_BOOL(0, "check-oids", &opts.check_oids,
+			N_("require OIDs to be commits")),
 		OPT_INTEGER(0, "max-commits", &split_opts.max_commits,
 			N_("maximum number of commits in a non-base split commit-graph")),
 		OPT_INTEGER(0, "size-multiple", &split_opts.size_multiple,
@@ -173,6 +176,7 @@ static int graph_write(int argc, const char **argv)
 	};
 
 	opts.progress = isatty(2);
+	opts.check_oids = 1;
 	split_opts.size_multiple = 2;
 	split_opts.max_commits = 0;
 	split_opts.expire_time = 0;
@@ -227,7 +231,8 @@ static int graph_write(int argc, const char **argv)
 
 				oidset_insert(&commits, &oid);
 			}
-			flags |= COMMIT_GRAPH_WRITE_CHECK_OIDS;
+			if (opts.check_oids)
+				flags |= COMMIT_GRAPH_WRITE_CHECK_OIDS;
 		}
 
 		UNLEAK(buf);
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index e874a12696..2cbd301abe 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -49,6 +49,34 @@ test_expect_success 'exit with correct error on bad input to --stdin-commits' '
 	test_i18ngrep "invalid commit object id" stderr
 '
 
+graph_expect_commits() {
+	test-tool read-graph >got
+	if ! grep "num_commits: $1" got
+	then
+		echo "graph_expect_commits: expected $1 commit(s), got:"
+		cat got
+		false
+	fi
+}
+
+test_expect_success 'ignores non-commit OIDs to --input=stdin-commits with --no-check-oids' '
+	test_when_finished rm -rf "$objdir/info/commit-graph" &&
+	cd "$TRASH_DIRECTORY/full" &&
+	# write a graph to ensure layers are/are not added appropriately
+	git rev-parse HEAD~1 >base &&
+	git commit-graph write --stdin-commits <base &&
+	graph_expect_commits 2 &&
+	# bad input is rejected
+	echo HEAD >bad &&
+	test_expect_code 1 git commit-graph write --stdin-commits <bad 2>err &&
+	test_i18ngrep "invalid commit object id" err &&
+	graph_expect_commits 2 &&
+	# update with valid commit OID, ignore tree OID
+	git rev-parse HEAD HEAD^{tree} >in &&
+	git commit-graph write --stdin-commits --no-check-oids <in &&
+	graph_expect_commits 3
+'
+
 graph_git_two_modes() {
 	git -c core.commitGraph=true $1 >output
 	git -c core.commitGraph=false $1 >expect
-- 
2.26.0.106.g9fadedd637
