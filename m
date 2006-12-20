X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add log.fulldiff config option
Date: Wed, 20 Dec 2006 03:58:12 -0500
Message-ID: <20061220085812.GB6895@coredump.intra.peff.net>
References: <20061220060102.GA540@coredump.intra.peff.net> <7v8xh3j86h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 08:58:26 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7v8xh3j86h.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34911>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwxHF-0003GR-Ha for gcvg-git@gmane.org; Wed, 20 Dec
 2006 09:58:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964942AbWLTI6O (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 03:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbWLTI6O
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 03:58:14 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:38715
 "HELO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id
 S964942AbWLTI6O (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 03:58:14 -0500
Received: (qmail 23908 invoked from network); 20 Dec 2006 03:58:13 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2) by
 66-23-211-5.clients.speedfactory.net with SMTP; 20 Dec 2006 03:58:13 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Dec
 2006 03:58:12 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Wed, Dec 20, 2006 at 12:14:14AM -0800, Junio C Hamano wrote:

> > Also, should this instead be diff.fulldiff?
> 
> Probably not.

Based on your explanation, I think that makes sense.

> > Also also, I was going to submit a patch to document --full-diff,
> > but I had a few questions. Should it go in diff-options? That makes some
> > sense to me, but the parsing actually happens in setup_revisions.
> 
> Not at all.

Then where should it go? whatchanged and log have a great deal of
overlap in terms of parsing, but they don't seem to share any
documentation (or note the fact that git-whatchanged is basically just
git-log -p).

> > Furthermore, it seems to do the same thing as --pickaxe-all. Should we
> > try to combine these?
> 
> No.

Thanks for the thorough explanation. I think this makes my config option
description a little bit off, then, since it doesn't actually show all
of the changed files for a commit in the case of pickaxe.

What has me confused, then, is that you said this:

> I typically do:
> 
>         git log --full-diff -p -SCOLLISION
> 
> The --full-diff option helps because it shows the diff for other
> files (that do not have different number of substring COLLISION
> in the pre and postimage) in the same commit as well.

But that isn't the case, AFAIK (e.g., the command line you mention shows
only changes to sha1_file.c in commit aac17941, but cache.h was also
changed). Did you mean --pickaxe-all?

> Your understanding needs to be clarified on how paths are
> filtered, and how log family and diff interacts, and probably
> these need to be better documented.

To be honest, I'm not sure when one would really _want_ the flexibility
this provides. It might be more intuitive to git-{log,whatchanged} users
to have a single option (config and command line) to set --full-diff and
--pickaxe-all together. At the very least, I think I now want a
diff.pickaxeall config option.

