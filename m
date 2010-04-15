From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] (resend) stash: Don't overwrite files that have
 gone from the index
Date: Thu, 15 Apr 2010 03:38:56 -0400
Message-ID: <20100415073856.GC27542@coredump.intra.peff.net>
References: <1271291062-32154-1-git-send-email-charles@hashpling.org>
 <1271291062-32154-2-git-send-email-charles@hashpling.org>
 <201004150933.41330.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Charles Bailey <charles@hashpling.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Apr 15 09:39:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2Jff-00082q-0b
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 09:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757376Ab0DOHj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 03:39:26 -0400
Received: from peff.net ([208.65.91.99]:46758 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756704Ab0DOHjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 03:39:25 -0400
Received: (qmail 14687 invoked by uid 107); 15 Apr 2010 07:39:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 15 Apr 2010 03:39:28 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Apr 2010 03:38:56 -0400
Content-Disposition: inline
In-Reply-To: <201004150933.41330.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144959>

On Thu, Apr 15, 2010 at 09:33:40AM +0200, Thomas Rast wrote:

> Charles Bailey wrote:
> > diff --git a/git-stash.sh b/git-stash.sh
> > index 908aab2..9efc544 100755
> > --- a/git-stash.sh
> > +++ b/git-stash.sh
> > @@ -87,6 +87,8 @@ create_stash () {
> >  			export GIT_INDEX_FILE &&
> >  			git read-tree -m $i_tree &&
> >  			git add -u &&
> > +			{ git diff --quiet --diff-filter=D --cached ||
> > +				git diff -z --name-only --diff-filter=D --cached | xargs -0 git add --ignore-errors; } &&
> 
> I think you'll also have to turn it into an 'add -f' invocation since
> the file in question could conceivably have been ignored-but-tracked,
> and straight 'add' would refuse to re-track it.
> 
> (No, I don't have any good ideas on how to get rid of xargs short of
> some shell loop...)

It should probably use update-index, which has a --stdin mode, and which
doesn't care about ignores.

-Peff

PS I have not looked carefully into this issue yet, so I don't know if
   the patch actually does the right thing or not.
