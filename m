Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F1DF1F462
	for <e@80x24.org>; Mon,  3 Jun 2019 10:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfFCKzx (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 06:55:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:44434 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726645AbfFCKzx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 06:55:53 -0400
Received: (qmail 12710 invoked by uid 109); 3 Jun 2019 10:55:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 03 Jun 2019 10:55:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3194 invoked by uid 111); 3 Jun 2019 10:56:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 03 Jun 2019 06:56:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Jun 2019 06:55:36 -0400
Date:   Mon, 3 Jun 2019 06:55:36 -0400
From:   Jeff King <peff@peff.net>
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: Antw: Re: Q: git describe --always --tags .. gives "warning: tag
 'tag1' is really 'tag2' here"
Message-ID: <20190603105536.GA12649@sigill.intra.peff.net>
References: <5CEE38B4020000A1000317C6@gwsmtp.uni-regensburg.de>
 <5CEE38B4020000A1000317C6@gwsmtp.uni-regensburg.de>
 <xmqqd0k1ywal.fsf@gitster-ct.c.googlers.com>
 <5CF4B8FE020000A100031962@gwsmtp.uni-regensburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5CF4B8FE020000A100031962@gwsmtp.uni-regensburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 03, 2019 at 08:06:54AM +0200, Ulrich Windl wrote:

> > Imagine you have only v1.0.0 (which is with known issues) but
> > somebody did "cd .git/refs/tags && mv v1.0.0 v1.1.0" in an attempt
> > to fool you.  The fact that your 'master' is a bit ahead of the
> > commit that was tagged with the tag object (which is v1.0.0 but
> > pretending to be v1.1.0) can be seen with "describe", but the
> > command is careful enough to use the real version number
> > (i.e. v1.0.0) and not the refname (i.e. v1.1.0).
> 
> Still I'm missing a verbose version of "git tag" that shows the commit IDs
> along with the tag names. Unfortunately "-v" is not "--verbose" but "--verify"
> (as opposed to "git remote" for example).

You can use for-each-ref format strings with "git tag" these days. E.g.:

  git tag --list --format='%(refname:short) %(tag) %(*objecttype) %(*objectname)'

will show each tag with its refname and tag-object name (which generally
match, but would not in the case discussed here), and then the type and
oid of the pointed-to thing (the "*" is a "dereference").

-Peff
