Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738C4C49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 10:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 589C2613AE
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 10:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhFXKmC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 06:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhFXKmB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 06:42:01 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36F5C061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 03:39:41 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id hc16so8682306ejc.12
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 03:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=cQcRWNa24PYB5cMvNht08y8I/AYQJ68zAOV8+CR4W0Q=;
        b=VQ5r77FteoA+hiVKq6O7ZuFVA5X1VpZa0fOmyjdd7A0Ioy+/HlTHhPkAeX6zgfr/MH
         95z2eHO7xaBzzvXSiA0xV/m16UQmFKd2XFcKFsSzkNXdhAGlcK+/69IVzWoAqn/qS3Zt
         vETCdPIyGpzNj8gNSGQlGRjdTuSvsI6dpZXBesGOL1d/eUR73ygjczyms/o59474k9Pl
         MyZWALWRKO9sPKLqlhLUhSSji4rFbyNjtqDNzmYJIzgr3jtn255QPWrlsspHBAo7Hgqu
         CdFx5d/uV+qzs0xJnjrjN7p/vmw9VvYwc0DSFuMxvUO9FiCzj9Qmn9soRQlrtMWnE+A5
         +rWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=cQcRWNa24PYB5cMvNht08y8I/AYQJ68zAOV8+CR4W0Q=;
        b=l/CydeO8TsmrHv7JyYqXanII6qPCD347m+XSYkr5J9TocoDmbXi0Hj+SidZ/f4y2f7
         L26FmFoZRmmp52VgkkvMLjVcmpmqeQ61dnkqE/tPXAv8Gakxi54cOjhA3/KH86Ofoe7P
         JgmX1E8KvypMPQAMCCFcLtJq7epb2sZbZPyqXNIW/MWaZwg//313BUimUoZej+dnqlLm
         Rzu0J8OQvIoxL0UvwTe64DLOkY5xrJwwG+mI8S3gsO6nHpZnxev69o7kGFmc7joCWETw
         0DPKAVZyj/MuYXyeEv5LGRzqT/xikQdlNC/Gk+kyN/LeKF7FWQ2AgSCyFwWohqZNYFvv
         l3uA==
X-Gm-Message-State: AOAM533NArZzmFWMQKajOrlvNQ+J2aWn9OMYugohSvE4aG2DWf3tzhCB
        drLRspNm3PqNrS6S/ug5XTo=
X-Google-Smtp-Source: ABdhPJxIfb20d0Xdai7kedLuly+d0JbbofdgEb5G1B0yRdF5Iudm0O49ry/l20npvoZtrfpW9PyUqQ==
X-Received: by 2002:a17:906:9148:: with SMTP id y8mr4594838ejw.57.1624531180176;
        Thu, 24 Jun 2021 03:39:40 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id d7sm1670232edy.6.2021.06.24.03.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 03:39:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: Re: [PATCH 0/8] test-lib tests: split off subtest code in t0000
 into lib-subtest.sh
Date:   Thu, 24 Jun 2021 12:38:32 +0200
References: <cover-0.8-00000000000-20210614T104351Z-avarab@gmail.com>
 <xmqq35tjzwz2.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <xmqq35tjzwz2.fsf@gitster.g>
Message-ID: <87czsb1r85.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 15 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> This refactors the testing of test-lib.sh itself in t0000 into a
>> lib-subtest.sh, fixing duplicate setup, bugs and various shell nits
>> along the way.
>> ...
>> I thought it was better to submit this now anyway, while
>> this code is fresh in people's minds.
>
> Any time you send it anew is the time it is fresh in people's minds
> if they read it, no?  I am not sure I understand the reasoning.
>
>> I'm hoping Felipe will take some variant of my
>> http://lore.kernel.org/git/8735tk22if.fsf@evledraar.gmail.com and
>> perhaps review this series & base his patch on top of these changes,
>> but alternatively they can go in independently with Junio solving the
>> conflict.
>
> I'd rather not if it can be avoided.  Please scale the process by
> coordinating among contributors yourselves.

Per Felipe's reply and his
https://lore.kernel.org/git/20210615183157.104999-1-felipe.contreras@gmail.=
com/
I don't think there's any conflict anymore, so this series should apply
on master without any conflicts.

It would be great to have it picked up, it's another set of test
cleanups I need for a subsequent series...
