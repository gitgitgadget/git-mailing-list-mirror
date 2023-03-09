Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D5EC61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 23:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjCIXo7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 18:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjCIXo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 18:44:56 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AC8FAD79
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 15:44:54 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id i5so3813501pla.2
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 15:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678405494;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=y5G384vmdpH14m8jgRkPRBmkCZVIescfZ3L7z4lfdhA=;
        b=DbyNC8hR4fV5FS3rr0dgbXHmgLYZEK9mP+Vxs+AerXcoXskvIWhvifS8sHefcqT9zz
         iMM/T1eCg8ApWDREdKG9nAVyJsOqRpYh8rokD4qnGWQkUN9/BJoUKR9wKpcc81syGMB8
         YgJGoEuakfCcZsCcWRH2if0Q6EEE4eFP0wEsS9HRSHp1ofOgVnyPMoq5R1ZzzNTuG4/m
         YAcdjTD76TyhBQTtE2SXrqWYjS1EoHE4VS8infSHm14EOCWwFgwa3RwAVlt9kvdh0ytq
         DbjwjuLoXZWK4LeJSdiznNOw4yN1q9l2qCmCgS/Vou+WnwTJWlnTxeBAwpV40wAqg8fo
         GXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678405494;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y5G384vmdpH14m8jgRkPRBmkCZVIescfZ3L7z4lfdhA=;
        b=K58w8d0vaX5TW//rkzfXpfXnCvc7kLkjKQGXzZno9SuFp8UQ+CIwz+3Mm7dmjgZ72X
         brBOLxqcZ8kxTHeHQsERAXMvIk5rwXsH/z5e6z5qChehTTRVOOKWMMJFDz2RzzyUQ03c
         0YbtCGgcAkFsmSg/DG5+AoVL6yTkCvxj3IQ4/22Gv3EwrC2ZdseONLk7G1ilghR1l4wJ
         FtwgyXgGHnWoxbDaivGz6BWaXHQYl9aDWSgDOHeWuZxdpFc24h0Mt94l6wsTjw+/rrXA
         FmeClu4Wn4aPnErfEUZLAT8EsHFZhOXLl8Nv1rwHo0OUGy8F7r99iMk7Q2vmkyWBi6Of
         I+Cg==
X-Gm-Message-State: AO0yUKW2+o5Ll14QUtpG+OUPeKrr8YyVBcki1CX4PuqiiU/A92v+q67f
        0rgGrv7UCh78X7f5FwjlVOo=
X-Google-Smtp-Source: AK7set8oBrxrEgfMeHpLmMQ9qlIgRN2YRgRd6qL4Q+CAq31UOXA87wDNIzzdUN2KtE64LRIT1xX0/A==
X-Received: by 2002:a17:90b:3e8b:b0:234:e8e:a91d with SMTP id rj11-20020a17090b3e8b00b002340e8ea91dmr24075924pjb.7.1678405494264;
        Thu, 09 Mar 2023 15:44:54 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id n10-20020a635c4a000000b00502ea3898a7sm145147pgm.31.2023.03.09.15.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 15:44:53 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Alex Henrie <alexhenrie24@gmail.com>,
        Heba Waly <heba.waly@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Matheus Tavares <matheus.tavb@gmail.com>
Subject: Re: [PATCH 0/2] advice: add diverging advice
References: <20230308024834.1562386-1-felipe.contreras@gmail.com>
        <ZAix68A9e6RHz69y@nand.local>
Date:   Thu, 09 Mar 2023 15:44:53 -0800
Message-ID: <xmqqv8j97ami.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Mar 07, 2023 at 08:48:32PM -0600, Felipe Contreras wrote:
>> Not all our users are experts in git who understand their configurations
>> perfectly, some might be stuck in a simple error:
>>
>>   Not possible to fast-forward, aborting.
>>
>> That's not very friendly.
>>
>> Let's add a bit more advice in case the user doesn't know what's going
>> on.
>
> Thanks for improving this case. I think the new advice() is reasonable
> and will be helpful for users who might otherwise get stuck here.

We may want to further tweak the advise() message depending on the
caller [*], but that can come on top after these two patches settle.

[Footnote]

* When a failed "git pull" gave the new advise() message, the user
  may not be advanced enough to adjust the advice to run "git merge
  --no-ff" to the given situation, for example.


