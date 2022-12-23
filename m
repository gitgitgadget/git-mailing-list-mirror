Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A1CC4332F
	for <git@archiver.kernel.org>; Fri, 23 Dec 2022 01:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiLWBvy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 20:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLWBvw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 20:51:52 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF5C6566
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 17:51:52 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so7468489pjr.3
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 17:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hsmmq5bhWd0pTupkDupZv7SiBbtiyNHvz67bJ/xfZTE=;
        b=iqjPclm2Pcz6eyedPsCVXQBJbB7MMVfLMYZ1WK6BBqjS3iksB4pSsdiLBkQg4wFK1F
         qHp9Ul4u0e9M3gtpZCcdpQxLXOzaSrC+3Ree/cMFPIIgOZnS2hpEiy/p2wJB2WRrkvLD
         d4uUEN8nIZBFtmKWjVdf7tisKxsj5VbYyjZpCEZIaoe0Q3qcJSqQAz0lWWw8hSNXC3MK
         E5OpAgSrfg28iTn8f5FDkOY2Isqc3Y77TL8tMCZ1ELik33FxQ+6ZdAhSySSo6M4fhnX5
         dj8QJfnpX8nkNLR0lAsvs9Eu0lWjOVhKCHi9eBrgu8djwBJeLKHgJSh4gGGYjLMU3iZx
         5WZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hsmmq5bhWd0pTupkDupZv7SiBbtiyNHvz67bJ/xfZTE=;
        b=ZIISk28bD9tqxlxstza4Ace9XJMUnxZYnWrsRHtLoCHrdgGMGE5whg7iGXxwWsjNUw
         mti8Pee0K52Ws01f/z2HtUxQ5YYaxb1Q27ZefQRsXzmnmYgpTtYDez+QpoD5EvScNRLa
         Bwl9ueqsIT8VJFypecbI18W91Zkbw1B7kUInVAY6P+ze9HdDmTc6wH+JvUp306MjVTL4
         WwU4tKVAj1zp4wLojFRpYmh1NyZA6dIENZiR0QrHlplbe+4iMWQ6I92OoA0AkSFdV3V0
         isiJjYRtZrwy7exQqinmfjYHOUbhCtpM5tQAKt2sVAdPsbHUnamuGna9La8xvQptDEXl
         S2Qg==
X-Gm-Message-State: AFqh2kpE7nH6bYSp2yykkxAlmw5PRW+gJb6i1VwVo8KgZniD1zo+pFMu
        V1Pai6EJ/HJ5Ov4Ul4WH//c=
X-Google-Smtp-Source: AMrXdXsdktQCeLVQSuPH0bqTu0ZYCXuPVsieE+2lg8py2GxZvGtOvcctkpj3icWhfmt/UnhuV4JOkQ==
X-Received: by 2002:a17:902:f392:b0:189:d8fb:151f with SMTP id f18-20020a170902f39200b00189d8fb151fmr6658532ple.23.1671760311526;
        Thu, 22 Dec 2022 17:51:51 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902c1c500b001891ea4d133sm1192250plc.12.2022.12.22.17.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 17:51:50 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Seija Kijin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Seija Kijin <doremylover123@gmail.com>
Subject: Re: [PATCH v9 2/2] prep: reformat pthread.c to fit coding guidelines
References: <pull.1406.v8.git.git.1671724911188.gitgitgadget@gmail.com>
        <pull.1406.v9.git.git.1671729453.gitgitgadget@gmail.com>
        <4c82a16a9950b67416530249157332a6b2afa839.1671729453.git.gitgitgadget@gmail.com>
Date:   Fri, 23 Dec 2022 10:51:50 +0900
In-Reply-To: <4c82a16a9950b67416530249157332a6b2afa839.1671729453.git.gitgitgadget@gmail.com>
        (Seija Kijin via GitGitGadget's message of "Thu, 22 Dec 2022 17:17:33
        +0000")
Message-ID: <xmqqa63erio9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Seija Kijin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH v9 2/2] prep: reformat pthread.c to fit coding guidelines

I am guessing that you meant to have "prep" stand for "preparation"
(which by the way is not a good thing to have instead of <area>:
prefix).  Perhaps "windows-pthread:" or something?

In any case, this step should be done first, i.e. [1/2] of a
two-patch series, as a preparation for the real change, I would
think.

