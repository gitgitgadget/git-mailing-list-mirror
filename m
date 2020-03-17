Return-Path: <SRS0=62NG=5C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEE4C10F29
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 14:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B257B20663
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 14:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xr1AmkRs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgCQOWo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:22:44 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33888 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgCQOWo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Mar 2020 10:22:44 -0400
Received: by mail-lf1-f65.google.com with SMTP id f3so7094978lfc.1
        for <git@vger.kernel.org>; Tue, 17 Mar 2020 07:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=jhz6yhZx1qo42e2neWM85X9tAaj2vhEeh0vEBcaQzeE=;
        b=Xr1AmkRsbk29ffraE1+Ou4V/WYN/rkWGAHVoiGTvssSkFDQcRoFeXkjnaCK9CQbVEB
         qDCrq0GBV/zfCRiv6qjOcbKOsnl5kmDH1RSPyS+hjGQwJCqY7VD3W82CevaMvJJ7VyLL
         QXBtiqaKxaxtmCwK83Ojj1Iz6Cdo8sVT5Jk+w/YhxEtHcYqTCLxnQdIJyLWiRx6VKYX/
         wkuvcvEyYLNNSu5iTdb44x0Dc7SOUtQa8L0o9WgnNh3GqX09fygEL38EO02B7IQXJ/QG
         bKV7QaZDBfKiswF4snHVodUoN5zPiMQii5U9/FvHfiLtDts0i53rqImzqoseQOXeWgcl
         iqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=jhz6yhZx1qo42e2neWM85X9tAaj2vhEeh0vEBcaQzeE=;
        b=XbXZ/fQKg0nKgEtYzl+vjmyU50pwIRRf8vUVqjRgQNkvGpBVdAiD0TGlYe+pBGawcO
         owZMsttld6nY1S4O8Ww9GJM5d2CYJRQeqO8FBd3LDB61TFwwePj4pqS7cxLke95X+4ac
         TsAd+1sviw4vlx64iDQrX9YSgQfh9nuFZlzIk+/xn035QgpvBV3iFdACOatt1quDsgTb
         yZL/MxVOczOWJj8D3F/iaFcaDFiMV+BKK4jJDFFl6SFTg8EoPATUCAqCXc6I2Z/NgqQZ
         dIY3oQivGIhoUcY7BXYSlQq6NanHVdjyQ1Hk6kHQtrLiKPho0ibEKSBx4M6WGSBuC3k9
         HOGA==
X-Gm-Message-State: ANhLgQ2Z/l5F6Dlps1XhJIZM4O+jvwuIyO/duj+kUaeLfL/S09A8tzqk
        qFY5ffT3o7AfH5slMLSx7K8=
X-Google-Smtp-Source: ADFU+vtWEaqaV1p2mYF7kIPUduzTCRHJIFZK/61L4pUmT2Hjd6VCAwfn7ZrGF8pphzJmRU35eTI+Pw==
X-Received: by 2002:a19:88d5:: with SMTP id k204mr2975506lfd.120.1584454961976;
        Tue, 17 Mar 2020 07:22:41 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id c7sm2085341lfg.66.2020.03.17.07.22.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Mar 2020 07:22:41 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Heba Waly <heba.waly@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Subject: Re: [RFC] Possible idea for GSoC 2020
References: <86mu8o8dsf.fsf@gmail.com>
        <xmqqo8t2hfxj.fsf@gitster.c.googlers.com> <86tv2s34lo.fsf@gmail.com>
        <86zhch7kyz.fsf@gmail.com>
        <d1a4998d-039f-65da-f18b-12ec714ec532@gmail.com>
Date:   Tue, 17 Mar 2020 15:22:39 +0100
In-Reply-To: <d1a4998d-039f-65da-f18b-12ec714ec532@gmail.com> (Kaartic
        Sivaraam's message of "Tue, 17 Mar 2020 17:54:27 +0530")
Message-ID: <861rpr6oy8.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
> On 15-03-2020 19:56, Jakub Narebski wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>>>
>>> I have prepared slides for "Graph operations in Git version control
>>> system" (PDF), mainly describing what was already done to improve their
>>> performance, but they also include a few thoughts about the future (like
>>> additional graph reachability labelings)... unfortunately the slides are
>>> in Polish, not in English.
>>>
>>> If there is interest, I could translate them, and put the result
>>> somewhere accessible.
>>
>> Here it is, traanslated into English, but otherwise almost exactly as I
>> have presented it on December 2019.  Those slides includes much of
>> introductory information, so one would be interested probably in few
>> last slides (the "Future work" section).
>>
>>    https://drive.google.com/file/d/1psMBVfcRHcZeJ7AewGpdoymrEfFVdXoK/vie=
w?usp=3Dsharing
>>
>> I will be extending those slides with more information about interval
>> labeling, and then I will update the file, and I can post it also on
>> SlideShare (or other site, if one can recommend it).
>>
>
> Just wanted to note that Speaker deck[1] is a nice alternative to
> SlideShare. I've not uploaded slides to it but have seen people
> sharing slides using Speaker deck. I find the user interface to be
> more neat and minimalistic than SlideShare. FWIW, their mobile
> interface a lot better than the SlideShare's interface.
>
> [1]: https://speakerdeck.com/

Thanks for the suggestion.  The slides (which are at version 1.2) are
now also available on SlideShare[2] and on SpeakerDeck[3], in addition
to being on Google Drive:

[2]: https://www.slideshare.net/JakubNarbski/graph-operations-in-git-versio=
n-control-system-how-the-performance-was-improved-for-large-repositories-ho=
w-can-it-be-further-improved
[3]: https://speakerdeck.com/jnareb/graph-operations-in-git-slides-2019

The only disadvantage with SpeakerDeck is that bitmap images (PNG, JPEG)
are a bit blocky/pixelated in HTML-ized version of slides.

P.S. I am not sure if I put my slids in correct category...
--=20
Jakub Nar=C4=99bski
