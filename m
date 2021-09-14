Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE0DC433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 17:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B33DC610D1
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 17:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhINRT0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 13:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhINRTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 13:19:25 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45295C061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 10:18:08 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id j18so18092869ioj.8
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 10:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ltJP/fUtZo0GJsJK6/sOZJ910ohtLRLRvWYPGQcXF+s=;
        b=mi7ZUVlYCqX5W43qGq2ECvTDHdzfINcjMWakKSM0qJLUNQYhmFyya2Qi/yt4ZXA1Y+
         rLTKdw1dI9J+/R+HLvU8rV7I0yPoGWjMd+g07kfG+xj52NYTj0r/cGtA79YT948uHe7j
         5W2NMyqICX7Z966PEyuNKE2cPHES4qqVuxzWh9wAMX2oJD6qf3sTjpFedEAORyyEnKZc
         Cg6ZWQ4f6NT3HjvaFhmhp+OjQFcx/C2eQ9jvLMGonNtlUGqJq1hf69O7WDApawIfud3p
         /qYclvoR8svxcTJa0NuQ+ChtcuA/aJ+GZnmPyfFi6Q8O/jLLbNGFvjrS11c2rjWggY+E
         Ezow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ltJP/fUtZo0GJsJK6/sOZJ910ohtLRLRvWYPGQcXF+s=;
        b=oJwC4PF6Ph8aFOiFGuAXUhaITfOcx8pz4nr6hEphZ4y3tIasyaB1oysH0WRNWaOwHo
         A8jpbVEO7cIsPfooL7+evSy3m+4eLVyB/xSqE9djD5uJ0JhcwQBV+5lanwye65X7EQLb
         Eop2VQjb/iRoSTatuCFtgLHUriSTUNARxRGpeIFxTvXYooho7BIhXEy7TKqVAUprLfZt
         Srwp3i6cPdRu+sPYbcSAdIe39Vhnd3SjiU9bk0pN3DyRv+NtMBjVMO2+Duruq7by2Eut
         4e/82YvJmc5EgzTqk/ORGvd8ndzssLenlkPuGgQb50fW2ryDdQNFUtWviOhulciHYKT5
         +8Tw==
X-Gm-Message-State: AOAM532vsjAb1FgMQ46UjRPykuRBp4YuIPZv3fBeyPDiG72+mFl7MXKD
        ACt71Rg3Vw1PxI6gv0TGy/6+Ay4Lp+q2NmA5
X-Google-Smtp-Source: ABdhPJwxHJ1y0mosoy4zRDR40Nc1l5+wSF6+U5j0y34hupYFR6dMDjUpcZDKeJ1DkD4/e6J1CNbC6A==
X-Received: by 2002:a5e:8d04:: with SMTP id m4mr14662947ioj.149.1631639887613;
        Tue, 14 Sep 2021 10:18:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x8sm7104428ilc.40.2021.09.14.10.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 10:18:07 -0700 (PDT)
Date:   Tue, 14 Sep 2021 13:18:06 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 7/9] ls-refs: ignore very long ref-prefix counts
Message-ID: <YUDZTvI4hrqRK8Th@nand.local>
References: <YUC/6n1hhUbMJiLw@coredump.intra.peff.net>
 <YUDBokYvEBnzwsIN@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUDBokYvEBnzwsIN@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 11:37:06AM -0400, Jeff King wrote:
> Because each "ref-prefix" capability from the client comes in its own
> pkt-line, there's no limit to the number of them that a misbehaving
> client may send. We read them all into a strvec, which means the client
> can waste arbitrary amounts of our memory by just sending us "ref-prefix
> foo" over and over.
>
> One possible solution is to just drop the connection when the limit is
> reached. If we set it high enough, then only misbehaving or malicious
> clients would hit it. But "high enough" is vague, and it's unfriendly if
> we guess wrong and a legitimate client hits this.
>
> But we can do better. Since supporting the ref-prefix capability is
> optional anyway, the client has to further cull the response based on
> their own patterns. So we can simply ignore the patterns once we cross a
> certain threshold. Note that we have to ignore _all_ patterns, not just
> the ones past our limit (since otherwise we'd send too little data).

Right, because each ref-prefix line *adds* references to the advertised
set instead of culling them out. So as soon as we start ignoring even a
single ref-prefix line, we have to ignore all of them. Makes sense.

> The limit here is fairly arbitrary, and probably much higher than anyone
> would need in practice. It might be worth limiting it further, if only
> because we check it linearly (so with "m" local refs and "n" patterns,
> we do "m * n" string comparisons). But if we care about optimizing this,
> an even better solution may be a more advanced data structure anyway.
>
> I didn't bother making the limit configurable, since it's so high and
> since Git should behave correctly in either case. It wouldn't be too
> hard to do, but it makes both the code and documentation more complex.

Agreed. I don't think it's worth making it configurable because the
limit is so absurdly high that probably nobody will ever want to tweak
it.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> We're perhaps bending "optional" a little here. The client does know if
> we said "yes, we support ref-prefix" and until now, that meant they
> could trust us to cull. But no version of Git has ever relied on that
> (we tell the transport code "if you can limit by these prefixes, go for
> it" but then just post-process the result).
>
> The other option is that we could just say "no, you're sending too many
> prefixes" and hangup. This seemed friendlier to me (though either way, I
> really find it quite unlikely anybody would legitimately hit this
> limit).

FWIW, either (dropping the connection or the approach you took here)
would have been fine with me, but I find it unlikely that any real users
will notice ;).

