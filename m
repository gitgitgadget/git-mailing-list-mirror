From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Commit signing
Date: Mon, 15 Jan 2007 11:31:46 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701151126540.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701151000.58609.andyparkins@gmail.com> <20070115101529.GB12257@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 20:07:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6VVr-0000SI-Dd
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:20:51 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V9c-0003eK-R1
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:57:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbXAOKbt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 05:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbXAOKbs
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 05:31:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:47488 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932197AbXAOKbs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 05:31:48 -0500
Received: (qmail invoked by alias); 15 Jan 2007 10:31:46 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 15 Jan 2007 11:31:46 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070115101529.GB12257@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36862>

Hi,

On Mon, 15 Jan 2007, Shawn O. Pearce wrote:

> Andy Parkins <andyparkins@gmail.com> wrote:
> > I was just talking to another developer in my office about version control.  
> > He's working with Windows so has chosen Monotone for a version control 
> > system.  I didn't have any huge objections, as I'm sure monotone can be 
> > migrated to git without much trouble (they look to support the same features 
> > from my brief reading).
> > 
> > Of course my favourite is git, but we were talking about the certificates 
> > needed by monotone for each developer.  I assume that monotone therefore 
> > signs every commit.  It obviously crossed my mind as to how one would do that 
> > with git?  We obviously already have the ability to sign a tag, but is there 
> > a way in which one could sign every commit.
> > 
> > The more I think about it, the more it could be a reasonable question.  In my 
> > own repository I can obviously create whatever commits i like, claiming them 
> > to be from whomever I like just by altering a few config settings.  If I put 
> > a few of those in my own repository and then managed to persuade Junio to 
> > pull from me - wouldn't I have faked commits from another developer?  
> > However, I wouldn't be able to fake a gpg signature.
> 
> You could sign the content of the raw commit and include the signature
> in the payload, much like we do with tags.  E.g.:
> 
> 	tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
> 	parent 5064201cfd47822e567456fb1d6a76a5e81da800
> 	parent e6987d056595deace8cba91ce0a2524bb91770a9
> 	author Shawn O. Pearce <spearce.org> 1168855184 -0400
> 	committer Shawn O. Pearce <spearce.org> 1168855184 -0400
> 
> 	Merge branch 'branch' into 'master'.
> 
> 	-----BEGIN PGP SIGNATURE-----
> 	Version: GnuPG v1.4.6 (GNU/Linux)
> 
> 	iD8DBQBFiY2zwMbZpPMRm5oRAll0AJ0ZR+Bu8zjMVe8eEKR8Xr+3QMtndACcC2Kl
> 	aWSkKLptN0LAOpDinq+aqOc=
> 	=dZlu
> 	-----END PGP SIGNATURE-----
> 
> But that's horribly ugly and probably vast overkill.  Plus the only
> way to really verify each commit is to have the complete database of
> PGP public keys handy.  A commit-msg hook could probably implement
> the signing.

But it would only sign the _message_. You would have to sign the whole 
_raw_ commit message, to include also the ancestry. But there is no hook 
_between_ constructing that _raw_ commit message and actually writing the 
commit object (this would have to be in builtin-commit-tree.c:151).

Ciao,
Dscho
