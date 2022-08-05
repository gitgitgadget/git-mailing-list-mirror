Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DD8C00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 10:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239980AbiHEKOF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 06:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235713AbiHEKOD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 06:14:03 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9082918E02
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 03:14:02 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z20so881906edb.9
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 03:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=kZFGxKqHyr58lg0oTzJ2t5bGPxCZF3inSTvHw/5nd4Q=;
        b=puOTf7EQXo39W051kXX7woG3HMBrcbtUxo/Z9iPf0O2SRQdi/70rDs2uJCc9g9wttW
         QPBmzcAerjoKcGcly418v4QmBa8hhBj4fndnEIt26QtPR7tulfBN19ZQDpXtVcY39UIE
         oQ5nX93uPSYhBAnF1sBzysAZrdIVayTI5YKgkG6nJ0cT3cO0QLSfTVLQdMDIx9xUwnXq
         LZQ/N1wzc16mi8ZUTM/JDvvg2QjAAM0kRQY1C2D9AvksWSjfs4UmnWrLDCU21t8TvJ8E
         8hgatm06aGiBiiBOoX6DsfwMx4RWgRT3odVqSe91ARiXI0l+nVcyKkBV6FwGGlMcAhZd
         nEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=kZFGxKqHyr58lg0oTzJ2t5bGPxCZF3inSTvHw/5nd4Q=;
        b=qWmV9XbJQ5pLEhJB9cUs0sNL0iz95aMbJ9u8GcPKBGbsRvyMwpO6EiHP6z4E/o4sKS
         5cK/ELBorgbeOSyRsomBm2tGvMK5F4YABHB9Li1BmJJi01RsCfGHVYNOkcqKYx2ZtuLJ
         FtF+v1GWqrdibEp3r3CU8u2ok3kXQWonaLWactzbGXeRyTZb+B1Xbtpe9frsPFSz82SY
         4RXQF5qRTNUdpx3lnPwgIqMRjB6d1Ia+32G3ea1gOBpAri+BsKuk28CgkNuuxSY8E8mi
         16Oy2KOZooyLGAamyzAXW2Df9AHpRHaawVZq/8due8SnzgfWvWLt7LW6cRT43ci+oZa5
         PL/g==
X-Gm-Message-State: ACgBeo2tELV1x8DfYP+t8k1NMvjRiFt3Z9CSewaxVNBacKtD7TPDSVQw
        o1GNNRunwmMs+y3jSgY9Lw1iwypxhF7Zog==
X-Google-Smtp-Source: AA6agR7j9yt3yNTchYB8M99Ye3HChqmp0qVwIRhHO0OKwHFYrOLn90hRcpzIAzL6pAvNv96MDkhGGw==
X-Received: by 2002:a05:6402:22bc:b0:43d:73a7:370a with SMTP id cx28-20020a05640222bc00b0043d73a7370amr5967506edb.120.1659694441005;
        Fri, 05 Aug 2022 03:14:01 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709063e9500b00730a73cbe08sm1369416ejj.169.2022.08.05.03.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 03:14:00 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oJuL9-000VG4-1F;
        Fri, 05 Aug 2022 12:13:59 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Li Linchao via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Li Linchao <lilinchao@oschina.cn>
Subject: Re: [PATCH] rev-list: support `--human-readable` option when
 applied `disk-usage`
Date:   Fri, 05 Aug 2022 12:03:29 +0200
References: <pull.1313.git.1659686097163.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1313.git.1659686097163.gitgitgadget@gmail.com>
Message-ID: <220805.864jyrro9k.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 05 2022, Li Linchao via GitGitGadget wrote:

> From: Li Linchao <lilinchao@oschina.cn>
>
> The '--disk-usage' option for git-rev-list was introduced in 16950f8384
> (rev-list: add --disk-usage option for calculating disk usage, 2021-02-09).
> This is very useful for people inspect their git repo's objects usage
> infomation, but the result number is quit hard for human to read.

s/the result number/the resulting number/
s/for human/for a human/

