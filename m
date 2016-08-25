Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99AAD1F859
	for <e@80x24.org>; Thu, 25 Aug 2016 18:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755888AbcHYSqR (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 14:46:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:32996 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755743AbcHYSqN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 14:46:13 -0400
Received: (qmail 6772 invoked by uid 109); 25 Aug 2016 18:39:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Aug 2016 18:39:31 +0000
Received: (qmail 15120 invoked by uid 111); 25 Aug 2016 18:39:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Aug 2016 14:39:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Aug 2016 14:39:28 -0400
Date:   Thu, 25 Aug 2016 14:39:28 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ed Greenberg <edg@greenberg.org>, git@vger.kernel.org
Subject: Re: git push origin BRANCHNAME question
Message-ID: <20160825183928.jm7pihc4kzwuej6y@sigill.intra.peff.net>
References: <6c4fbb7d-6f67-b454-2b4b-9f5fbeffae9b@greenberg.org>
 <xmqqr39cn3fk.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr39cn3fk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 25, 2016 at 10:50:23AM -0700, Junio C Hamano wrote:

> Ed Greenberg <edg@greenberg.org> writes:
> 
> > I think I understand this from the git-push man page, but I want to
> > make sure:
> >
> > I have two branches, master and develop.
> >
> > If I am (accidentally) sitting on master, and issue 'git push origin
> > develop', does this properly push develop to remote develop, or does
> > it push master to remote develop (which seems to be bad, in the most
> > common use case.)  ?
> 
> You can find it out yourself quite easily, I would think.
> 
> $ git init src
> $ git init dst
> $ cd src
> $ git commit --allow-empty -m initial
> $ git checkout -b develop
> $ git commit --allow-empty -m second
> 
> $ git checkout master
> $ git push ../dst develop
> Counting objects: 3, done.
> Delta compression using up to 6 threads.
> Compressing objects: 100% (2/2), done.
> Writing objects: 100% (3/3), 226 bytes | 0 bytes/s, done.
> Total 3 (delta 1), reused 0 (delta 0)
> To ../dst
>  * [new branch]      develop -> develop

Yes, though I think the "why" is interesting here, too.

And the answer is that "develop" is a shortened refspec, whose full form
is more like "develop:develop". A name with no colon is always the local
source, and the implied destination is usually the same name on the
remote (though it can be changed via config). The third paragraph of
"<refspec>..." under OPTIONS in "git help push" covers this, though I do
think it is a little hard to follow.

-Peff
