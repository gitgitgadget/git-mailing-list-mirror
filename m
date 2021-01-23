Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_A1,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_REPLYTO,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1125FC433DB
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 23:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAAAE22CB9
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 23:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbhAWXQl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 18:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbhAWXQj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 18:16:39 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2441DC0613D6
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 15:15:59 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id z6so7055755qtn.0
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 15:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:reply-to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=5OaE5KN21xPjJh5WZpIDEux8dSnhpw/a9kn3mwx0pY8=;
        b=TAV0KGhIm1ptyC7ux6kNYRUDtwoRzhZK9U02oA5N59dQefneOIDyrJOF27qv+OICm1
         IOKJJKK/B2IFmAXItEi7jpF2WjznXs37M6VoVXwsznhnhXqN2bCtf3Wm/0U3iher7nnb
         GkanOXwobPcGJFR/itNszQHVwV6dPDH+gKolv539Q9fTCrfZ1pkXeWckwkpVxK7nPIER
         hWXv5QuZovr5zf2xh1H6Y2Igp2gsXmSowoozL7E06j1HfYxZDsmqd/DKDu7cH7ElDdVB
         jJMODpvjZg8GXCm5HLK5w79DSvD8tBi/ZhJ76AyS8UgFmN/VGLsK/e6X3r7qhW2IxncL
         sEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:reply-to:from:subject:message-id:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=5OaE5KN21xPjJh5WZpIDEux8dSnhpw/a9kn3mwx0pY8=;
        b=GB62I0n10Yhdu1qBCpPWg9GUhXlQGoqyHRdwkEzDrdzExqM+pjLHboKw5dFy53yVyz
         Jgd0FlR/ZRcbjx1bJpmdNl5d22qNAEy9A6gN/EBmyKLbrrmIt6sablvxiXnE3kZaqy+H
         2vKUlJ7c2gvKE1kXyUXfOd3Bcli97NnArOkf4kYN9iyDSLxYPi7hnMYK8neNwQbQbUXi
         0OXICjMsFhCgRlRoN/cLwUlYSSXexAAOaD7NeEdY/1Olv1sAG4MTstaQLKNZyjQ6N5rB
         DcH+tb68QO53ll+LKBHgX6FhMAyZmLj1DBbnLnrs3ba10V3qnTJDBUsJ40JAPSp9kIBu
         xrVQ==
X-Gm-Message-State: AOAM5321ovNAJ9mSfcXrNKca9iVZrfbU6LmkJzV0DGudCNQeJvUBCL55
        4vbCfm56BcXP3i3qvBJ/MTc=
X-Google-Smtp-Source: ABdhPJxV4BE/cNk5um5lrDwyuxnQVD+ImfF84ni2jMqpwNHfPRCY5ERI/2/3WYZzbtDB9UWBmMybfw==
X-Received: by 2002:ac8:c8f:: with SMTP id n15mr1019426qti.351.1611443758335;
        Sat, 23 Jan 2021 15:15:58 -0800 (PST)
Received: from [10.88.111.17] ([205.175.212.203])
        by smtp.gmail.com with ESMTPSA id a129sm4283013qkf.95.2021.01.23.15.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jan 2021 15:15:57 -0800 (PST)
To:     gitster@pobox.com
Cc:     phillip.wood123@gmail.com, peff@peff.net, gitgitgadget@gmail.com,
        git@vger.kernel.org, agc.klotz@gmail.com
Reply-To: xmqqpn6ilwwx.fsf@gitster.c.googlers.com
From:   Andrew Klotz <agc.klotz@gmail.com>
Subject: Re: [PATCH 1/2] config: improve error message for boolean config
Message-ID: <5f00282b-2e65-929a-5331-df50c4a8d8cc@gmail.com>
Date:   Sat, 23 Jan 2021 18:15:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the feedback,

I updated the branch and moved:

  - boolean error message change out of git_config_bool_or_int to just 
in git_config_bool

  - added die_bad_boolean instead of modifying die_bad_number.

The advantage here is we only use a bool error message when we know the 
value
is a bool. Is this more along the lines of the suggestion?

