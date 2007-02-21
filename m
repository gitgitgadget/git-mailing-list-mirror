From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: removing content from git history
Date: Wed, 21 Feb 2007 09:14:44 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702210904350.4043@woody.linux-foundation.org>
References: <20070221164527.GA8513@ginosko.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Michael Hendricks <michael@ndrix.org>
X-From: git-owner@vger.kernel.org Wed Feb 21 18:14:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJv3M-0001Bd-32
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 18:14:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422718AbXBUROu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 12:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422719AbXBUROu
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 12:14:50 -0500
Received: from smtp.osdl.org ([65.172.181.24]:33877 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422715AbXBUROq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 12:14:46 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1LHEhhB028043
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 21 Feb 2007 09:14:43 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1LHEgNC020164;
	Wed, 21 Feb 2007 09:14:43 -0800
In-Reply-To: <20070221164527.GA8513@ginosko.local>
X-Spam-Status: No, hits=-0.465 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40307>



On Wed, 21 Feb 2007, Michael Hendricks wrote:
>
> I assume that this question has already been addressed on the mailing
> list, but I wasn't able to find anything about it in the archives.
> 
> Is it possible to remove content entirely from git's history?

It's been discussed.

There are two options for doing it:

 - rewriting history. There are a few tools for this already, and for 
   specific needs it would be fairly easy to resurrect git-convert-objects 
   to do it for any kind of object.

   See "cg-admin-rewritehist" from cogito for an example of a tool that 
   would do what you need done. In fact, it has this exact thing as the 
   first example.

   (Btw, I think cg-admin-rewritehist is one of the few things that cogito 
   had that was really a good idea. Not that people probably _used_ it 
   much, but it's somethign that makes sense in the plumbing)

 - explicit support for "missing objects". We don't do it right now, but 
   we could add it. It was discussed for things like limited history etc 
   (the "shallow clone" kind of thing, before people actually added 
   shallow clones), and it would support the notion of "we export all our 
   history, but for internal reasons we cannot make certain objects 
   available" kinds of workflows.

So right now, rewriting history is an option that you can do. It will 
effectively create a totally new branch (which you can then make into a 
new repository) which has nothing in common with the old branch from the 
point where it was modified. So you can never really merge the two ever 
again, and you need to make sure that everybody who had the old repo 
contents will destroy it.

But at least in theory, it wouldn't be impossible to extend on the 
".git/grafts" kind of setup to say "this object has been consciously 
deleted", and that could in some circumstances be a better model. The 
biggest headache there would be the need to extend the native git protocol 
with a way to add such objects.

			Linus
