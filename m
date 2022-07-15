Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCDAC43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 11:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbiGOLSG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 07:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiGOLSF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 07:18:05 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855218723E
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 04:18:03 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y8so5881609eda.3
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 04:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=w/cASJRXvmVbx6MELbDrpgMv3QSseHrtM6Lp4Qbm9/Q=;
        b=ZVAe1TZoDnx3kKY9tVBxI3nw42T7YeWo8zPkV5UcZzFG0cYF2QoeNBifgt4lAUTngA
         1bkwsdu7lruluABAX+gU2uJpm/9g/8XZwcfNlBa1PYQJkN0B8mCGGcFZenYFxEIpFOZi
         HmWmlobKf+H6UXlwZTjJPO/Eh90MCjCvjpdZV9LMxEnqcH2c+BoDC4DRPC5NFi75JyPU
         NteJ2zeogQPhdMwWhsCdDXzCrLdKxSkg5Nl3eF/Rt0AVQ/A6Y7axVsI2jhde75OzdV7b
         vLln7QTPgTFU+4wGABkibow/ToQK8nH5oCHiNwcrU7v5mE+VFOkFmNldV0pld5eeS01J
         NcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=w/cASJRXvmVbx6MELbDrpgMv3QSseHrtM6Lp4Qbm9/Q=;
        b=gaw5WdOAkiE7jNyNKUDPRHoQZzx00fV02H2Wl/IX64oKVBvdKtP1fkiqewQZCLIZ/V
         HKO1sWqn04np66OTrW79a95PkuIlpw9wVJrmBF0/jlmG3UPMyJpjd863kUa08EX1m8dk
         4WYOsSxPL/AWWJS2k8MNvi/ZAR3Q36C4pVMU8Ti9mBvpNWaBspY1MWkfZwNzbIUYGNCX
         5wwwMAEM4Aj62xcRnIXZbNNYhV9Meok19YSoumQPgAawOFCtkeBVSnwgXdnPeScQH+2X
         0yTAlCgb0BPBFIfojl7dmGf0z6whlv06b8U3MRiScUcUkrTe7JuGDXAA7NCOs/tzM1Ws
         3woA==
X-Gm-Message-State: AJIora8yEliwGaTeEg+cHjwk/H0wqMsK5Daxfnm0S/fnP9sr7Hoo0fOj
        fWHAeuGvbTVDNv36NRc/bX8=
