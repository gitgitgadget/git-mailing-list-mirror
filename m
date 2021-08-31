Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71291C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 14:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57C606103A
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 14:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238273AbhHaOsk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 10:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238203AbhHaOsi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 10:48:38 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7542BC061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 07:47:43 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id w19so24680491oik.10
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 07:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R5EsiD9AisNQ9kbYgvUKBgLOV5+pqHl7zRw5mQfbKYE=;
        b=Vh+7i2NzSyxRFUMLBN81j3xiwNgnmd+FWXeFa5Ap+IoEdNflCR/4Q4pNMdvfFe1pPt
         OaFrP9UE1wi4Ky++2EuI4shblgwuqWPRMdULjGRX4PknfQlRQeRa/AMHxiJU1Du/3Dm9
         FTVeEyEPLVLkxKujEG1v8R4VcpdPDgi3T2ILZ4M48M/Hn1vJtBsw0eBaYo4ob+xXpJzP
         m7znU0sfa4V5a7a1Ui0QwphD9hQgnrIcJGZxESzlVQy6f8YFcl3SPc2awU8gNBQvT4XJ
         tPxOFE/wBUQ1rTxJC4SGn66AIj9MY7JCxuIZXeiCExgkhew1Ve2PU9xb2OIUyualKPcX
         yh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R5EsiD9AisNQ9kbYgvUKBgLOV5+pqHl7zRw5mQfbKYE=;
        b=c7eQY91o644ikXIf45NjsNTZh0IdrAm8H+l2wdgsgCXCW+e6LephLQRBLlcrcQ1exq
         rsKWefEBc0GioV3oKjK+ZPvykpg5fVNEvUBeRmVDxrmumNiqZNcpn1IwQYpKoMUFpvTP
         UlEXcYI5VDk5lsR0aQMv1K3lJYAlIcOP0ssjSIheMxU1LHeuv9qIJQSIG80TC8OBZGiV
         Hd/5uMSD88nOf2xGd2wmAGlH+5BPfVyEYi24f5cK0/upEiKomi/9Ub+sTHK6KkJl8vXU
         8kz12FjcegvZ0iKBPPE2WDgK4+LFVDHsq0g4ullDdQI7dSRfH8Ni2gy48usjoaOCHXsB
         mmFQ==
X-Gm-Message-State: AOAM530+REYEHbdR81mHvIo1OdAqxiYmrbOAkj4iDzKawy9DZ6MkvCjh
        ezLflikaRyWu69ynkbK+DjlIqfKYb9w=
X-Google-Smtp-Source: ABdhPJxwEQUgGqDo1mvp8OHBDMNh2RKSaQ+auT1HZLKlKZi3wN2e14ISkriDUv5OO8a5+NFMPXvoTQ==
X-Received: by 2002:aca:bec2:: with SMTP id o185mr3307896oif.151.1630421262714;
        Tue, 31 Aug 2021 07:47:42 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7821:7d0e:d840:aa7e? ([2600:1700:e72:80a0:7821:7d0e:d840:aa7e])
        by smtp.gmail.com with ESMTPSA id u40sm3605183oiw.51.2021.08.31.07.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 07:47:42 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] Fix GIT_TEST_SPLIT_INDEX
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20210817174938.3009923-1-szeder.dev@gmail.com>
 <20210826210004.672860-1-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <885bc067-adef-6d23-b867-017cf1b72d25@gmail.com>
Date:   Tue, 31 Aug 2021 10:47:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210826210004.672860-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/26/2021 4:59 PM, SZEDER Gábor wrote:
> To recap from v1's cover letter:
> 
> Running tests with GIT_TEST_SPLIT_INDEX=1 is supposed to turn on the
> split index feature and trigger index splitting (mostly) randomly.
> Alas, this has been broken for ~2.5 years, and it hasn't triggered any
> index splitting since then.
> 
> The last patch in this series makes GIT_TEST_SPLIT_INDEX=1 work again,
> although it slightly changes its behavior; see its log message for all
> the details.

I checked the range-diff and reread the patches. This version looks
good to me. Thanks for pointing out the new failures that were
happening in my patches. I think I fixed them in my latest versions
of the sparse-index work, so the latest 'seen' should pass with these
changes to GIT_TEST_SPLIT_INDEX.

Thanks,
-Stolee
