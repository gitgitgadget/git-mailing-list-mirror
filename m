Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E28C433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 14:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 574AB61445
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 14:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240633AbhD2OeH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 10:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239032AbhD2OeD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 10:34:03 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77222C06138B
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 07:33:15 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l10-20020a17090a850ab0290155b06f6267so4880091pjn.5
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 07:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=e7jjSuhp9wWfjNNPu6Se2giu835LumcKpQZPcFosxgc=;
        b=JyEl9dhKu0IWH0KTN4u7gWowiMp7fpdfRPclOm/BbWS3QpH3wR9Nvri3kgPoJrfd3C
         MuKksllNk4jAJTDggwHmZ27EF6dBqi3buAogNZXBa7L+3KcU+mCU6ZdEsrIHU6TjV6es
         FtWyMG+TPKYaM6zWRVSZWrFaM8ZHpbxx0KGSGf4cws4Z8xZ/J2scgOnmgMTWB1KXu+jn
         qit14dmAwSnjm8dlUAO56h1rjqHDxQS8XPjFbp1gN7pXm06dJ/Rd82oXj5KMZu+/11Tp
         YikiV5Zz/z0eLHLCxokCwq0nIUdPAXCJDNIBFedEBpHAr1uF0aPIck55mPXT9kIDHfrD
         mmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=e7jjSuhp9wWfjNNPu6Se2giu835LumcKpQZPcFosxgc=;
        b=Z8GtITr5P/pQt6lO7EBQE4OdEHv6FELL7kqpVeJuOQAxzMBDL5Uq4YJngvQe5Yqsvu
         GQGCd4sq4jTg9dzEfpLgQB6iJrn/F506AdYeMDPWcyj8KbCE7UtE5KoqUcDF+U3G/ekq
         X2OXscy0Nlp6z95MTD0YkBc9DUy7HYeM3vbVwRPm1y1a0rp28r9VFfMLmgm6Rew0cWdi
         I5hQa8jePMnxT+tU5QnjqsMiW0H+ITgsa/svle6Y7LJCmqz028LAALPk+4u1mdDsUttR
         VC0cQ7a4UcdFJgezw+gPwpgD9Bqr25uD8kBHJbMlWy//rcDa0nWTr4CAZv8Zfa5VkUGM
         8bHA==
X-Gm-Message-State: AOAM532DLoJ2cso5QqDvuCjPqWu6lOTVoD0buh0UAQsLQgg7Sq2GCR79
        HHLnNbFJTVjIvvLkWcBwE7T6kTTv+238rg7kF/mwO9RidWyPQMNyFwQ=
X-Google-Smtp-Source: ABdhPJwcMMb/jLT/EZ4ljLFOt7YLtaBTc52T1CIvao2msBCT8Fo5EJrKB3ODnu36oT7pDn8nigNg0gTasZcF8srRjTQ=
X-Received: by 2002:a17:902:e843:b029:eb:8aff:360 with SMTP id
 t3-20020a170902e843b02900eb8aff0360mr35878146plg.1.1619706794808; Thu, 29 Apr
 2021 07:33:14 -0700 (PDT)
MIME-Version: 1.0
From:   Yiyuan guo <yguoaz@gmail.com>
Date:   Thu, 29 Apr 2021 22:33:05 +0800
Message-ID: <CAM7=BFooqCo3vn+yy6uM26szZDAcbx8M=sZS1znucJvHRbtxHg@mail.gmail.com>
Subject: A possible divide by zero problem in read-cache.c
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, git developers.
I have found a possible divide by zero problem in read-cache.c. Here
is the trace (with links to code location) for triggering the bug:

Step 0: (In function do_read_index) [ link:
https://github.com/git/git/blob/311531c9de557d25ac087c1637818bd2aad6eb3a/read-cache.c#L2216
]
      nr_threads = istate->cache_nr / THREAD_COST;
If istate->cache_nr == 0, nr_threads will also obtain 0 value.

Step 1: (calling another function load_cache_entries_threaded with
nr_threads as an argument )  [ link:
https://github.com/git/git/blob/311531c9de557d25ac087c1637818bd2aad6eb3a/read-cache.c#L2247
]
      src_offset += load_cache_entries_threaded(istate, mmap,
mmap_size, nr_threads, ieot);

Step 2:  (use nr_threads as divisor, leading to possible divide by
zero in function load_cache_entries_threaded) [ link:
https://github.com/git/git/blob/311531c9de557d25ac087c1637818bd2aad6eb3a/read-cache.c#L2103
]
      ieot_blocks = DIV_ROUND_UP(ieot->nr, nr_threads);

Please let me know if you think this bug report is genuine and worth fixing.

Thanks, Yiyuan

(PS: this report is originally sent to the security mailing list.
After some discussions, it seems that it is more appropriate to post
it in the public list, considering its threat level.)
