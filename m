From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix t6031 on filesystems without working exec bit
Date: Mon, 19 May 2008 08:00:15 +0200
Message-ID: <20080519060015.GA3179@steel.home>
References: <20080518145727.GA3058@steel.home> <7v7idqaocb.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 19 08:01:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxyQo-0006NE-Bb
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 08:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603AbYESGAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 02:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752686AbYESGAT
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 02:00:19 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:26600 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559AbYESGAR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 02:00:17 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarAeHyHI8Q==
Received: from tigra.home (Fac8f.f.strato-dslnet.de [195.4.172.143])
	by post.webmailer.de (klopstock mo52) (RZmta 16.34)
	with ESMTP id B03ec0k4J474Qz ; Mon, 19 May 2008 08:00:15 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 80B1C277BD;
	Mon, 19 May 2008 08:00:15 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 1855A56D28; Mon, 19 May 2008 08:00:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v7idqaocb.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82414>

Junio C Hamano, Mon, May 19, 2008 06:51:16 +0200:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > diff --git a/t/t6031-merge-recursive.sh b/t/t6031-merge-recursive.sh
> > index c8310ae..f1c91c8 100755
> > --- a/t/t6031-merge-recursive.sh
> > +++ b/t/t6031-merge-recursive.sh
> > @@ -12,8 +12,7 @@ test_expect_success 'mode change in one branch: keep changed version' '
> >  	git add dummy &&
> >  	git commit -m a &&
> >  	git checkout -b b1 master &&
> > -	chmod +x file1 &&
> > -	git add file1 &&
> > +	git update-index --chmod=+x file1 &&
> >  	git commit -m b1 &&
> >  	git checkout a1 &&
> >  	git merge-recursive master -- a1 b1 &&
> 
> I have to wonder if this is enough on a filesystem with usable executable
> bit.  Has this been tested on both kinds of filesystems?

Yes and yes.

> You aren't setting +x on work tree file anymore, but only flipping the bit
> inside the index before committing.  Because of this change, after "b1"
> commit, work tree has a local modification relative to the commit (namely,
> reversion of chmod +x is in the work tree), which is different from the
> original test sequence.  Doesn't this local modification interact with
> switching to a1 branch and what merge-recursive does?

I think no (I depend on this in my workflows on both systems).
