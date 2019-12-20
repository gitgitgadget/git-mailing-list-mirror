Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F53FC43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 16:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0116321D7E
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 16:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgjWGDaF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfLTQFY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 11:05:24 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42008 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfLTQFX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 11:05:23 -0500
Received: by mail-qt1-f195.google.com with SMTP id j5so8573497qtq.9
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 08:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ylS2tPanDE+RxZ9Ssp0snJZDPZu5Qe5LdQ4+XtK/J9M=;
        b=fgjWGDaFPSiuLwHNhmfq823bqw4nqogog1/HBN6iKiEtsU53DZdrJKBw554EUBGh5z
         9sHS33gvPmJGdb62QsYdBxavxQoBsW6T31JvSsdf+fZWSgah/9YsKK5D/PtLzI64oltz
         EINcrcbO6Ht2PNzy8ez2XqFDgtP0tTjejIM8upLTyBqvYZdvhlRkyrXjZg8vyR9qcxPZ
         3laSVS9YJdQL/+R1Odjt/ymp88W/Es6jeSOXSsskS/AyE8BNRs1RhA6XVUiBi2rhcF9j
         XZJOX9xDOFnYEVRxiCpi8hha2JC/+9qsdDFZC0066+sxUm5WfPNiLHFK80QcaQ9i1dqX
         PORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ylS2tPanDE+RxZ9Ssp0snJZDPZu5Qe5LdQ4+XtK/J9M=;
        b=qHzvrzOQvvyDiBDtfwFcsVSC9sHcNecyv/QEfx0zGTexXTyFBGIw5zGCGPo8PnLQhR
         Tg/x0snqtCmkV5vAwYbL8E5/d/UP4WwhTQh3tZKdNjkD1n9Gulr+GqK7IeuTOnGTTIBE
         b/yuzGOywtHDVdCwtJzHQ5ma+Fj/iIqW3ct5h04s60jhmhTESwQSDSvCe0JpwIsqwuW9
         OJQ9znVhjRRNqeLfbCbZ8nJdw+GATbTEnHJPM2au4OhwYTQUrJKNv+G0z4+Zex5Y3x48
         wFiHCHfCjP7b3NSe9Q+wDpLe8ZNVP+ws0KQlWQHrr4vA4TFc+MBDtItR4stJ0htJXeO8
         cx+g==
X-Gm-Message-State: APjAAAWv01xieMEc/tR4zYYqhLLuQ0HmpQLmewoZdx/JPqoj+m58sAUv
        VT24kQrEfg02MEYvv+pOH2Y=
X-Google-Smtp-Source: APXvYqzvSjBFH7lhDPPelGemGF8yINoQunwPdM8At4L9OZsFYeK0BkoBgsSdHR9/KvdcYDGdZ9nxtw==
X-Received: by 2002:ac8:2e6a:: with SMTP id s39mr12464233qta.349.1576857923054;
        Fri, 20 Dec 2019 08:05:23 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:b8d3:2731:aa33:5534? ([2001:4898:a800:1012:6a07:2731:aa33:5534])
        by smtp.gmail.com with ESMTPSA id l19sm3143227qtq.48.2019.12.20.08.05.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2019 08:05:22 -0800 (PST)
Subject: Re: [PATCH v3] sparse-checkout: improve OS ls compatibility
To:     Ed Maste <emaste@FreeBSD.org>,
        git mailing list <git@vger.kernel.org>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>
References: <20191219015833.49314-1-emaste@FreeBSD.org>
 <20191220153814.54899-1-emaste@FreeBSD.org>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9c3d10c3-76fb-9e9e-013b-b3f66b934dd6@gmail.com>
Date:   Fri, 20 Dec 2019 11:05:22 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20191220153814.54899-1-emaste@FreeBSD.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/20/2019 10:38 AM, Ed Maste wrote:
> On FreeBSD, when executed by root ls enables the '-A' option:
> 
>   -A  Include directory entries whose names begin with a dot (`.')
>       except for . and ...  Automatically set for the super-user unless
>       -I is specified.
> 
> As a result the .git directory appeared in the output when run as root.
> Simulate no-dotfile ls behaviour using a shell glob.

This patch looks good to me and seems to match where the
discussion landed. Thanks for finding and fixing this!

-Stolee

