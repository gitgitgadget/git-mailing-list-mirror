Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A40EC433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 19:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF9FF613C7
	for <git@archiver.kernel.org>; Wed,  5 May 2021 19:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhEET1y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 15:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhEET1v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 15:27:51 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7331CC061574
        for <git@vger.kernel.org>; Wed,  5 May 2021 12:26:53 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id c11so4191982lfi.9
        for <git@vger.kernel.org>; Wed, 05 May 2021 12:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=0jroktHbyoPkrevMB+oM8yQ1qCp/xxUK/qc6wy59Q0I=;
        b=n6BxsR8IfswEh5uCbkJnntL0bP2HzC5XzOFnQ1m4YzGYif0YuGMwBCI2JoUCL8Fr8s
         WotxIignVusUW1OXLzGl0ewtE/gLZWxqemuAVNiIZCDfTvRKHmxkjqgpfuFcl1ZMVD8q
         HLCC//Sh9KEiyBd0MLDcVApdjxxWpUeawCX2ga1u4AcOFRG6J18jePe7Y19CT15+nLuJ
         GBew28bqjWziiIqROD8ehpnUJoTgHOd5Zc1/M0EKek8HRekHH8EKN0xZ3eeLRNYTMRpJ
         LdGsW/9TpdHKiQ5P8sU0PKmrs13uxkcAY1TI7MF/4hJeM3lUgP5DVEM6HDGalAvUKYvi
         edrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=0jroktHbyoPkrevMB+oM8yQ1qCp/xxUK/qc6wy59Q0I=;
        b=jEb7D8PI5LfJPBEOxHoSTR9MyGyJPMQzCY5XeLRp2I1SfQUo7540pnnDFBCEaOWfKQ
         HI2dD5mQ5CYe9T/esIHppA5qbc+b68oAmpqpct0bxDCCyWhWPsmlDt/qegvOhAyPF000
         NUj8Lu1LgUrw7eEGvq+TfE8dpNTwf1J8HDQDJARy4Hm6PlvfYT2m/poFVTLw7qDQ37MB
         i/vlOLLZ9e18VTH0BO6HbPgLDB9vwdpt4gWmZhtlg8O//3rhxvMdhPPUrV58KYmSTPZA
         dJUMDjZjQS6AxNzPIdJz+0miX7FZjbitOae1+jvWuxe6EDOXWXGLzN381NMyKgsSF6Ei
         OQdw==
X-Gm-Message-State: AOAM531CAhH+cgUPPoZspTlKfVFN5GNkMtUu2EQNdQYTRveMwkpjgB1Q
        RBvbVK0dtsaLsPPsZH4fjdZSuZDyz1U=
X-Google-Smtp-Source: ABdhPJzrI7Q3Fpf5P8INqoGdB55iqQF3MmS4zJC7kVo/i3b55xzcGv+5Dy6A4N3190aQsZDYO6IVrA==
X-Received: by 2002:ac2:5295:: with SMTP id q21mr273282lfm.108.1620242811721;
        Wed, 05 May 2021 12:26:51 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id a16sm74492lfl.51.2021.05.05.12.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 12:26:51 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?Q?G=C3=A1bor?= Farkas <gabor.farkas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git switch/restore, still experimental?
References: <CAPiPmQnb=XMaF2+YkryEbiX8zA=jwa5y=fbAGk9jpCExpbS4Rw@mail.gmail.com>
        <CABPp-BHBcjSQbkotrzwDtVRSC-qqjEyP4m=biY-0+=Jdg9ETQw@mail.gmail.com>
        <877dkdwgfe.fsf@evledraar.gmail.com>
        <6092da0ccf4e9_1d24520833@natae.notmuch>
Date:   Wed, 05 May 2021 22:26:50 +0300
In-Reply-To: <6092da0ccf4e9_1d24520833@natae.notmuch> (Felipe Contreras's
        message of "Wed, 05 May 2021 12:46:52 -0500")
Message-ID: <87y2ct56dh.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Ævar Arnfjörð Bjarmason wrote:
>> In summary, I think it should be changed to act like this:
>>     
>>     |---------------------------+------------------------+---------------------------|
>>     | What | Now | New |
>>     |---------------------------+------------------------+---------------------------|
>>     | Switch | git switch existing | git switch existing |
>>     | Error | git switch nonexisting | <no change (errors)> |
>>     | Switch with --merge | git switch -m branch | git switch
>>     | --merge branch |
>>     | Create | git switch -c new | git switch -n new |
>>     | Create from existing | N/A | git switch -c new [<old>] |
>>     | Move & switch to existing | N/A | git switch -m new [<old>] |
>>     |---------------------------+------------------------+---------------------------|
>
> I'm in favor of this too.
>
>> In its current state I find "git switch" to be unusable. That sounds
>> like dramatic hyperbole, but I'm serious.
>
> I concur.
>
> I've tried to use it multiple times, and I always come back to using git
> branch / git checkout.

I didn't look at these commands till recently, and what I immediately
noticed is very unclear manual pages. I didn't read entire pages, but
DESCRIPTIONS sections and some options I did check. I think that even if
these commands are to be considered stable by now, the manual pages
themselves need to be heavily revised before removing the EXPERIMENTAL
label.

It'll be worse if unclear manual is just a symptom of unclear design
though.

Thanks,
-- Sergey Organov
