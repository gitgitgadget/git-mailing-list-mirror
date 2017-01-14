Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E4722093C
	for <e@80x24.org>; Sat, 14 Jan 2017 10:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751830AbdANKbh (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jan 2017 05:31:37 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:37152 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751733AbdANKbg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2017 05:31:36 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 131B42079E;
        Sat, 14 Jan 2017 10:31:35 +0000 (UTC)
Date:   Sat, 14 Jan 2017 10:31:34 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pat Pannuto <pat.pannuto@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] Use 'env' to find perl instead of fixed path
Message-ID: <20170114103134.GA586@untitled>
References: <20170112055140.29877-3-pat.pannuto@gmail.com>
 <6fe462dd-929a-671b-a210-36ee38e99115@kdbg.org>
 <CAAnLKaGbf9-GAF19+61=7_RfCOBM0=Ounwf8KkL1jS6HX3pOag@mail.gmail.com>
 <alpine.DEB.2.20.1701121118170.3469@virtualbox>
 <xmqqbmvcj9le.fsf@gitster.mtv.corp.google.com>
 <CAAnLKaGvz4Wzs36gMSdoYCg+tzx6KFCe59FNnk5zNQ-L58ww1g@mail.gmail.com>
 <20170113024842.GA20572@starla>
 <xmqq4m12izmd.fsf@gitster.mtv.corp.google.com>
 <20170113185246.GA17441@starla>
 <20170114075408.hyidkb4rzxzmm2je@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170114075408.hyidkb4rzxzmm2je@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> Just as a devil's advocate, why do we care about warnings in third-party
> modules? Or more specifically, why do _users_ who are running Git care
> about them? We cannot fix them in Git. A user may report the error to
> the module author, but the module author may not be responsive, or even
> may not be inclined to fix the problem (because they have a particular
> opinion on that warning).

Every user is a potential developer(*).  And I do feel
we (git developers) should be at least somewhat responsible
for helping maintain and fix the projects we depend on;
or moving to alternatives if we can't fix them.

There is a chance a newly-introduced warning in a 3rd-party
module points to a real problem with the way git uses it, too.
Having that warning would help us fix or workaround the bug
(either in git or the module).

I doubt any module author would be unresponsive to having a
localized "no warnings" for special cases.  AFAIK, "-w" is
widespread amongst Perl users (unlike Ruby in my experience).


(*) I feel that more strongly in the git case, and even more so
    for the Perl bits since the source is already on the user's
    machine.

> In the meantime, the user is stuck with an annoying warning message
> until Git is updated as you showed above. Why not just start there
> preemptively, and let module authors worry about their own warnings?

I'm not saying we blindly start using '-w' everywhere today.
But we may at least try it and see if it introduces new
warnings, first, and only enable '-w' when it it looks quiet
(and perhaps start working with module authors to fix warnings
 if not).

As a user, I'd rather have some indication of where something
might be wrong, than no warning at all when something does go
wrong.
