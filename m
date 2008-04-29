From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 04/13] Teach rebase interactive the mark command
Date: Tue, 29 Apr 2008 11:52:32 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804291147450.27457@eeepc-johanness>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org> <1208132469-26471-1-git-send-email-joerg@alea.gnuu.de> <1208132469-26471-2-git-send-email-joerg@alea.gnuu.de> <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de> <1208132469-26471-4-git-send-email-joerg@alea.gnuu.de>
 <7vabjm78v2.fsf@gitster.siamese.dyndns.org> <20080422095549.GB3752@alea.gnuu.de> <alpine.DEB.1.00.0804221127360.4460@eeepc-johanness> <7vy775ygjm.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804221810180.4460@eeepc-johanness> <7v3ap5a4ny.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804290138170.27457@eeepc-johanness> <7vk5ih8ckp.fsf@gitster.siamese.dyndns.org> <4816CA72.8070405@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Apr 29 12:53:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqnSQ-00061S-QW
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 12:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753605AbYD2KwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 06:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753711AbYD2KwW
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 06:52:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:49564 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752370AbYD2KwW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 06:52:22 -0400
Received: (qmail invoked by alias); 29 Apr 2008 10:52:20 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp043) with SMTP; 29 Apr 2008 12:52:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18NNtFXExoNejBgxYziz1oSgztgr7UWSjZw+PXH1z
	1Rrjww3x6peQR/
X-X-Sender: user@eeepc-johanness
In-Reply-To: <4816CA72.8070405@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80674>

Hi,

On Tue, 29 Apr 2008, Johannes Sixt wrote:

> Junio C Hamano schrieb:
> > This is just a minor syntax issue and I am not sure why we got into 
> > this misunderstanding, but let's try again.  Suppose you want to 
> > recreate this history on top of a different O'.  For merges, upper 
> > parents are earlier ones:
> > 
> >      A         reset O'
> >     / \        pick  B
> >    /   X       reset O'
> >   /   / \      pick A
> >  O---B   Z     merge B -- recreate X
> >   \   \ /      reset O'
> >    \   Y       pick C
> >     \ /        merge B? -- recreate Y
> >      C         reset B -- go back to recreated X
> >                merge B? -- recreate Z
> > 
> > The above sequence does not work.
> 
> Because it is hand-crafted. I'd expect rebase to suggest a series that 
> works as long as the user doesn't modify it. Like this:
> 
> 	reset O'
> 	pick C
> 	reset O'
> 	pick B
> 	merge C -- recreate Y
> 	reset O'
> 	pick A
> 	merge B -- recreate X
> 	merge Y -- recreate Z
> 
> Here all commit names are clearly the original in the first insn that 
> references it, and the rewritten version in later references. No marks 
> needed.
> 
> If the user modifies the insns, he better knows what he's doing, in 
> particular, when it's necessary to rebuild such complex histories.

I fully agree.  rebase -i is _not_ about the same goal as git-sequencer.  
rebase -i is about user interaction.  sequencer is about having a common 
plumbing for the different porcelains.

And of course, if you want to play games with rebase -i, you can _always_ 
use the "edit" command (even if you do not plan to edit) to get the commit 
name of the new commit.

And you can _always_ use the _full_ commit name to reference the original 
commit (at least that is how I planned it: the original _short_ name would 
be replaced by the rewritten commit name, but not the _long_ name).

Ciao,
Dscho
