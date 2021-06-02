Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C412C47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 06:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7609B61359
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 06:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhFBGyv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 02:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhFBGyu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 02:54:50 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2140DC061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 23:53:07 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id j17-20020a4ad6d10000b02901fef5280522so347227oot.0
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 23:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=TookIacmbPtozWIRKBn2w+hgR42TzyKkq50lQFG9AL0=;
        b=dM7/+ZV7mq2xX9jtrtGNVF1FZv90kjT241OKMXSHd7KiAvpR3NhQD40ORJMKwsbhLT
         pYP4+OSoi+6xHd+4VI01d6uoouwF2gZtdaLWWtnoXc2+Xtnd+C6BH3uVbl0BH3LulSmi
         Qmu+hLDhnKpmO9xVdwBnD3nOH1Vob/l/MdBsSW/LQMl3V9AtEdvJcVjtumYGHOx6mo4b
         U5YHixDj+efb6iHg32sv0OFJau1wn3fjCkGnjoUL1pQ+rRVV1Y72QFy1V+S8KCGTx3a+
         0JSCcFMffUC5Mm0Hl40IN9GWK63eAbQ4gjtTjR0PyTZy6euYfJGXclom0m2fXV7nyr47
         xm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=TookIacmbPtozWIRKBn2w+hgR42TzyKkq50lQFG9AL0=;
        b=IfxW6hZH2DFSfXjNlhpAwxrRwfK2aFdHKusWNaWmeYocrJFdHHmPlKnDLg0t+isVST
         E3ndEZ3jzP+bFAZwhtbVFYi3dmL24+e8oU4Qmx3YYIejkaXqq3chp8V5/UtZk6d0SFwR
         CzeQaj9QOcfcm9GcXbbvyO+OrBbcvpR2wuWxLrcCTAnWlhnZHYiaZo5QFTAnW8oV3wgx
         oLVQlco4KN7rufdwh/Ysr0DO2/n9uCbJj4TWe1O/3r/hF1R9D1l+R/PhGxBX72Za+dZh
         ZG41QedKgePHVzo0KEsIY65ZGmEtNaSMrmJLiFJ5TWWRL6tmBMRNkGSjOOdZxj2HvzGj
         Y8mQ==
X-Gm-Message-State: AOAM531rwLvoowl2xwWmyqskEfpVcYwKb7+xCDaeAzyi9ogSmaiA1vZs
        eVDiy/Vhvf1w1ZmDHlORlHQ=
X-Google-Smtp-Source: ABdhPJwfxD2YeOkope7qBvBvutC2CwtqkXr84CKU+5UzX7cOcoStj/LTsbxOl6IcvoqpZPze/QsD3g==
X-Received: by 2002:a4a:95c4:: with SMTP id p4mr23115213ooi.51.1622616786475;
        Tue, 01 Jun 2021 23:53:06 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id x7sm657444ooc.23.2021.06.01.23.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 23:53:05 -0700 (PDT)
Date:   Wed, 02 Jun 2021 01:53:04 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        David Aguilar <davvid@gmail.com>
Message-ID: <60b72ad0ccc57_501332083f@natae.notmuch>
In-Reply-To: <9fb1f823-44f8-8046-adb5-d2c0fdb6b5a0@kdbg.org>
References: <60b5d281552d6_e359f20828@natae.notmuch>
 <CAJDDKr7AG_qs2ZmNCuS9zS0oqCT9cWU=CSCfxALEkGuLHBH=OQ@mail.gmail.com>
 <xmqqzgw9qky5.fsf@gitster.g>
 <xmqqv96xqjyr.fsf@gitster.g>
 <60b6c642ba65b_4044208ca@natae.notmuch>
 <9fb1f823-44f8-8046-adb5-d2c0fdb6b5a0@kdbg.org>
Subject: Re: The git spring cleanup challenge
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt wrote:
> Am 02.06.21 um 01:44 schrieb Felipe Contreras:
> > Junio C Hamano wrote:
> >> Junio C Hamano <gitster@pobox.com> writes:
> >>> David Aguilar <davvid@gmail.com> writes:
> > 
> >>>> +1 for merge.conflictstyle = diff3, rerere.enabled = true, and
> >>>> log.decorate = short from me. I noticed others already mentioned
> >>>> these.
> 
> Does diff3 conflict style reduce conflicts to their minimum?

The objective is to resolve conflicts, not to see minimum conflicts.

> >>> As the inventor of rerere, I agree on rerere.enabled.  It was made
> >>> opt-in only because I thought it was somewhat risky when the feature
> >>> was introduced, but it has been stable and useful, and it is long
> >>> overdue to be enabled by default.
> >>
> >> Just to make sure, rerere.enabled is fine, but as I am not
> >> comfortable to recommend rerere.autoupdate to any human users, I
> >> would be opposed to turning it on by default.  Giving people a
> >> choice is fine, but the default should be a safe one that offers
> >> users a chance of final sanity checking before proceeding.
> > 
> > No commit is made. Doesn't `git diff --staged` offer users such chance?
> 
> rerere.autoupdate erases the information which files had conflicts. In
> my workflow, the rerere database time and again does hold outdated merge
> resolutions. I want to have an opportunity to cross-check the automatic
> resolutions, and for that I need to know which files had conflicts.

Then do rerere.autoupdate=false.

Defaults are not for you, they are for the majority of users.

Cheers.

-- 
Felipe Contreras
