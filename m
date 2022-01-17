Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A7BC433F5
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 22:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238297AbiAQWHz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 17:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbiAQWHy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 17:07:54 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46ACAC061574
        for <git@vger.kernel.org>; Mon, 17 Jan 2022 14:07:54 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id f24so17347924ioc.0
        for <git@vger.kernel.org>; Mon, 17 Jan 2022 14:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4urwuBjxeDWBPNp0sDUF+9WPee4XZnIGRowXBAK7nxE=;
        b=cXuXk5KjRhfYvAC9rZbJbUo44AKYbPx6fLB8xUyWz659obhe4dCOOzv1kgtWr1V2US
         uscYbztqFsHKJZD02tFnXFh1fAuvVPByk7hOJu+3g11vt6daas1O5++AswBurRzslVUB
         5IcxIJ+FqtJ3qXEgR5CnqIdxXu+dUt46jKbt9uR+D9F55vnHt7xajFhf61OU5LvSh52A
         dm++Zvd2/uAgiOjKLkVteMokhRliXR12+9wKQu+fxG7kb1mDc5/sTRMulzdWaX7GL5rD
         hilSE8PC9jlrFnpZFofh5cRkkjtseNX9/4dYitwXW9hPnyK1CevbyfA5hIE1uABw5WKX
         caqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4urwuBjxeDWBPNp0sDUF+9WPee4XZnIGRowXBAK7nxE=;
        b=Ze26Tcegkzj63uUbNHete1Mv5xoZd6yzzHtBoUGS/7/faST8TVB1Mm7nxMCPdKsSdu
         UDAqZiBiv137hllq1gHROLNGMhLZKRUCNRG2DdyBCN3LtkEaLp9yxIb/gMKjUQ7+2kM2
         GkRlgqVzV8m4TPnda8ZWkPyaxvp/f/b81T8kBrh9hzW6ISrez7sTsnmr3ts89Yg7xIw7
         fCMgn8l3Oct/k/luCfUEd7cJf2eYWydQXCay0c7VtZ4RDB4UzrGOj6M2Qaek12kyj6pv
         ASxgHNoccR3lhP8Z+tti1YZmjmDImcAmtbzeY5XbdtjGjGb+NkAAP9syHzruxAF9YlDY
         ejjg==
X-Gm-Message-State: AOAM531Ie25gb6MfZTUq64Lh7LV2tL5Tc2H4MCNSs80ZmmGxK8NA2L5x
        1jVywzOJ2skOJYmeEia8nUt6iSwkOMDx8Q==
X-Google-Smtp-Source: ABdhPJy/6BgS/wIG4VmTo9PHoY92OBMHy/K9o2iIHQNOHbGhAQrz3hjV0xd2Qt5awgIRjnLmDrkSsQ==
X-Received: by 2002:a02:ca07:: with SMTP id i7mr9657008jak.162.1642457273535;
        Mon, 17 Jan 2022 14:07:53 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h10sm10245559iow.10.2022.01.17.14.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 14:07:53 -0800 (PST)
Date:   Mon, 17 Jan 2022 17:07:49 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2] merge-ort: avoid assuming all renames detected
Message-ID: <YeXotaZmqhkJaQr6@nand.local>
References: <pull.1194.git.git.1642212566346.gitgitgadget@gmail.com>
 <pull.1194.v2.git.git.1642443955836.gitgitgadget@gmail.com>
 <xmqqh7a2uphk.fsf@gitster.g>
 <CABPp-BF+eUGJ7FgMRG9vOUh8X5ExU+jkR3WHZeFGnKH80SO7gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BF+eUGJ7FgMRG9vOUh8X5ExU+jkR3WHZeFGnKH80SO7gQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 17, 2022 at 01:21:11PM -0800, Elijah Newren wrote:
> On Mon, Jan 17, 2022 at 11:33 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> > Thanks.  An Ack?
>
> Taylor told me the code change fixed his case, and that he'd review my
> full patch with the testcase when I posted it.  Let's wait to hear
> from him.

Ack. I can't vouch for the ort-specific details, but I trust Elijah's
judgement (obviously). Running a version of Git with this patch applied
fixes the issue I originally reported.

Thanks, Elijah!
