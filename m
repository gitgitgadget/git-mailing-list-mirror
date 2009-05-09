From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix segfault in merge-recursive
Date: Sat, 9 May 2009 09:48:34 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905090947120.27348@pacific.mpi-cbg.de>
References: <alpine.DEB.2.00.0905070102010.30999@narbuckle.genericorp.net> <alpine.DEB.1.00.0905071144370.18521@pacific.mpi-cbg.de> <alpine.DEB.2.00.0905072131470.30999@narbuckle.genericorp.net> <alpine.DEB.1.00.0905082229520.4601@intel-tinevez-2-302>
 <7vocu3p3pr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dave O <cxreg@pobox.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 09 09:51:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2hLI-0003AW-PA
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 09:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755213AbZEIHsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 03:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755197AbZEIHsf
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 03:48:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:41811 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755154AbZEIHse (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 03:48:34 -0400
Received: (qmail invoked by alias); 09 May 2009 07:48:33 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 09 May 2009 09:48:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19nTMUBJFZnWCOllh1Rp8NgvF4ARBYDbouFKUxZG5
	+s8OIO3NLkXrqU
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vocu3p3pr.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118651>

Hi,

On Fri, 8 May 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > When there is no "common" tree (for whatever reason), we must not
> > throw a segmentation fault.
> 
> You described why the old code was wrong (i.e. "init_tree_desc_from_tree 
> is called with common == NULL"), but there is no mention why the new 
> code is correct.  For the purpose of satisfying the above statement, you 
> could have just exit(0) as well ;-)

Yes, I should have marked this patch as "please test if the result is what 
you think it should be", because I was running out of time and therefore 
could not properly think things through.

> > +	else {
> > +		opts.merge = 0;
> > +		opts.head_idx = 1;
> > +		init_tree_desc_from_tree(t+0, head);
> > +		init_tree_desc_from_tree(t+1, merge);
> > +		rc = unpack_trees(2, t, &opts);
> > +	}
> 
> This looks more like a half of branch-switch from HEAD to MERGE, not a
> merge between HEAD and MERGE as two equal histories.  Shouldn't it be
> doing a three-way tree merge using an empty tree object as the common
> ancestor instead, just like merge_recursive.c::merge_recursive() itself
> does?

But of course!

Thanks,
Dscho
