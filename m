Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709D7C433E9
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 21:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 445C123443
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 21:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbhATV2d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 16:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729266AbhATNlY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 08:41:24 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A416CC061798
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 05:40:24 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id d15so10788089qtw.12
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 05:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MJ0fOfpOMutMls6RT2UB9bkX9ISojWngtuzjEdm40WQ=;
        b=ciM4aJqBVYf+MkWCcbSBueZYA4nsjmEEJFyESLzO3rMiqUFqbWB6fUpMeFIiTpdx/O
         zqgH5Zb3pTjWC2uphOFtcxlrSqhwJPcBg09mdCpFH1Y/lAS0umAjmZnoSzh73VBPiLxI
         ca1FLriQrJbRT7aSyIzQMF5InjBmW6K45lnJxV+OGLFoOSkIGNtT5pfjCTgHym4vguEV
         tLKMzgQp5PlpiQyAehVVVvmaC3EMGQVlUxgcz1YyZQIDjsrmPFu59lQVJvA5l6JTdw+s
         r+84ZsCQqAO4mj4xYsvQrqUkITGOM9E9z4gkEgJ8xtd7wQXpUw22zbMVkkJiyC26GhfY
         cauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MJ0fOfpOMutMls6RT2UB9bkX9ISojWngtuzjEdm40WQ=;
        b=dS5kMQOFEZadO9Y2YkY06hFE0u7bGwVNKSyu6EIgil+KexITpFnogIvA9FZR/0kDW0
         YqwkwTZTF6srBfgaOH2BEKdgrOWlSCyrqHkGRbN/V+iTzI0VfNU0nulfcZb42Znlo9ms
         ToLw0k9MexoXcNaYTW4J4g6t8PaaaEwKSJ5RiuhThZ8QpksBdwOOkmHbWEVv2y2i7KMG
         1KPT9IPqpRJlCz3MFgo44NcUPA2pKk1yeN+ikHcgTI3G5RlJUmoWW/1LidijjIWECREY
         aqKLKDU3zMlZ1NJO4gPL7P4uPpCSXvfmILcyPGXVTRaED+y7m9QFpCcoAunPM3HXR95z
         n4/A==
X-Gm-Message-State: AOAM530u8HVbY1/BAt6sluQNgdRwMSBvdlZFZ2LnA+/iCGC0zut7Qj5l
        8NEuqwn8OrJ2ldh9tSkrWko=
X-Google-Smtp-Source: ABdhPJy8i4vPu1ALF6CTSD+8xWibVGlt60I8OVL6MZRx0btR+5wfSr1PJgsERi1M16mVWgUFXb6clQ==
X-Received: by 2002:ac8:5a01:: with SMTP id n1mr8840200qta.107.1611150023777;
        Wed, 20 Jan 2021 05:40:23 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:710c:cecb:a7d:75ab? ([2600:1700:e72:80a0:710c:cecb:a7d:75ab])
        by smtp.gmail.com with UTF8SMTPSA id r20sm1203088qke.92.2021.01.20.05.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 05:40:22 -0800 (PST)
Subject: Re: [PATCH 01/10] packfile: introduce 'find_kept_pack_entry()'
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
References: <cover.1611098616.git.me@ttaylorr.com>
 <dc7fa4c7a61f657e779e10385d3e8076d6dac36c.1611098616.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <607e7ebd-240d-f2dc-42ef-1d5a5a0b7f51@gmail.com>
Date:   Wed, 20 Jan 2021 08:40:22 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <dc7fa4c7a61f657e779e10385d3e8076d6dac36c.1611098616.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/19/2021 6:24 PM, Taylor Blau wrote:
>  	for (m = r->objects->multi_pack_index; m; m = m->next) {
> -		if (fill_midx_entry(r, oid, e, m))
> +		if (!(fill_midx_entry(r, oid, e, m)))

nit: we don't need extra parens around fill_midx_entry().

> -		if (!p->multi_pack_index && fill_pack_entry(oid, e, p)) {
> -			list_move(&p->mru, &r->objects->packed_git_mru);
> -			return 1;
> +		if (p->multi_pack_index && !kept_only) {
> +			/*
> +			 * If this pack is covered by the MIDX, we'd have found
> +			 * the object already in the loop above if it was here,
> +			 * so don't bother looking.
> +			 *
> +			 * The exception is if we are looking only at kept
> +			 * packs. An object can be present in two packs covered
> +			 * by the MIDX, one kept and one not-kept. And as the
> +			 * MIDX points to only one copy of each object, it might
> +			 * have returned only the non-kept version above. We
> +			 * have to check again to be thorough.
> +			 */
> +			continue;
> +		}
> +		if (!kept_only ||
> +		    (((kept_only & ON_DISK_KEEP_PACKS) && p->pack_keep) ||
> +		     ((kept_only & IN_CORE_KEEP_PACKS) && p->pack_keep_in_core))) {
> +			if (fill_pack_entry(oid, e, p)) {
> +				list_move(&p->mru, &r->objects->packed_git_mru);
> +				return 1;
> +			}

Here is the meat of your patch. The comment helps a lot.

This might have been easier if the MIDX had preferred kept packs
over non-kept packs (before sorting by modified time). Perhaps
the MIDX could get an extra field to say "I preferred kept packs"
which would let us trust the MIDX return here without the pack
loop.

(Note: we can't just change the MIDX selection and then start
trusting all MIDXs to have the right tie-breakers because of
existing files in the wild.)

Thanks,
-Stolee
