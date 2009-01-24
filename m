From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Heads up: major rebase -i -p rework coming up
Date: Sat, 24 Jan 2009 22:04:53 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901242156320.14855@racer>
References: <alpine.DEB.1.00.0901242056070.14855@racer> <7vpricmoda.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Stephen Haberman <stephen@exigencecorp.com>,
	spearce@spearce.org, Thomas Rast <trast@student.ethz.ch>,
	=?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: Junio C Hamano <gitster@pobox.com>, Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat Jan 24 22:06:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQphO-0004Dx-QV
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 22:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755757AbZAXVE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 16:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755745AbZAXVE0
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 16:04:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:55844 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755614AbZAXVEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 16:04:25 -0500
Received: (qmail invoked by alias); 24 Jan 2009 21:04:23 -0000
Received: from pD9EB3F9A.dip0.t-ipconnect.de (EHLO noname) [217.235.63.154]
  by mail.gmx.net (mp046) with SMTP; 24 Jan 2009 22:04:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+K63MZYjOKczYWfj0sLd1rEET32/fDUST7r4S13T
	+I0eGG52vzDFys
X-X-Sender: gene099@racer
In-Reply-To: <7vpricmoda.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107008>

Hi,

On Sat, 24 Jan 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > 	pick A
> > 	pick C
> > 	pick D
> > 	goto A'
> > 	pick B
> > 	merge D' was E
> >
> > This should lead to a much more intuitive user experience.
> >
> > I am very sorry if somebody actually scripted rebase -i -p (by setting 
> > GIT_EDITOR with a script), but I am very certain that this cleanup is 
> > absolutely necessary to make rebase -i -p useful.
> 
> Three questions.
> 
> - An obvious one first.  How does this relate to the sequencer project 
>   (that seems to have gone somewhat dark?)

As far as I can see, Stephan can keep the "mark" command he cherishes so 
much, and we can still use thise syntax for rebase -i -p.

> - What's with the apostrophe?  I seem to remember that you argued it 
>   would be enough to make "A" stand for the original when it is used for 
>   the first time and the second and later use can stand for the result 
>   of the last use (e.g. the "goto A'" above can be simply spelled as 
>   "goto A"), when I suggested to use "mark" in a way similar to how 
>   fast-import language uses it during the sequencer discussion?
> 
>   I am not complaining; I am just being curious why the sudden change of 
>   heart.

Very easy explanation.  I got convinced by your arguments.  Even if I 
could imagine that I never use the thing without apostrophe, it is good to 
have an obvious indicator that this is not necessarily the original 
commit.

> - Why do you need "merge D' was E"?  Shouldn't "pick E" be able to 
>   notice that E is a merge and decompose it into "merge D' was E" 
>   internally?
> 
>   This one I am somewhat complaining, unless your answer is "because 
>   this way the user could drop some parents from the merge in the 
>   editor".

Not only that; the user could use this to fix mismerges, i.e. by replacing 
a SHA-1 with the SHA-1 (or indeed, a short name, unless it is "was") of 
the branch that she _actually_ wanted to merge with.

>   And if your answer is that, then my next question will be "if that is 
>   the case, can the user be expected to easily find out which commit 
>   each parent SHA-1 refers to, without having more hint on the 'merge' 
>   insn line?"

Nope.

In most cases, however, that should be plenty enough:

	merge 9383af1' was f39d50a Merge branch 'mh/unify-color' into next

The user does not have to guess much what 9383af1 might refer to.

In case of octopodes, or when the commit message was changed, the user has 
to open another command line and look for herself, though.

Ciao,
Dscho
