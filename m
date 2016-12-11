Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BE921FF40
	for <e@80x24.org>; Sun, 11 Dec 2016 23:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754023AbcLKXnF (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Dec 2016 18:43:05 -0500
Received: from ozlabs.org ([103.22.144.67]:56997 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753944AbcLKXnE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Dec 2016 18:43:04 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
        id 3tcMwP2Hphz9t15; Mon, 12 Dec 2016 10:43:01 +1100 (AEDT)
Date:   Mon, 12 Dec 2016 10:25:02 +1100
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Michael Rappazzo <rappazzo@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/2] gitk: alter the ordering for the "Tags and heads"
 view
Message-ID: <20161211232502.GA18316@fergus.ozlabs.ibm.com>
References: <1459091168-46908-1-git-send-email-rappazzo@gmail.com>
 <1459091168-46908-2-git-send-email-rappazzo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1459091168-46908-2-git-send-email-rappazzo@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 27, 2016 at 11:06:07AM -0400, Michael Rappazzo wrote:
> In the "Tags and heads" view, the list of refs is globally sorted.
> Because of this, the list of local refs (heads) can be interrupted by the
> list of remote refs.  This change re-orders the view to be: local refs,
> remote refs tracked by local refs, remote refs, tags, and then other refs.
> 
> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>

This all looks OK except for the fact that the loop immediately below
the code you've modified (the loop that adds or deletes lines from the
actual displayed list) relies on the entries being in sorted order.
With your patch the entries are no longer strictly in sorted order, so
that display update loop will have to become a bit smarter too.  As it
is, I think that there will be cases where we will delete a lot of
lines and then re-add them.  If the user had scrolled the list to a
particular point that was within these deleted lines, the display will
scroll away from that point, which will be annoying.

Paul.
