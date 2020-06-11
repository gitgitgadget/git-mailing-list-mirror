Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8797FC433DF
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 02:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 525A9206FA
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 02:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="IxW1WUtl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgFKCfJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 22:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgFKCfI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 22:35:08 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619C4C08C5C1
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 19:35:08 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id s23so1997818pfh.7
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 19:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MZ0uni8KNnkvihCvAPTLf8z85eMORusWcDxzn2N1cE8=;
        b=IxW1WUtlSqzNrRoN3kCu4DiErqUfPtJ/EG45RTWkgR7JmfIimqHeaeALTmL+tv2G9x
         uvAkPvFA9WALZj0qOAp7hW0UJ/lexCk4jvddE0qiSaPM/qFO/K3IYfbLuCj/14Gb1OPQ
         Qy0aYoWlheCKIYnKlMsfcHaLhY/8PIceaYGzpuY9LPgYF7LEC+yNDF819MFAL9nzhHdm
         HwHWI/BHlwvbOG6wqWwwI+mCZOXUdxY5mUPYn33bJTV+RtQLGwRdxFmhSiqblm8q0MV4
         eX5ObvsgWxhvKX+klYw2PUp2ZPHVOrgoPfyabtFkseae6EoNrMn796u1VYFZB1N1kErM
         JJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MZ0uni8KNnkvihCvAPTLf8z85eMORusWcDxzn2N1cE8=;
        b=dCYPumOYRUG52hqUW8lri0JToORTk5urnra1P/oEFfdUgB/fpo4BsfCdIdwclg6O/v
         qNfIacS1OTvCPws5gTT7xMVlo99AVSBvr+QCLiRflR8m1TZqXgIjqojsLBVqpBxO3+9S
         oMujGA/ya1WWICcuKjWlcamOGbZrnFb9KZIx1cubDUzeUXSUDyhVc3zhh4QHS9m9u4LD
         WkKCYIT9Gi/TsFU8hXmi6hARELR685KVjm1gUmVYU8gPbSNN/BfVGq4eyxUDgXDYxiYF
         tMXmMl6iqVPCbBH524UOFy7Zg/VdHzF5He5jbBSbMU25zgCE0UE/o7dxhzguLlss8h+b
         wF5A==
X-Gm-Message-State: AOAM531+bJWMMbe8xMBjYpiF9mM7T0Eu1On9hObbyv8/AZDs55L+xNXN
        /KHhOLhmfbLvpWrg2MgbtcZDdtEoIhcXJg==
X-Google-Smtp-Source: ABdhPJyxADB2FU48MfXYYh8M1sOlC0qv+M5GB7tjfUA+lqb1jJqtAQTUUuFvUchtYNfhdbA9N14WaA==
X-Received: by 2002:a62:1407:: with SMTP id 7mr5109790pfu.282.1591842907412;
        Wed, 10 Jun 2020 19:35:07 -0700 (PDT)
Received: from localhost ([63.239.199.7])
        by smtp.gmail.com with ESMTPSA id e12sm1091371pgk.9.2020.06.10.19.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 19:35:05 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Wed, 10 Jun 2020 20:35:03 -0600
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        git@vger.kernel.org
Subject: Re: Virtual Inclusion Summit
Message-ID: <20200611023503.GA24130@syl.local>
References: <20200610222719.GE148632@google.com>
 <xmqqwo4eedwc.fsf@gitster.c.googlers.com>
 <20200611011040.GB21728@syl.local>
 <xmqq7dwecpsp.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7dwecpsp.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 10, 2020 at 07:13:58PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >> It is OK to have an optional meeting in the hope that a video
> >> meeting may have a better chance to keep those who easily become too
> >> aggressive and confrontational in text-only conversation in check
> >> and instead have civilized conversation.
> >>
> >> But I am not sure if it is a good idea to call such a meeting a
> >> "Summit", given that there are those who prefer not to be seen,
> >> heard or recorded how they appear and how they sound in a video
> >> conference.  They would not be able to join the conversation held in
> >> such a "Summit" held only by those who are privileged enough to be
> >> able to attend.
> >
> > I think that this is a very reasonable concern, stated in a very
> > reasonable fashion. Let's call it something else, sure, and avoid
> > recording/publishing the event (as we have done in the past at other
> > in-person events--such as the last Git Merge--which seems like a
> > lifetime ago ;-).)
>
> I am not opposed to recording and publishing for wider dissemination
> of what was said and agreed on among participants, who join with the
> full understanding of how the video meeting will later be consumed.
>
> What I am hesitant to see is that such an opt-in meeting becomes
> "you got a chance to attend and have your voice heard---if you
> didn't come, that was your choice, and whatever objection you give
> after it does not count" summit.

Ah, thanks for your clarification (and sorry for the misunderstanding).
I figure that any synchronous discussion should augment the on-list
discussion, not replace it.

Thanks,
Taylor