>
> Teach git rev-list to output more human readable result when using

s/to output more human/to output a human/

> '--disk-usage' to calculate objects disk usage.

For this I'd just s/ to calculate objects disk usage//. I.e. we already
discussed what --disk-usage does...

> +
> +-H::
> +--human-readable::
> +	Print on-disk objects size in human readable format. This option
> +	must be combined with `--disk-usage` together.
>  endif::git-rev-list[]

I'd really prefer if we didn't squat on -H, rev-list is overridden
enough, but how about:

	--disk-usage
	--disk-usage=human

Rather than introducing a new option?

>  	struct bitmap_index *bitmap_git;
> +	struct strbuf bitmap_size_buf = STRBUF_INIT;
> +	off_t size_from_bitmap;
>  
>  	if (!show_disk_usage)
>  		return -1;
> @@ -481,8 +484,13 @@ static int try_bitmap_disk_usage(struct rev_info *revs,
>  	if (!bitmap_git)
>  		return -1;
>  
> -	printf("%"PRIuMAX"\n",
> -	       (uintmax_t)get_disk_usage_from_bitmap(bitmap_git, revs));
> +	size_from_bitmap = get_disk_usage_from_bitmap(bitmap_git, revs);
> +	if (human_readable) {
> +		strbuf_humanise_bytes(&bitmap_size_buf, size_from_bitmap);
> +		printf("%s\n", bitmap_size_buf.buf);
> +	} else
> +		printf("%"PRIuMAX"\n", (uintmax_t)size_from_bitmap);
> +	strbuf_release(&bitmap_size_buf);

I think this would be better if we just use the strbuf unconditionally
(and a short &sb is conventional in such a short one-use function). So just:

	if (human_readable)
        	strbuf_humanise_bytes(&sb, size_from_bitmap);
	else
		strbuf_addf(&sb, "%"PRIuMAX", (uintmax_t)size_from_bitmap);
	puts(sb.buf);

It gets you rid of the need for {} braces, and I think makes for a nicer
read.

> -	if (show_disk_usage)
> -		printf("%"PRIuMAX"\n", (uintmax_t)total_disk_usage);
> +	if (show_disk_usage) {
> +		if (human_readable) {
> +			strbuf_humanise_bytes(&disk_buf, total_disk_usage);
> +			printf("%s\n", disk_buf.buf);
> +		} else
> +			printf("%"PRIuMAX"\n", (uintmax_t)total_disk_usage);
> +	}

Ditto, and we could make the &sb scoped to that "if (show_disk_usage)".

> +test_expect_success 'rev-list --disk-usage with --human-readable' '
> +	git rev-list --objects HEAD --disk-usage --human-readable >actual &&
> +	test_i18ngrep -e "446 bytes" actual

use grep, not test_i18ngrep (the latter should be going away entirely).

But actually we should use test_cmp here, isn't that the *entire*
output? I.e. won't this pass?

	echo 446 bytes >expect &&
	... >expect &&
	test_cmp expect actual

If so let's test what we really mean, i.e. we want *this* to be the
output, not to have output that has that sub-string on any arbitrary
amount of lines somewhere...

In this case it's unlikely to do the wrong thing, but it's a good habit
to get into...

> +test_expect_success 'rev-list --disk-usage with bitmap and --human-readable' '
> +	git rev-list --objects HEAD --use-bitmap-index --disk-usage -H >actual &&
> +	test_i18ngrep -e "446 bytes" actual

ditto.


> +'
> +
> +test_expect_success 'rev-list use --human-readable without --disk-usage' '
> +	test_must_fail git rev-list --objects HEAD --human-readable 2> err &&
> +	echo "fatal: option '\''--human-readable/-H'\'' should be used with" \
> +	"'\''--disk-usage'\'' together" >expect &&

You can make this a bit nicer by not using echo, use a here-doc instead:

	cat >expect <<-\EOF
        fatal: ...
	EOF

But you'll still need the '\'' quoting, but I thing it'll be better, and
avoids the line-wrapping (which we try to avoid for this sort of thing).
