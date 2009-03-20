From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH v4] Introduce %<branch> as shortcut to the tracked
 branch
Date: Fri, 20 Mar 2009 23:08:42 +0000 (GMT)
Message-ID: <alpine.LNX.2.00.0903202300330.13726@reaper.quantumfyre.co.uk>
References: <200903181448.50706.agruen@suse.de> <20090318182603.GM8940@machine.or.cz> <alpine.DEB.1.00.0903182210310.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903182245280.10279@pacific.mpi-cbg.de> <7vr60ubgul.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0903182343580.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200121330.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200137230.10279@pacific.mpi-cbg.de> <20090320004029.GX23521@spearce.org> <20090320004450.GY23521@spearce.org>
 <alpine.DEB.1.00.0903201027450.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903201714020.10279@pacific.mpi-cbg.de> <7v7i2ki0sw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Petr Baudis <pasky@suse.cz>,
	Andreas Gruenbacher <agruen@suse.de>, B.Steinbrink@gmx.de,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 00:15:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lknvs-0004TI-O3
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 00:15:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422AbZCTXLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 19:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752475AbZCTXLG
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 19:11:06 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:52737 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751069AbZCTXLF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2009 19:11:05 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 9DF537812E4
	for <git@vger.kernel.org>; Fri, 20 Mar 2009 23:11:02 +0000 (GMT)
Received: (qmail 24002 invoked by uid 103); 20 Mar 2009 23:08:42 +0000
Received: from darkphoton.datavampyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.94.2/9142. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.027141 secs); 20 Mar 2009 23:08:42 -0000
Received: from darkphoton.datavampyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 20 Mar 2009 23:08:42 +0000
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <7v7i2ki0sw.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114015>

On Fri, 20 Mar 2009, Junio C Hamano wrote:

> An most obvious one is that "git checkout branchname" and "git checkout
> refs/heads/branchname" behave differently.  You cannot checkout a branch
> called %master after this patch goes in.
>
> Just be honest and say "You may have a branch whose name begins with a '%'
> and you cannot refer to it anymore in certain contexts.  Too bad.  Don't
> do it next time you create a new branch".  I _can_ buy that argument.
>
> It however asks for a sane escape hatch.  You cannot "fix" such branch
> names in most obvious ways (if you could, that would be a bug in this %
> feature).
>
> (1) git branch -m %master percent-master
>
>     We would end up renaming what master tracks to new name.
>
> (2) git branch percent-master refs/heads/%master; git branch -d %master
>
>     The first part is a good try, but the latter deletes what master
>     tracks.

How about adding a generic escape hatch, that would cover this and 
future extensions?

Let a ref that starts with a single quote be taken as given and not 
processed.  You have to escape it to get it past the shell, but that makes 
it rather unlikely that anyone has used a name that starts with a quote - 
and if they have you can still use this mechanism to rename it.

So now (1) above could be written:

  git branch -m "'%master" percent-master

and other commands, such as

  git branch -d "'%master"

or

  git checkout "'%master"

would also do the right thing (i.e. use refs/heads/%master as a branch).

-- 
Julian

  ---
Stewie Griffin:  [looking in the fridge for a drink] Soda... purple stuff... Sunny D, all right!
