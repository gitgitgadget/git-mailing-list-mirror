Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2092BC433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 15:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D276961481
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 15:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbhBAPwr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 10:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbhBAPvy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 10:51:54 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52545C0613D6
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 07:51:15 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id t25so6596371otc.5
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 07:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZHVCd5iSbzrAmVbDuEdnCjZiu2FtSVA8IlGFWlcGjf0=;
        b=lbktc9VTA04ZGSw0BJ44GVL1YdhFAWVQcEjbuZcyZohNIXtp5Q0Opx2IrlWOvArUtY
         GCM17OeKU0ZC6GzZSQBRMayP1PAJnA5067fJNCmcWeVqnPYfZPkvmHMDo4qSKkUsSVuO
         vkg4gfWDmkvh/GTNSq/bfiH8j+WuDiv7jOkMAuI4Eoh7xjJaBhXIBa7aLgtOUdkd0Dpm
         XSEUrCq9KKphB6H1JX11Rppei3+tvNRVybKSMSbrUaqGHKwwg6m3c+acCBtRQg61eMvL
         lYtC58kqHlCZIuDxJF66pQB0il303Rx4K0++gkBypUGFsAEe+QSNU5hIk0h/sVqyZxx6
         Cf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZHVCd5iSbzrAmVbDuEdnCjZiu2FtSVA8IlGFWlcGjf0=;
        b=kaWrVKL1dwJgFknZn1oHxQuxqn6zleqgMyukNba9eOa+vPoRfsTxF8kI8FFmXlFMF2
         81VsYrjKREHwvbZJd+l8rf40LxFoTjbvk8UrvBmGyH2iDi49Jfc3Op9QKt12mD9OyVm+
         xuevq4knw7HB5gydRLyFDWTXdD3WNgR3iGOZDq8Y25XdD60sPSZwkd5RTjHIXON+38/n
         qHYvP7ZWQI0bjQB5ibgNSqUGmU4oKeQO0wsYGuI4YZiP3L4B/5lFb2C7mkODnBo2hzm7
         oDyTYHnuqQyo6DLe2ECp/V57NorECmxHL/7CUyBWei8hd8n7Nj/MnKRCyZags/jdUKqs
         5kRg==
X-Gm-Message-State: AOAM531/F42HRlRDvUuefnsMlz1KWqheMpqAe20ZCiSS6yIw8TS7+T5T
        QoYAr+Td1hHD3wnpfMkxadtGtb7GlHe0ijZ3sTUUXwoAfPFZMQ==
X-Google-Smtp-Source: ABdhPJyiwkbISuJwAY6+wHE1hDJD/rov50Pl5NFe9eNE7QTRhUd6skCtKRievMBCEKv4al2t0eG8KAYD8aBvb/Ui7iY=
X-Received: by 2002:a9d:313:: with SMTP id 19mr11878063otv.147.1612194674760;
 Mon, 01 Feb 2021 07:51:14 -0800 (PST)
MIME-Version: 1.0
References: <xmqqsg6infev.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqsg6infev.fsf@gitster.c.googlers.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Mon, 1 Feb 2021 21:21:03 +0530
Message-ID: <CAPSFM5fLcSBmcGTLaPuoKKHO0qv3fKB5q-XvXv5emWfLYpFv=w@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2021, #06; Sat, 30)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 31 Jan 2021 at 05:38, Junio C Hamano <gitster@pobox.com> wrote:

> * cm/rebase-i (2021-01-29) 9 commits
>  - doc/git-rebase: add documentation for fixup [-C|-c] options
>  - rebase -i: teach --autosquash to work with amend!
>  - t3437: test script for fixup [-C|-c] options in interactive rebase
>  - rebase -i: add fixup [-C | -c] command
>  - sequencer: use const variable for commit message comments
>  - sequencer: pass todo_item to do_pick_commit()
>  - rebase -i: comment out squash!/fixup! subjects from squash message
>  - sequencer: factor out code to append squash message
>  - rebase -i: only write fixup-message when it's needed
>
>  "rebase -i" is getting cleaned up and also enhanced.
>
>  It seems to break t3415 when merged to 'seen'.
>

I fetched and built the 'seen' branch with merged patches[1]. After that
build all the tests, but at my branch all tests are passing.

Also, I looked at here :
https://github.com/git/git/runs/1803017766

It seems that a lot of tests are failing in macOS. Also in the link t3415 test
is shown passing.
As I have tested on linux/Ubuntu. So, I am unable to get how to figure out
why the tests are failing. Or maybe I am missing something ?

Thanks and Regards,
Charvi

[1] https://lore.kernel.org/git/20210129182050.26143-1-charvi077@gmail.com/
