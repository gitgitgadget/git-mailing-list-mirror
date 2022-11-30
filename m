Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B206C433FE
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 10:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbiK3K4y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 05:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiK3K4x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 05:56:53 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B351DA48
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 02:56:50 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id td2so26268388ejc.5
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 02:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pOJWhfZrzw1lNqgqa7AUtaigfoMMiEH4dTZa0kZNIGI=;
        b=PL8GriuRFjagxRpmiCsAxQeyNNAcom2hspkORMBMKmrM2LaQ/rZv63nnfGYst6cync
         8mRGZcEU/gnkOhyu0MF2SuPCT60t+TAxNgmlLclCDMH9mpd126s7K5DM9cGlTC8G8XeQ
         HG1SQcXgMDxLCJoktX3ryEf6v7f9+PY6JB0tudXASzrZ5LAzDT39W8V97Vd/rWI52x9y
         uexueCpCT3C3DMl6wubgZq2xRASgt28S/+N7x4lXLM0lxqwMlgq9HvgpFuEBCwQkYHhL
         sUXL7gaAZPKMoqYnWlzRFQK8/zGJqalT64sOFZwl2WCdFv0RC9kWahmOYpFQKDrPolb3
         AkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOJWhfZrzw1lNqgqa7AUtaigfoMMiEH4dTZa0kZNIGI=;
        b=FXzQPynu2UckM0W0XKtCHCBtY13zs0lBNWtWlw13KFNMPx2VD6q1JoDdyvRgacWEcP
         VKGUSlIoz7IaREfFcmzpocWGbP8vkChO5ftkVQ3bnwuNdXha4wGJ8johZq0RLRfJ9W0Q
         8m3Miby3wN91olSBoYfY/C0TCu7pia3eIP/PXWvjHAWwspGGOZt/fFqaax2O5Ai65KvE
         i/0abrXbh4MhwFM4Y2/WUDtWscZWlEJI6zyLNzNAcxIiC/3rtV1uxgNxB+By2/eq+gIo
         jtrQ5yqeqZ1QowT48onx1p7aX+GgAZGMA3Zo+UUVWP7rlEKvV5BiUnCWcC2k4cDj0oKN
         Hl2Q==
X-Gm-Message-State: ANoB5pkjvQRoVjTeU8JwKVVo+GwF6Tes8x0Vq+7gyHms+XhlDM2r+ule
        guLSPpA0ixsXCnDqD4U4YKUHCsVMOQ9TAA==
X-Google-Smtp-Source: AA0mqf7GQFlZZhBAGKsvVfoN3zw4q4qunzRWZSDqnUbgvKI10UKUyIjVA0nO1Dy4gPL1jtp1L/de5g==
X-Received: by 2002:a17:906:547:b0:7ad:9028:4b17 with SMTP id k7-20020a170906054700b007ad90284b17mr51516213eja.366.1669805808764;
        Wed, 30 Nov 2022 02:56:48 -0800 (PST)
