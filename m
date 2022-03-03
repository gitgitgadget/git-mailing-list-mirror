Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C45C433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 12:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbiCCMtS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 07:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbiCCMtS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 07:49:18 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AD7C7D5A
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 04:48:32 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id gb39so10444439ejc.1
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 04:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s8xr2R93KoRh6/abGxJWqQ0/2178oOM3ggR8JwnlcMA=;
        b=mCUL+uzzo4vBlSz2WwW+qir209QA9Nao/fh4pQmAYx+5SuSUsTCtaQ8SNeG5jH9KRI
         pU9N4SnuPyI1CKzxfdCyAUEGw2ubYTd6LDcOWjeXnfXhNu5pU9Xm3nr89gA7dTddPh2u
         KZtymooJ1ySIrxTuqGuTh2/ZoLVt5Dlurb5FQ7PhJ+ewJkeRn1P9yFUu7q09UzeKAeyP
         rXVoQeRaUH0B0BAni3MQ4Y4r9wTLk7JttPfJhixbGAwJHvgNLBeYuhmEGsXRj3Q7eNXM
         vMWLD+DGACN6NA9dO5omwTRZxGmfL/1AcswWbNlPRBncRbI4QhMUAKDGZw7RA8QNbXAS
         hq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s8xr2R93KoRh6/abGxJWqQ0/2178oOM3ggR8JwnlcMA=;
        b=cCHJbWLfCFeXpjfYaPqHTEwU35fp666mV2I/hVORmpYyNXBXQ2u5q15ctpLGhvni8i
         x5oikaz/WwSnEpZipjH3Sss3EJXkNhdZZ6UwaG/6lvj8q9pf7dOHlPo43gWJbdem4kKl
         8FLw3pdV3hOC6fvzzvTQoCkkVQyaj1Jvw55a5vKElZwx8O9Z2XjYVGncQjJ0JVQCkp8u
         37cwjlH2gUYVXPLfewtBpQAsKL3SeEM2MqnX9Fx4kzwMjPbwgSilRpJdKmykF14RLIpE
         Udu9tGhogr6LV6cMVmaizBBPTF7dnLXPgJAfyfJk3oAFrXNskeAMGWmQ9dJJREyvrlSV
         ALzw==
X-Gm-Message-State: AOAM531upFKe4yN8TtFj50BkwAZ67lNs1TFcTaAkSpD6HYsOJasZ0+9h
        rXThYwE2gSMVsf55uS8RYe60DDQ3GyeVVV7Gn7Y=
X-Google-Smtp-Source: ABdhPJxvWf4v+ex2H8+IACR70/Mrdna4vAQaWmVTjgTXRccHW2umlbFcwGNYTMjP3N22dulN7WPTFze18VkbQdOWYh0=
X-Received: by 2002:a17:906:58d0:b0:6da:9e79:38f6 with SMTP id
 e16-20020a17090658d000b006da9e7938f6mr854025ejs.471.1646311711158; Thu, 03
 Mar 2022 04:48:31 -0800 (PST)
MIME-Version: 1.0
References: <220224.86o82wab31.gmgdl@evledraar.gmail.com> <20220227122453.25278-1-shivam828787@gmail.com>
 <20220227122453.25278-2-shivam828787@gmail.com> <177b8b40-9e27-5019-c4df-772642508c37@kdbg.org>
In-Reply-To: <177b8b40-9e27-5019-c4df-772642508c37@kdbg.org>
From:   Shubham Mishra <shivam828787@gmail.com>
Date:   Thu, 3 Mar 2022 18:18:18 +0530
Message-ID: <CAC316V7s5xQWP13YrwSV3ekt8T5oAWxpkmXTBsjff7C1KFrHyQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] t0001-t0028: avoid pipes with Git on LHS
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 27, 2022 at 11:13 PM Johannes Sixt <j6t@kdbg.org> wrote:


> We see a pipe here, and in the upstream of that pipe is a git
> invocation. That should be fixed, too. After the rewrite that you
> already did here, it should be sufficient to move the git invocation
> before the parentheses.

I missed that pipe, Thanks for pointing it out and reviewing.

Sorry for responding late, I am in the middle of my exams, so I am
hardly checking mails.

Thanks,
Shubham
