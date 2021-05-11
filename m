Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2353C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 14:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6EF061263
	for <git@archiver.kernel.org>; Tue, 11 May 2021 14:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhEKOtq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 10:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbhEKOtj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 10:49:39 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82777C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 07:48:31 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id j10so3123738ejb.3
        for <git@vger.kernel.org>; Tue, 11 May 2021 07:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=shMTXczEa3wBIZGnsGJk4hWEuyZ3HICwa7PcB2r+aPs=;
        b=Ka/oIwF+sMnT/Mzi7/hxKPV9JZEaGGC5f2lfrjDavBilDv3Bdal8wNZhfhS2Owddi0
         /j5j2dk2csLPo7fAkBlfXP74wBRGuFEQVshJ5Pz1jMvdY3kg6JXlkg8SUciSxU8+GUjD
         IqytybmW5lLBpUK9/7Ds43r6VXuuSfpRdYmqJ0rTKIJsqa+8+WqkVy8zQIBtjwDuDf+T
         nsJMyyAY/z2efk+twm/Ty/JLmeum0zjDUJk6NohR94GCXrVZISq1lIOViMf4GFewA/7F
         Tw+U/hJiLEoDVk6mRne2+UOJhvokQSfHw+jGWpd1Ha7hrHn8WrrjuYUJNQxaOgbq/Jaq
         0bVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=shMTXczEa3wBIZGnsGJk4hWEuyZ3HICwa7PcB2r+aPs=;
        b=uI4sWsJazKJGqMDT517Qiita9Jgs7cjloGG6V+ljWs2QBihR9H1Y4SSeFhOBRt/tR2
         PI+Uit/lZW2MiaoUmlgiWEXQKadVYeGQ7jy/XRhpFcNbt6twaaIaQzRKxxE7+qoGDRlM
         RtAoW5D9udZciyGH6yqCTiiHO/wusWJIlkA5L4aYONiTTNqUxRRruaQRbhjwKBcxWS+r
         qDlXScikA1RoCj+NzNleXStnqyQSlBCsB6aSbNidW/N0NmGklQ8Bxw43S/kgqOYq6yvS
         wlmuuZBkMyI1sNivd+4WuiwfqDoOta6igY0F/RbcmNNQlYoIS0GntC1pOAoXNYALq+Qx
         lOTA==
X-Gm-Message-State: AOAM530iGFdC/wOxZnrqkRo685g5F8qE/fy4Ug4TtHOEa7hje6xviIcT
        WO9IvLzNNq1mPKhf7Fupejx8RnFM2uVrqA==
X-Google-Smtp-Source: ABdhPJw7OfQUH8GC6DjW9NzZznBwBSTyNnuinhZUlurFKmyEFv5vD78Sqq0qqZBpLwTb+R6JIdgpZg==
X-Received: by 2002:a17:906:c827:: with SMTP id dd7mr32324527ejb.225.1620744510202;
        Tue, 11 May 2021 07:48:30 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id r15sm14347499edp.62.2021.05.11.07.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 07:48:29 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-curl: fix clone on sha256 repos
Date:   Tue, 11 May 2021 16:47:28 +0200
References: <20210511103730.GA15003@dcvr>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210511103730.GA15003@dcvr>
Message-ID: <874kf9tjgj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 11 2021, Eric Wong wrote:

> I'm not very familiar with the way some of this stuff works, but
> the patch below seems to fix clone for me.

Me neither, but it seems that whatever issue we have here we've got a
big blind spot in our test suite.

GIT_SMART_HTTP in the environment will be ignored by test-lib.sh,
manually changing the code to use it leads to a lot of test failures,
some are definitely expected (incompatible server responses), but some
might not be...
