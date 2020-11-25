Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688B6C56201
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 18:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F2F720656
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 18:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/0hv7v1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbgKYSdF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 13:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgKYSdE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 13:33:04 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D3FC0613D4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 10:33:04 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id k4so3624346edl.0
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 10:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5ES5XUk6gLgumDQgszBeTYNgW//GKI/T9bAHYc8wGNc=;
        b=p/0hv7v1T0fTHMO2roN0yLN9YSEjpLd+LOuIfyzOuulyJkL1xsE9Ek+Kd3Rb54xec0
         k175UhvrIlh9VHnzrRtBT/HW6WJjxBAdRkJZgw/oj1DUubT/HPq0SGj2MAQSFz1aHevo
         WhAe8UUNk5+Ek4JE2HQ5T6mSA2tCP2quJ5jalCC3noO+UsYcbnqUIz3KuleoWa1sBSdX
         z0T1qHCsNz64kDlFN0lubFcasCOIdvJyTvFukm2RPRvon349mi2+Ai6ImqjqtjDIpRHy
         OLMAIlUR6pL1DpLbjR79bdPv+c3xONcqYm4tybIF2J231CqMsNCrrSbKCURskx0cbesG
         /Vow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5ES5XUk6gLgumDQgszBeTYNgW//GKI/T9bAHYc8wGNc=;
        b=KN/YV7tyqBbagF3TAmtWbb6I0AahbBZt4kiary8d59nwcn9Y6NdGEzYiQ2NyAog29c
         tSDkd3n6f16gmyWwIbG7r1TPPbE0D3PuQkb9HkdUjHn+Mv17J8JYf4nvG16Or86ih70X
         sqFhe/KHhiTeCS8GupcdJS4V3lNAYIkuSgrg9DOTZKMsLojXCN+3C3lKWV85UyyWrolJ
         WluS9OKm4qepgHLbcGFfy8F8Hc4oXL40VhkEkaDe5EPBlKI6RTut2ZWxBq45Im/uXs4Q
         Xtra3ZNOG/uabLESj7jJcijjp1COgGNhPfc9NX44tC7fEtx3tdsPyyT9X7RpimtDCbD1
         CkWg==
X-Gm-Message-State: AOAM530WiC3aTJFBbwUOHoIqH8ErXqM5ifc7D//XBpczrfkq4G2f+FUn
        GTijn1JBgTF66owgE/P90wU=
X-Google-Smtp-Source: ABdhPJweje5ZjV0ZzWDMqImJmiy3xaMQl21iWSnvNfc05Bv9AxTvd2pnmaGeDqH9/sroKy+dGH4+Pw==
X-Received: by 2002:aa7:dc05:: with SMTP id b5mr4804530edu.47.1606329183211;
        Wed, 25 Nov 2020 10:33:03 -0800 (PST)
Received: from szeder.dev (62-165-236-118.pool.digikabel.hu. [62.165.236.118])
        by smtp.gmail.com with ESMTPSA id h9sm1697743ejk.118.2020.11.25.10.33.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Nov 2020 10:33:02 -0800 (PST)
Date:   Wed, 25 Nov 2020 19:33:09 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Drew DeVault <sir@cmpwn.com>, git@vger.kernel.org,
        lanodan <contact+git@hacktivis.me>
Subject: Re: [PATCH v4] help.c: expand options for help.autocorrect
Message-ID: <20201125183309.GF8396@szeder.dev>
References: <20201118172849.24715-1-sir@cmpwn.com>
 <xmqq1rgq35my.fsf@gitster.c.googlers.com>
 <xmqqwnyi1qgs.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwnyi1qgs.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 18, 2020 at 10:15:31AM -0800, Junio C Hamano wrote:
> Also, I think we would want _some_ test, as the base form of
> help.autocorrect is already tested.  Perhaps something like this.
> 
>  t/t9003-help-autocorrect.sh | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git c/t/t9003-help-autocorrect.sh w/t/t9003-help-autocorrect.sh
> index b1c7919c4a..8f1035c3c2 100755
> --- c/t/t9003-help-autocorrect.sh
> +++ w/t/t9003-help-autocorrect.sh
> @@ -49,4 +49,17 @@ test_expect_success 'autocorrect running commands' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'autocorrect can be declined altogether' '
> +	git config help.autocorrect never &&
> +
> +	test_must_fail git lfg 2>actual &&
> +	if test_have_prereq C_LOCALE_OUTPUT
> +	then
> +		: cannot test with poisoned i18n
> +	else
> +		grep "is not a git command" actual &&
> +		test_line_count = 1 actual

The two branches of this condition are in the wrong order, as it
doesn't check the expected error message in normal mode, but it does
grep for the specific translated error message when run with
GIT_TEST_GETTEXT_POISON=1 which then fails the test.

I think we should simply use 'test_i18ngrep' instead of that whole
if-else block.  

I wonder what that 'test_line_count = 1' is supposed to check, and am
not sure that it's really necessary.  Anyway, the gettext poisoned
output should be a single line as well, so we can use that same check
both with and without C_LOCALE_OUTPUT.

> +	fi
> +'
> +
>  test_done
