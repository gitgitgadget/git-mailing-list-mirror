From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] git-commit: '--no-status' Allow suppression of status
	summary in commit msg
Date: Thu, 28 Aug 2008 21:34:23 +0200
Message-ID: <20080828193423.GA6825@blimp.local>
References: <1219949215-10189-1-git-send-email-marcus@griep.us> <7vd4jtdki8.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marcus Griep <marcus@griep.us>,
	Git Mailing List <git@vger.kernel.org>,
	Marius Storm-Olsen <mstormo_git@storm-olsen.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 21:36:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYnHH-0007mm-Im
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 21:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048AbYH1Te1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 15:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753523AbYH1Te1
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 15:34:27 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:21753 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005AbYH1Te0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 15:34:26 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20hf4kO7
Received: from tigra.home (Faa1f.f.strato-dslnet.de [195.4.170.31])
	by post.webmailer.de (mrclete mo48) (RZmta 16.47)
	with ESMTP id R03130k7SJ3Id4 ; Thu, 28 Aug 2008 21:34:24 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 09100277AE;
	Thu, 28 Aug 2008 21:34:24 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 020EB36D1D; Thu, 28 Aug 2008 21:34:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vd4jtdki8.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94124>

Junio C Hamano, Thu, Aug 28, 2008 21:09:35 +0200:
> Marcus Griep <marcus@griep.us> writes:
> 
> > Currently, using any editor to edit a commit message for 'git commit'
> > kicks of a 'git status' which is then included as comments to give
> > the commit author some context. However, in some situations, such as
> > having a working tree of many hundred thousand files or on an inefficient
> > filesystem,
> 
> I am not interested in this particular patch, especially the part that
> hoards a short-and-nice -S flag that we could use for something more
> useful.  Also calling the configuration variable "nostatus" is backwards;
> I'd name it to "showstatus" that defaults to "true" if I were doing this.

I like it (almost. I agree, it is not a very good idea to use up "-S"
for such a thing). Not because of "inefficient filesystem" (I have
proper systems at home), but because I more often need no file list in
the commit message than I do need one. It is just annoyance.  OTOH,
maybe I'm just too used to put things in the index and trust that. Or
maybe it is again that stupid user-friendliness.

> If that is not still enough for your particular use case, I think you can
> have a custom wrapper that does:
> 
> 	#!/bin/sh
> 	: >.log-message-file &&
>         vi .log-message-file &&
>         git commit -F .log-message-file "$@" &&
>         rm -f .log-message-file 
> 
> without touching git at all.

That's not enough. Consider "-mMessage -e", "-t" or "-c" flags of git
commit. The wrapper would have to catch them all! Not to mention the
future flags in the same ballpark.

ATM, I just use that "--cached" (from the patch I mentioned in the
other mail) with "--cleanup=verbatim" to get the commit message just
how I like them.
