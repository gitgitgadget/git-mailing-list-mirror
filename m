Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3325C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 08:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6D51608FC
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 08:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhFHIaU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 04:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFHIaU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 04:30:20 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96870C061574
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 01:28:27 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id e27-20020a056820061bb029020da48eed5cso4814311oow.10
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 01:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Sm1St0VWx3xW9CzKppHPY6+GpBXYBPh7ugFPm6GuncQ=;
        b=fwtEMDulCNDNSgwrrrXT1J7pOO3JY0dR0kDVk/M3dbwNcbJXETj39WsOOaosKGgzhK
         7jh0qBDZEMxpHapQ7PH27AkvYtqBlA548W3OfZWo4EtfHBGtgK4jlYjUjoQJgpi2B67D
         Dw5t7224jvnyhe3CnTdzbz4WL2J51T1f6R2XYY1M0V8f46abJv+N4z0DWsHBjcDFHuY1
         bl5lC5Nq+pF37jWgKcbHSriDZg71XR6hgqui/7DOS9edRPCSp2WBIAFYEgwgqt+ipoOt
         IyN2imjHKc84GhN9AKg4ByrN+y706WbOsfK0qREHv5TwOTG0UUS95TSTL3uF7M8GVeXF
         vA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Sm1St0VWx3xW9CzKppHPY6+GpBXYBPh7ugFPm6GuncQ=;
        b=ER9I6aYeuo7NX8iTQdbK1vbAz2vhEp0s+/Z9KUWFca0NXrFnd8A3dnn7zgFSZWoAqp
         NCONtrv54MFNGh8Are6DaLXtvdjio2wsMV4ZY6e4LlUO3LKqg2YxOSv5ZxcGMOLFhFA0
         lKFEBUElT+O0ezGDHVVfTwK0lXCLqurT7MaFIfq3cE/YAJBDWlhssGz8B93o0IetkpTZ
         wl+51NU6yTaQrFA6h6K/c1V3fcX9mX6+QhyIAeM95LbyWkSfSBm7exRmb524kOhPO4Nd
         MZ3ds1gbtmF2Os8DXnNN4dQf/G/uJZeussQDYdXYSu9kIWXr16zCy8oLWANGFpbX7lBm
         iyVw==
X-Gm-Message-State: AOAM5302TBIprofpJ5/6/mFrCpdIsU6W0Uk7BOSTXUSR51S9YS0qdKdO
        yc1SPjtAeoYMkvl9TjH7RtQ=
X-Google-Smtp-Source: ABdhPJyLfqz8qCAkbaklM2dpXD/waua9cat6V1HGBZu+wJXIOGyDEOJFeH+9eT4/fyGK8X8LerJKBQ==
X-Received: by 2002:a4a:d285:: with SMTP id h5mr6838854oos.71.1623140906943;
        Tue, 08 Jun 2021 01:28:26 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id r83sm2699365oih.48.2021.06.08.01.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 01:28:26 -0700 (PDT)
Date:   Tue, 08 Jun 2021 03:28:24 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Message-ID: <60bf2a2883b54_1a73f820887@natae.notmuch>
In-Reply-To: <YL8b/zUx0ikbqwC6@coredump.intra.peff.net>
References: <20210605011339.2202-1-felipe.contreras@gmail.com>
 <87czt059sn.fsf@evledraar.gmail.com>
 <YLv8NWL7WfBRkiGe@coredump.intra.peff.net>
 <60be41f6473e2_39c0a208f6@natae.notmuch>
 <YL8KiiGXF8LdGmQ2@coredump.intra.peff.net>
 <60bf1997b1a72_1a2ac520865@natae.notmuch>
 <YL8b/zUx0ikbqwC6@coredump.intra.peff.net>
Subject: Re: [PATCH] branch: make -v useful
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Tue, Jun 08, 2021 at 02:17:43AM -0500, Felipe Contreras wrote:
> 
> > > Don't bother on my account. I have generally found that going more than
> > > one round deep of discussion with you does not lead anywhere productive,
> > > and I don't intend to continue this thread.
> > 
> > If there's no evidence that will ever convince you otherwise, that means
> > you are not interested in actual real users, only in your idea of users.
> 
> I think you missed the point here. I am not interested in engaging with
> _you_, because I often find it a waste of time. And I choose to do more
> productive things.

This is a cop-out.

We are engaging in a discussion in a *public* mailing list, you are not
enging only with me, you are engaging with a community.

Your response will be read by other people.

I asked you a direct question that other people in the mailing list
would benefit from hearing:

  What kind of evidence would satisfy you?

You do not have to "engage with me", but if you are going to object to
a proposal, other people will want to know on what grounds.

You could say "to demonstrate X, we would need Y", and leave the
discussion.

But to just say "I don't think X" is not productive for anyone in the
mailinst list.

Cheers.

-- 
Felipe Contreras
