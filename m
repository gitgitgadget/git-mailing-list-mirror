From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Fri, 25 May 2007 08:35:28 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705250830220.26602@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0705240039370.4113@racer.site>
 <200705251427.46903.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0705251343550.4648@racer.site>
 <200705251559.53846.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Lars Hjemli <hjemli@gmail.com>, skimo@liacs.nl,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 25 17:36:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hrbpo-0004pn-Le
	for gcvg-git@gmane.org; Fri, 25 May 2007 17:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbXEYPgE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 11:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbXEYPgE
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 11:36:04 -0400
Received: from smtp1.linux-foundation.org ([207.189.120.13]:44612 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750754AbXEYPgD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 May 2007 11:36:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4PFZUmC032133
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 25 May 2007 08:35:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4PFZSlK021755;
	Fri, 25 May 2007 08:35:29 -0700
In-Reply-To: <200705251559.53846.Josef.Weidendorfer@gmx.de>
X-Spam-Status: No, hits=-2.787 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.179 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48389>



On Fri, 25 May 2007, Josef Weidendorfer wrote:
>
> * Submodules can appear/disappear any time in the superproject.
> Therefore, going back in time can make it necessary to have to clone
> a submodule you did not have before.

You missed the obvious thing here: if a submodule 
appears/disappears/moves, then the module info *has* to be versioned. 
Otherwise your module setup will be *wrong*.

Think about it. If you move the kernel module somewhere else (say, you 
make it be in "old-kernel"), and then replace the "kernel" module with a 
_new_ submodule, if you don't version the .gitmodules file, you're simply 
_screwed_. You'll be loading the "kernel" module from the wrong place 
when you move around in history!

In contrast, if you version it, everything JUST WORKS.

So:

 - submodule information *has* to be versioned. If it isn't, it's broken. 

   It really _is_ that simple.

 - because some people will want to replace repository addresses etc, you 
   want to have a per-repo (or user, or system) *mapping* of that
   versioned submodule information, so that people can override the actual 
   location. But that doesn't obviate the need for the basic module 
   information having to be versioned.

So no, we cannot have the fundamental module info setup anywhere else than 
in something like .gitmodules.

		Linus
