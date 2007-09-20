From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-rev-list --invert-match
Date: Thu, 20 Sep 2007 14:12:54 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709201403540.28395@racer.site>
References: <20070919202615.GK3076@jukie.net> <Pine.LNX.4.64.0709201132381.28395@racer.site>
 <20070920123849.GD12076@jukie.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bart Trojanowski <bart@jukie.net>
X-From: git-owner@vger.kernel.org Thu Sep 20 15:14:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYLrJ-0001Ih-Pt
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 15:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037AbXITNNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 09:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753992AbXITNNt
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 09:13:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:35988 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753940AbXITNNs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 09:13:48 -0400
Received: (qmail invoked by alias); 20 Sep 2007 13:13:46 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp031) with SMTP; 20 Sep 2007 15:13:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Q61Ab8SAQiyNCTQRBXdQn8HtAs24dtnAY/xm3J5
	6iYUpCl23Ai7FN
X-X-Sender: gene099@racer.site
In-Reply-To: <20070920123849.GD12076@jukie.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58776>

Hi,

On Thu, 20 Sep 2007, Bart Trojanowski wrote:

> * Johannes Schindelin <Johannes.Schindelin@gmx.de> [070920 06:34]:
> > On Wed, 19 Sep 2007, Bart Trojanowski wrote:
> > >   git log --invert-match --grep="uninteresting"
> > 
> > IMHO this is only half a solution.  Some of us want to say "git log 
> > --grep=this --but-not-(in-the-whole-message) --grep=that".
> 
> I have noticed that unique negation flags are getting scarce... we
> already have --reverse, --inverse, and --not  mean something elsewhere.
> --but-not maybe be good.
> 
> I also agree that git-grep could use this extension.
> 
> Anyways, I can see four solutions for adding "show me this but not that"
> functionality to git-rev-list:
> 
>  1) adding a --but-not flag, as you suggested.  It separates positive
>     matches that precede it with negative matches that follow.
> 
>   Example:
>     git log --grep=this --but-not --grep=that --committer="${MY_EMAIL}"

That is basically the approach taken by

http://article.gmane.org/gmane.comp.version-control.git/51874

(Yes, since you refused to search in the mailing list archives, I did it 
for you... this time!)

>  2) Adding --not-grep, --not-author, --not-committer which add negative
>     matches.  Maybe even --grep!=PATTERN, --author!=PATTERN, ...
> 
>   Example:
>     git log --grep=this --not-grep=that --committer!="${MY_EMAIL}"

That sounds sensible.

>  3) Extending the PATTERN we accept in --grep, --author, and --committer,
>     such that a prefix in the pattern tells us how to use the match:
>     --grep=!PATTERN
> 
>   Example:
>     git log --grep=this --grep='!that' --committer="!${MY_EMAIL}"

Now you can no longer avoid defining clean semantics: what does that mean?  
Does it mean that there is _one_ line that does not have "that" in it, or 
is it the complete message?

Further, it probably makes sense to have the option to say _both_: "Find 
me a commit that contains Bart in one line, but not Simpson, and that 
does not contain the word "Sverdoolaege" at all."

>  4) (going on a limb here) Can this kind of match be done with perl
>     regular expressions?  Maybe we could use --perl-regexp
> 
>   Example:
>     I've got nothing :)

This time you'll have to find the thread yourself.  Hint: search for pcre.

Ciao,
Dscho
