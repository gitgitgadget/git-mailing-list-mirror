From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix t6031 on filesystems without working exec bit
Date: Thu, 22 May 2008 15:12:58 +0200
Message-ID: <20080522131258.GE3206@steel.home>
References: <20080518145727.GA3058@steel.home> <7v7idqaocb.fsf@gitster.siamese.dyndns.org> <20080519060015.GA3179@steel.home> <7v8wy360l8.fsf@gitster.siamese.dyndns.org> <81b0412b0805220116h4e4ff279k2e433a8a9a1cd9fc@mail.gmail.com> <7vskwawvzq.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 22 15:13:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzAcB-0007B2-NN
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 15:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763247AbYEVNNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 09:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763318AbYEVNNA
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 09:13:00 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:32244 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763242AbYEVNM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 09:12:59 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMna1s/dNSK
Received: from tigra.home (Fa855.f.strato-dslnet.de [195.4.168.85])
	by post.webmailer.de (fruni mo15) (RZmta 16.38)
	with ESMTP id U0719ek4MBtD2F ; Thu, 22 May 2008 15:12:57 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id BF184277BD;
	Thu, 22 May 2008 15:12:57 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 3292856D28; Thu, 22 May 2008 15:12:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vskwawvzq.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82627>

Junio C Hamano, Thu, May 22, 2008 11:04:09 +0200:
> "Alex Riesen" <raa.lkml@gmail.com> writes:
> 
> > 2008/5/21 Junio C Hamano <gitster@pobox.com>:
> > ...
> >> @@ -12,6 +15,7 @@ test_expect_success 'mode change in one branch: keep changed version' '
> >>        git add dummy &&
> >>        git commit -m a &&
> >>        git checkout -b b1 master &&
> >> +      chmod +x file1 &&
> >>  	  git update-index --chmod=+x file1 &&

Just retested this on my normal system, and of course you are right.
My patch breaks the t6031 there.

> > Now, this is pointless in my setup. Cygwin just ignores the operation
> > and decidedddds (presumably according the file _content_ or maybe
> > phase of the moon) that is not executable. Working tree is still modified.
> 
> Doesn't it mean you spotted a bug?
> 

Looks like: builtin-merge-recursive.c does not seem to reference
trust_executable_bit (aka core.filemode) anywhere. The default
configuration statements are read in alright (there is a call to
git_default_config), it is just I am cannot find if the flag is used.

Johannes, in the meantime I lost the track of merge-recursive
completely. In this case, should I look at unpack-trees.c or is
it still somewhere inside merge-recursive (merge_file)?

> If your repository is marked so that executable bit is untrustworthy
> there, the check done when switching to branch "a1" to compare if "file1"
> that is involved in the switch operation has local changes should ignore
> (apparent and false) executable-bit change, shouldn't it?

Will see next monday, when I get back to that wretched laptop.
