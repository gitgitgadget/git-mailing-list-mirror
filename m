Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51949C35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 00:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B50B20720
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 00:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R+9pl8OC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgBDAH5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 19:07:57 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45258 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbgBDAH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 19:07:57 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so8451972pfg.12
        for <git@vger.kernel.org>; Mon, 03 Feb 2020 16:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=AyXWAoe2UCmVp5vvRlWu9wXFrBNWIsDJbAhEaeJNgfc=;
        b=R+9pl8OCzrJYIFolWdbeeRiXI8FY3iE6E5Bgbx1YGdMHpgxDK4LlD9u1p2jqZxm1jJ
         WmDGWI1iWh9zD/F1uFXTfEoEyqcCZwcM8MCdDvzPnFyhCoWvbWtCPibXMuZElFDb4J1K
         8VTY5y48u5Atzm8NNnhb810dltQ/XgIvn2D5vNSSyHPaWDXdLrhPRWg8PG5vGvlbMCQW
         kXSU9AIEUhugfPYMDQY1OWKgi3cjlnboSKnExlNLV3cp0BIiDOHStiFSiC5cV2a04r0j
         5LUFFw9KFSvdhsKzNZK2le4mZXExv71KWZbfcUDU188JFNdrfBo7XujcTdO0UGdS3Mk8
         H0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AyXWAoe2UCmVp5vvRlWu9wXFrBNWIsDJbAhEaeJNgfc=;
        b=Uj2PH4SyOeR6K1vQJAWkVNs+w/GYm1ZhoctSkPHSiEdRWB1ArtvONcXYocSZB13bXU
         LBWKzLaw4OuvWo6Put1MC/Bvsw4148YEUTk6QIVg7qCFz/kGMSkVa196GJTs/xtvUjM5
         NmMshskDdHyoyvWZ/8YI565FwgmWqgnUk62VEfkae58cXuycMTdTl+ME1K5KnIG9ILLm
         DJyQ8gj5dsSQ+LbUrAodMm32IvqVWS/JMlBGdHw7BFd0sQG3s7B/Bk8vM0hEf8Zoq5gK
         5w3fMbBs9R4L2Zy953o4M03cZim4I8QaPYQIvs2Rn9ZmDAonUfBpyCq0Zu+MOetbBsjy
         Di8Q==
X-Gm-Message-State: APjAAAV7yEi8Y0o5RssxRrabriHo+NAR0hS/j442Dv8rEvxx4By+4yUc
        55D91shRv7BvP4Zre7KYK9FcLA==
X-Google-Smtp-Source: APXvYqyc+MBrSor8j32/4gMOI++HgI1UZWBHxBSvoV45uBwVyGsfWPRSXeGdLZwQAyMQ5jGaQwj9Yw==
X-Received: by 2002:a63:cc:: with SMTP id 195mr27780519pga.117.1580774876168;
        Mon, 03 Feb 2020 16:07:56 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id x6sm21142878pfi.83.2020.02.03.16.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 16:07:55 -0800 (PST)
Date:   Mon, 3 Feb 2020 16:07:51 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Aaron Schrab <aaron@schrab.com>
Subject: Re: [PATCH v5 00/15] add git-bugreport tool
Message-ID: <20200204000751.GA87163@google.com>
References: <20191213004312.169753-1-emilyshaffer@google.com>
 <20200124033436.81097-1-emilyshaffer@google.com>
 <CAN0heSrwxnHGR0JP9EHgAHYysFO+E2qqV2JGO2qLaMM=MrA=LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSrwxnHGR0JP9EHgAHYysFO+E2qqV2JGO2qLaMM=MrA=LQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 30, 2020 at 11:15:25PM +0100, Martin Ågren wrote:
> On Fri, 24 Jan 2020 at 04:35, <emilyshaffer@google.com> wrote:
> > This topic branch depends on the patch mailed in
> > lore.kernel.org/git/20191211233820.185153-1-emilyshaffer@google.com in order to
> > display scopes for configs gathered during "bugreport: add config values from
> > safelist".
> 
> Should this use `config_scope_name()` which looks like it's about
> to graduate [1]? Disclaimer: I haven't followed that patch set too closely.

Yeah, you're right that I can use it. config.h:config_scope_name() is a
new feature on that patch since last time I looked. Thanks for the tip!

 - Emily

> [1] https://lore.kernel.org/git/xmqqzhe66dav.fsf@gitster-ct.c.googlers.com/
