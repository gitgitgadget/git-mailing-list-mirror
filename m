From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Keep rename/rename conflicts of intermediate merges
 while doing recursive merge
Date: Sat, 31 Mar 2007 14:50:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0703311445190.4045@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070329141230.GB16739@hermes> <81b0412b0703290744h34b6ef01s4e6f90b1d7ed231b@mail.gmail.com>
 <81b0412b0703290804n13af6f40we79f7251562c540@mail.gmail.com>
 <20070329183237.GB2809@steel.home> <Pine.LNX.4.64.0703291232190.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703291237240.6730@woody.linux-foundation.org>
 <Pine.LNX.4.63.0703302239050.4045@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0703301728510.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703301754590.6730@woody.linux-foundation.org>
 <20070331104947.GA4377@steel.home> <20070331114938.GB4377@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Tom Prince <tom.prince@ualberta.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 14:50:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXd2m-0006bs-E8
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 14:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbXCaMuu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Mar 2007 08:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbXCaMuu
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 08:50:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:58507 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751240AbXCaMut (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2007 08:50:49 -0400
Received: (qmail invoked by alias); 31 Mar 2007 12:50:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 31 Mar 2007 14:50:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+sOAhnctSswFyggvaur5nyyVryDsb8j4U6zj57XG
	C0FMLnxjDory1Z
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070331114938.GB4377@steel.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43551>

Hi,

On Sat, 31 Mar 2007, Alex Riesen wrote:

> This patch leaves the base name in the resulting intermediate tree, to
> propagate the conflict from intermediate merges up to the top-level merge.

I'd rather have conflict files, i.e.

	for each entry in the index which is unmerged,
		write the file in this form:
		<<<<<<
		[stage2]
		======
		[stage3]
		>>>>>>

		mark as merged (i.e. remove stages 1--3 from the index, 
		and add the conflicted file as stage 0)

The big problem is that you _cannot_ leave unmerged entries in 
intermediate stages, because then, you could not write the tree. OTOH, you 
_need_ to mark them as unmerged _in the end_.
		
That problem keeps me from just whipping up a patch in a few minutes, 
sending it untested to the list, and get all the blame for it.

Ciao,
Dscho
