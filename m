From: Jeff King <peff@peff.net>
Subject: Re: git branch: multiple --merged and --no-merged options?
Date: Fri, 22 Mar 2013 13:50:34 -0400
Message-ID: <20130322175034.GB29011@sigill.intra.peff.net>
References: <87fvzwmp23.fsf@59A2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jed Brown <jed@59A2.org>
X-From: git-owner@vger.kernel.org Fri Mar 22 18:51:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ67T-0008JS-97
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 18:51:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422735Ab3CVRuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 13:50:44 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:35936 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422678Ab3CVRun (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 13:50:43 -0400
Received: (qmail 3096 invoked by uid 107); 22 Mar 2013 17:52:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Mar 2013 13:52:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Mar 2013 13:50:34 -0400
Content-Disposition: inline
In-Reply-To: <87fvzwmp23.fsf@59A2.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218828>

On Fri, Mar 15, 2013 at 02:38:12PM -0500, Jed Brown wrote:

> I find myself frequently running commands like this
> 
>   $ comm -12 <(git branch --no-merged master) <(git branch --merged next)

That's a reasonable thing to want to do.

> when checking for graduation candidates. Of course I first tried
> 
>   $ git branch --no-merged master --merged next

Yeah, sadly that does not work, as we use the same slot for the flag and
store only one of the two (and we also allow only one "--merged" head,
even though you could in theory want to know "merged to X, or merged to
Y"). I do not think there is a reason we could handle both. I think we
could even do it with a single traversal, but even with two traversals,
doing both in-process will be faster (because we only have to pull the
commits from disk once).

So I think it is something that ought to work, but it will need some
code written. Patches welcome. ;)

-Peff
