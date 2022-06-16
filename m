Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F51C43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 09:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359684AbiFPJXv convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 16 Jun 2022 05:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiFPJXt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 05:23:49 -0400
X-Greylist: delayed 549 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Jun 2022 02:23:47 PDT
Received: from mailproxy01.manitu.net (mailproxy01.manitu.net [217.11.48.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B884611822
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 02:23:47 -0700 (PDT)
Received: from localhost (nb-ana002.math.uni-hannover.de [130.75.46.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: michael@grubix.eu)
        by mailproxy01.manitu.net (Postfix) with ESMTPSA id A776E1260246;
        Thu, 16 Jun 2022 11:14:36 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <nycvar.QRO.7.76.6.2206151649030.349@tvgsbejvaqbjf.bet>
References: <cf6aee9acadfb666de6b24b9ed63e1a65bfc009e.1655220242.git.git@grubix.eu> <nycvar.QRO.7.76.6.2206151649030.349@tvgsbejvaqbjf.bet>
Subject: Re: [PATCH] t3701: two subtests are fixed
From:   Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org,
        =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Message-ID: <165537087609.19905.821171947957640468.git@grubix.eu>
Date:   Thu, 16 Jun 2022 11:14:36 +0200
User-Agent: alot/0.10
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin venit, vidit, dixit 2022-06-15 16:50:40:
> Hi Michael,

Hallo Dscho!

> On Tue, 14 Jun 2022, Michael J Gruber wrote:
> 
> > 0527ccb1b5 ("add -i: default to the built-in implementation", 2021-11-30)
> > switched to the implementation which fixed to subtest. Mark them as
> > expect_success now.
> 
> Good catch!
 
I'm no list regular anymore, but still a "next+ regular". While
experimenting with my own patch I noticed something got fixed
unexpectedly. That goes to show that these unexpected successes
(from expect_failure) go unnoticed too easily. I had missed this on my
regular rebuilds.

> However... that commit specifically contains this change:
> 
>         diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
>         index cc62616d806..660ebe8d108 100755
>         --- a/ci/run-build-and-tests.sh
>         +++ b/ci/run-build-and-tests.sh
>         @@ -29,7 +29,7 @@ linux-gcc)
>                 export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
>                 export GIT_TEST_MULTI_PACK_INDEX=1
>                 export GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=1
>         -       export GIT_TEST_ADD_I_USE_BUILTIN=1
>         +       export GIT_TEST_ADD_I_USE_BUILTIN=0
>                 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
>                 export GIT_TEST_WRITE_REV_INDEX=1
>                 export GIT_TEST_CHECKOUT_WORKERS=2
> 
> The intention is to have t3701 be run with the non-built-in version of
> `git add -i` in the `linux-gcc` job, and I am surprised that those two
> tests do not fail for you in that case.
> 
> Did you run this through the CI builds?

That's why I mentioned "no list regular" - I didn't know about that knob
nor the intention to have the test suite run with either implementation
(rather than switching to the new one for good).

I do local builds, usually with

```
DEVELOPER=1 (which I had to disable during the bisect run; gcc12...)
DEFAULT_TEST_TARGET=prove
GIT_PROVE_OPTS=--jobs 4
GIT_TEST_OPTS=--root=/dev/shm/t --chain-lint
SHELL_PATH=/bin/dash
SKIP_DASHED_BUILT_INS=y
```

in config.mak. Nothing else strikes me as potentially relevant.

Ævar noticed this and has a better version of my patch, I think.

Michael