Received: from gmgdl ([109.38.157.167])
        by smtp.gmail.com with ESMTPSA id ec16-20020a0564020d5000b00467481df198sm495716edb.48.2022.11.30.02.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 02:56:48 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p0Klj-001zl6-1e;
        Wed, 30 Nov 2022 11:56:47 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: ab/cmake-nix-and-ci (was Re: What's cooking in git.git (Nov
 2022, #07; Tue, 29))
Date:   Wed, 30 Nov 2022 11:16:40 +0100
References: <xmqqsfi22j67.fsf@gitster.g>
 <544fff8a-7d56-57a1-00a3-d1a9302e227c@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <544fff8a-7d56-57a1-00a3-d1a9302e227c@dunelm.org.uk>
Message-ID: <221130.86h6ygiuc0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 30 2022, Phillip Wood wrote:

> Hi Junio

Hi, and thanks for your review of this series.

> On 29/11/2022 09:40, Junio C Hamano wrote:
>> * ab/cmake-nix-and-ci (2022-11-04) 14 commits
>>    (merged to 'next' on 2022-11-08 at 6ef4e93b36)
>>   + CI: add a "linux-cmake-test" to run cmake & ctest on linux
>>   + cmake: copy over git-p4.py for t983[56] perforce test
>>   + cmake: only look for "sh" in "C:/Program Files" on Windows
>>   + cmake: increase test timeout on Windows only
>>   + cmake: support GIT_TEST_OPTS, abstract away WIN32 defaults
>>   + Makefile + cmake: use environment, not GIT-BUILD-DIR
>>   + test-lib.sh: support a "GIT_TEST_BUILD_DIR"
>>   + cmake: set "USE_LIBPCRE2" in "GIT-BUILD-OPTIONS" for test-lib.sh
>>   + cmake & test-lib.sh: add a $GIT_SOURCE_DIR variable
>>   + cmake: chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4
>>   + cmake: don't copy chainlint.pl to build directory
>>   + cmake: update instructions for portable CMakeLists.txt
>>   + cmake: use "-S" and "-B" to specify source and build directories
>>   + cmake: don't invoke msgfmt with --statistics
>>   Fix assorted issues with CTest on *nix machines.
>
> If that's all this series did then I think it would be fine. However
> it also makes changes to test-lib.sh to hard code the build directory
> in an attempt to remove GIT-BUILD-DIR. I'm not convinced that is an 
> improvement on the status quo.

I think the series as it stands addresses those concerns. In particular
building outside of contrib/buildsystems/out works, just as before:

	cmake -S contrib/buildsystems -B /tmp/git-build -DCMAKE_BUILD_TYPE=Debug &&
        make -C /tmp/git-build &&
        ctest --test-dir /tmp/git-build -R t0001

Per [1] and [2] which added the "ctest" support that's the use-case for
this part of the build: running the tests with ctest, which works as
before with the default or custom directories.

Perhaps the reason this has been a sticking point for you is that in
summarizing this, Johannes's [3] didn't make that distinction between
running the tests with "ctest" and running them manually by entering the
"t/" directory after the build. I.e.:

	(cd t && ./t0001-init.sh)

It's only that part which acts differently in this series. I.e. if you
were to build in /tmp/git-build this would no longer find your built
assets:

	$ ./t0001-init.sh
	error: GIT-BUILD-OPTIONS missing (has Git been built?).

If you just leave it at the default of "contrib/buildsystems/out" it'll
work:

	(cd t && ./t0001-init.sh)
	ok 1 [...]

I think my [4] convincingly makes the case that nobody will
care. I.e. as the [5] it links to the use-case for running the test
after the build without ctest was ("[...]" insert is mine):

	[To build and test with VS] open the worktree as a folder, and
	Visual Studio will find the `CMakeLists.txt` file and
	automatically generate the project files.

I.e. we want to support the user who builds with that method, and runs
the tests manually. I think you're worrying about an edge case that
nobody's using in practice.

> As I mentioned previously [1] I think
> the non-*nix related patches could do with a review from the windows
> folks before this hits master.

I'd welcome another review of it, but at this point it's not for lack of
waiting for interest from the CC'd Windows people.

Per the above I don't think any special Windows knowledge is really
needed, just a reading of the above history & use-cases.

All of which I've been careful not to break, and which you can now
simply test on *nix with this series, so no Windows-specific testing is
needed anymore for this concern you're raising.

*If* we have someone that's been using this on Windows and e.g. building
this in /tmp/git-build (or whatever the Windows equivalent) with a
custom recipe all they'll need to have it work as before is:

	GIT_TEST_BUILD_DIR=/tmp/git-build ./t0001-init.sh

I think nobody's straying off the golden path to do that, but if they
are doing so and building in some custom directory they're already
tweaking, just setting an environment variable doesn't seem like a big
imposition.

The flip-side of that trade-off is (on both Windows and *nix) that the
existing way to support the use-case has unintended side-effects, which
the series improves:

* When we pick up the not-a-Makefile tree implicitly like this we'll
  now emit a message telling you what git we're implicitly using.

* We no longer have edge cases where you can e.g. build with make, then
  cmake, then run some "make" target that won't go through the path to
  remove GIT-BUILD-DIR (e.g. changing "git.c" and "make git").

  Then when you run the tests you'll end up with a different git running
  it than what you'd expect, i.e. the old stale cmake one.

Even that hypothetical user who's going to need to set
"GIT_TEST_BUILD_DIR" would benefit from that, as they'd no longer
accidentally flip-flop between the two if they ran "make" and wiped away
the rather fragile link between the source directory & the linked-to
cmake build directory.

> [1]
> https://lore.kernel.org/git/64b91b29-bbcd-e946-1f20-c0a5be63d9b7@dunelm.org.uk/
>
>>   Will cook in 'next'.
>>   source: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>

1. c4b2f41b5f5 (cmake: support for testing git with ctest, 2020-06-26)
2. 7f5397a07c6 (cmake: support for testing git when building out of the
   source tree, 2020-06-26)
3. ee9e66e4e76 (cmake: avoid editing t/test-lib.sh, 2022-10-18)
4. 16a5421a654 (Makefile + cmake: use environment, not GIT-BUILD-DIR,
   2022-11-03)
5. 3eccc7b99d4 (cmake: ignore files generated by CMake as run in Visual
   Studio, 2020-09-25)
