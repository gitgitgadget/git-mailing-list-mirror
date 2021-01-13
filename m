Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76004C433E6
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 18:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB1FA2225E
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 18:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbhAMS7K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 13:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbhAMS7J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 13:59:09 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83670C061786
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 10:58:29 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id n2so2032724pgj.12
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 10:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=KpBtOCoQQRJ5IWbO/rWh84ViKxZf5ur7MPSCOZPllBM=;
        b=VMp+KoFGY8UErr7/FFF+uRYClSFUY+hvK9g6jgMfl2mFLdpDEizxIoiYXHwjho8hfI
         6BALWOjb/I2CWAegwGXz2wSM7Be9E3M8fS/hnSQgXmaNj83pfpu/ylWbQzJCYRrfNdLn
         5qt05dNxxCDV7XCWoDhqEBxz+1kbM396ECZ/dQoGVXD9n/ln7Nb/PPr0/A8ZpRIP76fU
         uVi4wd5mRlBj5psuHwCpn/1JFQVYGdq/16AkyRCYz7bOOKlC/+QjSaiTMXLfmy6ejN5s
         RDJtYzAf6es1qKsLLkymfjWyPqxhYnxT2Ng6xhPPcVVxmbija1xc0njWc9wY3X/cn/K1
         14fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KpBtOCoQQRJ5IWbO/rWh84ViKxZf5ur7MPSCOZPllBM=;
        b=AAkkFZt5uUJcHcTnR9dm/3sY7Q051VmtThloYyBG58yE7sBEgfvdLYXaUOO9I2BCQc
         8piWtBWKpAbTPRcOf9+y56lLAqp26+KIgMeDuPM9NLBCxN776QeT++L9wSu/gNzBqtG7
         k5UMmqfd7jP/UfgiAVvhV0u63FlhXfrWbGhuM/tN8g8C1WfhpyB6h1hWTfoCYwAy6ALG
         jtA2enElclgN6AAgJP18qvMKSUSytfihd0eFyqxKlE/JqnL9EfufIDMtf6HJdlwdXTDX
         JSuXRyO+Z3VRcMWcGf1QBSlvHk9w1B7seVA+oqMaIfPpZhCgKQfTxNV0gzflneHprcWY
         WGgw==
X-Gm-Message-State: AOAM533phT7lpt/qG9bmbPt7PdnS9pMXuWOBlBxYWrrRqum7XDCXM4W6
        gb/xC8FxHXdaThzIsKhDJJ385XVRSdnoZ9xtRpl2
X-Google-Smtp-Source: ABdhPJzo5T5fBkCNqf0tkIyMOwwctavAyic1cU4FKtrb2SKLNc3vvJ0bzN8u4TwiPbhcikJvqcHU97uIf+ccbj0cEY7T
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:9248:0:b029:1ae:8b24:34c8 with
 SMTP id o69-20020a6292480000b02901ae8b2434c8mr3456855pfd.67.1610564308196;
 Wed, 13 Jan 2021 10:58:28 -0800 (PST)
Date:   Wed, 13 Jan 2021 10:58:23 -0800
In-Reply-To: <xmqqzh1dxmlo.fsf@gitster.c.googlers.com>
Message-Id: <20210113185823.206040-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqzh1dxmlo.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: Re: [PATCH] CoC: update to version 2.0 + local changes
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the reminder.

Acked-by: Jonathan Tan <jonathantanmy@google.com>
