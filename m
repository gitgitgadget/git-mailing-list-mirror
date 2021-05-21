Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DE3C04FF3
	for <git@archiver.kernel.org>; Fri, 21 May 2021 23:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AAFA613F2
	for <git@archiver.kernel.org>; Fri, 21 May 2021 23:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhEUXFz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 19:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhEUXFy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 19:05:54 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CB0C061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 16:04:27 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id v13-20020a4ac00d0000b029020b43b918eeso4931116oop.9
        for <git@vger.kernel.org>; Fri, 21 May 2021 16:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Adi24ujtVLLYBUIyPogDrxD7BlIXVw1Ixs+ZKl6v2Os=;
        b=DLug78Y9Pntl0RA9vuZAwZIenEMy+aw+4kJMOWV2fadNozHXFhro+q+W5FU0p48CvA
         /ViXrVvgaePipB8mb3npj2Pq/7aTbeFIIRsDi6aECYikzhxYxLQZ0DBAzTql+rDX6ALc
         m2mxRPV2rF3g/E95x+VefF5ynJa4syFqd3nIH9QoS0hR9O7GQ3aX+zniYPfxCm6WOg/b
         3Q+2v1H75bryJPbT15XBbes+UqPljG3+SSFg1IWte5M+a6T52avUHZDuuDqtHeX3zOjv
         QBIqfuX3CP1kU7g1nkyED549BGg5EZkeUhUqSXSHCKGm4d1kRS7SEJzu52kCqstA1uQU
         Zh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Adi24ujtVLLYBUIyPogDrxD7BlIXVw1Ixs+ZKl6v2Os=;
        b=Oxw9dhEKcEDQzZRFgYH9DUtIyER9QHTz1W14R7/Sachj83qVa0GWHq6LIuAC++xlCC
         qRFRFUNi1YAVYEhs1ia1/bwiW4tBm92R9q+G+G4YZE0w6rveCgQ+K/ADeme0JTgDRRLm
         zn8Gm/c+7MuNuSGuCL7wYnrPZ5w+vhUlbJ40iQE50feOwZGDBvgRLvTLROvnnJ4lztrw
         fShw6BUfSAfphRKt3gSOIsFqWs7cYYyK4NTL5HM9nsSxTE2Fagw8sUROc8Go4KK4pW8q
         iZl7v84Dduqhe+EWOAmF6ILA6PgElCJRo5wnxK4KHfEPdsiJGbHaSASbA0voSyeDrmoA
         HG3A==
X-Gm-Message-State: AOAM533arDq9tk6Avkk8Q1IcwX2IweK3dgKJ2Y7aLCfV2AH9N2RgS20Z
        wpisJAobkFFJu5vrQhZ4u4k=
X-Google-Smtp-Source: ABdhPJwZ3b9nm1+KucIJsiaNtZx3lYvlM/Uzh1l9n80Ai9jvRYLA+hp5WNZpYVLaat4Y6H1+BNGF3g==
X-Received: by 2002:a4a:4117:: with SMTP id x23mr9896531ooa.37.1621638267020;
        Fri, 21 May 2021 16:04:27 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id v9sm1582103otn.44.2021.05.21.16.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 16:04:26 -0700 (PDT)
Date:   Fri, 21 May 2021 18:04:25 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Leah Neukirchen <leah@vuxu.org>
Message-ID: <60a83c794ed4d_81cd4208f3@natae.notmuch>
In-Reply-To: <636007b7-c079-f8a6-1b26-eb2a55505354@gmail.com>
References: <20210518010121.1350327-1-felipe.contreras@gmail.com>
 <YKMWL0iZLVl1KTrB@camp.crustytoothpaste.net>
 <60a332fd22dad_14c8d4208ed@natae.notmuch>
 <YKRSlFcFAcHcR3uY@camp.crustytoothpaste.net>
 <xmqqfsyj1qe1.fsf@gitster.g>
 <YKRy6oPkgS6FMSZ0@camp.crustytoothpaste.net>
 <xmqq1ra3z23n.fsf@gitster.g>
 <87lf8bqdv0.fsf@evledraar.gmail.com>
 <YKcFrbuuJrWAxXgm@camp.crustytoothpaste.net>
 <60a7f7427eab6_55039208ba@natae.notmuch>
 <8811383b-d5f1-2b06-8ac7-47bbc5fc9d20@gmail.com>
 <60a8243323625_77e4f208f8@natae.notmuch>
 <636007b7-c079-f8a6-1b26-eb2a55505354@gmail.com>
Subject: Re: [PATCH] help: colorize man pages
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Igor Djordjevic wrote:
> On 21/05/2021 23:20, Felipe Contreras wrote:
> > Igor Djordjevic wrote:
> > > 
> > > If I may, NO_COLOR approach seems to be rather straightforward to me, 
> > > as per description on their homepage[1] - make all software supporting 
> > > it behave as colors are an opt-in feature, thus disabled by default.
> > 
> > May I ask you how you interpret this?
> > 
> >   It is reasonable to configure certain software such as a text editor
> >   to use color ... sparingly
> 
> Sure, but to make the point (hopefully) even more obvious, let me 
> quote the whole part:
> 
>   It is reasonable to configure certain software such as a text editor 
>   to use color or other ANSI attributes sparingly (such as the reverse 
>   attribute for a status bar) while still desiring that other software 
>   not add color unless configured to. It should be up to the user 
>   whether color is used, not the software author.
> 
> I understand it exactly as (I think) it says - it is reasonable to 
> allow (the user, not developer!) to configure certain software to 
> (still) use color

This does not follow.

The contraposition of that statement is that if a text editor doesn't
use color sparingly, then the user should not be allowed to configure
such software.

Do you really think that's what they are saying? The user should not
have a choice? (with certain software) That's color fascism.

-- 
Felipe Contreras
