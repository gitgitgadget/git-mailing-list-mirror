Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41DF01F461
	for <e@80x24.org>; Wed, 10 Jul 2019 07:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfGJHon (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jul 2019 03:44:43 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:17854 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbfGJHom (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jul 2019 03:44:42 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 834E6A10BA;
        Wed, 10 Jul 2019 09:44:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id GIUEXp7eanxb; Wed, 10 Jul 2019 09:44:30 +0200 (CEST)
Date:   Wed, 10 Jul 2019 09:44:28 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     paulus@samba.org, max@max630.net, git@vger.kernel.org
Subject: Re: [PATCH] gitk: fix --all behavior combined with --not
Message-ID: <20190710074428.GA65621@book.hvoigt.net>
References: <20190704080907.GA45656@book.hvoigt.net>
 <xmqq4l3wz6y8.fsf@gitster-ct.c.googlers.com>
 <xmqqr26zx0wr.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr26zx0wr.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 08, 2019 at 09:55:00PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Heiko Voigt <hvoigt@hvoigt.net> writes:
> >
> >> In commit 4d5e1b1319 ("gitk: Show detached HEAD if --all is specified",
> >> 2014-09-09) the intention was to have detached HEAD shown when the --all
> >> argument is given.
> >
> > The "do we have --all?" test added by that old commit is not quite
> > satisfying in the first place.  E.g. we do not check if there is a
> > double-dash before it.  This change also relies on an ancient design
> > mistake of allowing non-dashed options before a dashed one, adding
> > more to dissatisfaction by making a future change to correct the
> > design mistake harder.
> 
> Actually, I do not think this patch is a good idea.
> 
[...]
> 
> As the code is _already_ finding the _exact_ location on the command
> line where "--all" appears, I think you can go one step further and
> make sure you insert the "HEAD" immediately after "--all", as that
> exactly matches what you (and the ancient 4d5e1b1319) are trying to
> achieve: pretend as if "--all" always include "HEAD", even when it
> is detached.
> 
> This is orthogonal to the question I posed in my earlier reply
> (i.e. "we found --all; is it really a 'give me all refs' request
> given by the user, or something else (is it an argument to another
> option, like "--grep '--all'", or is it pathspec after '--'), but
> assuming that we have reliably found the "--all" on the command line
> the user meant as "give me all refs", I think inserting HEAD
> immediately after that location would be the right solution.  It is
> incorrect to unconditionally append as your original example shows,
> but it is equally incorrect to unconditionally prepend.

Yes I agree, there are too many other use cases that my change will
break. I tried to replace a hack with another quick hack, but that did
not make it better.

Will reply to the other mail with some more questions.

Cheers Heiko
