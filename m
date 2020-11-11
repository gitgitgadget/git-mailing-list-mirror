Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BC8C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 15:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23EA4206A1
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 15:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qiL1OVvX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgKKPbt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 10:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgKKPbt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 10:31:49 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C381EC0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 07:31:47 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id 11so2007746qkd.5
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 07:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=0vuB9jHfkGgJlYczpAsKbkg8Qty8vHj4YeLLtKWXKRs=;
        b=qiL1OVvXR9kX4Twch8dmT17w+Rx/vXeJKguWW2s4RS9k2FRAYg3US6+wHp0+Luypme
         KookAR4JC0xd28Gx4jGP0cllEPnVj0XRasHiOws3y1XFxgKckOvoUw5qMBt0S+0u6IOf
         ClW4h4QP9JtmSeb49Y8wZddL9cIUeboKwxjNQrGByCqT9nf3vyYfq17YH5pUymramagR
         CeWitZTShYHgn+wjXxA8JKICsP+UCPh1BhxoTlAxA2+ikd49h8/E5qXAD1k0fQ4HHXaT
         k6wIggCLLg5QPHD8nyPLuOb8YOc3Ugm3HN8wNRaRCTlW/jDzp+rmqTkmmcW/vduZ3R/u
         0Dfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0vuB9jHfkGgJlYczpAsKbkg8Qty8vHj4YeLLtKWXKRs=;
        b=t0eiIq7nrig6b9uX5EYVRKPLlbVUuUezJi1lpJSugfqaLl1yfeZlfNo/zmpYDQN4Pu
         MuYyQkAF9RGw2uezE7L+e+xEjcX33BgHVucaDKzNAQnBEYMkA7kAFdW8LtfZZwqTTDB6
         ziwhYSduH0KqKN0byUOZndY78aeBlVfsli3xE+gLItWFU6Nhg0xjsqmzj2HxuWRfm7h7
         63IvyDYEJhZ85ucEsg1MNU2+EkgB5fWomj4kFkfh0BxXD7jIrkr2epRc5h7On82n4esO
         HcjDj2LYK3Ysw5nbQUT8V3pwPxdGlZqv5tLikMZa4h5lpUcos3pCvvOpB2V63P6vewif
         Lg8w==
X-Gm-Message-State: AOAM532PAuBcsTODnK10gC6eF94k3RMPZaqycGunOoRT/dBxgP/kEjep
        huSNiM3M9qF5vjLsS4wHV6Y8D2YLeLyV2A==
X-Google-Smtp-Source: ABdhPJw3Vdk8c72KN8v6Rz54LVJqiNsqhpf7Xp86YXHBBNe2wRIQxgBEfZdcrVJZquiwI82edBT6pw==
X-Received: by 2002:a05:620a:5a6:: with SMTP id q6mr18465029qkq.80.1605108706762;
        Wed, 11 Nov 2020 07:31:46 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:c9d4:abc:8d:1568? ([2600:1700:e72:80a0:c9d4:abc:8d:1568])
        by smtp.gmail.com with UTF8SMTPSA id 205sm2285956qki.50.2020.11.11.07.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 07:31:45 -0800 (PST)
Subject: Re: [PATCH v2 10/20] merge-ort: avoid recursing into identical trees
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
References: <20201102204344.342633-1-newren@gmail.com>
 <20201102204344.342633-11-newren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <88ff65b6-1529-3471-00c3-c91233d75ad9@gmail.com>
Date:   Wed, 11 Nov 2020 10:31:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <20201102204344.342633-11-newren@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/2/2020 3:43 PM, Elijah Newren wrote:
> +	/*
> +	 * If mbase, side1, and side2 all match, we can resolve early.  Even
> +	 * if these are trees, there will be no renames or anything
> +	 * underneath.
> +	 */
> +	if (side1_matches_mbase && side2_matches_mbase) {

Here is a case where if you were not caring about renames you could prevent
recursion here when "!renames && sides_match". Something to think about.

> +		/* mbase, side1, & side2 all match; use mbase as resolution */
> +		setup_path_info(opt, &pi, dirname, info->pathlen, fullpath,
> +				names, names+0, mbase_null, 0,
> +				filemask, dirmask, 1);
> +		return mask;
> +	}
> +

-Stolee

