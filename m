Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C1161F404
	for <e@80x24.org>; Fri, 10 Aug 2018 18:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbeHJVGE (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 17:06:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46385 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbeHJVGE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 17:06:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id h14-v6so9071694wrw.13
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 11:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZAkYLvDUsARzlNF+rN4YXoKBcx+J2xX1yTwRosweqZQ=;
        b=iYd8KdLDaklEPjXWIuHiQXS/p83VVpDAJluageL80Eg60BbIVhZvpDiZJOYfrSHgD/
         GYHkiP2oAKkzBpDH+I66ZV+9S/f+iHP8r21uJbSnNIS86BkDZqKBVk72O6u71NtW71Yc
         Q7jsu4hXO7HPpFDmmcM21ilWjCOSA+BKvfulAcs+E8BuNR50yKb0dPdgTiaRiq49Q+6p
         vufS/MuGWrWwZwsArg0TlGnPhx/LayQpMrdWDOCUixA4KK37LlQDKDZwLhbwFi5FGiId
         wPBT9/SogP8RM2SYYt4/TXO+jhqDxksv8f2nPntBJnR15d/705fvCWFsAsQFfSSxCmDR
         emRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZAkYLvDUsARzlNF+rN4YXoKBcx+J2xX1yTwRosweqZQ=;
        b=kQuO/AQG2QooOUKAtXdd/TI8QvdziggqmAraoLfMiOdpzHuZciEa+O+hHE3XaIeSSk
         gJnbclfMzSsKyiNEKjg7BCc3UKPYg5iLKV7XrFpwfzJzfvpCVYOz+lHiZMoLP3HaCK/Y
         IIdf7d+X7QlA/MoQK4qFD4LjvdWJWmL3iHrxVyzLjRdCO63zoKzXr7TLf/VaL96Q7zGw
         SdB1aMg6gqG6YsJ27UrOoW6utiYH6x3gIwrwEN0FmFpj3S8C1W0njRt4JSbZZIIvVBZG
         kj8eHZ1Fji+DpYXGrgrJF0WWH2TGNjPRkHV3KFbHtUaXDC6akiqeen0VMY0jSo27blDm
         qBew==
X-Gm-Message-State: AOUpUlH382v3uuYCRrQKz2kMs1a6lopU0frjVjChC7/ae1vpRllJlbS/
        WU+uNrvzEt8o8lDegHLIkzaHbAsO
X-Google-Smtp-Source: AA+uWPx5rESd+brK90YstfqnY/wb3eBJUQAW2LTAN3zNID+jY8znUzNYi7ukoewFKek6ygQ51upAOg==
X-Received: by 2002:a5d:6401:: with SMTP id z1-v6mr4815737wru.64.1533926100590;
        Fri, 10 Aug 2018 11:35:00 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l11-v6sm14037845wru.25.2018.08.10.11.34.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Aug 2018 11:34:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] t5552: fix flakiness by introducing proper locking for GIT_TRACE
References: <pull.17.git.gitgitgadget@gmail.com>
        <811ded48-6f33-c46e-7bae-b9f7c7e8764c@kdbg.org>
Date:   Fri, 10 Aug 2018 11:34:59 -0700
In-Reply-To: <811ded48-6f33-c46e-7bae-b9f7c7e8764c@kdbg.org> (Johannes Sixt's
        message of "Fri, 10 Aug 2018 18:15:36 +0200")
Message-ID: <xmqqin4i83zg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> As this buglet looks like a recurring theme, and a proper fix is
> preferable over repeated work-arounds. To me it looks like we need
> some sort of locking on Windows. Unless your friends at Microsoft have
> an ace in their sleeves that lets us have atomic O_APPEND the POSIX
> way...

Just to put the severity of the issue in context, we use O_APPEND in
a few codepaths, and the trace thing for debugging is the only thing
that could have multiple writers.  Other users of O_APPEND are:

 * refs/files-backend.c uses it so that a reflog entry can be
   appended at the end, but because update to each ref is protected
   from racing at a lot higher layer with a lock, no two people
   would try to append to the same reflog file, so atomicity of
   O_APPEND does not matter here.

 * sequencer.c wants to use it when moving one insn from the todo
   list to the 'done' list when it finishes one operation.  If you
   are running two sequences in a single repository, intermixed
   'done' list would be the least of your problem, so presumably we
   are fine here.

It may make sense to allow GIT_TRACE to have a placeholder
(e.g. "/tmp/traceout.$$") to help debuggers arrange to give
different processes their own trace output file, which perhaps may
be a simpler and less impactful to the performance solution than
having to make locks at an application layer.


