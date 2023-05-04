Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC3DC77B7C
	for <git@archiver.kernel.org>; Thu,  4 May 2023 18:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjEDS0j (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 May 2023 14:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjEDS0g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2023 14:26:36 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E216176BD
        for <git@vger.kernel.org>; Thu,  4 May 2023 11:26:34 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f13dafd5dcso984286e87.3
        for <git@vger.kernel.org>; Thu, 04 May 2023 11:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683224793; x=1685816793;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0XUKqpJ4Qs65pRyzGJB2md1m5y2FPw/J7zBDOqBH2Do=;
        b=IMQ4dTltyhKvD0zliEk2+U84B1qfcVrWB48b/c4L8MKq0iyUUSaVcB1MHfO4hWnAI7
         zXqWFBOUQuIR7AW588SqupiPgb4sdnkMPhyYrtTEdTbrGYFHKw5qlWu4rLEx5y0V8hcg
         p7fY6wQ0i1PZsSjH+a3mLsT8FoWd4QKjiJjq7nC5Q+1hBm52U0RBEpVXohegloZbOTuy
         zjPyLJiyifxoievAmKaecqt7OwZhNZaIOvhL+pS+iqjs1SJS2A5zwhA2T11homMUq6xS
         lhzVfJ3WzbYR3X1cdbUgxDt0raTpKZO5iMloS9woj9ngd8nWVeRm6TPkSafrEw0SHRCO
         FS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683224793; x=1685816793;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XUKqpJ4Qs65pRyzGJB2md1m5y2FPw/J7zBDOqBH2Do=;
        b=jeL+YPS2W47ieLdyEBXw6Z3qk3Ellf3zP/MgTlNnDIWzgGOmYVfuRwbKJ7vm54rZBk
         uAtdwk5SYiT7C3a7tKNOZ7sVwwdTdv5lXxDCPmv78qwO4Mn++oakU+6LSApBhFJyR90g
         c+eAhH+NmGusrmMFZ090Gb9WIrLvJCaKUwxcMKaFVvL4WzsC67xRQctylSeQJIq5vlH3
         iE7tgrFmvCEo8rz1pSSjwOuz8VxwQnIoc4LNkU2RDATsr4ep8056SSKMu7q+NCOS2y0C
         7CXngwUmvIe5gipR6wDlNppjDWbdNLvuQRIkM9e6mJlZerkFs57FTQ/sGLhorQqz2Acp
         KMXw==
X-Gm-Message-State: AC+VfDydnjDVVFBUrD77Bja0vBKtPbRUFq+CKyqKwJ7v945nEJyyth7s
        WhGRgFfuQ5W3jCzz1KlS7KDJQa5tM/A=
X-Google-Smtp-Source: ACHHUZ4fBUuZsz0D1ZcDOnc/LvmOuJKKtImuKSK21QzrC8PNfdT4bbnrqBEgGuhseS1orqtUHc2v8A==
X-Received: by 2002:ac2:4c91:0:b0:4eb:c4e:bd87 with SMTP id d17-20020ac24c91000000b004eb0c4ebd87mr2121337lfl.58.1683224792650;
        Thu, 04 May 2023 11:26:32 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id x6-20020ac259c6000000b004db1a7e6decsm6577178lfn.205.2023.05.04.11.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 11:26:32 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t4013: add expected failure for "log --patch --no-patch"
References: <20230503134118.73504-1-sorganov@gmail.com>
        <xmqqsfcdtkt0.fsf@gitster.g> <xmqq1qjwj7go.fsf@gitster.g>
Date:   Thu, 04 May 2023 21:26:31 +0300
In-Reply-To: <xmqq1qjwj7go.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        04 May 2023 11:07:51 -0700")
Message-ID: <87jzxo3qco.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Sergey Organov <sorganov@gmail.com> writes:
>>
>>> --patch followed by --no-patch is to be a no-op according to the "git
>>> log" manual page.
>>
>> I briefly wondered if it is a bug in the documentation.
>> ... when "git log -p --raw" shows both patch and raw, I do not
>> think of a reason why "git log -p --raw --no-patch" should not
>> behave similarly.
>
> So, to tie the loose ends, "log -p --raw --no-patch" and "log -p
> --stat --no-patch" do behave similarly.  Where my reaction was
> mistaken was that I did not read the manual page myself that clearly
> said it is the same as "-s" that suppresses diff output (where "diff
> output" is not limited to "patch"---diffstat is also output of "diff"),
> and incorrectly thought that "--no-patch" would countermand only
> "--patch" and nothing else.
>
> In Documentation/diff-options.txt we have this snippet:
>
>     -s::
>     --no-patch::
>             Suppress diff output. Useful for commands like `git show` that
>             show the patch by default, or to cancel the effect of `--patch`.
>
> I imagine that argument could be made that the last half-sentence
> can be read to say that the option is usable ONLY to cancel the
> effect of `--patch` without cancelling the effect of anything else.
>
> But that smells like a bit of stretch, as "like" in "commands like"
> is a sign, at least to me, that it gives a few examples without
> attempting to be exhaustive (meaning that it is too much to read
> "ONLY" that is not written in "or to cancel the effect of")..
>
> Here is my attempt to make it tighter to avoid getting mis-read:
>
>     Suppress all output from the diff machinery.  Useful for
>     commands like `git show` that show the patch by default to
>     squelch their output, or to cancel the effect of options like
>     `--patch`, `--stat` earlier on the command line in an alias.

This is fine, but is irrelevant to the test-case. Please refer to my
answer to your previous reply on the issue for details.

Thanks,
-- Sergey Organov

