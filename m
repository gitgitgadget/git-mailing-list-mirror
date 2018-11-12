Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C5091F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 16:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbeKMByf (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 20:54:35 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43944 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbeKMBye (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 20:54:34 -0500
Received: by mail-qk1-f193.google.com with SMTP id r71so14100320qkr.10
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 08:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=fJKfSyu0NwefHpPB8xFOEGNm5wnlg5xqvfYAU4E8ei8=;
        b=uTEWxcG07zVGAFm7fVypWxzAeK2Xd5OaLQtxlv++EgtuwPYZaAs8e88NTx5t7AZjA/
         rAnvEyol1VW6PqkAmNMXjNSVC6Lkjh6/Rxs+aTXnniM2r6erci0P2a4ypEIL0RyMghX0
         XdoSNIj7tW5cyiYhEIbZz9YTzUzHErf1B4K1nVh2JLl5MkVhq+5rJN7Q100Kn8TvHcW8
         bvJ6NzJyXdyBRMVZjD48KOF1CbPCZz2Qi+9wwVObOLEaqA8RMbJe/n6qqFHYS2BWQQtT
         BnevG3Go8DikwJcbaG/tCtC7+mEwiTd/xQ71QHHoe8p3V5Q945Iy6HyZpzZU02R/xwK3
         HrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fJKfSyu0NwefHpPB8xFOEGNm5wnlg5xqvfYAU4E8ei8=;
        b=rJ34xSiUs9hPnnMELiT9RCt0NIJ3Xa56xrikoLqMcTAptzQWSuGGfxHH+wdFa2T0RI
         YSgLS9ZYyLksnb9iCB8RQ6vqdVfSxsLU077BrSdqTdwfF5MPhxDR11u/8EDgAG6Bb1NG
         lsxGnM94z9ZHtwxCNR4owf+gktYDWgWF6APuqdL0RoiOIlVGgrHZVV5dDu0ot2akbP5o
         DPLexf5EE8iJZW5lp8q5GbRzw8XqN1YhMrZlr3dr9JRXLIG9j4edL4wrCSk9k0neNGMu
         mYZe5v/WHp8x6R4Ow0WZqFZo6jBVXs1M8pLF1+9+0TKqYvqot+epjfD3DwFOC4kOjc+6
         z/Pg==
X-Gm-Message-State: AGRZ1gIYO8QCJlEf07lSdKbODP8rafe7pdKgG7BLJu4/lfOOQjcLNfGs
        4P9jgbutL8uuczELzktqW4m/rKoL
X-Google-Smtp-Source: AJdET5fDpeSRe7m+H/aJepE0BaBfOrHZaAYg/7rfHHKs6s/iU3vvACXG8ErKJ1CJmK9dgxEe8HX2Kg==
X-Received: by 2002:a37:7442:: with SMTP id p63mr1396118qkc.320.1542038443390;
        Mon, 12 Nov 2018 08:00:43 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:705f:75d7:178c:fe1c? ([2001:4898:8010:0:5995:75d7:178c:fe1c])
        by smtp.gmail.com with ESMTPSA id v57sm11710962qtv.80.2018.11.12.08.00.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 08:00:42 -0800 (PST)
Subject: Re: [PATCH 8/9] sha1-file: use loose object cache for quick existence
 check
To:     Jeff King <peff@peff.net>, Geert Jansen <gerardu@amazon.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Takuto Ikuta <tikuta@chromium.org>
References: <20181112144627.GA2478@sigill.intra.peff.net>
 <20181112145442.GH7400@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <eb3717c3-991f-16d9-3042-0d8b7f6a05af@gmail.com>
Date:   Mon, 12 Nov 2018 11:00:43 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20181112145442.GH7400@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/12/2018 9:54 AM, Jeff King wrote:
> In cases where we expect to ask has_sha1_file() about a lot of objects
> that we are not likely to have (e.g., during fetch negotiation), we
> already use OBJECT_INFO_QUICK to sacrifice accuracy (due to racing with
> a simultaneous write or repack) for speed (we avoid re-scanning the pack
> directory).
>
> However, even checking for loose objects can be expensive, as we will
> stat() each one. On many systems this cost isn't too noticeable, but
> stat() can be particularly slow on some operating systems, or due to
> network filesystems.
>
> Since the QUICK flag already tells us that we're OK with a slightly
> stale answer, we can use that as a cue to look in our in-memory cache of
> each object directory. That basically trades an in-memory binary search
> for a stat() call.
>
> Note that it is possible for this to actually be _slower_. We'll do a
> full readdir() to fill the cache, so if you have a very large number of
> loose objects and a very small number of lookups, that readdir() may end
> up more expensive.
>
> This shouldn't be a big deal in practice. If you have a large number of
> reachable loose objects, you'll already run into performance problems
> (which you should remedy by repacking). You may have unreachable objects
> which wouldn't otherwise impact performance. Usually these would go away
> with the prune step of "git gc", but they may be held for up to 2 weeks
> in the default configuration.
>
> So it comes down to how many such objects you might reasonably expect to
> have, how much slower is readdir() on N entries versus M stat() calls
> (and here we really care about the syscall backing readdir(), like
> getdents() on Linux, but I'll just call this readdir() below).
>
> If N is much smaller than M (a typical packed repo), we know this is a
> big win (few readdirs() followed by many uses of the resulting cache).
> When N and M are similar in size, it's also a win. We care about the
> latency of making a syscall, and readdir() should be giving us many
> values in a single call. How many?
>
> On Linux, running "strace -e getdents ls" shows a 32k buffer getting 512
> entries per call (which is 64 bytes per entry; the name itself is 38
> bytes, plus there are some other fields). So we can imagine that this is
> always a win as long as the number of loose objects in the repository is
> a factor of 500 less than the number of lookups you make. It's hard to
> auto-tune this because we don't generally know up front how many lookups
> we're going to do. But it's unlikely for this to perform significantly
> worse.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> There's some obvious hand-waving in the paragraphs above. I would love
> it if somebody with an NFS system could do some before/after timings
> with various numbers of loose objects, to get a sense of where the
> breakeven point is.
>
> My gut is that we do not need the complexity of a cache-size limit, nor
> of a config option to disable this. But it would be nice to have a real
> number where "reasonable" ends and "pathological" begins. :)

I'm interested in such numbers, but do not have the appropriate setup to 
test.

I think the tradeoffs you mention above are reasonable. There's also 
some chance that this isn't "extra" work but is just "earlier" work, as 
the abbreviation code would load these loose object directories.

>
>   object-store.h |  1 +
>   sha1-file.c    | 20 ++++++++++++++++++++
>   2 files changed, 21 insertions(+)
>
> diff --git a/object-store.h b/object-store.h
> index bf1e0cb761..60758efad8 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -13,6 +13,7 @@ struct object_directory {
>   	/*
>   	 * Used to store the results of readdir(3) calls when we are OK
>   	 * sacrificing accuracy due to races for speed. That includes
> +	 * object existence with OBJECT_INFO_QUICK, as well as
>   	 * our search for unique abbreviated hashes. Don't use it for tasks
>   	 * requiring greater accuracy!
>   	 *
> diff --git a/sha1-file.c b/sha1-file.c
> index 4aae716a37..e53da0b701 100644
> --- a/sha1-file.c
> +++ b/sha1-file.c
> @@ -921,6 +921,24 @@ static int open_sha1_file(struct repository *r,
>   	return -1;
>   }
>   
> +static int quick_has_loose(struct repository *r,
> +			   const unsigned char *sha1)
> +{
> +	int subdir_nr = sha1[0];
> +	struct object_id oid;
> +	struct object_directory *odb;
> +
> +	hashcpy(oid.hash, sha1);
> +
> +	prepare_alt_odb(r);
> +	for (odb = r->objects->odb; odb; odb = odb->next) {
> +		odb_load_loose_cache(odb, subdir_nr);
> +		if (oid_array_lookup(&odb->loose_objects_cache, &oid) >= 0)
> +			return 1;
> +	}
> +	return 0;
> +}
> +
>   /*
>    * Map the loose object at "path" if it is not NULL, or the path found by
>    * searching for a loose object named "sha1".
> @@ -1171,6 +1189,8 @@ static int sha1_loose_object_info(struct repository *r,
>   	if (!oi->typep && !oi->type_name && !oi->sizep && !oi->contentp) {
>   		const char *path;
>   		struct stat st;
> +		if (!oi->disk_sizep && (flags & OBJECT_INFO_QUICK))
> +			return quick_has_loose(r, sha1) ? 0 : -1;
>   		if (stat_sha1_file(r, sha1, &st, &path) < 0)
>   			return -1;
>   		if (oi->disk_sizep)

LGTM.

Thanks,
-Stolee
