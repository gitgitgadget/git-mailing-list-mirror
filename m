Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2820C433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 22:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355851AbiBCWqK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 17:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiBCWqK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 17:46:10 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AC2C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 14:46:10 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id y17so3486252plg.7
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 14:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=M5JqpFde3neu9KS3YG9rSrMngAI2OcOjzNEMzM5Emcw=;
        b=jV2bZYjHGm4A5m8cUHN6U0plhUi99D0PQrn3hxMJgDgWTtVuFY1ie4PDQYLE47mHwx
         ynihA0SpQNQXgMhdBj0FrGj7rRHh++L91mNvS/M+CC1GUIA9PcPjx6DtUZPAYfaCFShv
         lCqLiiI/GEHW8MFUx4TLodBFQ2ZOm4AlObC0STWrrRrqOwSozu5S+qnd6ofrvfg3XJu6
         I/sgnXHTLXA5KEytm98l8O/QEfz+8587LwsKvdCqA29Tfc4Y9YUKWERXw3cdqsFaYPkL
         hgGyOLlRuwFJsapTvUh4FVZ7sImhZ7Zd/39M4SgKVT0zuUcMA2xIp+v9L93UAc4CWMNH
         rrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=M5JqpFde3neu9KS3YG9rSrMngAI2OcOjzNEMzM5Emcw=;
        b=5qGJhaN1LHmEgAG7wdSNqKbmcO8m698ZAD+uOqVQFJIiQ4AbM4jpuaoHYiJ+9NToEh
         FVXo8bBvR9QDh+FvYw541qKf/39t4fZHgmZl5Fm8dp6Bqt0yhH3fFVZiG1k5DMdKZUx4
         MbDVv7Pcq1r9j15e0kwalEFfTXeFi2x+ymi07fNGOyT9FFLoHQvhgXndFFGCT8zFMIwi
         JW4366gOy5AR6poClofG4cpkqqTuQjc/ClOUp4wntJ//JLkv4wsDR7zHm7gB2HMrIu5g
         STuYi8g8VzgsF/8oiu91eMrTaWS9xFE8ZiSEU2QlnAWAUP+BtN7Eik9yVuql5Ll7TJKE
         NP4A==
X-Gm-Message-State: AOAM532LI1H/KdaN/ihaHLX6nhE3nVRTOP2rhNqs6ddJo/zog+D2LGjV
        R3RI2ZFNVMcIwM1/+aD5xyQ=
X-Google-Smtp-Source: ABdhPJz9fEYVwccg8kKmq8vH/Ma+YRp3hFg6QZEOtTp17qwQtvEuiANuT7dJdBgthNJlEiMq6dRXGQ==
X-Received: by 2002:a17:90a:db90:: with SMTP id h16mr15849437pjv.66.1643928369486;
        Thu, 03 Feb 2022 14:46:09 -0800 (PST)
Received: from localhost ([2620:15c:289:200:b5c2:580b:9b41:56b2])
        by smtp.gmail.com with ESMTPSA id v17sm66074pfm.10.2022.02.03.14.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 14:46:09 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Fabian Stelzer <fs@gigacodes.de>, git@vger.kernel.org,
        Henning Schild <henning.schild@siemens.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Hans Jerry Illikainen <hji@dyntopia.com>
Subject: Re: [PATCH] gpg-interface: fix for gpgsm v2.3
References: <20220203123724.47529-1-fs@gigacodes.de>
        <Yfw0kapgSSWO3Pyx@pobox.com> <xmqqsfszr5q6.fsf@gitster.g>
        <YfxSCbmatoSZlTwB@pobox.com>
Date:   Thu, 03 Feb 2022 14:46:08 -0800
In-Reply-To: <YfxSCbmatoSZlTwB@pobox.com> (Todd Zullinger's message of "Thu, 3
        Feb 2022 17:07:05 -0500")
Message-ID: <xmqq8rurr2kv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> By default, yes.  The string_list struct uses strcmp() if no
> cmp function is given.  That's why the previous chunk has:
>
>     struct string_list lines = { .cmp = starts_with };

Ahh, I missed that part.  Sounds correct to me, then.

Splitting only to iterate over these lines sounds wasteful to me,
though, since we do not need access to these lines only one at a
time and there is no need to keep an array of them.

Thanks.

