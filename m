Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB8DC49EAB
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 04:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A7CF61C3D
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 04:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhF0ETW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Jun 2021 00:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhF0ETW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jun 2021 00:19:22 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD8AC061574
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 21:16:57 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id m6-20020a9d1d060000b029044e2d8e855eso12583824otm.8
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 21:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=LiV14/mLeJp7Jwo1ukZEhvvg3asCVhyUoiGWZF6puZo=;
        b=JwnkgBCQgZnXPecrWWmtTyIRK0fnKwyY1owltEIMIIZhPqDoW1XXlFXB1B7mf8NUPT
         BG2r1TXD3rlvI7ktY0/H31SOrvHwbq7so/f7dDVw+D8ZnIf8wX1KQm3RpJeZgozlIoid
         mXVPEO7A52EdSxSpOcQEBaRSjwR4S5JFc1HBLjmZp77TbErdLzW+PesyBLTrKUuACt8b
         BNrgJ/U1auGiopw0FbZYIh96tdkpWgiLsHrBjA1BCVr2uvBXn4kzCcMCzvh7/R9VsH75
         fRmyjMStgIaY/GZi8ZISCBPC+NOCqb43abZvjHGl6nW7kkD2xfDYPV01UrfeTroMl9ms
         Cj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=LiV14/mLeJp7Jwo1ukZEhvvg3asCVhyUoiGWZF6puZo=;
        b=Z5kVARpPico8s3XDjiWOnWGXExfbTuyn3vnaOGJF1G6mA3kdJIgjWUFIp49YXyxw4a
         rrd/y58H+UsvFK5C2EDlMa/kB38kCIWBx4sFRnmuYGYf93XU5SG7JtbAkKXGvTHK+Htc
         ffLE7lLzFICUPBv64PnPa3uQunE2A2cGHWGaPB/1cFf5lhjUjPT63xhH2G8yifW6D7J5
         TzzLfUrN3dppdXWKUt5uhOGKB92i+uRW8/znNm7LpEqp9zFF8c+PJkHYFRrscsDDDdjN
         txBlIcDP6HLg2yqYSgFIh8GPkglTLD/0ZMUlbssH/MFczcJs0M3WgXIz8FyK5ttLOj3c
         MIGQ==
X-Gm-Message-State: AOAM532Num3vGtCDNzlMEh+DTrOhDGI8OCY5+zglvMUzSGtctH1lUQJ0
        DovwSGeSsaqtO8ypehOm4CU=
X-Google-Smtp-Source: ABdhPJzGoFNC9dRhfGTWg1ICAMpzBtAWKJIMTmXafbuUASfr2CPzKGyMCtpUDm+MjP43p4gMmFkysg==
X-Received: by 2002:a05:6830:19c2:: with SMTP id p2mr15950832otp.234.1624767417141;
        Sat, 26 Jun 2021 21:16:57 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id c21sm1170179otp.8.2021.06.26.21.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jun 2021 21:16:56 -0700 (PDT)
Date:   Sat, 26 Jun 2021 23:16:55 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Message-ID: <60d7fbb770397_b8dfe2087d@natae.notmuch>
In-Reply-To: <CABPp-BGko7BP6ZMyRKwKrv0xz7FM9ehe67HSAtzgHF9eV2TD3A@mail.gmail.com>
References: <20210627000855.530985-1-alexhenrie24@gmail.com>
 <CABPp-BGko7BP6ZMyRKwKrv0xz7FM9ehe67HSAtzgHF9eV2TD3A@mail.gmail.com>
Subject: Re: [PATCH] pull: abort by default if fast-forwarding is impossible
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:

> The code changes look good, but you'll need to add several test
> changes as well, or this code change will cause test failures.

Wouldn't you consider sending a patch without running 'make test'
"cavalier"?

> Thanks for working on this.

Such a completely different tone for a "cavalier" patch depending 100%
on the person who sent it. Weird.

-- 
Felipe Contreras
