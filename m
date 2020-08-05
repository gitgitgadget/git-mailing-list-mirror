Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7E2C433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 15:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4DCC2342C
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 15:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="axPFZRTe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgHEPut (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 11:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgHEPsi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 11:48:38 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08107C0D942B
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 08:17:18 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id l6so41964900qkc.6
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 08:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gcilrel7c901gSbI9L68V4cz33r0GYlgRBWtqDNZE90=;
        b=axPFZRTeWtZOn77aAbroKUTlh29EYCibg6yBkSGkJxVg7II7Jgfy7q2YviV8QKbywx
         ByidccZcFTn2do0hxMqmGDUjPtXw2+OxL0CXIflGdpu2gvRHbVQhJiAN/46ewTA+h2Ta
         2g2NUrCkR5jNMSOKVIOtFgds4z1XngNpdRq4Rkl1DBYQmlWNv93Q9QK7fggApQwiAm3S
         ++A79FhkSOZxG0AfhUYDJrg4lOvfWGa9obH4QdCNc/a5+6OpQ+SDtP35mn1v2chc3OvV
         WFcT8VHLxUVKrbC+7rx3t9KtHCXysBjBWmdm8WlmzmUM9IE5LBoHTzQdkfy7CjQqMFkm
         Ik5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gcilrel7c901gSbI9L68V4cz33r0GYlgRBWtqDNZE90=;
        b=VX0BoTVcQnYWru7cqB12z6Bu9lPh0n7DcB1d4pg2E3AH9Tv+BrOfGAZIozEcr6Y/kI
         dV2QlhmBYKNvTuYobXsaZfzhbsLzKht5WGgPSfZspOZ03644VBYDpxuoCHzVjwxqNLla
         cWg7fvBzZamGOtSkpywGlyBDLHNwa9LYSC0bDhw6x/Ccvz6GvnONfgezHG3UeDxxEQfw
         saFBEZAeyOu5lEetki2wIMsdPpg+gUrtFVcsQD0oErHICCbsIk5Ls6NyT1yEWvRE3vyN
         CiIudm4TuEu4SoqEm441zHhO8ZqSkwSKOAmSEA1wmpVLeVfFdzSYhy9T2/+EH60vyW0y
         ZZtQ==
X-Gm-Message-State: AOAM5335rUO/fE9O2A2CwBOSlGy2tWfK66hvD1Pybn3IPBa7kORq7lbN
        KdwGQvFcNF2XMMHng5Bg2S4NJA==
X-Google-Smtp-Source: ABdhPJwwGJ4h9uC3p6YDA9V4lACTO3fII9urX5XjrIC+1UYDU1P7gagNFRBC94kWOSnZcZ13bvRnHg==
X-Received: by 2002:a37:a495:: with SMTP id n143mr3807112qke.330.1596640633735;
        Wed, 05 Aug 2020 08:17:13 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:d118:9acc:fdba:dee7])
        by smtp.gmail.com with ESMTPSA id z24sm1725886qki.57.2020.08.05.08.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 08:17:13 -0700 (PDT)
Date:   Wed, 5 Aug 2020 11:17:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 2/3] revision: avoid out-of-bounds read/write on empty
 pathspec
Message-ID: <20200805151712.GD9546@syl.lan>
References: <20200804074146.GA190027@coredump.intra.peff.net>
 <20200804074652.GB284046@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200804074652.GB284046@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 04, 2020 at 03:46:52AM -0400, Jeff King wrote:
> Running t4216 with ASan results in it complaining of an out-of-bounds
> read in prepare_to_use_bloom_filter(). The issue is this code to strip a
> trailing slash:
>
>   last_index = pi->len - 1;
>   if (pi->match[last_index] == '/') {
>
> because we have no guarantee that pi->len isn't zero. This can happen if
> the pathspec is ".", as we translate that to an empty string. And if
> that read of random memory does trigger the conditional, we'd then do an
> out-of-bounds write:
>
>   path_alloc = xstrdup(pi->match);
>   path_alloc[last_index] = '\0';
>
> Let's make sure to check the length before subtracting. Note that for an
> empty pathspec, we'd end up bailing from the function a few lines later,
> which makes it tempting to just:
>
>   if (!pi->len)
>           return;
>
> early here. But our code here is stripping a trailing slash, and we need
> to check for emptiness after stripping that slash, too. So we'd have two
> blocks, which would require repeating some cleanup code.
>
> Instead, just skip the trailing-slash for an empty string. Setting
> last_index at all in the case is awkward since it will have a nonsense
> value (and it uses an "int", which is a too-small type for a string
> anyway). So while we're here, let's:
>
>   - drop last_index entirely; it's only used in two spots right next to
>     each other and writing out "pi->len - 1" in both is actually easier
>     to follow
>
>   - use xmemdupz() to duplicate the string. This is slightly more
>     efficient, but more importantly makes the intent more clear by
>     allocating the correct-sized substring in the first place. It also
>     eliminates any question of whether path_alloc is as long as
>     pi->match (which it would not be if pi->match has any embedded NULs,
>     though in practice this is probably impossible).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Another variant is to actually stop assigning revs->bloom_filter_settings
> so early, so that we don't have to clean it up. And then once we're sure
> we're going to use it and have passed all of our early-return checks,
> then assign it. But that conflicts with the get_bloom_filter_settings()
> patch in:
>
>   https://lore.kernel.org/git/08479793c1274d5ee0f063578bb0f4d93c910fa9.1596480582.git.me@ttaylorr.com/
>
> so I didn't go that way.

Good, I was going to ask about that. Thanks for thinking of those
patches and avoiding introducing a conflicting patch (of course, I
implemented this other approach in github/git, and so will pay the price
when I deal with the conflict myself ;-)).

>
>  revision.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/revision.c b/revision.c
> index 6de29cdf7a..5ed86e4524 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -669,7 +669,6 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
>  	struct pathspec_item *pi;
>  	char *path_alloc = NULL;
>  	const char *path, *p;
> -	int last_index;
>  	size_t len;
>  	int path_component_nr = 1;
>
> @@ -692,12 +691,10 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
>  		return;
>
>  	pi = &revs->pruning.pathspec.items[0];
> -	last_index = pi->len - 1;
>
>  	/* remove single trailing slash from path, if needed */
> -	if (pi->match[last_index] == '/') {
> -		path_alloc = xstrdup(pi->match);
> -		path_alloc[last_index] = '\0';
> +	if (pi->len > 0 && pi->match[pi->len - 1] == '/') {
> +		path_alloc = xmemdupz(pi->match, pi->len - 1);

Looks correct. Thanks.

>  		path = path_alloc;
>  	} else
>  		path = pi->match;
> --
> 2.28.0.536.ga4d8134877

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
