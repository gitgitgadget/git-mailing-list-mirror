Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B571C2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 07:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09927611C9
	for <git@archiver.kernel.org>; Tue, 25 May 2021 07:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhEYHFd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 03:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbhEYHFa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 03:05:30 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F206C061574
        for <git@vger.kernel.org>; Tue, 25 May 2021 00:04:00 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id i5so22019738pgm.0
        for <git@vger.kernel.org>; Tue, 25 May 2021 00:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=O3r3ZNtWXlvUh0i0eFH++KEHG4oCr4xpyPJP0oSzhUs=;
        b=rMos27Na3wvW0xt7wnZbcTeG2h9E/iASSArbhrHIedQFUAq4mDbGjbiEgMqNWmM2wa
         kymhXEHnuVvpVYiglZ0W/t+X28E/T9qhzbbhlPOkSuEG79oX+6CeITe9B8b4XFISqmv4
         +pdvk8q868DRuiIXpXOjq6zgJYdBzsTdkkKVkJo+egniZpBAMa5Lyr+bZT+VEwNZZeV5
         Nxv7hSNUvFbkf/nKpPQHYJSgbPnMnPz29+WZ+pIwV26bcIS2QXfuyiyQnVIMReoqrw2m
         WToKVU8Ev62XrsBbNv96qN2qngFifc3hj3L0qmLKNIXBJmYN/VsDnNbk8twmxPzqBecc
         eqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=O3r3ZNtWXlvUh0i0eFH++KEHG4oCr4xpyPJP0oSzhUs=;
        b=npq2y1yXO5zA6VcqXbf0BrnHD4dCX3fHnyTnhYTPwYGN/T16N1Bp/pYxYhqb9w0nFF
         Kz9Vj0nOmCQgH0WVcMbzEukHz0a9+9RjKN1bkkcUSvVPWdNpE2SYXFfD+Diy0nVc1RHB
         t/YxfvxHBgqZOpR2nY1BBiHtFlvEZ1Ik8WFk8jSeTm2f9Vx6aZM+SAoBOYPNVbn8vkd9
         zJ1XaSExEtQ4RHMeOOUqSA7EkEknzPVHRHaNCpQjxjOYulZD5U/8qFMODACSH3IDOB3L
         Hni1riQR6DWp8OTfwkhxTctasB/IJp3w1T4+bsrp3MBOE6TWUh5GEAGCDxhUDrpdl7Of
         PJ1g==
X-Gm-Message-State: AOAM532t5Ok1HMbXfjF+yGf+JcIu3cDcTgJ4/+xGqkDANk5a9x49o2mc
        V0pyorXiJx0/DfwnePHeg1B9sU57RI95Xg==
X-Google-Smtp-Source: ABdhPJy1HkPSn5HEmXrX7Ie5HpPEE1wYUqRPHvD+RvYW9nezaj5hJEPgh1nuzQH0unL5fUiU7oIq1g==
X-Received: by 2002:a62:148e:0:b029:2e4:e5a5:7e33 with SMTP id 136-20020a62148e0000b02902e4e5a57e33mr20491991pfu.9.1621926239243;
        Tue, 25 May 2021 00:03:59 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-75.three.co.id. [180.214.233.75])
        by smtp.gmail.com with ESMTPSA id m2sm13208531pgu.85.2021.05.25.00.03.57
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 00:03:58 -0700 (PDT)
To:     Git Users <git@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: git status when merging non-conflicted 3-way merge says "All
 conflicts fixed"
Message-ID: <79e26cee-daed-d52b-76d7-692f5cb2e20a@gmail.com>
Date:   Tue, 25 May 2021 14:03:56 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Supposed that we have following commit graph:

----A----B----C----D <- master
               \
                ----E <- e

When we merge e branch by `git merge e`, obviously we will do 3-way
merge. Assumed that the merge doesn't conflict, Git will fire up
editor to edit `COMMIT_EDITMSG` for us to enter merge commit
message. Then we abort the commit by either delete all the lines
there, or comment all of them.

But when we check status by `git status`, Git says:

> On branch master
> All conflicts fixed but you are still merging.
>   (use "git commit" to conclude merge)

That message above is misleading, because we know that our merge
doesn't conflict (3-way merge applied successfully without conflict). 
However, it makes sense only when we have resolved all conflicts
on the conflicted merge.

So for non-conflicted merge, we can say instead:

> On branch <branch>
> You are still merging, and the merge applied without any conflicts.
>   (use "git commit" to conclude merge)

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
