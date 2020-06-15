Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9397CC433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 09:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 655412068E
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 09:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsX7pd8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbgFOJvu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 05:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbgFOJvt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 05:51:49 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007BAC061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 02:51:48 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id n23so18352770ljh.7
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 02:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5uCx5OH1ay1o1iCVTSpn+khexexoyBwKmeKWiIVED0A=;
        b=lsX7pd8+uBmYwcRAWdt/Q66BBHPWnQFgFohMGIAYKZVtN2njQ4FNdrESXxQJ1igQQK
         xKV2qSw2B9PGFJ4QkUJHBEWHsm9HddwqFLDPLiMaaQ/yMbhY0OQYkpepYG98afqddPPI
         WdJllD7GILk1Ep0VMBRZo+m0UNmhw2wtzAo1Rs+b6bapeRHneI7zoByGzbexd0PZQoBv
         yX3cP663G/4jPyQYzeSLs92Ata+B+7nW88lp9m55YhYMHr6tboTVM9hpI7oMnyixkxCn
         HaTwfSfOSPZ2RnbTeA+xaCcMmvakprz84CmILXkLotaM5APSceSyRlqIbfNGeOjHBhW3
         z4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=5uCx5OH1ay1o1iCVTSpn+khexexoyBwKmeKWiIVED0A=;
        b=bg/exzAuQCeb7QE3c71xHGS5NxwRoMT09kMe1VfEjb1MUE2/GtnLhBT8PIzPMjF3rv
         BtRcJWdO/HGv+YZmhz5QBAMO5NCl/Z2bft4l0RDiAhLBA1KYte7nlroD/ZyHzS0BauEg
         Ht3pqf3E91dn1OvHLk6rZJ5NtEolruRxrjqFWmVbTC1MSPovYRzgdC2pCObWbx8yBMkN
         vk86+57/vdXnQnYSWBRktxIFJmBkjRUwEUmJi3mg/UjmWGhiC9S8yXgpOXm8I8ijS2qZ
         CpTG6E9/rRP9KicpxGXpDz+aaVHiOurCaMKHPsiiYc5LuRvLDLe3ytlubhVwzJDYfQJv
         nmSQ==
X-Gm-Message-State: AOAM532mIoIB7TOXl7/fYtkCCj3SgpkSVK01Wn8qUP513bimth85o79g
        tE4ou99RP+r0dqz0MVoT8RE=
X-Google-Smtp-Source: ABdhPJzEXTQ/qjcYqKFqLtXiquvEOHXW7+75jxBTId5yI5S46GdmatzhqBRkIOi/YuPFQdDzN4jfSQ==
X-Received: by 2002:a2e:9816:: with SMTP id a22mr13144696ljj.129.1592214706621;
        Mon, 15 Jun 2020 02:51:46 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id j17sm10424lfk.31.2020.06.15.02.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 02:51:46 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     "Curtin, Eric" <Eric.Curtin@dell.com>,
        Christian Couder <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Geary, Niall" <Niall.Geary@dell.com>,
        "rowlands, scott" <Scott.Rowlands@dell.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Collaborative conflict resolution feature request
References: <BY5PR19MB3400EB9AD87DFE612AFD5CC390810@BY5PR19MB3400.namprd19.prod.outlook.com>
        <CAP8UFD3m9ANt6UOyOoMDy2haTJjhzL5ctFiki46ktgH3RLPqjA@mail.gmail.com>
        <BY5PR19MB3400AE170C9F5FF501D27B18909E0@BY5PR19MB3400.namprd19.prod.outlook.com>
        <432b9e0b-eedf-6d39-ebc0-0416f8574afc@iee.email>
Date:   Mon, 15 Jun 2020 12:51:45 +0300
In-Reply-To: <432b9e0b-eedf-6d39-ebc0-0416f8574afc@iee.email> (Philip Oakley's
        message of "Sat, 13 Jun 2020 14:14:32 +0100")
Message-ID: <87zh943bda.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:


[...]

> Also look at 'rerere'.

'rerere' is a superb feature, but isn't it local? If so, how could it
help for collaboration? What's the idea? Is there a way to share
'rerere'?

Thanks,
-- Sergey


