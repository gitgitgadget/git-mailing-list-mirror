Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28563C6FD1F
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 16:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjCPQup (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Mar 2023 12:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjCPQun (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2023 12:50:43 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1B8BE5C0
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 09:50:40 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id h8so2390063plf.10
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 09:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678985439;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9KjptdF+6ex6St18feRfWREZH9VSj9aL5kllMeaKODI=;
        b=PUgczCc+uzVnvJ/et8Mno+w/yBobFPrzBQVxrmhIeI1mHogJK5AGBNf5r3iEmJi+XX
         en0u2x6NV/JfUD/iEU1T30TtOIOBXm7QQVfdwPs48XCHN51I+h4E2qTkvUHQNZMu8x0j
         MUvwkWbfQctItjF5L4wjpuc5acvsoih/YUzAHsaIq06Q5fR/impJNgum7bTnqyL/vBhG
         pu3ipsXwmUD9tmkRw0CWUZkngWBg3nOsYaEDP0QDwGWQD/4EYuFQse1xaVzm96dU2DcM
         UhP2IQEyPTGdtdvV6T7esGJTb0FRY62nEBSh7mTeRs4UzH6InVcnAzomrRQta3okdngK
         n/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678985439;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9KjptdF+6ex6St18feRfWREZH9VSj9aL5kllMeaKODI=;
        b=NdySfV8Ct7maGbV/HMEg58u/j69/VXP1noFKPflgXjdDjLwAGHbYTvvdVS86jnweBi
         I+1d8+1/DvDoAH/7g/x8m0LXxY1ozYRl9YfLXA67VzxSiIeIgNxLFuAU1VU4J16BowjZ
         HXqEoBi3wuUq9qmcSlcjmlocksjV9GkNNN18hGu5mGcduZCTQ37GIKBlQIAYn9u7+3cg
         dHSuxxSUDShXc1x+RpDXNEqeTxjHOQbtMfAnA03xiw4M/kAiy0oUG+0IOqEapLBLYERt
         Cf08Gp8AYfNYwnt1l6gdfNoIX8k85CJxiymutQjRWJQSdmpcZzbzTFGxbu49z9K3O+hx
         /dUw==
X-Gm-Message-State: AO0yUKVGasH3FoBtMnN4LG3FYh0dinjpfj3eNob5YJ7wFgm6g4K7W+ve
        goJczuIq2q8KVzPWfMFkGKjY/2uQU7Q=
X-Google-Smtp-Source: AK7set8tOTDcd2f7uangUHHWx9Zab5Gg6zKbDmExRZ275DmZcK+Y2MKVRaa+vyPv3+w36dOeV4p9KA==
X-Received: by 2002:a17:902:ce85:b0:19e:dc0e:1269 with SMTP id f5-20020a170902ce8500b0019edc0e1269mr5025527plg.7.1678985439626;
        Thu, 16 Mar 2023 09:50:39 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id kn3-20020a170903078300b0019f114570b0sm5875930plb.152.2023.03.16.09.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 09:50:39 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/8] fetch: deduplicate handling of per-reference format
References: <cover.1678878623.git.ps@pks.im>
        <d45ec31eeaf42ee042bad04efd69668144df3138.1678878623.git.ps@pks.im>
        <xmqq4jqlocqf.fsf@gitster.g> <ZBMwXAnEnD5QjsFE@ncase>
Date:   Thu, 16 Mar 2023 09:50:38 -0700
In-Reply-To: <ZBMwXAnEnD5QjsFE@ncase> (Patrick Steinhardt's message of "Thu,
        16 Mar 2023 16:06:04 +0100")
Message-ID: <xmqqv8j0ljxd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

>> So, I dunno.  The result of applying this patch leaves it in an
>> in-between state, where the division of labor between the caller and
>> the callee smells somewhat iffy.
>> 
>> Thanks.
>
> I totally agree with you here. From my point of view this "division of
> labor" is getting fixed in the final patch that then also moves the
> printing logic into `format_display()`.

Yes, again I smell the same "isn't this series going a bit too
roundabout route to its goal?" which I expressed in my response to
an earlier step.  The endgame of the series, even though I may not
agree with it 100%, is self consistent and does not leave the "this
ends at an in-between state" aftertaste in my mouth.

Thanks.

