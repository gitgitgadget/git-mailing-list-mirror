Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B303CC433EF
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 11:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AD1360EBA
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 11:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236260AbhIFLGk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 07:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbhIFLGf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 07:06:35 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCB7C061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 04:05:30 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id i24so5357484pfo.12
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 04:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sLrowN0GVerrBdr3r7Y792JhnN6wHpzfK2MMC4aHNe0=;
        b=FuNptgIWX7n/3ch/xApe2dG9tfuL5U+9+6Dz36kOL6CARo42ce1862tL7D+8cgD8BQ
         uNFJ3cg8P0ZAXJex2ZIwT53nxP7c6O8MPRTCuad1lgy0y4W+COd3CUK8+7/3cGwJeaf4
         uNxbOnOO4zuEfl+cqmafjKS/h7OKFdhMId7s40M52JMoCqzMY1PU6YixQdgPqosOxKgm
         0k/tpNMOvaMnFGNi3w3ocHN26S9ZqVJ7rwMbpwRFnAmx7x+vmSo/P2hprTvhRkFQ5bdl
         t7s4G1qV1QpidLmRBJw9h2qNuyvnd6yVIo598fPKCjtM2lu7I9RfhvmdWw5TJCKgruS6
         ojWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sLrowN0GVerrBdr3r7Y792JhnN6wHpzfK2MMC4aHNe0=;
        b=YqG5QfZDH/faU0e4392yjfx7TyhipBJ22z4n3BAhH8fziberT+FXTrMQhwffsrk9PV
         L9/kditTbtQcKru4yduFEDNO4HirbGtFUydBu3zUygD2MBce0t9lco+JUtTbxzPNWHv1
         A6TcvxJYskJw76kqg6ybcxYzYZqHf9Z46pbbDb+9/D5to75Qr9wIjPu3pLUOyyMsoVVt
         XJIc8n5vaA+8dM7ahwlQq6ROMczTVovwWmZ5MCeFA2pB3Rg1xaM+f0xVAzrmRwEMagha
         Xt7N2qewQcEBAe0S1voW8s81aqdVVZjFzPDA4jVtVsfiQoYitgm55Qoy4B3cli7YZgoB
         clbg==
X-Gm-Message-State: AOAM531daipFZI2MYw5Nuz4HG/r6y5RPXFpCXNwlBmb7uMt6RuBlVb0G
        Go6GsXT4cUTD9jMABlu93l2RpU3sL1UgdA==
X-Google-Smtp-Source: ABdhPJwCNQfBnT2meHc++gGuMbF7meA+NsR4CVLu4AeHM7eU1jVqaUPl0j4iq6jl/gaKM+Ql6v5KkA==
X-Received: by 2002:a63:6d89:: with SMTP id i131mr11760077pgc.235.1630926330053;
        Mon, 06 Sep 2021 04:05:30 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-39.three.co.id. [116.206.28.39])
        by smtp.gmail.com with ESMTPSA id r4sm1819119pjm.50.2021.09.06.04.05.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 04:05:29 -0700 (PDT)
Subject: Re: [PATCH] send-email: fix a "first config key wins" regression in
 v2.33.0
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eli Schwartz <eschwartz@archlinux.org>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
References: <96814e5e-54be-1eca-0d75-68be53b1be3d@archlinux.org>
 <patch-1.1-ae6ff9f77f1-20210906T073306Z-avarab@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <ce194f13-2b1f-fb21-e224-80190f3b2fd6@gmail.com>
Date:   Mon, 6 Sep 2021 18:05:25 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <patch-1.1-ae6ff9f77f1-20210906T073306Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/09/21 14.33, Ævar Arnfjörð Bjarmason wrote:
> +test_expect_success $PREREQ 'sendemail.8bitEncoding in .git/config overrides --global .gitconfig' '
> +	clean_fake_sendmail &&
> +	git config sendemail.assume8bitEncoding UTF-8 &&
> +	test_when_finished "rm -rf home" &&
> +	mkdir home &&
> +	git config -f home/.gitconfig sendemail.assume8bitEncoding "bogus too" &&
> +	echo bogus |
> +	env HOME="$(pwd)/home" DEBUG=1 \
> +	git send-email --from=author@example.com --to=nobody@example.com \
> +			--smtp-server="$(pwd)/fake.sendmail" \
> +			email-using-8bit >stdout &&
> +	egrep "Content|MIME" msgtxt1 >actual &&
> +	test_cmp content-type-decl actual
> +'
> +

Did you mean overrides global .gitconfig (s/--global/global/)?

Anyway, compiled and tested successfully (test suite passed).

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