>  ls-refs.c            | 19 +++++++++++++++++--
>  t/t5701-git-serve.sh | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+), 2 deletions(-)
>
> diff --git a/ls-refs.c b/ls-refs.c
> index a1a0250607..839fb0caa9 100644
> --- a/ls-refs.c
> +++ b/ls-refs.c
> @@ -40,6 +40,12 @@ static void ensure_config_read(void)
>  	config_read = 1;
>  }
>
> +/*
> + * The maximum number of "ref-prefix" lines we'll allow the client to send.
> + * If they go beyond this, we'll avoid using the prefix feature entirely.
> + */
> +#define MAX_ALLOWED_PREFIXES 65536
> +
>  /*
>   * Check if one of the prefixes is a prefix of the ref.
>   * If no prefixes were provided, all refs match.
> @@ -141,6 +147,7 @@ static int ls_refs_config(const char *var, const char *value, void *data)
>  int ls_refs(struct repository *r, struct packet_reader *request)
>  {
>  	struct ls_refs_data data;
> +	int too_many_prefixes = 0;
>
>  	memset(&data, 0, sizeof(data));
>  	strvec_init(&data.prefixes);
> @@ -156,8 +163,16 @@ int ls_refs(struct repository *r, struct packet_reader *request)
>  			data.peel = 1;
>  		else if (!strcmp("symrefs", arg))
>  			data.symrefs = 1;
> -		else if (skip_prefix(arg, "ref-prefix ", &out))
> -			strvec_push(&data.prefixes, out);
> +		else if (skip_prefix(arg, "ref-prefix ", &out)) {
> +			if (too_many_prefixes) {
> +				/* ignore any further ones */
> +			} else if (data.prefixes.nr >= MAX_ALLOWED_PREFIXES) {
> +				strvec_clear(&data.prefixes);
> +				too_many_prefixes = 1;
> +			} else {
> +				strvec_push(&data.prefixes, out);
> +			}
> +		}

The order of this if-statement is a little odd to me, but obviously
correct. I might have wrote:

    if (too_many_prefixes)
      continue;

    if (data.prefixes.nr < MAX_ALLOWED_PREFIXES) {
      strvec_push(&data.prefixes, out);
    } else {
      too_many_prefixes = 1;
      strvec_clear(&data.prefixes);
    }

But certainly what you wrote here works just fine (so this is a cosmetic
comment, and not a functional one).

>  		else if (!strcmp("unborn", arg))
>  			data.unborn = allow_unborn;
>  	}
> diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
> index 930721f053..b095bfa0ac 100755
> --- a/t/t5701-git-serve.sh
> +++ b/t/t5701-git-serve.sh
> @@ -158,6 +158,37 @@ test_expect_success 'refs/heads prefix' '
>  	test_cmp expect actual
>  '
>
> +test_expect_success 'ignore very large set of prefixes' '
> +	# generate a large number of ref-prefixes that we expect
> +	# to match nothing; the value here exceeds MAX_ALLOWED_PREFIXES
> +	# from ls-refs.c.
> +	{
> +		echo command=ls-refs &&
> +		echo object-format=$(test_oid algo)
> +		echo 0001 &&
> +		perl -le "print \"refs/heads/$_\" for (1..65536+1)" &&
> +		echo 0000
> +	} |
> +	test-tool pkt-line pack >in &&
> +
> +	# and then confirm that we see unmatched prefixes anyway (i.e.,
> +	# that the prefix was not applied).
> +	cat >expect <<-EOF &&
> +	$(git rev-parse HEAD) HEAD
> +	$(git rev-parse refs/heads/dev) refs/heads/dev
> +	$(git rev-parse refs/heads/main) refs/heads/main
> +	$(git rev-parse refs/heads/release) refs/heads/release
> +	$(git rev-parse refs/tags/annotated-tag) refs/tags/annotated-tag
> +	$(git rev-parse refs/tags/one) refs/tags/one
> +	$(git rev-parse refs/tags/two) refs/tags/two

You could have written this as a loop over the unmatched prefixes, but I
vastly prefer the result you came up with, which is much more explicit
and doesn't require readers to parse out what the loop does.

So this part looks very good to me.

Thanks,
Taylor
