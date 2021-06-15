Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41851C48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 20:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CC7E611C0
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 20:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhFOU57 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 16:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhFOU56 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 16:57:58 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C615C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 13:55:53 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id og14so24750873ejc.5
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 13:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=f/KydaQBQlxh94PunHV4Vfy5ww0IPUR+urRpOC33OqI=;
        b=KScboVVvKW1bAb1Dz9sCJbK9gtxlG4cUtm1tJk4+0n434nAIioB6X1QlGPT5SKz7kT
         ryjLxMD1WhccrWfdQVTUzX0PSKmw+DmRE9xUwHqh5kM88hY9tuqtANDb+1TNlFDgR8hM
         JiZ929SkgZIo48izZyoxTw1J+FTuLW2VuEiciE+mmfE8YGeNM1ZLse9gNlY/x6G9VFUx
         t9W6e6mhoxMo6PsaSdHbz4wF28Q91xaI8YD5P0y0HO7bufxaRRLWm04QAg8JG3gJqTfj
         rUkDH3UBX8lXk8JKZVaL3Gzzykq9UkZHVectWCDRWZZjRnndi1tgxCHfB2M/GdPfuMtR
         U0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=f/KydaQBQlxh94PunHV4Vfy5ww0IPUR+urRpOC33OqI=;
        b=MaRc7vguxd2/qnQeMv7ug8qDp6q8L7R741uBZRYfsv/KhwaDB95aWXKdBGKG+o0epE
         XbC9rEic7sTndj5zGZi0Cw5MmrIZ4bYoeHYkFzJ/LIJZRl+SFObZHTGFeM61eDATO+II
         joF8zk2Rj1cv62yoYJdwH15TU4EeKKFzTXrEfzgw9kJcwfbWs+JBaAKT5fBgkWwCseDc
         scxWPpjfuR2Oe7lbq1SZHNw9h7set7Vc8Ouoysb1LB8BbfTMKas29pm+jB/2fiWjklsI
         +COi9ac011eBRrWAhcXEKMzrdBDnl6JR3/uTfPeNkLBjzmECVB8duDuj0/xHFS5NT9QW
         ZQaA==
X-Gm-Message-State: AOAM530iVWIj4sGX+plxwhguFGBHcF97LUUT4imTC4phFwMOvi3yePNW
        so8NR7GJvbScE32WN46hkno5Qx/F+lHBmX4+OkA=
X-Google-Smtp-Source: ABdhPJwPrqMBbvlBtiiYVfc1WFidvNRkR6PLVn86gQ9YWul3/K7pYuozd4CcYNBWHT/n7RNhQRDbkg==
X-Received: by 2002:a17:906:2ec6:: with SMTP id s6mr1492609eji.65.1623790551717;
        Tue, 15 Jun 2021 13:55:51 -0700 (PDT)
Received: from [10.19.18.14] ([212.102.57.84])
        by smtp.gmail.com with ESMTPSA id y1sm74400ejl.7.2021.06.15.13.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 13:55:51 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
Subject: [BUG] question mark in GIT_SKIP_TESTS is broken in master
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <1d003cac-83fa-0b63-f60e-55513ac45cf9@gmail.com>
Date:   Tue, 15 Jun 2021 22:55:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've taken an example of how to use GIT_SKIP_TESTS directly from
t/README:

     $ GIT_SKIP_TESTS='t[0-4]??? t91?? t9200.8' make

and noticed that t0000 is still being run.  I've written a script to
bisect the issue:


     #/bin/sh

     (
             cd t
             GIT_SKIP_TESTS='t[0-4]??? t91?? t9200.8' make | \
                     head | grep 'SKIP skip all tests in t0000'
     )


and it bisected to edc23840b0 (test-lib: bring $remove_trash out of
retirement, 2021-05-10) which was merged to master in 2019256717 ("Merge
branch 'ab/test-lib-updates'", 2021-06-14).

Note, that spelling out the tests number in full works, i.e.

     $ GIT_SKIP_TESTS=t0000 make

won't run t0000.
