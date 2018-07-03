Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1A8B1F85A
	for <e@80x24.org>; Tue,  3 Jul 2018 19:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752789AbeGCT5t (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 15:57:49 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:54707 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752734AbeGCT5s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 15:57:48 -0400
Received: by mail-wm0-f49.google.com with SMTP id i139-v6so3518897wmf.4
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 12:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BF8jcqBWvh/GwzU24EihUC72MRuQKdLBsei4wBDGsxk=;
        b=MtviEKp4IrXMCCOFbvt8+u3UcoLso6QLEAeYJANzlyiS9t2aXogK0b1e8e3zLT9CjM
         lQuFJ0WbeFMq/keXfCaF15ml7O0+42UAWpD3BYMn0BLMTVKqQ3XWeSjcpAWu0i4rScdS
         kl2f+nzVs66c5OSwI1X4sfgBZjyJCwfqWmem1HuqZvHiKuj4NkqWdYfcLB67BD1m0Gre
         tvduqCSTybL+X1x626o3hmQwV+FNII6OiClpHYN4IdAtA75ss9osRySVwE28ij15nPV6
         HqidbmL4oH4i5DI3aVRGTe6Y6BQFmpeLYdXra21IvLAfeUzlbIIgfGKido11Hl+TzK/7
         IRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BF8jcqBWvh/GwzU24EihUC72MRuQKdLBsei4wBDGsxk=;
        b=LrVxFlSCU+vZePGeuy748Hqfbp1Qz4Z7pIc7hFSRPCK/JN/skEq9ZoKoDt9vYDZmHC
         JePPl5PL5HsWxC7vjF+icKVJ5fSTIjGgsdvNaXtD/HPWBEdVVNW2yVV4BiD2eMRySItt
         NWx6xQKGSq4xiX4LQWPOchavYLOzHcNjdHUF6QzttvlvdB2TJSow3KSiRuB7uK9ucvat
         s4Hko5eK+rAov3NtHszevDiLf0HS4Nrd9ePwvktOxqDzey//Zyi+IoWweDTw26acjNRg
         bn0zGFmQh0xCiVlZX8NAadATQjZqu3Pk6YvCI0rbcAkX8K4Y+vVMhsRGK8aiPKFh3g8Z
         4cJg==
X-Gm-Message-State: APt69E1qzr3a1bcn8xem+llucuDNeDDYBVLXs76x63QYinnmJcQbxx6f
        xsz9XfUDQN+TVYhMbfFb7Or5JtnM
X-Google-Smtp-Source: AAOMgpcLMTnb2IhZLjsxhCapVoYzVIkLB7aUaoWFWHc/adamYq+QtxOknYqwNVbUPpFGovyJads/gQ==
X-Received: by 2002:a1c:da0f:: with SMTP id r15-v6mr10327074wmg.22.1530647866869;
        Tue, 03 Jul 2018 12:57:46 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p3-v6sm3379974wrg.47.2018.07.03.12.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 12:57:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH v2 6/9] merge-recursive: fix assumption that head tree being merged is HEAD
References: <20180603065810.23841-1-newren@gmail.com>
        <20180701012503.14382-1-newren@gmail.com>
        <20180701012503.14382-7-newren@gmail.com>
Date:   Tue, 03 Jul 2018 12:57:45 -0700
In-Reply-To: <20180701012503.14382-7-newren@gmail.com> (Elijah Newren's
        message of "Sat, 30 Jun 2018 18:25:00 -0700")
Message-ID: <xmqq1sckqeh2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> `git merge-recursive` does a three-way merge between user-specified trees
> base, head, and remote.  Since the user is allowed to specify head, we can
> not necesarily assume that head == HEAD.

Makes sense.
