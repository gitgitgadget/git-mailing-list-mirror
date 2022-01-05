Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE1CC433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 06:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiAEGRK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 01:17:10 -0500
Received: from mail-pg1-f178.google.com ([209.85.215.178]:41703 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiAEGQG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 01:16:06 -0500
Received: by mail-pg1-f178.google.com with SMTP id f8so24627513pgf.8
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 22:16:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J1mKV7jqsAwt0ItICtE+ccfncgcSXxGFGmm6lzeo8c4=;
        b=hLzAUY9RrSkPhSHdw+XuxYSfo8MnS+2M8WvOy/oGLHtm/mQVweTg5IGnAkFZGS3X82
         5e18rERThMJvBahCQVOOSj6KPgub7xig3jV1Q2qmhgNwh9QMZwd1LErxc+w8UHqq3HuX
         zMioSjxNZpKLQ9TBjBuACx/rX56wjV4928WCcvjSMwY5qS4rfVN2hq/QUsL30CftKI63
         cT6kps1ItkWlvnJIdXJX4EIc/Ob/NgDocauR4s58+XRMrYxxkvZLLfmyAcP5UaLwDNvF
         T3/qxiYn6dTQRGukpTC74AsHlerGYnYoNRMm1+sOHZz+7JwozSpyZMt+6b8WVXUt0kN1
         k4JQ==
X-Gm-Message-State: AOAM531Sc3JeeKkXTx6yDxCHKBI8DblxhuK+n0XidaUM2dlJFR9eZaoH
        bmKpbZ6M7xZ4P6gowbszs+qaft4IdwnDZffJW8z3QF2yNSJU1w==
X-Google-Smtp-Source: ABdhPJylqXVCS8rVzyqcJ7GcvCnyz4h2JfnOpjZ7gj9oxSmNaNvf82WBFtDyeK/aJeXf2e0WOR2+SM25GcKB3Ge5Y00=
X-Received: by 2002:a63:395:: with SMTP id 143mr47320037pgd.181.1641363365808;
 Tue, 04 Jan 2022 22:16:05 -0800 (PST)
MIME-Version: 1.0
References: <CACEm96jjWALB=iPiBNr0P5HrX9Oo3bXm_k1PpxsHm4Ns9M-vOQ@mail.gmail.com>
In-Reply-To: <CACEm96jjWALB=iPiBNr0P5HrX9Oo3bXm_k1PpxsHm4Ns9M-vOQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 5 Jan 2022 01:15:55 -0500
Message-ID: <CAPig+cRhBg9fvAAfzQUrPKqyFKoBtx7GQoiwpyaQr0bajBvfHQ@mail.gmail.com>
Subject: Re: Stash Apply/Pop not restoring added files when conflict occurs on restore
To:     AJ Henderson <ahenderson@datto.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 5, 2022 at 1:08 AM AJ Henderson <ahenderson@datto.com> wrote:
> I have had two developers have this problem 3 times.  When they are
> doing a stash push with newly created files and old files, when they
> go to do a stash pop, if there is no conflict, the files show up as
> expected, but when there is a conflict, the modified files are
> restored (and placed in a conflict state as expected), however, the
> new files are not restored.
>
> We are able to work around this issue by grabbing the files directly
> out of the log for the stash head, but are unsure why this behavior
> isn't working as expected.  It seems to be a new change in behavior as
> we had never previously seen this issue, but have seen it 3 times now
> in the last few weeks.

As a follow-up for anyone who comes across this thread in the future,
Elijah posted a patch[*] to fix this regression.

[*] https://lore.kernel.org/git/pull.1180.git.git.1641337498996.gitgitgadget@gmail.com/
