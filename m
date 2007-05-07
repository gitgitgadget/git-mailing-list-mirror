From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] submodule merge support
Date: Mon, 07 May 2007 12:30:30 +0200
Organization: eudaptics software gmbh
Message-ID: <463EFFC6.12A1B0A1@eudaptics.com>
References: <20070506190224.GG30511@admingilde.org> <20070506220745.GA2439@steel.home> <alpine.LFD.0.98.0705061517380.12945@woody.linux-foundation.org> <20070507090346.GI30511@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 12:30:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hl0UL-00080e-RJ
	for gcvg-git@gmane.org; Mon, 07 May 2007 12:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754320AbXEGKaj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 06:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754322AbXEGKai
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 06:30:38 -0400
Received: from main.gmane.org ([80.91.229.2]:35058 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754315AbXEGKai (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 06:30:38 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hl0UA-0008GO-Si
	for git@vger.kernel.org; Mon, 07 May 2007 12:30:30 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 07 May 2007 12:30:30 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 07 May 2007 12:30:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46439>

Martin Waitz wrote:
> On Sun, May 06, 2007 at 03:18:53PM -0700, Linus Torvalds wrote:
> > On Mon, 7 May 2007, Alex Riesen wrote:
> > > How about making all existing strategies just ignore submodules, and
> > > move recursive merge in the merge driver (git-merge.sh)?
> >
> > Yes, I think that's the right thing to do.
> >
> > I think it's the right thing for another reason: in a true "recursive"
> > merge, the submodules shouldn't be recursively merged anyway. *THEIR*
> > merge will have its own history, and doing it based on some random history
> > of the superproject is actually wrong anyway!
> 
> Of course the submodule has to get its own history, it's not possible
> to do otherwise.  But you have to trigger the submodule merge when you
> find a submodule-level conflict in the supermodule merge, just as
> you trigger file-level three-way merges, too.

I think you missed Linus's point: If the supermodule's merge leads to a
conflict in the submodule links, it is not appropriate to merge the
submodule.

Say you are merging commits A and B in the supermodule, and A uses v1.0
of the submodule and B uses v2.0 of submodule, then you can't just merge
v1.0 and v2.0 - instead, you have to make a decision whether the
supermodule's merge result is going to use v1.0 or v2.0 or even
something different like v2.1. An automatic merge cannot make this
decision for you (unless there was no conflict in the first place).

-- Hannes
