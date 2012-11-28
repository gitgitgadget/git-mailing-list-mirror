From: Jeff King <peff@peff.net>
Subject: Re: Python extension commands in git - request for policy change
Date: Tue, 27 Nov 2012 19:51:28 -0500
Message-ID: <20121128005128.GB23224@sigill.intra.peff.net>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
 <CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
 <50B1F684.5020805@alum.mit.edu>
 <CAMP44s0WYiV3hTE7u28_Wd59FkGfu3o_psS0gocpnibzN4--Fg@mail.gmail.com>
 <20121127143510.GA15831@google.com>
 <CAMP44s10krOPD73dL0Ancie=kussk89jK7V5adR3hw=a73CVWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Magnus =?utf-8?B?QsOkY2s=?= <baeck@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 01:51:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdVsP-0001sl-Qw
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 01:51:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754524Ab2K1Avb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 19:51:31 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58785 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754361Ab2K1Ava (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 19:51:30 -0500
Received: (qmail 31485 invoked by uid 107); 28 Nov 2012 00:52:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Nov 2012 19:52:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Nov 2012 19:51:28 -0500
Content-Disposition: inline
In-Reply-To: <CAMP44s10krOPD73dL0Ancie=kussk89jK7V5adR3hw=a73CVWw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210646>

On Wed, Nov 28, 2012 at 01:10:34AM +0100, Felipe Contreras wrote:

> > While "constant traffic" probably overstates the issue, these are not
> > theoretical problems. I recall at least three cases in the last year
> > or so where Git has seen breakage with Solaris or Mac OS X because
> > of sed or tr incompatibilities, and I don't even read this list that
> > thoroughly.
> 
> Most of the *constant* traffic is about *theoretical*
> incompatibilities, how much of that are real incompatibilities, it's
> not known. _Some_ of the traffic is about real incompatibilities,
> sure, but you could count only three cases *in a year*. It's not a
> huge amount. And then, how man this year?
> 
> Also, I would like references to those incompatibilities.

Try:

  git log --grep='portab' -- '*.sh'

Not all of the hits are shell portability fixes, but most of them are,
and they are all in response to real, reported issues. The usual
culprits are Solaris, BSD (including OS X), and the occasional GNUism.
And that is only the ones that we fixed in response to bug reports for
commits in the wild. Many more have been caught in review before needing
a separate patch (grepping the list archive for 'portable' and '\.sh'
yields 1800 messages).

So dealing with shell portability is definitely something we do, and it
is a minor pain.

But like you, I think we have been getting along reasonably well with
shell scripts (and where it is not powerful enough, writing C). No
solution is going to be free of portability issues (whether because of
differing versions, because the tool is uncommon on certain platforms,
or whatever). And because git-core's official API is shell-executable
commands, any other language you write ends up looking a lot like shell
anyway.

If people are really hankering to write sub-commands of git in python
(or whatever), I would suggest checking out libgit2 which has a nice set
of python bindings (and ruby bindings, and C# bindings, and so on). It
doesn't have feature parity with git-core yet, but they have been making
a lot of progress.

-Peff
