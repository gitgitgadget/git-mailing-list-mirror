From: Jeff King <peff@peff.net>
Subject: Re: git-subtree
Date: Thu, 5 Jan 2012 10:47:40 -0500
Message-ID: <20120105154740.GA11475@sigill.intra.peff.net>
References: <nngaa638nwf.fsf@transit.us.cray.com>
 <CALkWK0nU9iO_6CCbWw8c_Fz=xodkaAW4300Jpc7M7D+kBP=QRg@mail.gmail.com>
 <87ipkq199w.fsf@smith.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Greene <dag@cray.com>, git@vger.kernel.org
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Thu Jan 05 16:47:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RipXf-0006lE-G7
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 16:47:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757529Ab2AEPrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jan 2012 10:47:43 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58248
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755164Ab2AEPrm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jan 2012 10:47:42 -0500
Received: (qmail 28295 invoked by uid 107); 5 Jan 2012 15:54:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 Jan 2012 10:54:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Jan 2012 10:47:40 -0500
Content-Disposition: inline
In-Reply-To: <87ipkq199w.fsf@smith.obbligato.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187984>

On Thu, Jan 05, 2012 at 09:03:38AM -0600, David A. Greene wrote:

> > Please read and follow the guidelines listed in
> > Documentation/SubmittingPatches.  The TL;DR version is: break it up
> > into logical reviewable commits based on the current `master` and use
> > git format-patch/ git send-email to send those commits to this mailing
> > list.
> 
> I've read that document.  The issue is that I didn't develop the code,
> Avery did.  This is a completely new tool for git and I don't have the
> first idea of what "logical" chunks would look like.  I assume, for
> example, that we'd want the first "chunk" to actually work and do
> something interesting.  I can go spend a bunch of time to see if I can
> grok enough to create these chunks but I wanted to check first and make
> sure that would be absolutely necessary.  It's a lot of time to learn a
> completely new codebase.  I was hoping to submit something soon and then
> learn the codebase gradually during maintenance/further development.

I think this is also somewhat different in that git-subtree has a
multi-year history in git that we may want to keep. So it is more
analogous to something like gitweb or git-gui, which we have brought in
(using subtree merges, no less).

The biggest decision is whether or not to import the existing history.
If we do, then we have to decide whether it becomes a sub-component like
gitweb (e.g., it gets pulled into a "subtree" directory, and we have
make recurse into it), or whether it gets overlaid into the main
directory (i.e., we clean and munge the subtree repo a bit, then just
"git merge" the history in).

If we want to throw away the existing history, then I think you end up
doing the same munging as the latter option above, and then just make a
single patch out of it instead of a merge.

I don't use git-subtree, but just glancing over the repo, it looks like
that munging is mostly:

  1. git-subtree.sh stays, and gets added to git.git's top-level Makefile

  2. the test.sh script gets adapted into t/tXXXX-subtree.sh

  3. git-subtree.txt goes into Documentation/

  4. The rest of the files are infrastructure that can go away, as they
     are a subset of what git.git already contains.

I'd favor keeping the history and doing the munge-overlay thing.
Although part of me wants to join the histories in a subtree so that we
can use "git subtree" to do it (which would just be cool), I think the
resulting code layout doesn't make much sense unless git-subtree is
going to be maintained separately.

-Peff
