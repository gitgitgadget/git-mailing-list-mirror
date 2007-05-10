From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Second parent for reverts
Date: Thu, 10 May 2007 11:22:22 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705101116480.3986@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
 <alpine.LFD.0.98.0705091513050.4062@woody.linux-foundation.org>
 <alpine.LFD.0.98.0705100927340.3986@woody.linux-foundation.org>
 <200705102006.08624.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu May 10 20:22:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmDHp-0006yL-DX
	for gcvg-git@gmane.org; Thu, 10 May 2007 20:22:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752929AbXEJSWh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 14:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756482AbXEJSWh
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 14:22:37 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:60012 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752929AbXEJSWg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 May 2007 14:22:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4AIMNVj027867
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 10 May 2007 11:22:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4AIMMJx027072;
	Thu, 10 May 2007 11:22:23 -0700
In-Reply-To: <200705102006.08624.johan@herland.net>
X-Spam-Status: No, hits=-3.48 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46884>



On Thu, 10 May 2007, Johan Herland wrote:
> 
> BTW, I'm wondering whether anybody has ever thought about allowing 
> after-the-fact annotations on commits. Kinda like free-form 
> continuations on the commit message. It would allow people to make 
> notes on previous commits that were either forgotten at commit-time, or 
> only became apparent after the commit was done.

We kind of have some of that.

Tag objects can be used that way, and the "grafts" file is a very special 
case. 

But if you want to do it on a larger scale, you'd need something that is 
really optimized for that. For example, git internally now has a notion of 
"decorating" arbitrary objects with arbitrary data, and if you just had an 
efficient file format to create such decorations (for blame or other 
special ops), the *code* is easy to write. It's how

	git log --decorate

works right now (the "data" is just the tag names, but you could make it 
read other decorations, and the git data structures are very efficient, 
and allow different types of decorations to be used independently of 
each other).

		Linus
