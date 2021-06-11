Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5CDC48BE0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 14:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70B78613C8
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 14:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhFKOL3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 10:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhFKOL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 10:11:29 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695B8C061574
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 07:09:17 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id t140so5973725oih.0
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 07:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=TJjqYTNDXffjI0nO4UXvMpNpc4uNSayZakoC52hrkbY=;
        b=VJ3DJ/wYQ3ejk8Ns9yK+up1Ojiau1Yb48MCp2sKLIPQjJe5RuLRrOY4wG9dLirp1qU
         KSRv/FBJrxa/cfQ0gpQaSJvgkMw+R6c5JY4pyEESG2X2b0Zehq1RMhbIoioiwgmlSbdU
         2qnMqfKqeskRuycQXF1qKo3HRkG4aAMnpCN6VF5BgsxeOWW8oIMoTPlKkCL3i4ijErgt
         NtoYf1NyOh/D67Ca87dpSJUnGJ+Gv8wuYbo41z4myLFBDIfcZ22EY7Ua95SPyN5ohUBF
         IdQ7fwYPJFb1bQ9ZUd96gzp6EKQzdYXu4IBuuLGS/pb4z4LJQAriiknwLw1Puy3b1qVP
         VsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=TJjqYTNDXffjI0nO4UXvMpNpc4uNSayZakoC52hrkbY=;
        b=p9acXahM+nMHohOJfBfcEIAorPKnaWTVdVBTk0O6jB0Kwxpd+AqvCKnGSFpsX9DlbY
         Kz6friyAsH3/ilBn3dBcFmwckfFvBmr6Z+zcXQZVA6qce9w5h00ksyRgT9d+TbNyePx5
         SeaEiv+g0nFc8noPL20pHEEZEOzn3VC+lfRNfrr7lSbFRe19g+2zFzoOzl8GtnB1ydw9
         BfuokED5FVaEp8B8WjDo4tJOPCZh9R+pJ5m7BHwSy3ECjTu0hLNDGE0DrXYKCbvdI5yA
         225xx624fgQrGqv16I6yQWxeNoQgh5+47DQOePY48xoGq8A7pFO/9BWpyCFPj7iZB0Lq
         MTuw==
X-Gm-Message-State: AOAM530BA7KHIAevw/scUSijvtk6BLwm7e/DmNMjQDO9OVSV9weSau+y
        d+pyudsYMMgb4PID4GaYou4=
X-Google-Smtp-Source: ABdhPJxUz/lEjATlEdKZQn/mhS+V94VFrxwdBueOVWB3NjUgsu37Mkcv4+In7O0QhTbCcndpNt4m0g==
X-Received: by 2002:aca:38c5:: with SMTP id f188mr2617923oia.36.1623420556752;
        Fri, 11 Jun 2021 07:09:16 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id 90sm827681otq.20.2021.06.11.07.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 07:09:16 -0700 (PDT)
Date:   Fri, 11 Jun 2021 09:09:05 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
Message-ID: <60c36e8112417_3ad9208d8@natae.notmuch>
In-Reply-To: <xmqqh7i5ci3t.fsf@gitster.g>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-8-felipe.contreras@gmail.com>
 <60883e1b-787f-5ec2-a9af-f2f6757d3c43@kdbg.org>
 <YMIYUgo71aKJ1Nnx@coredump.intra.peff.net>
 <xmqqh7i5ci3t.fsf@gitster.g>
Subject: Re: [PATCH 7/7] xdiff: make diff3 the default conflictStyle
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> A different way to say it is that until we improve the way the
> conflicted inner merge is shown, diff3 style is not something we can
> recommend to new users as a default, I would think.

I am not sure about that. Does anybody know any newcommer that you would
recommend diff2 (aka. merge) style to?

I wouldn't.

Put yourself in front of a class teaching how to resolve conflicts, I
wouldn't dream of explaning the particulars of conflict markers, I would
just fire up Meld, and show them visually.

Conflict markers are not for newcomers anyway, so that is a moot point.

Moreover, it is really hard for an expert to put himself in the shoes of
a newcomer... We forget how hard it was at the beginning.

At least me personally, I remember that long time ago when resolving
conflicts I constantly had to find the change from the base to the
remote side in order to see what changes I'm trying to merge, and then
from the base to the local side to see why they were conflicting.

I don't use diff3 because I want to be fancy, I use it because from
experience I *need* to see the base more often than not.

Plus, I try to follow the principile of eating your own dogfood [1]. If
using diff2 is so awful that basically no git experts use it, why are we
recommending it?

If the purpose of conflict markers is to resolve conflicts **correctly**
and preferably in an efficient way, then diff3 is just better.

Cheers.

[1] https://en.wikipedia.org/wiki/Eating_your_own_dog_food

-- 
Felipe Contreras
