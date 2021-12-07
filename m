Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A966DC433FE
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 20:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhLGUSa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 15:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhLGUSa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 15:18:30 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35558C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 12:14:59 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id e3so579451edu.4
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 12:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=EnEIEHY1ZW6NbBsrCqPf5LvnJ101R9eYmq3JWY1E3lw=;
        b=VqabhKjbiR1lQi07PztlUAzq3mQa6sKdv65ywyD2Ik2pOMJaOo76ua1kNpo3o1i46P
         Mm9bT9qENcccvg4I2CkuhbG9AtwrVMP1VLR4Z1IHNGPXpXhLV8oSE4nPueP+F1ZqnLmu
         Shzsqe4dKP+IhD7aIplUp5GyhFiy3WER99ilpwQHGOIWSnK8XK9kSPUFrolc4vvgJFFv
         S2AmDUBeLFmFFZd/r+SI/Lc1eDgk9rF2M+xKVXWJl2foOf1gXg+ihWCBtk0Zymd3riB3
         D31VoxnscPGoDcJjFH0OiI0dAGdG+oDgEgpy/ON6pjf5qAdmhif+8ALXACvgazYr1Rct
         KCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=EnEIEHY1ZW6NbBsrCqPf5LvnJ101R9eYmq3JWY1E3lw=;
        b=Bw8PDutacdwkBAXS6Sr6sHYFp26CWlvNFFe0dGUFwkfoU8zJ9fp3w4DUpoL90EjQu0
         KL8JE7i34gaZt8vy/fczBfY4rGe3q+qGuQYn8IWgH+jZNIvKMx5IsJRLeo48IctcP6IO
         lI38maehWknETN17V0R8V5mPDl6ohFcivd7iPYRU0yqkgZpJOOkyArkE6GExLenxqUqm
         zBKgzNTM5rxOBknDWW0+lzTvvkEYOmeOBakd4JymHn5JWdtrmHQd4xNnN1Mq1l/Nv3vs
         zLJWAumD46O3uhoodVbqFtcmISrbT2gVReBGLSBnD0Rq576frZEKMdldto7y4d6Kx7ZP
         1ROA==
X-Gm-Message-State: AOAM531Zda2RGf35Q9ImPWr0/+MFPzndXcg9vftWJ+fmzE+yKBirCsfC
        oGMjr8y8FBBGddZYXgpOkkM=
X-Google-Smtp-Source: ABdhPJy7lJRzIPhzvEmJN2BEhZB7KNJ5EupVntYP9zanbxC0n6bGgaGUx9vtzv/2hKf6RFpxU//BKw==
X-Received: by 2002:a05:6402:653:: with SMTP id u19mr12332104edx.106.1638908097578;
        Tue, 07 Dec 2021 12:14:57 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id aq6sm324041ejc.41.2021.12.07.12.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 12:14:57 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mugrY-001IhP-83;
        Tue, 07 Dec 2021 21:14:56 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v10 00/15] Upstreaming the Scalar command
Date:   Tue, 07 Dec 2021 21:05:31 +0100
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
 <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
 <CABPp-BGpe9Q5k22Yu8a=1xwu=pZYSeNQoqEgf+DN07cU4EB1ew@mail.gmail.com>
 <xmqq4k7nmksi.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <xmqq4k7nmksi.fsf@gitster.g>
Message-ID: <211207.86ilw0matb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Dec 05 2021, Junio C Hamano wrote:

> Elijah Newren <newren@gmail.com> writes:
>
>> From your wording it sounds like the plan might not include moving
>> these tests over.  Perhaps it doesn't make sense to move them all
>> over, but since they've caught problems in both Scalar and core Git,
>> it would be nice to see many of those tests come to Git as well as
>> part of a future follow on series.
>
> Yeah, we may be initially queuing this without tests for expediency,
> but a production code cannot go forever without CI tests to ensure
> continued code health.  People make changes in other parts of the
> system Scalar may depend on and unknowingly break some assumption
> Scalar makes on it.

In this case there really isn't any reason not to have the tests go in
at the same time. The explanation in the v10 CL is:
    
    Changes since v9:
    
     * The patches to build Scalar and run its tests as part of Git's CI/PR,
       have been dropped because a recent unrelated patch series does not
       interact well with them.

That assessment isn't correct.

The change in v8->v9 of adding a "make &&" before the "test" was only
necessary because of a logic error in the v8 version. Yes it broke
because the "scalar test" target didn't know how to build its
prerequisites, but the real underlying issue is that it was even trying
at that point. It had no business running in the static-analysis target
where we hadn't built git already.

Now v9->v10 has
dropped the tests entirely, allegedly due to an interaction with my
ab/ci-updates, but there's nothing new there that isn't also the case on
"master".

But we can have our cake and eat it too.

The below patch on top of v9 would make the scalar tests do the right
thing. I.e. whenever we do a "make test" we'll run the scalar tests
too.

The code changes somewhat with ab/ci-updates, but the conflict with
js/scalar is mostly textual, not semantic (and as I've pointed out, to
the extent that ab/ci-updates changed anything it made things a bit
better for js/scalar).

I'd really like to see this scalar series land, but I really don't see
why it's necessary to entirety eject the CI test coverage due to what's
a rather trivilly solved issue.

As I've noted ad-nauseum at this point I think the necessity for the
below patch is rather silly, this should just nicely integrate with
"make test", but <brokenrecord.gif>. But even without that IMO better
approach it's clearly rather trivial to make this series have test
coverage.

It was just broken because it added a test run to the "pedantic" run,
and didn't properly integrate with the multi-"make test" runs on
"master" , both of which are addressed by the patch below.

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 2ef9fbfdd38..af99699f82b 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -15,6 +15,26 @@ then
 	export DEVOPTS=pedantic
 fi
 
+make() {
+	scalar_tests=
+	for target
+	do
+		if test $target = "test"
+		then
+			scalar_tests=t
+		fi
+	done
+
+	# Do whatever we would have done with "make"
+	command make "$@"
+
+	# Running tests? Run scalar tests too
+	if test -n "$scalar_tests"
+	then
+		command make -C contrib/scalar test
+	fi
+}
+
 make
 case "$jobname" in
 linux-gcc)
@@ -52,6 +72,4 @@ esac
 
 check_unignored_build_artifacts
 
-make && make -C contrib/scalar test
-
 save_good_tree
