Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7097AC432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 13:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF4A2082F
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 13:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvnjLQXC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfKYNSk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:18:40 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39691 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfKYNSj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 08:18:39 -0500
Received: by mail-wm1-f65.google.com with SMTP id t26so15923485wmi.4
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 05:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=s9MkXYIhtXQWecej7//ANZYJGhiSQhcC6DIL8cZATJU=;
        b=dvnjLQXC7Mx5sVMOtZFBZIvJj8tsZ4mtCXhFPe+Xadp1W2RZjw3uyxSuzwZlagPc+c
         QRpB1L/OwuoTjFAI+IQVg6rJn1PgH4g7Ifh3KfFiUHfaKPkjO6RuXaif73YZtIfEDEtG
         Blpr5bWzkWgcf/aOSncEOjzqjaWHOvZyJXG9g3hwN9YjoEiwm9pzXYXn+5RKuZXKg9Gq
         dhqd1mY+OrNmSa8WWKGYDFzLDVVjrnO2rZ72sIX3Fb9jibtpq+TTLIljjpZxnRlFl1GW
         WIM4FcpLn+V1fwEOzHMvqFNPn4x3ydd5HPuRRg1fvAFta0tfxSSdSZcFy7vUBwcAKsAV
         xXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=s9MkXYIhtXQWecej7//ANZYJGhiSQhcC6DIL8cZATJU=;
        b=t2svr1a47CasY3r0rVcGeOeED8VgMdQDRn78ltpf6z9L0IwRi5aTeWAju9iEDQnV4x
         GNJbQaysl+fK5OVrb7TV/Bahu4dQE5IpXDWmLyH0GuQ+8Foj3cnDvvLjkC1d+XHi9TvK
         d0QAxpmBDRRD0kgruNKWDy+87fdivqITQ8bmRs5UEqT4aiJ/N2NgGaMjpdEAZR12KZNO
         fRvA4CE37INe4CgRjA1fr0XZe0ynq6XEmwW6yc7uHclFFGw8Lrx06m6635gYUFEuP5Gr
         mdf4RGlDjNZ5bvQzCr+bktMQMkiGcKlob0wxA1J1jjOCprRSxaxXMfQjPDehRgsizFQJ
         QBxA==
X-Gm-Message-State: APjAAAX9A9HDa5jWkx6CiBEgkT5KZ6gMzYqvrok16CrXtI32x9dl8VXJ
        jWXeU446W6vukKg1ttbN3ag=
X-Google-Smtp-Source: APXvYqy2AlAQbgL2ymDeDVxwIo2ipY2w0LdMKu9ciKtOZ+q9/Si0FRZOPTrQk88dd6tDZtVC5jbcqQ==
X-Received: by 2002:a7b:c935:: with SMTP id h21mr8458996wml.173.1574687916407;
        Mon, 25 Nov 2019 05:18:36 -0800 (PST)
Received: from szeder.dev (x4d0c37f4.dyn.telefonica.de. [77.12.55.244])
        by smtp.gmail.com with ESMTPSA id t187sm8237829wma.16.2019.11.25.05.18.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 05:18:35 -0800 (PST)
Date:   Mon, 25 Nov 2019 14:18:33 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t3429: try to protect against a potential racy todo file
 problem
Message-ID: <20191125131833.GD23183@szeder.dev>
References: <e7c01e0f-8466-c2c5-b53a-a93f941dfb1c@gmail.com>
 <20191123172046.16359-1-szeder.dev@gmail.com>
 <xmqqk17p280y.fsf@gitster-ct.c.googlers.com>
 <8c21662f-6548-a46e-9c87-eb364355cb78@gmail.com>
 <20191124211021.GB23183@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191124211021.GB23183@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 24, 2019 at 10:10:21PM +0100, SZEDER Gábor wrote:
> To notice a changed todo file the sequencer stores the file's stat
> data in its 'struct todo_list' instance, and compares it with the
> file's current stat data after 'reword', 'squash' and 'exec'
> instructions.  If the two stat data doesn't match, it re-reads the
> todo file.
> 
> Sounds simple, but there are some subtleties going on here:
> 
>   - The 'struct todo_list' holds the stat data from the time when the
>     todo file was last read.
> 
>   - This stat data in 'struct todo_list' is not updated when the
>     sequencer itself writes the todo file.
> 
>   - Before executing each instruction during an interactive rebase,
>     the sequencer always updates the todo file by removing the
>     just-about-to-be-executed instruction.  This changes the file's
>     size and inode [1].
> 
> Consequently, when the sequencer looks at the stat data after a
> 'reword', 'squash' or 'exec' instruction, it most likely finds that
> they differ, even when the user didn't modify the todo list at all!
> This is not an issue in practice, it just wastes a few cycles on
> re-reading the todo list that matches what the sequencer already has
> in memory anyway.

It can be much more than just a few cycles, because the total number
of parsed instructions from all the todo file re-reads can go
quadratic with the number of rebased commits.

The simple test below runs 'git rebase -i -x' on 1000 commits, which
takes over 14seconds to run.  If it doesn't re-read the todo file at
all (I simply deleted the whole condition block checking the stat data
and re-reading) it runs for only ~2.5secs.

Just another angle to consider...


  ---  >8  ---

test_expect_success 'test' '
	num_commits=1000 &&
	test_commit_bulk --filename=file $num_commits &&

	/usr/bin/time -f "Elapsed time: %e" \
		git rebase -i --root -x true 2>out &&

	grep "Executing: true" out >actual &&
	test_line_count = $num_commits actual &&

	# show the elapsed time
	tail -n2 out
'

  ---  >8  ---

