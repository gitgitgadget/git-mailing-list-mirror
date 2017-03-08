Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7369202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 17:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753926AbdCHR6t (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 12:58:49 -0500
Received: from quickstop.soohrt.org ([85.131.246.152]:37869 "EHLO
        quickstop.soohrt.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753904AbdCHR6r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 12:58:47 -0500
Received: (qmail 2549 invoked by uid 1014); 8 Mar 2017 17:58:44 -0000
Date:   Wed, 8 Mar 2017 18:58:44 +0100
From:   Horst Schirmeier <horst@schirmeier.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/6] deadlock regression in v2.11.0 with failed mkdtemp
Message-ID: <20170308175844.GG7566@quickstop.soohrt.org>
References: <20170307110328.GE7566@quickstop.soohrt.org>
 <20170307111406.GB1955@quickstop.soohrt.org>
 <20170307133437.qee2jtynbiwf6uzr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170307133437.qee2jtynbiwf6uzr@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 07 Mar 2017, Jeff King wrote:
> On Tue, Mar 07, 2017 at 12:14:06PM +0100, Horst Schirmeier wrote:
> > On Tue, 07 Mar 2017, Horst Schirmeier wrote:
> > > I observe a regression that seems to have been introduced between
> > > v2.10.0 and v2.11.0.  When I try to push into a repository on the local
> > > filesystem that belongs to another user and has not explicitly been
> > > prepared for shared use, v2.11.0 shows some of the usual diagnostic
> > > output and then freezes instead of announcing why it failed to push.
> > 
> > Bisecting points to v2.10.1-373-g722ff7f:
> > 
> > 722ff7f876c8a2ad99c42434f58af098e61b96e8 is the first bad commit
> > commit 722ff7f876c8a2ad99c42434f58af098e61b96e8
> > Author: Jeff King <peff@peff.net>
> > Date:   Mon Oct 3 16:49:14 2016 -0400
> > 
> >     receive-pack: quarantine objects until pre-receive accepts
> 
> Thanks, I was able to reproduce easily with:
> 
>   git init --bare foo.git
>   chown -R nobody foo.git
>   git push foo.git HEAD
> 
> Here's a series to fix it. The first patch addresses the deadlock. The
> rest try to improve the output on the client side. With v2.10.0, this
> case looks like:
> 
>   $ git push ~/tmp/foo.git HEAD
>   Counting objects: 209837, done.
>   Delta compression using up to 8 threads.
>   Compressing objects: 100% (52180/52180), done.
>   remote: fatal: Unable to create temporary file '/home/peff/tmp/foo.git/./objects/pack/tmp_pack_XXXXXX': Permission denied
>   error: failed to push some refs to '/home/peff/tmp/foo.git'

I tested your jk/push-deadlock-regression-fix branch in my local clone,
your patches fix the problem for me.  Thanks!

Horst

-- 
PGP-Key 0xD40E0E7A
