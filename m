Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B620C4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 23:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FE4C6139A
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 23:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbhFAXps (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 19:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbhFAXpr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 19:45:47 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7094C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 16:44:04 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id h19-20020a9d6f930000b02903c0c4560e99so934023otq.1
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 16:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=wvhKzEEJ2lELXmsLSMQs2zhf9sxm1koH4gBbEvlYVrw=;
        b=VWWRLVEC1aS7uoOdUUowpXbnMrQo4bvanjVCSvwTGmRNKL3iljshPphDAWOxSRKI9g
         GglR1vU3SuddyZUIvgfhOhtnX8vmd1/4mhYoGeG3wIoH9xLTxvt2odb5n+RD+dii1T9O
         oqomKaUllpJ4V7uDkWOhFxmOVEuRSAIPz65+QNUro7+vYXOEAxujXnHj6byCXhgaJJUB
         BVHRfKPbZRZltAaWq1gI2i4stLQPOpQyjGlw1TjajLUsrQ1ok76IjmRzl8YQdQcP6xxh
         7k1Rn5tcoeF7kRJG0WieKQOpJrLUBqKmNfuKaAmNegAJhjONzJP3Al8EsM3CLTBA61kH
         Criw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=wvhKzEEJ2lELXmsLSMQs2zhf9sxm1koH4gBbEvlYVrw=;
        b=BasP0Qpr/JZXoi4dgcu5U96RWmqh4OAMaE9WdfIi0bIIdnW7xTN59KFO78QJeDnv7F
         mwwn31jbFVfV3RV+l7bzp1J2kqCea58n7hb8hyuknu7kIBH6mbRe4tFLYpakurRo5KPg
         VA+I3/vL39RBb7S/vK1HK7AEpnflamLxU3Y0nMfquPsg+BrTb6fEA6154yE0XejkgPeh
         +9vVlCuIJ8a6laqnjIbqvK/XzEFVnrbv4f24WKqJLlvTdijG8ITtLg3m4OMzC5GBCAbz
         oY/x00kwdXfmxlxjpZ65QC1mw0SAE3FSfaARSSForu6ly01QCQLK1qABb0TNEcZfy464
         5+Fg==
X-Gm-Message-State: AOAM5330k+GBwgYZfAP8HWzaacUOJevYLnck7LqeVA+vBE1Xsa8hsC9b
        M+Zei3jl+3xJPdfOM18CTq0=
X-Google-Smtp-Source: ABdhPJzVLUE6gAWyLLKvMR+sUkHADldBmWUxYt96slAP9yA9YW1GGLRzkXms64NkQPUKdt936H3Vcw==
X-Received: by 2002:a05:6830:108a:: with SMTP id y10mr23587718oto.187.1622591044348;
        Tue, 01 Jun 2021 16:44:04 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id g26sm2369301ooe.15.2021.06.01.16.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 16:44:03 -0700 (PDT)
Date:   Tue, 01 Jun 2021 18:44:02 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <60b6c642ba65b_4044208ca@natae.notmuch>
In-Reply-To: <xmqqv96xqjyr.fsf@gitster.g>
References: <60b5d281552d6_e359f20828@natae.notmuch>
 <CAJDDKr7AG_qs2ZmNCuS9zS0oqCT9cWU=CSCfxALEkGuLHBH=OQ@mail.gmail.com>
 <xmqqzgw9qky5.fsf@gitster.g>
 <xmqqv96xqjyr.fsf@gitster.g>
Subject: Re: The git spring cleanup challenge
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > David Aguilar <davvid@gmail.com> writes:

> >> +1 for merge.conflictstyle = diff3, rerere.enabled = true, and
> >> log.decorate = short from me. I noticed others already mentioned
> >> these.
> >
> > As the inventor of rerere, I agree on rerere.enabled.  It was made
> > opt-in only because I thought it was somewhat risky when the feature
> > was introduced, but it has been stable and useful, and it is long
> > overdue to be enabled by default.
> 
> Just to make sure, rerere.enabled is fine, but as I am not
> comfortable to recommend rerere.autoupdate to any human users, I
> would be opposed to turning it on by default.  Giving people a
> choice is fine, but the default should be a safe one that offers
> users a chance of final sanity checking before proceeding.

No commit is made. Doesn't `git diff --staged` offer users such chance?

-- 
Felipe Contreras
