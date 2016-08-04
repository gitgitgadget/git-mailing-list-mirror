Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 893281F855
	for <e@80x24.org>; Thu,  4 Aug 2016 22:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbcHDWlK (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 18:41:10 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:57246 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758746AbcHDWlH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 18:41:07 -0400
Received: from x (unknown [IPv6:2605:e000:d5ce:1e00:c5f5:b7bf:c731:5d3f])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 658C3A80BF;
	Fri,  5 Aug 2016 00:41:01 +0200 (CEST)
Date:	Thu, 4 Aug 2016 12:40:58 -1000
From:	Josh Triplett <josh@joshtriplett.org>
To:	Richard Ipsum <richard.ipsum@codethink.co.uk>
Cc:	git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] git-series: track changes to a patch series over time
Message-ID: <20160804224058.po43kl7w26ockfie@x>
References: <20160729064055.GB25331@x>
 <20160803191202.GA22881@salo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160803191202.GA22881@salo>
User-Agent: Mutt/1.6.2-neo (2016-07-23)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 03, 2016 at 08:12:02PM +0100, Richard Ipsum wrote:
> On Thu, Jul 28, 2016 at 11:40:55PM -0700, Josh Triplett wrote:
> > I'd welcome any feedback, whether on the interface and workflow, the
> > internals and collaboration, ideas on presenting diffs of patch series,
> > or anything else.
> 
> One other nice thing I've noticed about this tool is the
> way series behave like regular git branches: I specify the name
> of the series and from then on all other commands act on that
> series until told otherwise.

Thanks; I spent a while thinking about that part of the workflow.  I
save the current series as a symbolic ref SHEAD, and everything operates
on SHEAD.  (I should probably add support for running things like "git
series log" or "git series format" on a different series, because right
now "until told otherwise" doesn't include a way to tell it otherwise.)

One fun detail that took a couple of iterations to get right: I keep
separate "staged" and "working" versions per-series, so even with
outstanding changes to the cover letter, base, or series, you can always
detach or checkout another series without losing anything.  If you
switch back, all your staged and unstaged changes will remain staged and
unstaged where you left them.  That solves the "checkout a different
series with modifications to the current series" case.

> git-appraise looks as though it might also have this behaviour.
> I think it's a nice way to do it, since you don't generally
> perform more than one review simultaneously. So I may well
> use this idea in git-candidate if it's okay. :)

By all means.  For a review tool like git-candidate, it seems like you'd
want even more contextual information, to make it easier to specify
things like "comment on file F line L".  For instance, what if you
spawned the diff to review in an editor, with plenty of extra context
and a file extension that'll cause most editors to recognize it as a
patch (and specifically a git-candidate patch to allow specialized
editor modes), and told people to add their comments after the line they
applied to?  When the editor exits successfully, you can scan the file,
detect the added lines, and save those as comments.  You could figure
out the appropriate line by looking for the diff hunk headers and
counting line numbers.

If you use a format-patch diff that includes the headers and commit
message, you could also support commenting on those in the same way.
Does the notedb format support commenting on those?

> I haven't found time to use the tool to do any serious review
> yet, but I'll try and post some more feedback when I do.

Thanks!

- Josh Triplett
