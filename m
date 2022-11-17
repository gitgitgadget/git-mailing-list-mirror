Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112CBC4332F
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 14:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240378AbiKQOTp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 09:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240367AbiKQOTl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 09:19:41 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DE077212
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 06:19:40 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id j12so1745266plj.5
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 06:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pIDJZtgDAp8OPRbcVn5NY5IbBuSZjp79dvncm7jSh8=;
        b=QoCF75mEQHGCZ6xsAJjw/C0Qu076AWC0zQmQ4qOpABfv8GMgV4Xi8EHvpl1Jtv/sue
         GQTkL106XN29hUFC/hbHDG0hQMF/UxVdsWpi8xVAn1TsdFmPqyKnRdpraFlzyUkm4XdT
         HzBV79L58awgeiNt+/xzB9fTzqzCW6mbK9+MFJiMiWlF41L6iK3ngJJJHntYj+z5QjkV
         V6stUmB+2kWXXtLuByykZIzEqnOsHDOOQjhr2zdUzWon6LwLHtWvE8UmD520ufd9qTg8
         +W6jge1NO2ySHRzRyZSt9D10OTjRJlxKPTknMmprSwjaYluPwJOlVEu6Pd1jjB6kQwBT
         NN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7pIDJZtgDAp8OPRbcVn5NY5IbBuSZjp79dvncm7jSh8=;
        b=WEkppm/ooydZbdccUyocSTVcx2i6PCEa6u2stshnUzWdScEskvebuM6yy/oUcSGKA+
         e2i8cvGHfEzYDcQm4FfS+SoVYKIC1+dmmmOwK8hE6HubmRNpREN2uF+S+eP9lK/GKnh/
         M4ZXp9ZlWmuiM/t0xxEXshohxkQwxwOrm48Db3iCkeFylv984Y0EvKLBMP1z83HOUB92
         Hskrx7kDUvvGnntnw83GfmMyvk0wbi6q1yeeoQ+wpWIDCbcRSWHoaigT5mR97JNiXcdx
         tbSeoLLCRjvmJ/j5MMW5Io3iCEiiSoPgOfJb+F9SYyVATkKMoMFMDfK+3HMasj+1ujSM
         ScVg==
X-Gm-Message-State: ANoB5pnI+tY9PjqHjIoZQNjZBhQfj2gwULDtk0A9xkESXvY78+sth8Zx
        vObWHjh+rcjkyD3A69Ihq0A=
X-Google-Smtp-Source: AA0mqf7n+ojBfmTukbEtD8uCXomXsHJpVXj3VCC3BmAzLTc6k2GDlqCYX+MW6iTU/RPS/8YM/ZJ8oQ==
X-Received: by 2002:a17:903:2487:b0:187:282c:9b9c with SMTP id p7-20020a170903248700b00187282c9b9cmr3057057plw.29.1668694780339;
        Thu, 17 Nov 2022 06:19:40 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.60])
        by smtp.gmail.com with ESMTPSA id i9-20020a17090332c900b00186b69157ecsm1397079plr.202.2022.11.17.06.19.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Nov 2022 06:19:39 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     peff@peff.net
Cc:     avarab@gmail.com, derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v3 0/2] pack-bitmap.c: avoid exposing absolute paths
Date:   Thu, 17 Nov 2022 22:19:33 +0800
Message-Id: <20221117141933.73790-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.1.383.g9d5a491887b
In-Reply-To: <Y3K//kO3fxD7Pl3/@coredump.intra.peff.net>
References: <Y3K//kO3fxD7Pl3/@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Me too. If we wanted to go further, there are two obvious next steps.
>
> One, we can break out of the bitmap loop early if we're not tracing:

> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index aaa2d9a104..3b6c2f804a 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -527,8 +527,15 @@ static int open_pack_bitmap(struct repository *r,
>  	assert(!bitmap_git->map);
>
>  	for (p = get_all_packs(r); p; p = p->next) {
> -		if (open_pack_bitmap_1(bitmap_git, p) == 0)
> +		if (open_pack_bitmap_1(bitmap_git, p) == 0) {
>  			ret = 0;
> +			/*
> +			 * The only reason to keep looking is to report
> +			 * duplicates.
> +			 */
> +			if (!trace2_is_enabled())
> +				break;
> +		}
>  	}
>
>  	return ret;
>
> I doubt this buys us much in practice. After patch 2, looking for extra
> bitmaps is much cheaper. It's one open() call per pack (which will
> return ENOENT normally) looking for a bitmap. And while it's only 2
> lines of code, it does increase coupling of assumptions between the two
> functions. So maybe not worth doing. I dunno.

I agree and I think it's reasonable.

So If I bring it into the patch how about the commit message:

Author: Jeff King <peff@peff.net>
Date:   Thu Nov 17 19:55:23 2022 +0800

    pack-bitmap.c: break out of the bitmap loop early if not tracing

    When we successfully open a bitmap, we will continue to try to open
    other packs, and when trace2 is enabled, we will report any subsequent
    bitmap ignored information in the log. So when we find that trace2 is
    not enabled, we can actually terminate the loop early.

    Signed-off-by: Jeff King <peff@peff.net>
    Signed-off-by: Teng Long <dyroneteng@gmail.com>

> And two, we could complain when there is both a midx and a pack bitmap,
> like so:
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 3b6c2f804a..44a80ed8f2 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -524,8 +524,6 @@ static int open_pack_bitmap(struct repository *r,
>  	struct packed_git *p;
>  	int ret = -1;
>
> -	assert(!bitmap_git->map);
> -
>  	for (p = get_all_packs(r); p; p = p->next) {
>  		if (open_pack_bitmap_1(bitmap_git, p) == 0) {
>  			ret = 0;
> @@ -559,11 +557,20 @@ static int open_midx_bitmap(struct repository *r,
>  static int open_bitmap(struct repository *r,
>  		       struct bitmap_index *bitmap_git)
>  {
> +	int found = 0;
> +
>  	assert(!bitmap_git->map);
>
> -	if (!open_midx_bitmap(r, bitmap_git))
> -		return 0;
> -	return open_pack_bitmap(r, bitmap_git);
> +	found = !open_midx_bitmap(r, bitmap_git);
> +
> +	/*
> +	 * these will all be skipped if we opened a midx bitmap; but run it
> +	 * anyway if tracing is enabled to report the duplicates
> +	 */
> +	if (!found || trace2_is_enabled())
> +		found |= !open_pack_bitmap(r, bitmap_git);
> +
> +	return found ? 0 : -1;
>  }
>
>  struct bitmap_index *prepare_bitmap_git(struct repository *r)
>
> But I'm not sure if that is even something we want. I know we retained
> pack bitmaps as a quick recovery mechanism while test-deploying midx
> bitmaps. OTOH, now that the feature is stable, I doubt anybody else
> would ever do that.
>
> It also suffers from the same coupling issues as the other.
>
> So I don't know that either is worth pursuing (hence this message and
> not fully prepared patches), but these are just the two leftover things
> I noticed from the series, so I wanted to record them for posterity.

Since this is an internal mechanism, and we are doing reminders in trace2, so
the diff looks good to me. How about the commit message if I need to take it:

Author: Jeff King <peff@peff.net>
Date:   Thu Nov 17 20:25:18 2022 +0800

    pack-bitmap.c: trace bitmap ignore logs when midx-bitmap is found

    We retained pack bitmaps as a quick recovery mechanism while
    test-deploying midx bitmaps. This is an internal mechanism, and we
    want to expose this rule externally through trace2 so that end users,
    repo-maintainers, and debuggers know what is happening in the process.

    Signed-off-by: Jeff King <peff@peff.net>
    Signed-off-by: Teng Long <dyroneteng@gmail.com>

Thank you Peff for providing such detailed suggestions for improvement.
