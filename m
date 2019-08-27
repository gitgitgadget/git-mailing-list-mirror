Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36BB91F461
	for <e@80x24.org>; Tue, 27 Aug 2019 02:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbfH0C6U (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 22:58:20 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34557 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728345AbfH0C6T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 22:58:19 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7R2wBcB017744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Aug 2019 22:58:12 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id BAAF242049E; Mon, 26 Aug 2019 22:58:11 -0400 (EDT)
Date:   Mon, 26 Aug 2019 22:58:11 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: Missing file in 2.23 (p5302-pack-index.subtests)?
Message-ID: <20190827025811.GJ28066@mit.edu>
References: <20190818160317.GA13772@mit.edu>
 <20190826205012.GB27762@sigill.intra.peff.net>
 <20190827012942.GD28066@mit.edu>
 <20190827022700.GA31125@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827022700.GA31125@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 26, 2019 at 10:27:00PM -0400, Jeff King wrote:
> > cannot open test-results/p5302-pack-index.subtests: No such file or directory at ./aggregate.perl line 153.
> 
> Implies that we're trying to _write_ to it, and that the problem is that
> test-results doesn't exist. That should be set up by this part of
> perf-lib:

Hmm....   test-results does exist after the failure:

<tytso@lambda> {/usr/projects/git/git-core/t/perf}   (master)
1174% rm -rf test-results ; ./run p5302-pack-index.sh
=== Running 1 tests in this tree ===
warning: $GIT_PERF_LARGE_REPO is $GIT_BUILD_DIR.
warning: This will work, but may not be a sufficiently large repo
warning: for representative measurements.
not ok 1 - repack
#	
#		git repack -ad &&
#		PACK=$(ls .git/objects/pack/*.pack | head -n1) &&
#		test -f "$PACK" &&
#		export PACK
#	
cannot open test-results/p5302-pack-index.subtests: No such file or directory at ./aggregate.perl line 153.
<tytso@lambda> {/usr/projects/git/git-core/t/perf}   (master)
1175% ls test-results
total 0
0 run_subsections.names

Maybe we're not in the right cwd for some reason?!?


> There are some bits of test-lib.sh that re-exec the script, but I think
> we ironed out the weirdness there (and I use "--verbose-log" myself,
> which is one such option). But just in case: do you set GIT_TEST_OPTS in
> your config.mak?

You mean in my top-level directory?  I don't have a config.mak file in
there:

<tytso@lambda> {/usr/projects/git/git-core}   (master)
1151% grep GIT_TEST_OPTS config.mak.*
<tytso@lambda> {/usr/projects/git/git-core}   (master)
1181% ls config.mak*
 4 config.mak.autogen   4 config.mak.dev   4 config.mak.in  24 config.mak.uname
<tytso@lambda> {/usr/projects/git/git-core}   (master)
1182% grep GIT_TEST_OPTS config.mak.*

					- Ted
