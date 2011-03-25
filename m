From: Jeff King <peff@peff.net>
Subject: Re: Why git silently replaces untracked files?
Date: Fri, 25 Mar 2011 14:06:44 -0400
Message-ID: <20110325180644.GA30838@sigill.intra.peff.net>
References: <1301064754576-6207950.post@n2.nabble.com>
 <20110325165811.GB25851@sigill.intra.peff.net>
 <1301075628970-6208585.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "igor.mikushkin" <igor.mikushkin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 19:06:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3BPQ-0003hJ-Jg
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 19:06:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754559Ab1CYSGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 14:06:47 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50396
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754257Ab1CYSGq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 14:06:46 -0400
Received: (qmail 16166 invoked by uid 107); 25 Mar 2011 18:07:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Mar 2011 14:07:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Mar 2011 14:06:44 -0400
Content-Disposition: inline
In-Reply-To: <1301075628970-6208585.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170007>

On Fri, Mar 25, 2011 at 10:53:48AM -0700, igor.mikushkin wrote:

> > diff --git a/git-pull.sh b/git-pull.sh
> > index a3159c3..fb9e2df 100755
> > --- a/git-pull.sh
> > +++ b/git-pull.sh
> > @@ -253,7 +253,7 @@ esac
> >  if test -z &quot;$orig_head&quot;
> >  then
> >  	git update-ref -m &quot;initial pull&quot; HEAD $merge_head
> > &quot;$curr_head&quot; &amp;&amp;
> > -	git read-tree --reset -u HEAD || exit 1
> > +	git read-tree -m -u HEAD || exit 1
> >  	exit
> >  fi
> > 
> > Though I don't know if there are any cases where the --reset would be
> > beneficial over &quot;-m&quot;. I couldn't think of any.
> > 
> 
> Thanks Jeff,
> My opinion is that you are right and merging is best here
> (Though just fail would be probably OK either).
> Love one line fixes.

It will fail with "untracked file 'test' would be overwritten..."; it's
just that --reset turns off the safety features of read-tree, which I
don't see a point in doing.

While looking at this, I also noticed that "git merge" behaves in a
funny way on this case. So I came up with this patch series:

  [1/4]: t7607: mark known breakage in test 11 as fixed
  [2/4]: t7607: clean up stray untracked file
  [3/4]: merge: merge unborn index before setting ref
  [4/4]: pull: do not clobber untracked files on initial pull

-Peff
