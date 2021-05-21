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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2F6C4707D
	for <git@archiver.kernel.org>; Fri, 21 May 2021 19:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B322613D9
	for <git@archiver.kernel.org>; Fri, 21 May 2021 19:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbhEUTt5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 15:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhEUTtv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 15:49:51 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBD2C0613CE
        for <git@vger.kernel.org>; Fri, 21 May 2021 12:48:26 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id f20-20020a05600c4e94b0290181f6edda88so1109096wmq.2
        for <git@vger.kernel.org>; Fri, 21 May 2021 12:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G1NqpDiS4OC4Bu5dsgES3QC+a3VEbXk2S6iSPkcxhZY=;
        b=flZVMhywDJTtTnqSX0lTyCKtWKxEUYT4Vfzcdn2T249RKwCk7nyHjsa8Wm4TCnxlX+
         25s8qf0vOIHnCBfPpoIcocozQVf/Axt8NyG6GCxUVqYb20mEbHjQnMAxBBbDoL5Kfdw5
         JFGXmcpbC48fRe8f80H//YTv/rkVBgFCm7ntOKoBLo0qfM+UgX4a19XuG96TGaFarioU
         vosvmkr4C02UL4jvNo5dIJRlERCP9rnFI0/4p5pFqCWGN62tcrOpQ0A0rJKD/Ew+XZJC
         uEA8KDtC8ojp+dnO8gnpfr9fzvEqb12U4xJhdKOSKuy8puNhmEuFI54YN8fGMj+hya+w
         g/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G1NqpDiS4OC4Bu5dsgES3QC+a3VEbXk2S6iSPkcxhZY=;
        b=R+/fzrfsIDSHcksrbdTMNKxpUljbPrcSXveRYIYeRZOHOcRGaMmjHWJCEov50iaUzV
         Pk5B1ad4j6A0V2bzltjsNh7y09/IapfTyvMG07lKSYDNDKxmrrrjqKVFTLqv+oeJf5Qg
         FqmZsQQS2va0mZ5j/2NET2UgtXhNf5o6UJov8bLsh8ITOmuv/0oSV6gjS5z5+IFpzmj5
         hxVT+sSQQ9ov5JNAbpblhDk4nR90HHyoY+G9nuJaxcJldj4JPisFYq2qG1vYzrc7Jupk
         mnS6XuvK3sh1OSakQocQCncpG50dHSbqRhym6hipnfc+2nloS2liidp78g1uAjEhxqTU
         vs2w==
X-Gm-Message-State: AOAM533hieS33n1uRluATON0dQl1d1bySzC/nU/RtazKP8ixi+ewmT6r
        3QSnH/V0frQ2faQdwt55hco=
X-Google-Smtp-Source: ABdhPJwCikMlG+k4BkBk+TrbBwT7aA8qujgYvMmefgaTf5pthluUUrcLk+Ez0CzAaFrGJ1fMQNYvGA==
X-Received: by 2002:a1c:a346:: with SMTP id m67mr10470977wme.101.1621626505034;
        Fri, 21 May 2021 12:48:25 -0700 (PDT)
Received: from [192.168.5.102] ([87.116.165.96])
        by smtp.gmail.com with ESMTPSA id v18sm3879284wro.18.2021.05.21.12.48.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 12:48:24 -0700 (PDT)
Subject: Re: [PATCH] help: colorize man pages
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Leah Neukirchen <leah@vuxu.org>
References: <20210518010121.1350327-1-felipe.contreras@gmail.com>
 <YKMWL0iZLVl1KTrB@camp.crustytoothpaste.net>
 <60a332fd22dad_14c8d4208ed@natae.notmuch>
 <YKRSlFcFAcHcR3uY@camp.crustytoothpaste.net> <xmqqfsyj1qe1.fsf@gitster.g>
 <YKRy6oPkgS6FMSZ0@camp.crustytoothpaste.net> <xmqq1ra3z23n.fsf@gitster.g>
 <87lf8bqdv0.fsf@evledraar.gmail.com>
 <YKcFrbuuJrWAxXgm@camp.crustytoothpaste.net>
 <60a7f7427eab6_55039208ba@natae.notmuch>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <8811383b-d5f1-2b06-8ac7-47bbc5fc9d20@gmail.com>
Date:   Fri, 21 May 2021 21:48:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <60a7f7427eab6_55039208ba@natae.notmuch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

If I may, NO_COLOR approach seems to be rather straightforward to me, 
as per description on their homepage[1] - make all software supporting 
it behave as colors are an opt-in feature, thus disabled by default.

And that's all there is to it.

Software which is able to but does not show any colors by default does 
not need to care at all, as colors are an opt-in feature there already, 
so NO_COLOR serves no purpose.

On the other hand, software which does enable (at least some) color 
by default, without user explicitly setting anything but requiring 
opt-out to disable color instead, should treat NO_COLOR precisely as 
that user requested opt-out, with an obvious convenience for the user 
being able to set NO_COLOR globally once and have all the programs 
supporting it recognize it as color opt-out exactly, without a need  
for the user to opt-out in each and every program separately 
(and differently).

So, the whole point is make the default value be "no color" for each 
and every application consistently, where user (and _not_ developer) 
needs to opt-in in order to enable colors (in each and every 
application where colors are in fact still desired).

Regards, Buga
--
[1]: https://no-color.org/
