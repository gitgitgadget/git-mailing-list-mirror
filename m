Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84788C43215
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 15:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5082420836
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 15:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0qlrhOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbfKYPPY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 10:15:24 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34097 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728528AbfKYPPX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 10:15:23 -0500
Received: by mail-wm1-f66.google.com with SMTP id j18so125988wmk.1
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 07:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Brz+bM6R9p5bS7CMlya/2FUXTqs53fbCBmH6RdJG4WA=;
        b=J0qlrhOEU6N3GTsDcBdHs83OjgUW/4ALSLIeHa8ezByPzVbFNQGJ3JWNeHOY1kaocc
         jd7Z8TRbgWCT144q1tk4smhN/hBlu3N+vEXT72olxhzbfQtpU9GBGhe1MX+4HAGUod1p
         BZeZGzeFnIiZdDMrbW1iDguk13gQ+trGl4bvjCol1xhHpnJEcLYDDQGtuzENcCsbEV9g
         JdNdoHLk8+zH6/ehR82Pb7ytkzMyTp5sLlou0WnHYbXkCUGdyUBhFAEx+W9ssY81NZGL
         GRnBxcMk/yj/zVyCzBznkS/fk/N52v8yZDE5zJguSE0UezxRjgAGRzGCzj9k9eQBfBou
         LKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Brz+bM6R9p5bS7CMlya/2FUXTqs53fbCBmH6RdJG4WA=;
        b=KNSL68ENYgU9gc7P0Kaj9YaEAFUBL9gNjJNpjp8nZ46YouUEhw1Fe6EyrPLTt6eLQO
         f+Ojx91MZrb+GdH4ZiIUBGYOmsu8GWqsEh7WMktRJcAPt7UoRRFau65pslBeTJ57cAsG
         IeJGmgdFFXL0EnKKUN3/LmLu/Z9VZAQ07zk4okSFV0i+hThpfDcBkV1m4/qlgFiRrBLT
         dtcRZeUcq6K8M/rIrHoLKTMIbd3sG9h5Z1zv1knVryFG+/53SIx/QUagzT+CZF5F7IQl
         qpmnKq9llSWkiX83nIRRSwwtbZprlp0DX1ip4IEu1CMG3FUh3sgZgQUirk37I2kk5Um9
         DZAw==
X-Gm-Message-State: APjAAAXvE7m//T6uZSDrc4xUyXyzdxZXvzbAAR72gS8ZWM/N4Luxbk6P
        C990rmxZBntcWB3s6jpDKrw=
X-Google-Smtp-Source: APXvYqwHVnFSHyeyXykee4jxRhQQRiwPOiaw82EH+PkKMNGS4ky1StmgK3iT4RR3Tc/XXuM8CgmDAQ==
X-Received: by 2002:a1c:f404:: with SMTP id z4mr29399789wma.12.1574694920782;
        Mon, 25 Nov 2019 07:15:20 -0800 (PST)
Received: from szeder.dev (x4d0c37f4.dyn.telefonica.de. [77.12.55.244])
        by smtp.gmail.com with ESMTPSA id u4sm10858643wrq.22.2019.11.25.07.15.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 07:15:19 -0800 (PST)
Date:   Mon, 25 Nov 2019 16:15:17 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t3429: try to protect against a potential racy todo file
 problem
Message-ID: <20191125151517.GE23183@szeder.dev>
References: <e7c01e0f-8466-c2c5-b53a-a93f941dfb1c@gmail.com>
 <20191123172046.16359-1-szeder.dev@gmail.com>
 <xmqqk17p280y.fsf@gitster-ct.c.googlers.com>
 <8c21662f-6548-a46e-9c87-eb364355cb78@gmail.com>
 <20191124211021.GB23183@szeder.dev>
 <20191125131833.GD23183@szeder.dev>
 <5a43a071-a3c2-770e-bca4-3e73aff96e48@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a43a071-a3c2-770e-bca4-3e73aff96e48@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 25, 2019 at 02:43:07PM +0000, Phillip Wood wrote:
> On 25/11/2019 13:18, SZEDER Gábor wrote:
> >On Sun, Nov 24, 2019 at 10:10:21PM +0100, SZEDER Gábor wrote:
> >>To notice a changed todo file the sequencer stores the file's stat
> >>data in its 'struct todo_list' instance, and compares it with the
> >>file's current stat data after 'reword', 'squash' and 'exec'
> >>instructions.  If the two stat data doesn't match, it re-reads the
> >>todo file.
> >>
> >>Sounds simple, but there are some subtleties going on here:
> >>
> >>   - The 'struct todo_list' holds the stat data from the time when the
> >>     todo file was last read.
> >>
> >>   - This stat data in 'struct todo_list' is not updated when the
> >>     sequencer itself writes the todo file.
> >>
> >>   - Before executing each instruction during an interactive rebase,
> >>     the sequencer always updates the todo file by removing the
> >>     just-about-to-be-executed instruction.  This changes the file's
> >>     size and inode [1].
> >>
> >>Consequently, when the sequencer looks at the stat data after a
> >>'reword', 'squash' or 'exec' instruction, it most likely finds that
> >>they differ, even when the user didn't modify the todo list at all!
> >>This is not an issue in practice, it just wastes a few cycles on
> >>re-reading the todo list that matches what the sequencer already has
> >>in memory anyway.
> >
> >It can be much more than just a few cycles, because the total number
> >of parsed instructions from all the todo file re-reads can go
> >quadratic with the number of rebased commits.
> >
> >The simple test below runs 'git rebase -i -x' on 1000 commits, which
> >takes over 14seconds to run.  If it doesn't re-read the todo file at
> >all (I simply deleted the whole condition block checking the stat data
> >and re-reading) it runs for only ~2.5secs.
> >
> >Just another angle to consider...
> 
> I know dscho was keen to avoid re-parsing the list all the time [1]
> presumably because of the quadratic behavior. (He also assumed most people
> were using ns stat times [2] but that appears not to be the case)

Nanosecond file timestamp comparisons are only enabled by the USE_NSEC
macro, which is only defined if the USE_NSEC Makefile knob is enabled,
but that is not enabled by default.

Then there is the related NO_NSEC Makefile knob:

  # Define NO_NSEC if your "struct stat" does not have "st_ctim.tv_nsec"
  # available.  This automatically turns USE_NSEC off.

As Dscho mentioned in [2], we do disable nanosecond file timestamp
comparisons in 'config.mak.uname' on a handful of platforms by setting
NO_NSEC.  This, however, does not mean that nanosec timestamps are
enabled on other platforms by default.

> Could we
> just compare the text of the todo list on disk to whats in todo->buf.buf
> (with an appropriate offset)? That would avoid parsing the text and looking
> up all the commits with get_oid()

Comparing the contents without parsing is still quadratic in the size
of the todo list, though I suppose with a much lower constant factor
than actually parsing it.

> [1]
> https://public-inbox.org/git/alpine.DEB.2.20.1703021617510.3767@virtualbox/
> [2]
> https://public-inbox.org/git/alpine.DEB.2.20.1704131526500.2135@virtualbox/
> 
> >
> >   ---  >8  ---
> >
> >test_expect_success 'test' '
> >	num_commits=1000 &&
> >	test_commit_bulk --filename=file $num_commits &&
> >
> >	/usr/bin/time -f "Elapsed time: %e" \
> >		git rebase -i --root -x true 2>out &&
> >
> >	grep "Executing: true" out >actual &&
> >	test_line_count = $num_commits actual &&
> >
> >	# show the elapsed time
> >	tail -n2 out
> >'
> >
> >   ---  >8  ---
> >