X-Google-Smtp-Source: AGRyM1tjX0KTOtfPux/tUFyey2c5PQMcgTTFEyWHxpi3sRMYyA9ykcwyhZqx5psd0mn4+mWlNkJLYA==
X-Received: by 2002:a05:6402:4252:b0:43a:9232:dafc with SMTP id g18-20020a056402425200b0043a9232dafcmr18003203edb.243.1657883881944;
        Fri, 15 Jul 2022 04:18:01 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id v20-20020a1709060b5400b0071cbc7487e1sm1907631ejg.69.2022.07.15.04.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 04:18:01 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oCJKa-002g9I-62;
        Fri, 15 Jul 2022 13:18:00 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 2/3] t/*: avoid "whitelist"
Date:   Fri, 15 Jul 2022 13:02:50 +0200
References: <pull.1274.git.1657718450.gitgitgadget@gmail.com>
 <pull.1274.v2.git.1657852722.gitgitgadget@gmail.com>
 <3c3c8c20bcb4e570d25a676ad1f29877762adb82.1657852722.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <3c3c8c20bcb4e570d25a676ad1f29877762adb82.1657852722.git.gitgitgadget@gmail.com>
Message-ID: <220715.86o7xqzkt3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 15 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The word "whitelist" has cultural implications that are not inclusive.
> Thankfully, it is not difficult to reword and avoid its use.
>
> Focus on changes in the test scripts, since most of the changes are in
> comments and test names. The renamed test_allow_var helper is only used
> once inside the widely-used test_proto helper.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  t/README                        | 9 ++++-----
>  t/lib-proto-disable.sh          | 6 +++---
>  t/t5812-proto-disable-http.sh   | 2 +-
>  t/t5815-submodule-protos.sh     | 4 ++--
>  t/t9400-git-cvsserver-server.sh | 2 +-
>  t/test-lib-functions.sh         | 2 +-
>  t/test-lib.sh                   | 2 +-
>  7 files changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/t/README b/t/README
> index 309a31133c6..56d5ebb5798 100644
> --- a/t/README
> +++ b/t/README
> @@ -367,11 +367,10 @@ GIT_TEST_SPLIT_INDEX=<boolean> forces split-index mode on the whole
>  test suite. Accept any boolean values that are accepted by git-config.
>  
>  GIT_TEST_PASSING_SANITIZE_LEAK=<boolean> when compiled with
> -SANITIZE=leak will run only those tests that have whitelisted
> -themselves as passing with no memory leaks. Tests can be whitelisted
> -by setting "TEST_PASSES_SANITIZE_LEAK=true" before sourcing
> -"test-lib.sh" itself at the top of the test script. This test mode is
> -used by the "linux-leaks" CI target.
> +SANITIZE=leak will run only those tests that have marked themselves as
> +passing with no memory leaks by setting "TEST_PASSES_SANITIZE_LEAK=true"
> +before sourcing "test-lib.sh" itself at the top of the test script. This
> +test mode is used by the "linux-leaks" CI target.

It's hard to improve your own verbage, but I think in this case my
original version can be improved still:

	GIT_TEST_PASSING_SANITIZE_LEAK=<bool> when compiled with
	SANITIZE=leak will, when true, only run those tests that declare
	themselves leak-free by setting "TEST_PASSES_SANITIZE_LEAK=true"
	before sourcing "test-lib.sh". This test mode is used by the
	"linux-leaks" CI target.

> -test_expect_success 'curl redirects respect whitelist' '
> +test_expect_success 'curl redirects respect allowed protocols' '

Isn't the real problem here that this is inaccurate with regards to
"curl", i.e. AFAIK from browsing transport.c the whitelist of protocols
has nothing to do with curl, we parse that out and apply it before we
ever get to the specific transport layer.

So this should just be "http(s) transport respects GIT_ALLOW_PROTOCOL",
no?

> -test_description='test protocol whitelisting with submodules'
> +test_description='test protocol restrictions with submodules'

Minor: I think this shows the awkwardness of using a word derived from
"allow". Before we could use "whitelist" and "whitelisting"
consistentlry, but now you have "allowed", "allowlist", "restrictions"
etc.

I guess you could say "test protocol allowances..." or something? Meh.

> -test_expect_success 'user can override whitelist' '
> +test_expect_success 'user can override with environment variable' '

Override what? This is a non-improvement. Saying "how" with "environment
variable" is good, but we dropped any mention of what's being tested.

> -test_expect_success 'req_Root failure (export-all w/o whitelist)' \
> +test_expect_success 'req_Root failure (export-all w/o directory)' \
>    '! (cat request-anonymous | git-cvsserver --export-all pserver >log 2>&1 || false)'

Is it really that we don't have any directiory whatsoever, in that case
I think this is a canditate for splitting up. I.e. the test didn't test
what it was intending to test?

But if it's really "without <whatever you call the list of stuff you
don't want>" we should still say that, no?

> -		# (Temporary?) whitelist of things we can't easily
> +		# (Temporary?) list of things we can't easily
>  		# pretend not to support

We've had this since my dfe1a17df9b (tests: add a special setup where
prerequisites fail, 2019-05-13), so we can probably just drop
"(Temporary?)" there while we're at it...

> -# skip non-whitelisted tests when compiled with SANITIZE=leak
> +# skip unmarked tests when compiled with SANITIZE=leak

This subtly changes the meaning in a way I didn't intend when writing
this. I.e. the existing wording could be improved, but some of what
we're skipping isn't "unmarked", it's explicitly marked as "false"
(which we assume by default).

I.e. I read this new wording as saying "skip <unset>", whereas the
previous can encompas "<unset,false>", just not "<true>"...
