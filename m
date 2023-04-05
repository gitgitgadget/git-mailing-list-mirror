Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC2BC77B6C
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 21:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjDEVtr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 17:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDEVtq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 17:49:46 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD0B44B6
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 14:49:45 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so40903194pjb.4
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 14:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680731385;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUpQ7m9qvQzQ6/ymR/MITJ6uVS6GGk8cdVCXnYtL5e4=;
        b=BstWjwMRoVEHJZhtdhxCI9N2OnHMsmZQoZgFeocBB1fvuHuF/rU7Fh251AusDLO3tu
         biyRwX/CxdjZVB5kClHJih1jG4qA6YY7zP+uq74BnFBYDYJ8NKt9Eyja38dPDXMwyt76
         ImpRgLBtFla9suc4yllccXwIXEXpVTud43VBGR10MsOdQZImtkos8737rZN17MEHUtal
         S1+JZ/a7FvibTQ9aG3Q+xewgVDzooyABL/KE0F0e8Tzh045jC2dhwlOEcVpmb8vru56y
         kqPOgAjtTBnuzK0VF5kKTCCh9Zms1pom+O9WuCr7FeJZvHOTsrB3yBROi0hi5hFde6vK
         4Adg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680731385;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LUpQ7m9qvQzQ6/ymR/MITJ6uVS6GGk8cdVCXnYtL5e4=;
        b=KEElMUhImJ13bdpaoylJsJ+GRVEGon/0kaKiYyP75+iUIWxxzciCkfglHA+GgR8oxf
         5kB8PifXztxwtTxyOLzv4m2Q5iE4syVZ9NrYKVZs+hKdrq6Er1sxvyIhIJfsX86cKMIn
         ydxdcYYARarI1F9Wt+8ysdgJUBg39jAKvmGMalJuByYhUtvcuAETpMIRy4EPLpc0H0bt
         ChxGPpEFdtj8n5DkHB9qKXgkvkop2XWApasLl/n2SIff01WtCAPDqKtAUGgjMCEjyfxq
         jCrlACXr6XTESTtv8hgrxYqUuAOOP4+m5o7xoGy7CZ96UY5NO35HXWJ6LNbxTcyqUZve
         7URA==
X-Gm-Message-State: AAQBX9foooDCxl3nkznJtFr7sjf1hQwKtfiatNhMD2b1nUPNk5Rso7in
        65wj7kopSvR3IFqQnQruXB8=
X-Google-Smtp-Source: AKy350YOJVMc1g8WyxvMVtLfEUoDN8ThaKnFt9eKkoBPKEOH/lIokDUe/ihUAiQClVTvk1esgxfxLA==
X-Received: by 2002:a17:90b:1b0b:b0:235:9d0c:6e3f with SMTP id nu11-20020a17090b1b0b00b002359d0c6e3fmr8669267pjb.31.1680731384828;
        Wed, 05 Apr 2023 14:49:44 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id mn5-20020a17090b188500b0023f3fc5d162sm1853817pjb.25.2023.04.05.14.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 14:49:44 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robin Jarry" <robin@jarry.cc>
Cc:     <phillip.wood@dunelm.org.uk>, <git@vger.kernel.org>,
        "Tim Culverhouse" <tim@timculverhouse.com>,
        "Nicolas Dichtel" <nicolas.dichtel@6wind.com>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>
Subject: Re: [PATCH RESEND] hooks: add sendemail-validate-series
References: <20230402185635.302653-1-robin@jarry.cc>
        <66099367-4ea0-7d2a-a089-7a88e27f695e@dunelm.org.uk>
        <CRNH5FOB91JE.14CZEA494X002@ringo> <xmqq7cus4m0b.fsf@gitster.g>
        <CRNHSC3H2B6C.UCSDE4Y6ET4A@ringo> <xmqqbkk3z9p9.fsf@gitster.g>
        <CROOKNR29PDV.1WIGA6219L1C6@ringo>
Date:   Wed, 05 Apr 2023 14:49:44 -0700
In-Reply-To: <CROOKNR29PDV.1WIGA6219L1C6@ringo> (Robin Jarry's message of
        "Wed, 05 Apr 2023 10:31:28 +0200")
Message-ID: <xmqqwn2qt2x3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robin Jarry" <robin@jarry.cc> writes:

> Just a thought. Instead of adding another hook, wouldn't it be better to
> add an option --validate-series (git config sendemail.validateSeries)
> that would change the behaviour of the sendemail-validate hook? Calling
> it with all patch files as command line arguments only once instead of
> once per file.

I do not see much upside in doing so.  Instead of having to write a
new validate-series hook script to store it under a new name, users
can update an existing validate-patch hook script to take a batch of
patches in one go.  Then the user now has to set a new configuration
variable.  Because the expected way to feed the hook script is *not*
per invocation but depends solely on how the script is written, a
command line option would not make much sense.  Not having to rename
the updated validate-patch script to validate-series might be a
small win, but I do not think it is a compelling reason to take that
approach.

> I know I was concerned with the max size of the command line args but is
> there really a chance that we hit that maximum? On my system, it is
> 2097152 bytes. Even with a 1000 patches series with 1000 bytes
> filenames, we wouldn't hit the limit.
>
> This way, we support any crap filename that the user may send and we
> don't add a new hook which basically does the same thing than the
> existing one.

Between "we may exceed command line argument limit" (which by the
way is way lower on certain systems than what you expect, IIRC) and
"the user may throw us a file with LF in its name", I'd find it
simpler to punt on the latter and tell them "if it hurts, don't do
it".  As long as the limitation is clearly documented, I'd say it is
OK.

Thanks.
