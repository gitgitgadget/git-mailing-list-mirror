Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A357C2B9F4
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 02:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49CCD60E0B
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 02:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhFWCtB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 22:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbhFWCtA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 22:49:00 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C47C061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 19:46:43 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id k16so1507587ios.10
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 19:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nBtfYxJmiXYWctbc0tzhvEMyN8gBD9ONyQz9mPuu+yg=;
        b=J/QONHY1qHGGMbd7jm9z6MFj0T4Nu+WwjSPbO9nOr5/TeFXLSfF19KqpCxn/lCFMBl
         4mZj78JAwPm5f50TxOXyy2WANm3EvcEv6Y8SkCjZFlYOwXZtWYNnLD8K5XUUgY7Yc5Fl
         uBwFAoJKea56yUuKcsvtr8839WvWH7p5SCuXGR3D5tQWk8/DtqcWY0TdpyLIK6UUM3WM
         kqXwhwJ62tYUQUpsbWTX6SvmGZ6SW8Yc6bXCzfMZBaVWq51IzQ0u5dX7wlzHr3GIovh5
         mG7Rbpnsxk/OC8K6WDTqDBiqZebOtveaqxCyMwDpzDLix46tcgS6a0oOjeQ6JkEvOGAJ
         wL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nBtfYxJmiXYWctbc0tzhvEMyN8gBD9ONyQz9mPuu+yg=;
        b=k9diB3glk967eGceLbL5FI3fcqgVa8vOqGq5iEfm7hZNzQAPHogf+Go94+uKWTrfBW
         tFbdOSAmZ2z5RbyZNHf+C1IZo3dnDyaQN1xbx9E1Ro94BVN6xpaUoCb9hk7PRpvJ+SZN
         WNNbP55ubjk699Tnc8Br9lchGSgBaXvI8iltb6L2GiJOR0v/roy1zDbLuI4CMWRHy1K+
         AdsEGkcZ6YbGDEJTo2qxQirn+8nUfwk7A4bCwLJ9uAfBPdQxN+KsL3j1LVQoo+T63q6q
         7sX9D4caQE7U3ITHDWuyGDQCUmNgUUjUj+GRQIlbpHunKPlmRW8AZQ+fxfxdloyIO2H+
         aJYw==
X-Gm-Message-State: AOAM530DeI2W2eeUQ8W7vsCUX0l1uJ4m/ziYEeTJEwXA4N+QCkmMD3xW
        O0YTC2D3IOkSyr5nIdAEJ2t7ULR0AgT92lyV
X-Google-Smtp-Source: ABdhPJyipv8/riVScTJZ0ofV9V8+dG67KQKrvrEGoyNdXxxbbRvbRBLlh33ZDZ7JRNR5o2MP8WBiRg==
X-Received: by 2002:a6b:e018:: with SMTP id z24mr5350492iog.206.1624416402482;
        Tue, 22 Jun 2021 19:46:42 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:827b:778a:e73b:3ade])
        by smtp.gmail.com with ESMTPSA id 7sm9287931ily.63.2021.06.22.19.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 19:46:41 -0700 (PDT)
Date:   Tue, 22 Jun 2021 22:46:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/5] load_ref_decorations(): avoid parsing non-tag objects
Message-ID: <YNKgkGkPiMgNubNE@nand.local>
References: <YNIJw/8p0F3cPfzd@coredump.intra.peff.net>
 <YNILCDz3LpHX7OX0@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YNILCDz3LpHX7OX0@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 22, 2021 at 12:08:40PM -0400, Jeff King wrote:
> If the packed-refs file ever learns to store all of the peeled layers,
> then we could switch to it. Or even if it stored a flag to indicate the
> peel was not multi-layer (because most of them aren't), then we could
> use it most of the time and fall back to a manual peel for the rare
> cases.

Yeah, I would be in favor of either of these. Of the two, the latter
seems like the simplest thing, but the former provides you all of the
information you could hope for.

I suppose that if you are already changing the format of packed-refs,
then we might as well do the thing which provides the most information
and allows us to optimize *all* cases, not just the vast majority of
them.

Of course, that's all way outside of the scope of this patch, which
shouldn't have to deal with either of those.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  log-tree.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/log-tree.c b/log-tree.c
> index 7b823786c2..8b700e9c14 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -134,6 +134,7 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
>  			      int flags, void *cb_data)
>  {
>  	struct object *obj;
> +	enum object_type objtype;
>  	enum decoration_type type = DECORATION_NONE;
>  	struct decoration_filter *filter = (struct decoration_filter *)cb_data;
>
> @@ -155,9 +156,10 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
>  		return 0;
>  	}
>
> -	obj = parse_object(the_repository, oid);
> -	if (!obj)
> +	objtype = oid_object_info(the_repository, oid, NULL);
> +	if (type < 0)
>  		return 0;
> +	obj = lookup_object_by_type(the_repository, oid, objtype);

The comments about s/type/obj&/ aside, this looks good to me (and the
amended version below looks ready to be picked up, at least in my eyes).

One thing I did want to note which is elided by the limited context is
that we *do* parse tags like you say, it's just hidden in the "while
(obj->type == OBJ_TAG)" loop below.

So that's doing the right thing, but it wasn't clear from the limited
context here that this patch was immediately correct.

Thanks,
Taylor
