Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCBAC433E6
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 23:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B5B8206F4
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 23:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a5Sea9OS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgGOXNR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 19:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgGOXNR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 19:13:17 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD0AC061755
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 16:13:16 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id m22so3833419pgv.9
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 16:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gAuLNYVQKw5NWeqeIMq6FrT6rGR8PALrrhvTCx0tPhQ=;
        b=a5Sea9OSd+Ljo2uqJVIQ+HMno2zw27L/wV9jF4A6NMNH/k8/vUlGed/jDL8P9GsPsG
         0I+oj+Kr1IxdaJDfUajjgugE0wN9lbFRvJuCzR0i6o5VGYk4121AZlR9NvGObRQojVtW
         0KSRiYccU3f321bJEQqTl3phrxi3buvvJHfY8GXW+bC/Dhis2vThUPefEDQh5rXHs2mu
         P9rgF84hD8V+tTE1G651a/MDCR86BFm8hLvoNivnmVRLtWxeSDzYbUEAnPTAVLFidK1Q
         biMKt9YI0Gxf3Rng7Dpquh7G+SbtRsPAnhplDWdt2kybsnJIOca50GYkA4kkypa7/QCQ
         2WzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gAuLNYVQKw5NWeqeIMq6FrT6rGR8PALrrhvTCx0tPhQ=;
        b=kKyaf/Bmr1s2vyfvi7Ez11HsOrPRmocsOrukRWeC0Cu8vav798p/e5xgrY6RTg45Bh
         G0XvtMIsvLDBFBfSDgFLhHQPtZJj0cNtJOiY4ZwQFOJMe13Ka1ByE3bMdc3ueNsJ5E3N
         YfZZ2h9A1+4+PLwX8umRMJo7ppjz/93MHKDEG/xa9Mp8Ux5ewn79OBFQuVimJ9TFkSMg
         RLOvUzcmd2I3pABkOR7sNid6ew9QQA6aW9ZH6tJKI/Uq9kf0w/VZTOnZu4W+dktWXA2G
         o3FhWbK5vPl/sEYYdcaP3BQ3XiyaO6qL3gZMkcnQpOhfHZsFnpAiakxD2sbhiJTBvWF/
         l1Jg==
X-Gm-Message-State: AOAM5338Gq4UoV+m8GSn/o2fE6f0p9y0hz9FrD9YsnaBsvi0/f8Q4hvE
        wnj+O/F6yJpEHPNL5mA+dB9U3g==
X-Google-Smtp-Source: ABdhPJzzEzQE9JlJiY9SxPh8LHk+NuBM56y7Bt0dmNZDPEJ9bnGb7U06uOw6SUzseVeLt6Here1bDg==
X-Received: by 2002:a65:52c2:: with SMTP id z2mr1796244pgp.419.1594854796165;
        Wed, 15 Jul 2020 16:13:16 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id p12sm2961193pjz.44.2020.07.15.16.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 16:13:15 -0700 (PDT)
Date:   Wed, 15 Jul 2020 16:13:11 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: es/config-hooks, was Re: What's cooking in git.git (Jul 2020,
 #02; Thu, 9)
Message-ID: <20200715231311.GJ3189386@google.com>
References: <xmqqa708wen2.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2007152247210.52@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2007152247210.52@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 15, 2020 at 10:50:49PM +0200, Johannes Schindelin wrote:
> cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
> 
> Hi Junio & Emily,
> 
> On Thu, 9 Jul 2020, Junio C Hamano wrote:
> 
> > * es/config-hooks (2020-05-21) 4 commits
> >  - hook: add --porcelain to list command
> >  - hook: add list command
> >  - hook: scaffolding for git-hook subcommand
> >  - doc: propose hooks managed by the config
> >
> >  The "hooks defined in config" topic.
> >
> >  What's the status of this one?  Abandoned?
> 
> This patch series is unfortunately still breaking on Windows, at least in
> the version carried in `seen`. It _still_ needs the patch I provided in
> https://lore.kernel.org/git/nycvar.QRO.7.76.6.2005250055180.56@tvgsbejvaqbjf.bet/
> and the patch (which I accidentally reversed) that I provided in
> https://lore.kernel.org/git/nycvar.QRO.7.76.6.2005250053080.56@tvgsbejvaqbjf.bet/

I haven't had time to work on it until this week (I am working on it
now). I think I have these patches applied locally, or if not I will
make sure to apply them before I send another round. Probably I can send
that end of the week. I don't think there have been any new rounds of it
since you send those two patches, right? Sorry for the inconvenience.

 - Emily
