Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A815C4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 15:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 755B260F38
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 15:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243012AbhHJPYi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 11:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243001AbhHJPYh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 11:24:37 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3611C0613C1
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 08:24:14 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l18so26844281wrv.5
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 08:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hDIx5C/fv5u0j/qpGJqqwgEQbzY/Caoe3Y85rMfjFhM=;
        b=FrfoDN4EPiss22d3xxiUlFDewfyp53mAUgKImRMZUZwKXS4HZf8rFCYZ49s9w19jrY
         3Zy1SRXaVRqrfm3Y2NhiwJlSAKQugr7Ux/nOqJ2Rr6mk2Q5CgICeXUYgWQwL5DyvLT0e
         u61ZVKLRoXzu7o2xlax72RCyz3DjyBLyUobI8aP/k9LrtEb0x9TlFxskVrEvQKeWuR4D
         79GxCMN79Ed987HkHNYlQZEw5TnAzU2M8nJp2BdDm+HwVIUlQFDwmbKo3sk02wOMW+33
         N2q0f9RZPMFqTWkUq9V7RxBahyY2jp7+RYCoKiybmlqbh4Eh8QiJfwlab3bDSnKs+68d
         CT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hDIx5C/fv5u0j/qpGJqqwgEQbzY/Caoe3Y85rMfjFhM=;
        b=dhRd6LKhgC6kAN21eYoJCHjMiWziDCCCCnUBF+pkKeSIRlsUoW2mDgX3L6WNqNIQNn
         K6AJMEN2CX1Z6XVisVyIB4AKumOQcQvJmK+Nx9VE5gRNb1+zQIVuvpvnSHRw70jFhc14
         D36BK9lik7arhkhm5ZlaDIq3TzvKS+1eKlv4WGF1fvvBdgmVZi7R4H5uCIU2WcmxXpLw
         a62D5rSsItlPjZUxsRsQQ4KaxxO5N704r/ICLlqsyA1dckSnifiks/++4YZcOLPH006N
         pAcqb+uVOp+oAM4NA5jCyOjYlmELqFTFrkE7sv6VsZrtXdoBfsO1q5zyjy3mD/XrVUPo
         cR8w==
X-Gm-Message-State: AOAM532tN4hkuL/rUGu81uY1P+a40pgnzf33PD15fzrZTctDffKB6vVU
        v6CrK6D2x/AVGaYA6A57znA=
X-Google-Smtp-Source: ABdhPJyuM02KTIjMinvs6spGbghZHG/iP+JSyZ6Z3nrd7bLUXqbVPVu6ldIzrG2TA9stxn3NkbJQWw==
X-Received: by 2002:adf:f149:: with SMTP id y9mr32852122wro.413.1628609053507;
        Tue, 10 Aug 2021 08:24:13 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.232])
        by smtp.gmail.com with ESMTPSA id o17sm23294165wrw.17.2021.08.10.08.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 08:24:13 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH/RFC 3/3] ci: run a pedantic build as part of the GitHub
 workflow
To:     Carlo Arenas <carenas@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, e@80x24.org
References: <CAPUEsphf9F1+=zOMKx3j=jH8xqDwQX99+9uHiYUpXhFE1nervg@mail.gmail.com>
 <20210809013833.58110-1-carenas@gmail.com>
 <20210809013833.58110-4-carenas@gmail.com>
 <1b096830-3e01-efbe-25dc-c0505c8bac7b@gmail.com>
 <CAPUEspgh54AywgqMuOXJf5uPZdR2AN9JLrzJwcOtoec7sRnN7w@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <6fac977d-80c5-d123-d232-2df5e5966c04@gmail.com>
Date:   Tue, 10 Aug 2021 16:24:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAPUEspgh54AywgqMuOXJf5uPZdR2AN9JLrzJwcOtoec7sRnN7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/08/2021 23:48, Carlo Arenas wrote:
> On Mon, Aug 9, 2021 at 7:56 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Totally unrelated to this patch but while looking at the ci scripts I
>> noticed that we only run the linux-gcc-4.8 job on travis, not on github.
> 
> it is actually related and part of the reason why I sent this as an RFC.
> travis[1] itself is not running, probably because it broke when
> travis-ci.org was
> shutdown some time ago.
> 
> maybe wasn't as useful as a CI job using valuable CPU minutes when it could
> run in the development environment before the code was submitted? the same
> could apply to this request if you consider that unlike the other
> similar jobs (ex: sparse or "Static Analysis")
> there is no need to install an additional (probably tricky to get tool)

I think there is value in running the CI jobs with -Wpedantic otherwise 
we'll continually fixing patches up after they've been merged, I just 
wonder if we need a separate job to do it. We could export 
DEVOPTS=pedantic in ci/build-and-run-tests.sh or change config.mak.dev 
to turn on -Wpedantic with DEVELOPER=1. Having said all that your commit 
message also mentioned using a recent compiler to pick up any problem 
early, I'm not sure how common that is but perhaps that makes a new job 
worth it. If so there is a gcc docker image[1] which always has the 
latest compiler.

Best Wishes

Phillip

[1] https://hub.docker.com/_/gcc

> Carlo
> 
> [1] https://travis-ci.com/github/git
> 
