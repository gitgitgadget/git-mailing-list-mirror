From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH] Add color to git-add--interactive diffs (Total
	different idea to solve the problem)
Date: Tue, 23 Oct 2007 07:34:01 +0200
Message-ID: <20071023053401.GB9330@xp.machine.xx>
References: <1192351494.7226.18.camel@athena> <20071022204719.GA23348@xp.machine.xx> <Pine.LNX.4.64.0710230054130.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tom Tobin <korpios@korpios.com>, Dan Zwell <dzwell@gmail.com>,
	Jonathan del Strother <maillist@steelskies.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 23 07:34:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkCPP-0004iG-RT
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 07:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbXJWFeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 01:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751992AbXJWFeH
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 01:34:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:54696 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751968AbXJWFeG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 01:34:06 -0400
Received: (qmail invoked by alias); 23 Oct 2007 05:34:03 -0000
Received: from mason.hofmann.stw.uni-erlangen.de (EHLO localhost) [131.188.24.36]
  by mail.gmx.net (mp009) with SMTP; 23 Oct 2007 07:34:03 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1+9eEwPZj69bBtorekX9KOSFyzQMOn6/v+q++33Oc
	CTgykijq5Jomfw
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710230054130.25221@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62093>

On Tue, Oct 23, 2007 at 12:55:44AM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 22 Oct 2007, Peter Baumann wrote:
> 
> > Wouldn't it make more sense to implement the diff coloring inside git 
> > apply so that you could use something like
> > 
> >         diff file1 file2|git apply --color
> > 
> > to make the generated diff with colors [1]? It already implements the
> > same semantic for generating a diffstat, using
> > 
> >         diff file1 file2|git apply --stat
> 
> No.  In both cases, "git diff" realises that the output is no terminal, 
> and switches off color generation.  (Just try with diff.color=true instead 
> of =auto.)
> 

I didn't mean git-diff here, instead I meant diff, so no coloring involved
on the diff side. The git-apply would be enhanced to do the coloring on
every diff it gets on its STDIN.

In the git-add -i case, the perl script whould do something along these
lines:

	foreach my $file (@files) {
		# read in the diff of a file *WITHOUT* using color
		@diff = `git-diff-files $file`;

		# ... store it away for later use in hunk selection ...


		# print out a nice colored diff for the user
		`echo @diff | git apply --color`
	}

Instead of handcoding the colorization in the git-add--interactive perl
script, just enhance git-apply to do the colorization *after the fact* for
you on _any_ patch you throw at it in its STDIN.

-Peter
