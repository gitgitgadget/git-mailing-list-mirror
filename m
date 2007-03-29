From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: SEGV in git-merge recursive:
Date: Thu, 29 Mar 2007 12:40:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703291237240.6730@woody.linux-foundation.org>
References: <20070329075010.GA3493@hermes> <81b0412b0703290429k63642a34u6bea1e08803ffba7@mail.gmail.com>
 <20070329125803.GA16739@hermes> <81b0412b0703290634j6e62ba89tce3c8c963be3fb92@mail.gmail.com>
 <20070329141230.GB16739@hermes> <81b0412b0703290744h34b6ef01s4e6f90b1d7ed231b@mail.gmail.com>
 <81b0412b0703290804n13af6f40we79f7251562c540@mail.gmail.com>
 <20070329183237.GB2809@steel.home> <Pine.LNX.4.64.0703291232190.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Tom Prince <tom.prince@ualberta.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 21:41:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HX0Ur-0006BP-I2
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 21:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934329AbXC2TlQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 15:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934335AbXC2TlQ
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 15:41:16 -0400
Received: from smtp.osdl.org ([65.172.181.24]:37344 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934329AbXC2TlP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 15:41:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2TJesU2028379
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 29 Mar 2007 12:40:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2TJerBB010452;
	Thu, 29 Mar 2007 12:40:53 -0700
In-Reply-To: <Pine.LNX.4.64.0703291232190.6730@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.462 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43464>



On Thu, 29 Mar 2007, Linus Torvalds wrote:
> 
> It's not the initial commit. It's a criss-cross merge, and it's a virtual 
> commit created by a previous level of merging.
> 
> Apply this patch to see it blow up much earlier, when that bogus commit 
> with a NULL tree is created.
> 
> (I didn't debug *why* that happens, but maybe this gets somebody further)

Well, it happens because "git_write_tree()" returns NULL. Which in turn is 
because "unmerged_index()" returns true. 

merge_trees() tries to clean up the unmerged index, but apparently doesn't 
do good enough of a job, so git_write_tree() is called with entries still 
unmerged..

		Linus
