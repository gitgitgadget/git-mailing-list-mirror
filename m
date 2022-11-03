Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDB5C4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 19:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiKCTuM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 15:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiKCTuK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 15:50:10 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B7A11838
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 12:50:08 -0700 (PDT)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oqgDy-0003Sp-Fw;
        Thu, 03 Nov 2022 19:50:07 +0000
Message-ID: <ab275fa0-2977-f880-cc33-836f667287bc@iee.email>
Date:   Thu, 3 Nov 2022 19:50:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC/PoC 1/5] doc: provide DocBundles design document
Content-Language: en-GB
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
References: <20221102224843.2104-1-philipoakley@iee.email>
 <20221102224843.2104-2-philipoakley@iee.email>
 <221103.86mt981i9h.gmgdl@evledraar.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <221103.86mt981i9h.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar,
Thanks for the review,

On 03/11/2022 09:19, Ævar Arnfjörð Bjarmason wrote:
> On Wed, Nov 02 2022, Philip Oakley wrote:
>
>> [...]
>> diff --git a/Documentation/technical/docbundle.txt b/Documentation/technical/docbundle.txt
>> new file mode 100644
>> index 0000000000..8c17a7847f
>> --- /dev/null
>> +++ b/Documentation/technical/docbundle.txt
>> @@ -0,0 +1,97 @@
>> +docbundle Design Document
>> +=========================
>> +
>> +The Git man pages contain many example setups to demonstrate aspects
>> +of the related Git commands, such as history simplification in the `log`
>> +and `show commands. However, while illustrative, these are not
>> +accessible, as example repositories, to regular, potentially confused,
>> +users who may need to understand the set up of the examples.
>> +
>> +The docbundle concept is that for each of these examples there is a
>> +matching `bundle` file, provided with the Documentation, which can be
>> +simply cloned to provide an example repository containing the example.
>> +
>> +There are also many example repositories in the Git `/t` test system
>> +that could be exposed to users which already demonstrate some important
>> +testable aspect of Git within a carefully constructed repository.
>> +
>> +
>> +This proposal is to provide DocBundles to users via the Git project.
>> +
>> +
>> +Firstly, it should be reasonably self-evident that the man page examples
>> +should, in themselves, be tested for accuracy, especially if provided
>> +to users.
>> +
>> +Secondly, the existing test system is the proper place to setup and
>> +test any such docbundle repositories.
>> +
>> +Third, that the bundle is an obvious pre-existing mechanism for
>> +transporting repositories (see also the Bundle-URI proposals).
>> +
>> +Fourthly, the preparation and distribution of the docbundle should
>> +require minimal maintainer effort, preferably being integrated into
>> +the existing automation for Documentation preparation and distribution.
>> +
>> +Fifthly, the docbudles themselves should not to be part of the git.git
>> +repo. They are prepared via the test suite and should be stored (locally)
>> +in a designated Git_DocBundle_Dir, and be .gitignored. The DocBundles
>> +are transferred to the maintainer's Doc repo via the automation.
>> +
>> +Sixthly, the docbundles to be named based on their `tnnnn` test number
>> +and a (short) descriptive name.
>> +
>> +Seven, (dev) start with an existing test, rather than add a test (most
>> +doc/man examples aren't tested!). Add tests for missing examples later.
>> +
>> +Eight, (option) add a `git docbundle` command to assist in locating and
>> +listing the docbundle examples. It also provides place to explain their
>> +purpose as "Tutorial Examples" (Note, many existing examples are to
>> +illustrate complex/difficult scenarios where the wording was insufficient;
>> +the docbudles are minimal examples).
>> +
>> +
>> +Status
>> +======
>> +
>> +This is an RFC/PoC (Request for Comment / Proof of Concept).
>> +
>> +The attached commits establish:
>> +
>> +Set out this design in the Documentation/technical directory.
>> +
>> +A default location for the docbundles and an env variable to allow
>> +flexibility by extending test-lib.
>> +
>> +The docbundles are ignored, as is the default directory.
>> +
>> +Two docbundles are generated from a 'random' test that I happened to
>> +have open in my editor (t6102 rev-list-simplify).
>> +
>> +The docbundle creation is protected by `test_expect_success` wrappers.
>> +
>> +ToDo
>> +====
>> +
>> +DocBundles - Is this the best name, or just a convenient way of
>> +indicating the delivery mechanism?
>> +
>> +Add Prerequisite to control if docbundles are generated (don't waste
>> +maintainers PC time when not needed).
>> +
>> +CI integration (i.e. whether to test the bundling aspect - should be
>> +reliable).
>> +
>> +How to update the man pages, perhaps by inclusion of the test comment
>> +(exported?), and distinguish between man page descriptions (being
>> +packaged by the test suite) and tests which offer users insight into
>> +Git operations, usually with 'interesting' commit-graph set-ups.
>> +
>> +Claim t999x as the man doc bundle test sequence ('999' is the UK
>> +emergency ("Help!") number; 911, 101 and 102 are taken test areas.
>> +
>> +Other stuff implicit in the eight point list
> I've skimmed this, and provided some rough comments inline.
>
> I think the core idea sounds nice, if I'm getting it right. Let me see
> if I can rephrase it, and you can point out where I'm wrong/didn't get
> it:
>
> We have stuff in our docs like e.g. this, at the top of git-rebase(1);
>
>        Assume the following history exists and the current branch is "topic":
>
>                      A---B---C topic
>                     /
>                D---E---F---G master
>
> It would be nice if for that and other things we could add a blurb like:
>
> 	To play around with this history, do:
>
> 		git clone git-doc://git-rebase/description-1.bndl && cd description-1

That is generically correct. The motivating example was History
Simplification (see 5/5), where the example needed to cover a range of
setups which then confused new users in a catch 22 manner (link in the
'PoC patch). I had been aware of the issue previously, when looking at
the support I'd seen in some other tools which have example setups.
>
> Or whatever, this POC doesn't fleshen that out, but the idea is that
> through <some mechanism> we would bridge the gap such that the user
> could be looking at and playing with the history we're describing in our
> docs.

In terms of fleshing the PoC out, I didn't want to try stepping on too
many toes too soon, rather wanted to pick out a few pinch points with
suggestions.

>
> The above assumes we'd ship those with installed git, but these could
> also be hosted online, e.g.:
>
> 	git clone https://git-scm.com/test-bundles/git-rebase/description-1.bdl
>
> So as an end-goal you could both run these locally, and we could imagine
> that e.g. git-scm.com 

I was assuming that the bundles would be static documentation artefacts,
available locally and potentially on-line. They could even be hosted on
the forges..

> could eventually have UX similar to Redis's
> website: https://redis.io/commands/hgetall/
>
> I.e. where it drops you into a shell to play with the command.
I wasn't expecting to have a virtualised on-line git experience from
this, but never say never ;-)
> In reply to 3/5 I said I had some "local patches", but I forgot the
> relevant part was on master already (the whole subsequent leak analysis
> is local): 366bd129dc3 (test-lib: add a SANITIZE=leak logging mode,
> 2022-07-28)
>
> So I think you're making the whole "have the test suite make these" part
> of this too complex,

My main point was that the examples need to be covered by the test
suite, and that bundles were a simple way of capturing the tested setup.
The GIT_BUNDLE_DIR was simply a way of collecting them in one place for
ease of distribution with the documentation (as you mentioned that's a
gap in the automation step)
>  i.e. with a minor variation of that you can do this
> in test-lib.sh:
>
> 	TEST_RESULTS_BDL_DIR="$TEST_RESULTS_DIR/$TEST_NAME.test-bdl"
>
> Then have a helper like:
>
> 	do_my_test_bundle_stuff () {
> 		local name="$1" &&
> 		shift &&
> 		git bundle create "$TEST_RESULTS_BDL_DIR/$name.bdl" "$@"
> 	}
That would be a simplification
>
> Then all you need to make these is:
>
> 	make test GIT_TEST_OPTS=--debug

I didn't quite get the link in that step between the `--debug` and the
bndl prep.
>
> And then:
>
> 	ls -l t/test-results/*.bdl/*
>
> Will give you all the bundles you want.
>
> We're then missing the "connect it with the docs" part, but that part
> would be e.g.:
>
> - Have a validation target for it that depends on such a "make test" run
> - Sanity check that we did create the ones the docs expect
>
> Anyway.
>
> I like the end-goals, but I can't help think that bundles are the wrong
> direction to go in, as opposed to:
>
> 1. We could have "make install" ship test-lib{,-functions}.sh along
>    with git itself
> 2. Have e.g. t/doc-setup/*.sh with the snippets to set up these test
>    demos, which we'd also ship.

I'm not into the idea of shipping a load of extra `test` infrastructure
with Git itself. We don't ship any in the Git for Windows install.
 
I'd viewed the bundles as an adjunct to the also independent manuals and
documentation.
>
> And you'd then do e.g.:
>
> 	git test-case rebase/description-1
>
> Which would just be a thin wrapper around (pseudocode):
>
> 	dir=$(git test--helper get-tempdir) &&
> 	(
> 		cd "$dir" &&
>                 # And whatever else we need to set up to say "use this local installed git"
> 		GIT_TEST_INSTALLED=[...] &&
> 		. "$(git --test-dir)"/test-lib.sh
> 		. "$(git --test-dir)"/doc-setup/rebase-description-1.sh"
>
> 		# This would run test_commit, and any other arbitrary setup code
> 		setup_rebase_description_1()
> 	) &&
> 	echo "Go play with '$dir', and have fun"
>
> The big advantage of that is:
>
>  1. It ships with git, so it works offline, and we won't get into the
>     inevitable confusion of the user reading v2.40 docs locally, but the
>     online url tracking a v2.50 example or whatever.

Isn't this always a problem (lack of synchronisation between multiple
sources). If the user has local documentation, it should have matching
bundles locally, No?
>  2. We can represent whatever arbitrary repo state, e.g. drop the user
>     into a merge conflict that's already happening.
Isn't the manual's example already meant to describe that? And the user
then (hopefully) follows along in their throw-away copy of the repo bundle.
>  3. We can also represent "repo-extra" state, e.g. imagine the
>     "git-gc/git-repack" docs discussing loose objects, and wanting to
>     get you into some arbitrary state with regards to your loose objects
>     etc.
That's a future option, but way past the initial concept for user
on-boarding.

Thanks

Philip

