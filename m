Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A244C2BA2B
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 04:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C6BE2078B
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 04:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="YNdMhIIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389259AbgDOEbm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 00:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388430AbgDOEbk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 00:31:40 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE3AC061A0C
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 21:31:40 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id np9so6246151pjb.4
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 21:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kToRRE5Gh6fL634MkGLH8FU6ZdChWz0viNJW01sk5ns=;
        b=YNdMhIIKbAK51c8Uq8RZ5N4npJAzZRmin56kPot8gY9LYZhjU9C+AYrzD4wUBNPZWC
         g0/lhMgBsKoL3qTkdXu/LJ+yuqQQaliFWSPLq+PXQeJ3uYVgB7qA98fqVNH6G+4NuzKv
         N3fN6XNEXOUCo8862RJvRsQ+fWwc8jPTGSPsD+b8HkzaS4HU6hJOscOZvlBXJAR3CHlh
         hHA0XT4p0zzejix2dRHSO0Phgmv7cSJC8WqqhA8H8y5HBmGZgreGLBsrq2OKw8ABMbMU
         usAZQCQTnGowCUgh07njODALwgyo8xw+9nXfDPO5o10NqVWfJFCT6p/yoboPUzJ3hu6p
         Wdig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kToRRE5Gh6fL634MkGLH8FU6ZdChWz0viNJW01sk5ns=;
        b=kx/g+g1R39+99d0hRNCVqIornJ53MCihfEhAVmIIS/iXXQND5IokPUSoVF1MVIpna8
         5M/kXy/vXrwaOhWxz9o1Rs9DDFgpg65ofeh57+MKAWfXC/kLegQJyAEV8v/WWtkHIPbD
         dBpSAMlV/9g0bSlDZziYm84GYhPVL7/vJqe6n4yvSw/HO0luOrARi+xfpLPba3zg6t6E
         OsnhHR+ESY2df6Hodr9Xx41Ifjty5xVg9LvPfamoSjqFZMvFgSuCljBBw2PB602lq3aR
         ffbYe1mBpwxzOvFDMSr1L8+dlt8Fb5M7vrvP19Q7kO2oF33mdEreRfUe02P14I1M31b1
         bYBg==
X-Gm-Message-State: AGi0PuZ4R3gDdqWAh+h4thyDllfaItVpTJ6o/Gk5qT4SxAzhS179yF3V
        S07v07dFBeqOZLoEQ5XpdmLiWLfgTEvchOAJ
X-Google-Smtp-Source: APiQypK14ngWc4FCKMgN1SC+eDhH1hcYzWOjv7ZsZyuRXcPq/fUS1ni8xB5k7bBXVGtQ0bRm/qSH3A==
X-Received: by 2002:a17:902:b941:: with SMTP id h1mr3174328pls.174.1586925099332;
        Tue, 14 Apr 2020 21:31:39 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id y2sm4390500pfg.8.2020.04.14.21.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 21:31:38 -0700 (PDT)
Date:   Tue, 14 Apr 2020 22:31:37 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, szeder.dev@gmail.com
Subject: Re: [PATCH 7/7] commit-graph.c: introduce '--[no-]check-oids'
Message-ID: <20200415043137.GA12136@syl.local>
References: <cover.1586836700.git.me@ttaylorr.com>
 <1ff42f4c3d568dd25889d2808cda3edf38a36cb9.1586836700.git.me@ttaylorr.com>
 <20200415042930.GA11703@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200415042930.GA11703@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 14, 2020 at 10:29:30PM -0600, Taylor Blau wrote:
> Whoops. I sent the wrong version of this patch. It should be the below:

Double whoops. I was on the wrong branch, and hit send too early. *This*
is the version of the patch that I meant to send ;).

--- >8 ---

Subject: [PATCH] commit-graph.c: introduce '--[no-]check-oids'

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
 commit-graph.c                     |  2 +-
 t/t5318-commit-graph.sh            | 28 ++++++++++++++++++++++++++++
 4 files changed, 42 insertions(+), 4 deletions(-)

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
diff --git a/commit-graph.c b/commit-graph.c
index f60346baee..b8737f0ce9 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -145,7 +145,7 @@ static int verify_commit_graph_lite(struct commit_graph *g)
 	 *
 	 * There should only be very basic checks here to ensure that
 	 * we don't e.g. segfault in fill_commit_in_graph(), but
-	 * because this is a very hot codepath nothing that e.g. loops
+	 e because this is a very hot codepath nothing that e.g. loops
 	 * over g->num_commits, or runs a checksum on the commit-graph
 	 * itself.
 	 */
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index e874a12696..7960cefa1b 100755
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
+	test_i18ngrep "unexpected non-hex object ID: HEAD" err &&
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

