Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65CFB202AE
	for <e@80x24.org>; Sun,  9 Jul 2017 17:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752225AbdGIRFw (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jul 2017 13:05:52 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:34958 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752146AbdGIRFv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2017 13:05:51 -0400
Received: by mail-pg0-f51.google.com with SMTP id j186so38114061pge.2
        for <git@vger.kernel.org>; Sun, 09 Jul 2017 10:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=tupx4SKNNMaBbZJd9pupJ6c0X3NaYnqUsUJg+Fdmx9c=;
        b=RnG9z8rjTHmrTh8UZ3ePNl9sU44cHgVHD8vHI+kJEa7Alou0WgvIyKr6vz7XU0+6rK
         6oQnONHiLQQfdPK0q56P2g0fEV7iWM+3qUB0c66MksO8eZTjDTVM2+budIzmB3pYsOm1
         kzEpV75pxFgy6CY/H+Xp3QtPGgVDSJ64MvBOmzkM5GgkSC6fEhX0kA+f3suJtz5crJFb
         1GgEmwz4yR0geWhgb2dWhDqhJkIwYxtFPv/BJYWVx9rmWAGVdw8Snue1qMh9jd9Q+G8a
         RxtmBjg93xlMyZqz7dbq+5xJ5ahb/KkKhhxn/PCuGM9lolNBEvkzLmEre6X9ABnl5gi6
         04PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=tupx4SKNNMaBbZJd9pupJ6c0X3NaYnqUsUJg+Fdmx9c=;
        b=Ma3zq3H5llXprS0Wkp6F+B4iH/SqBXJFNt22Lup8Ue/aMFInazaRuuGt30ultiDEaw
         e9/c0awn5H/0CD/Wa9r3HYC2QrllV3UfiJtprX0DCW9wb4uxJHUE8D+Do3A+CKZN3Vwq
         tngzHIfUEkOftYNXHstaIigTVMILX2akhOrwzZrVXThK/fjFQY/cdpMQt+WUa49+loZM
         uOoF5HXIOjmokI6xZJsh/m1Ibo1sstYmZA4T3YA8CsT54iQ6pjWfAHik2TzzuzVYPv7/
         C8NnvHlXTt9+ITXLm9KnNqXbrMGjZ8gGr158FTECf1zKx1ivPh8LPWr8ARoqwVjpnjw3
         Q+yA==
X-Gm-Message-State: AIVw112w/OGjxsGGGO0+Gc1Florsj7oVDrRGfbaAOmwgHuBzdiK8UHG0
        Jih7Q+3r81vTZhCj0Xk=
X-Received: by 10.84.131.71 with SMTP id 65mr13907351pld.35.1499619950791;
        Sun, 09 Jul 2017 10:05:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:dc1e:60e1:7751:9c92])
        by smtp.gmail.com with ESMTPSA id v17sm23976776pgn.4.2017.07.09.10.05.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 09 Jul 2017 10:05:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] apply: use strcmp(3) for comparing strings in gitdiff_verify_name()
References: <d1bb978b-a7df-48a8-15c8-80730c77e11c@web.de>
        <87tw2ngp94.fsf@linux-m68k.org>
        <e46a7de9-3e0e-4eeb-c9a3-a8b5f22620b4@web.de>
        <87o9svgia8.fsf@linux-m68k.org>
        <df3bd047-6ddd-c120-54dd-4165d2257bb0@web.de>
        <87lgnxpyzu.fsf@linux-m68k.org>
        <52d0ac32-7b3d-990d-8ad9-42ef9ee8d8cf@web.de>
Date:   Sun, 09 Jul 2017 10:05:49 -0700
In-Reply-To: <52d0ac32-7b3d-990d-8ad9-42ef9ee8d8cf@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 9 Jul 2017 15:19:53 +0200")
Message-ID: <xmqqpod98rrm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> I wonder when we can begin to target C99 in git's source, though. :)

Let's get the ball rolling by starting to use some of the useful
features like designated initializers, perhaps, in a small, critical
and reasonably stable part of the system that anybody must compile,
leave it in one full release cycle or two, and when we hear nobody
complains, introduce it en masse for the remainder of the system?

That way, we will see if there are people who need pre-C99 soon
enough, and we won't have to scramble reverting too many changes
when it happens.

