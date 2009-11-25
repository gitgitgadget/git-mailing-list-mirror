From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] grep: --full-tree
Date: Wed, 25 Nov 2009 16:49:49 -0500
Message-ID: <20091125214949.GA31473@coredump.intra.peff.net>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org>
 <20091125203922.GA18487@coredump.intra.peff.net>
 <7viqcytjic.fsf@alter.siamese.dyndns.org>
 <20091125210034.GC18487@coredump.intra.peff.net>
 <7vmy2as319.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 22:49:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDPkI-0007hc-1k
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 22:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934727AbZKYVtm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 16:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933357AbZKYVtm
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 16:49:42 -0500
Received: from peff.net ([208.65.91.99]:60823 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932983AbZKYVtl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 16:49:41 -0500
Received: (qmail 16450 invoked by uid 107); 25 Nov 2009 21:54:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 25 Nov 2009 16:54:12 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Nov 2009 16:49:49 -0500
Content-Disposition: inline
In-Reply-To: <7vmy2as319.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133679>

On Wed, Nov 25, 2009 at 01:33:22PM -0800, Junio C Hamano wrote:

> We could redefine get_pathspec() to treat a pathspec that begins with a
> slash to be anchored at the top, i.e.
> 
> 	$ git grep -e frotz /
> 
> would be a nicer way to spell
> 
> 	$ git grep --full-tree -e frotz

I do like that idea (and I cannot see any obvious flaw in it, though I
have only been think for a few minutes). I am not sure how useful it
will be for other commands. Conceptually I might use it for "diff" and
"status" (the new version that uses pathspecs sanely :) ), but those
commands generally aren't a big deal. I haven't touched anything in the
uninteresting subtree, so there is nothing to report.

Hmm. Actually, after having considered that, don't we actually allow
absolute paths in diff to do out-of-tree diffs? I haven't looked at how
that code interacts with get_pathspec.

> > Certainly I think that would be an improvement. But again, it suffers
> > from the "you must remember to do this" as above. I really want "git
> > grep" to Do What I Mean.
> 
> And /this-is-absolute is one way to tell "grep" What You Mean.  I do not
> claim it would be the _best_ way (I just concocted it up a few minutes ago
> without giving it deep thought).  Do you have a better alternative in
> mind?

Well, what I meant is that I shouldn't have to tell it each time what I
mean. I should be able to set up configuration so that it does what I
want (well, ideally, it would just read my mind, but I am willing to
concede that point). That is, I don't want to have to remember "git grep
--full-tree" or "git grep /" every time, because I am not likely to
notice when I forget. I want to set up "when I am in this directory,
this is probably what I want".

> My earlier "push is excusable" was primarily because "push" tends to be
> the _final_ action in the chain of events, as opposed to "ls-files" and
> "grep" output that are meant to be used by the user to _decide_ what to
> do next depending on what they find, and as such, the latter has more
> problem if they changed behaviour based on the configuration.

I'm not sure I really understand. "git grep" is routinely producing
wrong results for me _now_. I'd like to configure it so that it produces
results more sensible to me. If I am the one who sets the configuration
variable to something more sensible for my workflow, who am I hurting?

-Peff
