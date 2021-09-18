Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3374C433EF
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 15:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90BFB61244
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 15:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237350AbhIRPy0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 11:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237245AbhIRPyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 11:54:25 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512F6C061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 08:53:02 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id y197so2470484iof.11
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 08:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=afLUz+MstSkxzsqcg5pcrR1MXuaVRAMLdxyz5lc/CKs=;
        b=CwqxZgj1fYm1aBe2leaJbXcd7Mt83NbPvBSTfg+/jjJ/MOsuyil1vRptr6qVCT4mS2
         bXoJVvrtWLYDXO0G7eU5ZzCOrRetOJC9nmphOe7mpcPGZS6HOEBD3s+/4B+Mn39cfL/r
         ex4quNdhaBd2hHAJzYWWAgABlSzbNG1/YkpP6kkvfZZ2AxnkxSeyy4hjeQVrF7nSpgMQ
         T1YsLgVKKvr//jBlYlWoh26jfsuSOGZSx2WYHLMXHPcdVLzc5/z232jPCGc6FonhTa2+
         CMVAmjBnWKGc60DI7FiiKWYx+wdgjK6kw0Qg/NVt59PAd3YkQfi5UnAVsTETsx2YMk72
         5fCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=afLUz+MstSkxzsqcg5pcrR1MXuaVRAMLdxyz5lc/CKs=;
        b=yEvWKfBIgiiJZEUn7SfjU8np1nLqkoVMwH6i6w0MCbxTyHcAW7Q3YH4wB5Z89fRzzc
         e+ptlADvdncb47VC4W2PSTZEjGtu/ttBQtc79+hS4N+ZdcskXEPLSII+vb25mfbzdAx0
         qSCfOUDmCvPla3AACzkqEcErRfBHUKK3eiBsOk83HvGgSZlWI+7J0kNT2J8FT7NCpdBl
         7NOsmJsRQ31l+OLzO8wpRgkJE+OPr0vPoJG6q9bYNA6T5eDFOUpnLBqdqrYnq3Fpj2Bb
         6Se+b6GPTc+O4lc8CkhVF3II1paVpgtvwkX5lU2Q9ACfJgrkg9eZUBAWwHax1TBenb6l
         XEMg==
X-Gm-Message-State: AOAM533Iz275YsIWsJP+LJkrJgWggt2xaypmGRbpTLKzm3mS2mvLGZu0
        KqC9TucVyS7M54GhQgbL3WyjAmJ6K3E5Kd3C
X-Google-Smtp-Source: ABdhPJysdHUTWqHf8nrrGlguvHNwwnhZAReQZcJ6vCJZMFKmqp6wjqLMM3qPw4pnTQCw3YGKTwlh+A==
X-Received: by 2002:a6b:5114:: with SMTP id f20mr1652901iob.97.1631980381645;
        Sat, 18 Sep 2021 08:53:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c20sm5401155ili.42.2021.09.18.08.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 08:53:01 -0700 (PDT)
Date:   Sat, 18 Sep 2021 11:53:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Andrzej Hunt <andrzej@ahunt.org>
Subject: Re: [PATCH] connect: also update offset for features without values
Message-ID: <YUYLXKN8U9AMa5ke@nand.local>
References: <pull.1091.git.git.1631970872884.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1091.git.git.1631970872884.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andrzej,

On Sat, Sep 18, 2021 at 01:14:32PM +0000, Andrzej Hunt via GitGitGadget wrote:
> From: Andrzej Hunt <andrzej@ahunt.org>

Thanks for writing this patch. I have seen a copy of this on the
security list, but the modified version here looks good to me, too. I
left a few notes throughout.

Recapping our discussion on the security list, we decided that this
didn't merit an embargoed release because a misbehaving server can still
cause a client to hang if it simply printed half of its ref
advertisement. So this issue isn't new, but fixing this instance of it
is good nonetheless.

