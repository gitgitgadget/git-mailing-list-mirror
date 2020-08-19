Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA09C433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 09:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D784D20658
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 09:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Baib56Wn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgHSJvS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 05:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbgHSJvP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 05:51:15 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E006C061757
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 02:51:13 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id 88so20864028wrh.3
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 02:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mzVuGvKCRL9GJat+nFKFG+XW6EtxjRtJwc5Ply1MMdc=;
        b=Baib56Wn0M6teYSnPWIhJ0jw9U2hKkOBQYv5S/0fIiSMbno6qUgVTKP7e4RyF78z/E
         gAptonf/CLqtlcwdc8B1VXljdF9uvGkwd54hREBcF9FkmMr2PA8rRZM/8qIvjllMZA2V
         b9yXr1kOOVJN0gp0syY68MZQDwP+bgN/kG0TdveNsC+IZ+JlD4j7GCzVVy63I4k6Tb9C
         8oHhwIbRSkuyA3I7RKF05+4tgFiSaFi+NQahypJlEHDy2J9RjEkhsjTCfrx2or7T9sWF
         w6kBPq44lVFXTCygKxipZMpgOGM8pLlrHBINAob0GnD5H2JmycDaW1C+NNum2RDLOiA7
         ijGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mzVuGvKCRL9GJat+nFKFG+XW6EtxjRtJwc5Ply1MMdc=;
        b=U61Xm9zH+KJ7g4yMo8VKHl1Wt5GtB+iBtx5iWUHV8dnbtB6ECXVGfWwZft/Xg/FMSO
         Z+xizuyfgqSib0BDsSNNDPk/oX74zi3yvWIkBUzKNMVX5FGPM5zd3bGPt3PKxvr5Ik8a
         UawGkRz84VTBlHeVVHX1i6hxGvUP6SfDOgKGc71IqFqPIpP6G49yNnwG14cAmIkutLfC
         QLCCTbv5IGhkKplrtxDFwabyyQ0PmJbjeDzSPWbRyXuD+6zOYRG7c3//MPwEnMT72ah+
         nEErYewB1tzT+rc/F+W++3GHggeVjbC0BP3lBEuCu6XA2iw7yN8PghT0t4DLa6at+yXE
         QEmA==
X-Gm-Message-State: AOAM530yqTvYChnCnpgP7qT1fA2UH1uOscmaM+oN6r5lVRHIGW1CTh5H
        ap5NMDNsA919WqKPv1vgWKk=
X-Google-Smtp-Source: ABdhPJxXGR0NGpl2BncSpW+VUPmdTn2b5UBbSe4EXepLxfWcZOMby6Dh6rbXokMqGd6s20esFy/65A==
X-Received: by 2002:adf:cd91:: with SMTP id q17mr24665101wrj.5.1597830671716;
        Wed, 19 Aug 2020 02:51:11 -0700 (PDT)
Received: from localhost ([2.25.81.70])
        by smtp.gmail.com with ESMTPSA id b8sm39443288wrv.4.2020.08.19.02.51.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Aug 2020 02:51:10 -0700 (PDT)
Date:   Wed, 19 Aug 2020 10:51:09 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Carmen Andoh <candoh@google.com>
Cc:     git@vger.kernel.org, git-inclusion@googlegroups.com,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git Inclusion Contributor Summit Registration
Message-ID: <20200819095109.GA60828@cat>
References: <CA+Twho+nyERK1Ljdy6MnXA=iK6SiU85v4yLQc+fRmW83JVa+hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+Twho+nyERK1Ljdy6MnXA=iK6SiU85v4yLQc+fRmW83JVa+hQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/14, Carmen Andoh wrote:
> Registration is now open for the Git contributor summit dedicated to
> inclusion. The summit will take place online over two half days on
> Monday, September 14th, 16:00-19:30 UTC (9am-12:30pm PDT) and Tuesday,
> September 15th, 17:00-21:00 UTC (10am-2pm PDT).

I've taken the liberty to add the event to tinyurl.com/gitCal with the
link to the registration form, to give it some more visibility.

Should that be unwelcome please let me know and I'm happy to remove
it again :)

> This is a free event.  We encourage anyone interested to register by
> Tuesday, September 7th.  Registration does not guarantee attendance.
> If you might want to lead a break-out discussion and attend a
> moderator training session in advance, please respond by September
> 1st.
> 
> The contributor summit is an opportunity for members of the Git
> community to gather, discuss issues of inclusion, and get face time
> with some of the Git development team and other contributors.
> 
> Please fill out the registration form [1] and organizers will be in
> touch with more information in the coming weeks. If you have any
> questions, contact git-inclusion@googlegroups.com.
> 
> 
> [1] https://forms.gle/ryhQRv6yXiy2Y9MK6
> 
> Thanks,
> Carmen Andoh
