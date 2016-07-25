Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AB4E203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 20:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753509AbcGYUtG (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 16:49:06 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:32914 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753166AbcGYUtF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 16:49:05 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96059203E2;
	Mon, 25 Jul 2016 20:49:04 +0000 (UTC)
Date:	Mon, 25 Jul 2016 20:49:04 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] format-patch: escape "From " lines recognized by
 mailsplit
Message-ID: <20160725204904.GA1424@starla>
References: <20160722224739.GA22961@whir>
 <xmqqk2gb8q81.fsf@gitster.mtv.corp.google.com>
 <xmqqd1m3825y.fsf@gitster.mtv.corp.google.com>
 <20160725084357.GA8025@starla>
 <xmqqzip562s3.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzip562s3.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> 
> >> Also, doesn't it break "git rebase" (non-interactive), or anything
> >> that internally runs format-patch to individual files and then runs
> >> am on each of them, anything that knows that each output file from
> >> format-patch corresponds to a single change and there is no need to
> >> split, badly if we do this unconditionally?
> >
> > Yes, rebase should probably unescape is_from_line matches.
> 
> This shouldn't matter for "git rebase", as it only reads from the
> mbox "From <commit object name> <datestamp>" line to learn the
> original commit and extract the log message directly from there.

OK.

> But a third-party script that wants to read format-patch output
> would be forced to upgrade, which is a pain if we make this change
> unconditionally.

I suppose unconditionally having mailsplit unescape
">From ...  $DATE" lines might be acceptable?

It'll still propagate these mistakes to older versions of git,
but those installations will eventually become fewer.

> >> IOW, shouldn't this be an optional feature to format-patch that
> >> is triggered by passing a new command line option that currently
> >> nobody is passing?
