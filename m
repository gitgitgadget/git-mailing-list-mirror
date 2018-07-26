Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 879C61F597
	for <e@80x24.org>; Thu, 26 Jul 2018 17:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731646AbeGZSvS (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 14:51:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44678 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731388AbeGZSvS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 14:51:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id r16-v6so2496912wrt.11
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 10:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qQJ/PB1edl5C7lpV1lzwg1JvDlaoEZR8CZzjTKlSXhA=;
        b=vTL6IIcM/EJMZI0JFzaNVJTTJAHebOcXqcgO2/Mkz78qRFytktXqmqot6FxPqMAJ9f
         083UlWQ3SC71RB4YMs3U2VM+JpZZja/5HHtovqEQM0dsCozVJY0TT+8l5vlPYZPuxW+l
         ptDlg2FRcv7O6iN3bYal4HMCdsylYz5FI9A8TJEzePcRbz3xJRay+TM6OHuHkAU3MnyX
         OoeMn/kUlXQ8RjTK72JceIfILtzPGiT5LDqLLyIb5rjJKnHeCTCG2+pUQxgfEKb4ul9/
         oCKTCjgrsjqSzFVpBPDPcCjojxnDG6WU0JziXjzIQ/SVy3Pmt9dgUHm5nk0cGecEb7/D
         +uVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qQJ/PB1edl5C7lpV1lzwg1JvDlaoEZR8CZzjTKlSXhA=;
        b=Tk0fCw/ooryaj2b52T001veBs1EBa400z6Cdyw/4r0z842iTxfP+/uu+FiTM9gnxMt
         u1CtsgydzimAcwsQlQX71NjeLO8fVq7PGrIB29SJ6+Ioqx1Uhtpg4I7ldij+Azd2JvKN
         nW3GqBu2H7UNYxKylsi5gcz8j9S7d3HdHn0ofqBG3n702hR0WP1c2zuUE7nl1Www+7UX
         CLXWZhQmS23flW3DCUtzCLpi4ta0imaDMZaSVpfY2ovX5A0qFPd2Wv3uJAlTV/ynauy4
         JpzmHuVWoCHsoCGqLnzsto59igT7xuaiYu9TcLADhhymieFNfTPty5ryhGrlFYI80vp5
         ljJg==
X-Gm-Message-State: AOUpUlGpTm7SSCSqiqeat0dgncl2raqDl0Hl5Cuazj9olMGNnjLDnEYq
        jV8VGxAumWlzaHcva8ZlYjUO8y8E
X-Google-Smtp-Source: AAOMgpcgmT+HQfUYX1pX5Jvb0HVv5BSjAP4tCknHCgEHmDhwp9E5EtKHZ97pmDeG0GTc6PzhJ4l7fQ==
X-Received: by 2002:adf:f74d:: with SMTP id z13-v6mr2418741wrp.85.1532626408462;
        Thu, 26 Jul 2018 10:33:28 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l5-v6sm1178415wrq.86.2018.07.26.10.33.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 10:33:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 1/4] automatically ban strcpy()
References: <20180724092329.GA24250@sigill.intra.peff.net>
        <20180724092618.GA3288@sigill.intra.peff.net>
        <CAPig+cRpcUOA5+k7v3Gy3WsLohedEb=j-a_fCGc3g0ktDfsDVA@mail.gmail.com>
        <20180726065840.GA27349@sigill.intra.peff.net>
        <20180726072105.GA6057@sigill.intra.peff.net>
Date:   Thu, 26 Jul 2018 10:33:27 -0700
In-Reply-To: <20180726072105.GA6057@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 26 Jul 2018 03:21:05 -0400")
Message-ID: <xmqqfu05rjfc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So here's a replacement for just patch 1 (I'm assuming this creates less
> work than re-posting them all, but it may not be if Junio prefers
> dealing with a whole new mbox rather than a "rebase -i", "reset --hard
> HEAD^", "git am" -- let me know if you'd prefer it the other way).

A single patch replacement that is clearly marked which one to
replace and which other ones to keep, like you did here, is fine.
The amount of work is about the same either way.

0) I would first do these to make sure that I can replace:

 $ git checkout jk/banned-functions
 $ git log --first-parent --oneline master..
 $ git log --first-parent --oneline next..

If 'next' has some patches that are not in 'master' from the topic,
I must refrain from replacing them (in this case, there is no such
issue).

1-a) With a wholesale replacement,

 $ git checkout master...	;# try to keep the same base
 $ git am -s mbox		;# on detached HEAD
 $ git tbdiff ..@{-1} @{-1}..	;# or range-diff

If the range-/tbdiff tells me that earlier N patches are the same,
the above is followed by something like (pardon off-by-one)

 $ git rebase --onto @{-1}~N HEAD~N

to preserve as many original commits as possible.

1-b) With a single patch replacement, it is quite different.

 $ git checkout HEAD~4	        ;# we are replacing 1/4 of the original
 $ git am -s mbox               ;# that single patch
 $ git show-branch HEAD @{-1}

That would give me something like this

    * [HEAD] automatically ban strcpy()
     ! [@{-1}] banned.h: mark strncpy() as banned
    --
    *  [HEAD] automatically ban strcpy()
     + [@{-1}] banned.h: mark strncpy() as banned
     + [@{-1}^] banned.h: mark sprintf() as banned
     + [@{-1}~2] banned.h: mark strcat() as banned
     + [@{-1}~3] automatically ban strcpy()
    -- [HEAD^] Merge branch 'sb/blame-color' into jk/banned-function

The most natural thing to do at this point is

 $ git cherry-pick -3 @{-1}

But we know range-pick is buggy and loses core.rewriteref, so
instead I did this, which I know carries the notes forward:

 $ git rebase --onto HEAD @{-1}~3 @{-1}^0

    Side note: The point of last "^0" is that I do not want to lose
    the topic branch jk/banned-functions not just yet.

If I need to re-apply separate pieces of the original history, it
becomes very painful to emulate these multiple cherry-picks with
multiple "rebase --onto", though.  That is where "the amount of work
is about the same" comes from.  If cherry-pick worked correctly,
selective replacement should be less work for me.

Anyway, we already preserved as many original commits, but unlike
1-a, did so manually when we decided to replace selective patches.
So there is no further rebasing with this approach.

2) I now have two diverged histories in HEAD and @{-1} that I can
compare with range-/tbdiff in either case: 

 $ git tbdiff ..@{-1} @{-1}..

After the usual inspection and testing, replacement is concluded by

 $ git checkout -B @{-1}

which takes me back to (an updated) jk/banned-functions topic.