> parse_feature_value() does not update offset if the feature being
> searched for does not specify a value. A loop that uses
> parse_feature_value() to find a feature which was specified without a
> value therefore might never exit (such loops will typically use
> next_server_feature_value() as opposed to parse_feature_value() itself).
> This usually isn't an issue: there's no point in using
> next_server_feature_value() to search for repeated instances of the same
> capability unless that capability typically specifies a value - but a
> broken server could send a response that omits the value for a feature
> even when we are expecting a value.

It may be worth adding a little detail here. parse_feature_value takes
an offset, and uses it to seek past the point in features_list that
we've already seen. But if we get a value-less feature, then offset is
never updated, and we'll keep parsing the same thing over and over in a
loop.

(I know that you know all of that, but I think it is worth spelling out
a little more clearly in the patch message).

> Therefore we add an offset update calculation for the no-value case,
> which helps ensure that loops using next_server_feature_value() will
> always terminate.

> next_server_feature_value(), and the offset calculation, were first
> added in 2.28 in:
>   2c6a403d96 (connect: add function to parse multiple v1 capability values, 2020-05-25)

This line wrapping is a little odd, but not a big deal.

>
> Thanks to Peff for authoring the test.
>
> Co-authored-by: Jeff King <peff@peff.net>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Andrzej Hunt <andrzej@ahunt.org>
> ---
>     connect: also update offset for features without values
>
>     This is a small patch to avoid an infinite loop which can occur when a
>     broken server forgets to include a value when specifying symref in the
>     capabilities list.
>
>     Thanks to Peff for writing the test.
>
>     Note: I modified the test by adding and object-format=... to the
>     injected server response, because the oid that we're using is the
>     default hash (which will be e.g. sha256 for some CI jobs), but our
>     protocol handler assumes sha1 unless a different hash has been
>     explicitly specified. I'm open to alternative suggestions.
>
>     ATB,
>
>     Andrzej
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1091%2Fahunt%2Fconnectloop-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1091/ahunt/connectloop-v1
> Pull-Request: https://github.com/git/git/pull/1091
>
>  connect.c                      |  2 ++
>  t/t5704-protocol-violations.sh | 13 +++++++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/connect.c b/connect.c
> index aff13a270e6..eaf7d6d2618 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -557,6 +557,8 @@ const char *parse_feature_value(const char *feature_list, const char *feature, i
>  			if (!*value || isspace(*value)) {
>  				if (lenp)
>  					*lenp = 0;
> +				if (offset)
> +					*offset = found + len - feature_list;

The critical piece :-). Since feature_list is a superset of found, this
is perfectly safe. It calculates first the offset of the found string
within feature_list, and then adds the length of the feature name.

I would have found this easier to read if it were spelled out as:

    *offset = found - features_list + len;

which is the same thing but follows the order of how I spelled out this
expression in English. But the way you wrote it matches how
parse_feature_value() sets the offset when there is a value, so I think
it's worth being consistent with that.

> diff --git a/t/t5704-protocol-violations.sh b/t/t5704-protocol-violations.sh
> index 5c941949b98..34538cebf01 100755
> --- a/t/t5704-protocol-violations.sh
> +++ b/t/t5704-protocol-violations.sh
> @@ -32,4 +32,17 @@ test_expect_success 'extra delim packet in v2 fetch args' '
>  	test_i18ngrep "expected flush after fetch arguments" err
>  '
>
> +test_expect_success 'bogus symref in v0 capabilities' '
> +	test_commit foo &&
> +	oid=$(git rev-parse HEAD) &&
> +	{
> +		printf "%s HEAD\0symref object-format=%s\n" "$oid" "$GIT_DEFAULT_HASH" |
> +			test-tool pkt-line pack-raw-stdin &&

I'm actually really happy with this modification to add the non-empty
object-format after the broken "symref" part, since it ensures that your
offset calculation is right (and that we can continue to parse features
with or without values after a value-less one).

> +		printf "0000"
> +	} >input &&
> +	git ls-remote --upload-pack="cat input ;:" . >actual &&
> +	printf "%s\tHEAD\n" "$oid" >expect &&
> +	test_cmp expect actual
> +'

Looks great to me.

Thanks,
Taylor
