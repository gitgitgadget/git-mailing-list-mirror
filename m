Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43E0F1FF6D
	for <e@80x24.org>; Tue, 29 Nov 2016 06:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754300AbcK2G7S (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 01:59:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:48262 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933241AbcK2G7P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 01:59:15 -0500
Received: (qmail 30656 invoked by uid 109); 29 Nov 2016 06:59:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Nov 2016 06:59:13 +0000
Received: (qmail 8136 invoked by uid 111); 29 Nov 2016 06:59:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Nov 2016 01:59:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Nov 2016 01:59:12 -0500
Date:   Tue, 29 Nov 2016 01:59:12 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2016, #06; Mon, 28)
Message-ID: <20161129065912.xa7itc3os425mr3r@sigill.intra.peff.net>
References: <xmqqk2bngn03.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk2bngn03.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 28, 2016 at 04:15:08PM -0800, Junio C Hamano wrote:

> * jk/nofollow-attr-ignore (2016-11-02) 5 commits
>  - exclude: do not respect symlinks for in-tree .gitignore
>  - attr: do not respect symlinks for in-tree .gitattributes
>  - exclude: convert "check_index" into a flags field
>  - attr: convert "macro_ok" into a flags field
>  - add open_nofollow() helper
> 
>  As we do not follow symbolic links when reading control files like
>  .gitignore and .gitattributes from the index, match the behaviour
>  and not follow symbolic links when reading them from the working
>  tree.  This also tightens security a bit by not leaking contents of
>  an unrelated file in the error messages when it is pointed at by
>  one of these files that is a symbolic link.
> 
>  Perhaps we want to cover .gitmodules too with the same mechanism?

Yes, sorry I haven't pushed that forward. I started on covering
.gitmodules, too, but it's much more complicated than the other two,
because we sometimes read them via "git config -f". So we have to
somehow teach git-config to start using O_NOFOLLOW in those cases.

I'm actually considering scrapping the approach you've queued above, and
just teaching verify_path() to reject any index entry starting with
".git" that is a symlink.

-Peff
