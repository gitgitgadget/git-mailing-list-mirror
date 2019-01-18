Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CFE51F453
	for <e@80x24.org>; Fri, 18 Jan 2019 20:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbfARUnB (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 15:43:01 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51471 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729459AbfARUnA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 15:43:00 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so5730070wmj.1
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 12:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EowA41eeLj4EvTYfEbreWOHcoSHiGqv6+uEzRwFG/K0=;
        b=VuUBHV93V3+u5zcreoXyHse83Oxn7MTvZDVxgNZreb3513iaIhFXJHeVl9wnOeLYm0
         76chVXFqqvkcrmp66E5umvgl4N28Lv+Lq/aWdmti3YCOLuFN33qvK3q6Cz1djQRaSmtT
         d28RElPDuB1Nv+U81WHZSZOaWnrqCaxaYiDfjeCzHK5hUQwdxQDL4Xo4fU7Iz3GWc0K7
         diEpxi5fwvMzWze4WT50+6wfk9EzwcisoP0p3hxpm8/KcI/xM21MmLfLihw+cA73b+sc
         dBsqj16hvM/U0XTaQ/5/SrLgBHniBPL7Evp76iPjowL7KKtfQeok4TwDZFq0cYhzBRKc
         VbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EowA41eeLj4EvTYfEbreWOHcoSHiGqv6+uEzRwFG/K0=;
        b=DOXuqvp0mLlUSCDiz+oC3D0tN8FNAyXhZtcLmso9JMgNrIJnrljBLZDtqytehgcZOy
         bTyNYeMXTuXTU1be9Rk3F6QIF4lAGFNboLIy8Q9/zyzvLqOmKx2HqgX0E0Tg649ZK3qq
         +tkQm+r/E2c8K08oRIPkmcPgdQzMQtaSH3mgRZo4KzkOINuV64NUl5zmXF9QyVc/OwfD
         QuCFnttOfciTscSPYSpAzcXjhtOISeO6LhlgOk3aXdFju0BPGjAKzDRyarecwIELoCJb
         PUkFEmefRrgLyqu2B34muUeOpzNgrD9YvFdbEoTi23+p6hAWjhRQV3AhjYck2o4Tceeg
         zBKQ==
X-Gm-Message-State: AJcUukcwjeGVf2DXW0o7GyMAkLjyCmg4QTqte4fJ59ZG8GFV8PlSpn+g
        khN7ixl51tB6CTyXifQt9F7EGy6c
X-Google-Smtp-Source: ALg8bN5LH8eOMIJlcWhhj3RWsQzHPqH870Dy6sDm18K7PA5vly14NIvLxdnDN+OnkmBhCSUq2ePUNg==
X-Received: by 2002:a1c:2b01:: with SMTP id r1mr16547359wmr.7.1547844178090;
        Fri, 18 Jan 2019 12:42:58 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y12sm27288321wmi.7.2019.01.18.12.42.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 12:42:57 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matthew Kraai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Matthew Kraai <mkraai@its.jnj.com>
Subject: Re: [PATCH 1/1] stash: fix segmentation fault when files were added with intent
References: <pull.110.git.gitgitgadget@gmail.com>
        <b5bbc7793c50991c7cb5a5188f53ccc3a14b23f6.1547805015.git.gitgitgadget@gmail.com>
Date:   Fri, 18 Jan 2019 12:42:57 -0800
In-Reply-To: <b5bbc7793c50991c7cb5a5188f53ccc3a14b23f6.1547805015.git.gitgitgadget@gmail.com>
        (Matthew Kraai via GitGitGadget's message of "Fri, 18 Jan 2019
        01:50:16 -0800 (PST)")
Message-ID: <xmqq5zulk88e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthew Kraai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Matthew Kraai <mkraai@its.jnj.com>
>
> After `git add -N <file>`, the index is in a special state. A state for
> which the built-in stash was not prepared, as it failed to initialize
> the `rev` structure in that case before using `&rev.pending`.
>
> Detailed explanation: If `reset_tree()` returns a non-zero value,
> `stash_working_tree()` calls `object_array_clear()` with `&rev.pending`.
> If `rev` is not initialized, this causes a segmentation fault.

It is a bit strange that the paragraph for "detailed explanation" is
shorter than the paragraph it attempts to clarify.

Dropping those two words "Detailed explanation:" easily fixes
awkwardness ;-).

> +test_expect_success 'stash --intent-to-add file' '
> +	git reset --hard &&
> +	echo new >file4 &&
> +	git add --intent-to-add file4 &&
> +	test_when_finished "git rm -f file4" &&
> +	test_must_fail git stash
> +'

This still must fail because an index with an I-T-A cannot be
included in a stash, but test_must_fail will make sure that the
command does not suffer an uncontrolled crash.  Good.
