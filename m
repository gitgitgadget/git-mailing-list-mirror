Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5E2920756
	for <e@80x24.org>; Fri, 20 Jan 2017 14:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752439AbdATO0j (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 09:26:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:42142 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752218AbdATO0i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 09:26:38 -0500
Received: (qmail 16696 invoked by uid 109); 20 Jan 2017 14:19:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Jan 2017 14:19:57 +0000
Received: (qmail 3647 invoked by uid 111); 20 Jan 2017 14:20:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Jan 2017 09:20:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Jan 2017 09:19:55 -0500
Date:   Fri, 20 Jan 2017 09:19:55 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC 2/2] grep: use '/' delimiter for paths
Message-ID: <20170120141954.xyocl6oqoykqmpl5@sigill.intra.peff.net>
References: <20170119150347.3484-1-stefanha@redhat.com>
 <20170119150347.3484-3-stefanha@redhat.com>
 <xmqqpoji2851.fsf@gitster.mtv.corp.google.com>
 <20170120141212.GC17499@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170120141212.GC17499@stefanha-x1.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 20, 2017 at 02:12:12PM +0000, Stefan Hajnoczi wrote:

> I find <rev>:<path> vs <rev> -- <path> confusing:
> 
>             | <rev>:<path>         | <rev> -- <path>
>   ----------+----------------------+---------------------
>   git grep  | OK                   | OK
>   ----------+----------------------+---------------------
>   git show  | OK                   | <path> ignored
>   ----------+----------------------+---------------------
>   git log   | no output            | OK
>   ----------+----------------------+---------------------
> 
> Neither syntax always does what I expect.  If git show <rev> -- <path>
> honored <path> then I could use that syntax consistently.
> 
> Sorry for going on a tangent.  Does it seem reasonable to handle <path>
> in git-show(1) as a UI convenience?

It's not ignored; just as with git-log, it's a pathspec to limit the
diff. E.g.:

  $ git show --name-status v2.9.3
  ...
  M       Documentation/RelNotes/2.9.3.txt
  M       Documentation/git.txt
  M       GIT-VERSION-GEN

  $ git show --name-status v2.9.3 -- Documentation
  M       Documentation/RelNotes/2.9.3.txt
  M       Documentation/git.txt

That's typically less useful than it is with log (where limiting the
diff also kicks in history simplification and omits some commits
entirely). But it does do something.

-Peff
