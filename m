Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA47C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 10:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F20A60F0F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 10:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237451AbhHDKMR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 06:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237516AbhHDKK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 06:10:28 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A06FC06179B
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 03:10:15 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b11so1592199wrx.6
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 03:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DwB8XbxBuCFTq2U2x409pTnirYDHbglAVBc0XHwOKyw=;
        b=f1fMrnFit8gxHJR9Ii+u4NFA2oAfUTfD5saW2c+VXHQLPj2JKIbz5brnrnN7s40Tzb
         PBONJ1NMWaL0p/L5oaSp6aCL//thMFhmiz5eIkQjY0UxsYlQ87jWPVnmUJLYJv5uIdiK
         jKkdb8RxoSfneegJM4YqbEoAzHraFcnhtyWLoYXyGifU36JU0P4EaGFHPwXVo6tSgLfO
         4mNQ5VIcPv2uIvhsxa5GWFWVMOFj9wPIfck0KcQnTZSDRex/kgfabNTY2URoRZ0Tpluc
         hSN3rJi2VgCGVupMAwfrCsAf5HrnO+kfKPPtnFvMp/qdWOWBAEtSxaT87k8Xtfj4izfS
         bArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DwB8XbxBuCFTq2U2x409pTnirYDHbglAVBc0XHwOKyw=;
        b=J05ows4TO0y5cCSSzrTDvn6unIRt1vLszoWx7Z0qyBnatCu8irHFx4CHQMt7AM2XcZ
         Lqk2z2+r2S2oL40kxLvVJmY6HFZ5pBMTwT0bztYOLa66FvEbRmoAJanRKnyRvufc6Zr0
         Q0INhON3TuGmNjXzJ+WSSQJWGQxKchExRW2UzYuJs1rKfaPb2ELFKu2dx/y9HlWQTgSJ
         mUMIdRBSh3XO3WH7hKQBP9H1LN+fBwKzCS/YOy4j4qJitfu3KV28KH1H25FYpLSJEgnl
         J811cKsnIrruc+vyllbdjtBDpiMMzFvw34QTBlou3fMs4ggkHRea3PM6FKcBCDR8sxyZ
         oocQ==
X-Gm-Message-State: AOAM531JOaFOoZxaUj2rzdescnCXj4cVZto0oBK8XE28PjwkwVUEmxbw
        uSzB4R5Wv3CDCZgyTmjiJRI=
X-Google-Smtp-Source: ABdhPJy2EFu6UDgM0ar+w3uPj9f5vmO41SEBtF/pxM7btFSMW2BgFBYP3zExsQlfB5y+83vQxodBlA==
X-Received: by 2002:a05:6000:1201:: with SMTP id e1mr27287223wrx.379.1628071814044;
        Wed, 04 Aug 2021 03:10:14 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.232])
        by smtp.gmail.com with ESMTPSA id b20sm1939883wmj.48.2021.08.04.03.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 03:10:13 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/2] [GSOC] cherry-pick: fix bug when used with
 GIT_CHERRY_PICK_HELP
To:     ZheNing Hu <adlternative@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
References: <pull.1010.git.1627714877.gitgitgadget@gmail.com>
 <pull.1010.v2.git.1627953383.gitgitgadget@gmail.com>
 <5d2fd55c580abc2057f2e6fe9f7d9c94748bf8de.1627953383.git.gitgitgadget@gmail.com>
 <xmqqa6lytat9.fsf@gitster.g>
 <CAOLTT8SkbNMcVocU9Lg3PfqTGHVEX8y27BMcP55HytfWH60w6g@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <2e3e8379-99e3-521b-1666-30fcf0e7909b@gmail.com>
Date:   Wed, 4 Aug 2021 11:10:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAOLTT8SkbNMcVocU9Lg3PfqTGHVEX8y27BMcP55HytfWH60w6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/08/2021 09:35, ZheNing Hu wrote:
> Junio C Hamano <gitster@pobox.com> 于2021年8月4日周三 上午6:36写道：
>> Hmph, this is a bit troubling.  So has this been part of the
>> "published" behaviour since d7e5c0cb (Introduce CHERRY_PICK_HEAD,
>> 2011-02-19) that introduced this test, and there are people who are
>> relying on it?  IOW, should the resolution to the original problem
>> report have been "if it hurts, don't do it" (in other words, "setting
>> GIT_CHERRY_PICK_HELP will remove CHERRY_PICK_HEAD, so if you do not
>> want to get the latter removed, do not set the former")?
>>
> 
> You mean that cherry_pick with GIT_CHERRY_PICK_HELP suppresses
> CHERRY_PICK_HEAD is not even a bug?
> 
> It is reasonable for `git rebase -p` and  `git rebase -m` to delete
> CHERRY_PICK_HEAD when a conflict occurs, but it is not necessarily
> for git cherry-pick to delete it too. IOW, I suspect that instead of
> letting users
> not touch the trap here, it is better to remove the trap completely.

Looking at the history I think it is fair to conclude that 
GIT_CHERRY_PICK_HELP was introduced as a way to help people writing 
scripts built on top of 'git cherry-pick' like 'git rebase' that want to 
have a custom message and do not want to leave CHERRY_PICK_HEAD around 
if there are conflicts. I don't think it was intended as a way for users 
to change the help when cherry-picking and has never been documented as 
such. I think we'd be better to focus on improving the default help that 
cherry-pick prints as the second patch in this series does.

Best Wishes

Phillip

> Thanks.
> --
> ZheNing Hu
> 
