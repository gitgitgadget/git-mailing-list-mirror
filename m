Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12296CA0EC9
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 21:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349430AbjIKVdd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239781AbjIKV0j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 17:26:39 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6C52696
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 14:16:40 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a751d2e6ecso3813950b6e.0
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 14:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atchoo-org.20230601.gappssmtp.com; s=20230601; t=1694466924; x=1695071724; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OOWLqTHfTUcMmGZPktUKEkxG6H5WMQDs01jh4yNiEQc=;
        b=dyL20ufpYFJMjUFHpfN+kFBfgT1IFy8UeqGj0PiLiz4tq7bAgbfMg30E1pEYZpFNEE
         cxk31Pyzo4F2tm+sRgEDCxsvp/a+n5yAd2AV3Jj8CVgf630FFvd7sYITlusy8PwvIFpT
         O2etnJgL4A6ztrPM08kJFORMmp5FUH6pcO8V+/qIKGTPOxqRTrvxO0QUIHL/19LoO6cj
         TSXQoDugdRF9HVMgQ5DJGLeLJ47vV+fv11MYwOIMTr2acec4vlSpeoeqTIyusb4qP8V1
         JsBVVPu4Yqb9Rai6uZIu4R0DXl4ltw1pqviCh9NDSHrSZjqVoZWUEKYYRmLsNkIxP8bk
         byAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694466924; x=1695071724;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OOWLqTHfTUcMmGZPktUKEkxG6H5WMQDs01jh4yNiEQc=;
        b=O438PAJyouOH84+n5MhtEE8SubKXCjRiHVopLQI6F4mii0oZl6wocgplcMp6OWd+bG
         FPNDMJVChAMutsg67u1yNLzmn9T+QiEE28kV3/Bp7MIWhapa0ok13xMFr//BQIQugPoW
         /sQy5kfuBPCFvVnC7vUIAYbVsEfsHVlMv3ZYA6ZuXNcpXCz7fYLZWJUjELTbidOhWJM6
         sbzAHKFxwwILcQPnChDUyVtazDN33xNKJMKWKP3e2Q85TyZZtkM13qMlHoj5xpofGT8P
         SiykfjITfEqof3tAK80lDZIVStNWae5hNcpFxhvHPD+VYXfJUpJ6FB2NhM8gwI0BkE+Q
         25jw==
X-Gm-Message-State: AOJu0Yzcs+yQ/WfGn2sgUC2XjTC47BjMf/GODY6PJp0euYiTaO2DeU7I
        GqopwyXSfSEv+4l/GKq340rQr7luN4sJnTtZ91L/8mypr96XUQ==
X-Google-Smtp-Source: AGHT+IF710MJsrdjiNWLrJHVis1xquVKHl14pp3xf2U13G1oxyKm2DZSi8bVQegnq8iZzBclP6g+mHDBK1WF3YOy4e8=
X-Received: by 2002:a17:90a:4ec5:b0:26d:4421:854d with SMTP id
 v5-20020a17090a4ec500b0026d4421854dmr8441766pjl.37.1694466179535; Mon, 11 Sep
 2023 14:02:59 -0700 (PDT)
MIME-Version: 1.0
From:   Roger Light <roger@atchoo.org>
Date:   Mon, 11 Sep 2023 22:02:47 +0100
Message-ID: <CAH7zdydYgSf+21GB70=gRhEcupv4e1ix==7LWCeQYgpD-1Rcmw@mail.gmail.com>
Subject: Commit dates on conflict markers
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

When I carry out a merge with conflicts, it's not always clear when
resolving the conflicts which is the correct part of code to use. I
sometimes use git blame to guide me as to the age of the different
chunks of code and hence what to choose.

I was wondering if there might be a way to help include that sort of
information directly into the conflict.

If you had a single line conflict it would be straightforward to
display by including the date the line was last modified alongside the
conflict marker:

<<<<<<< HEAD date:yesterday
print("please")
======= date:10 years ago
print("help")
>>>>>>> main

With a more realistic change with multiple lines and context from
different commits, it's not immediately obvious to me that it's
possible to do in a way that isn't completely horrible.

I am in no way a git expert though, so I thought I'd ask and see what
you thought.

Regards,

Roger
