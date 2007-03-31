From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Pruning objects from history?
Date: Sat, 31 Mar 2007 09:18:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703310913350.6730@woody.linux-foundation.org>
References: <460DC0F7.1070607@midwinter.com> <20070331131134.GC25539@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sat Mar 31 18:18:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXgHt-00015B-IX
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 18:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301AbXCaQSm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Mar 2007 12:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753333AbXCaQSm
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 12:18:42 -0400
Received: from smtp.osdl.org ([65.172.181.24]:55056 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753301AbXCaQSm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2007 12:18:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2VGIZod011689
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 31 Mar 2007 09:18:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2VGIWpq025804;
	Sat, 31 Mar 2007 09:18:32 -0700
In-Reply-To: <20070331131134.GC25539@thunk.org>
X-Spam-Status: No, hits=-0.465 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43562>



On Sat, 31 Mar 2007, Theodore Tso wrote:
> 
> It's painful to rewrite history, since you end up needing to rewrite
> every single commit after the point where you've tampered with time to
> fix up the parent commit ID.

Well, if you don't ever need to actually rewrite blob objects, and many of 
the trees end up being the same, history rewriting is actually pretty 
cheap. If it mostly just has to rewrite the commits and a few trees, you 
end up having (even for big projects) just a few hundred thousand easy 
objects to rewrite. It's going to take a minute or two at most.

"git-convert-objects" has most of the logic, so some trivial added code to 
"convert" tree objects by removing certain entries should just do it. But 
yeah, it would involve some real changes. cg-admin-rewritehist should be 
able to do it already, although I suspect it would be slower (but for a 
one-shot thing, nobody probably cares, and changing convert-objects is 
probably going to take more time than just running the rewritehist 
scripts).

> If you just want to do a one-way import, it's probably going to be
> much easier to modify whatever importer you use to not import the big
> files in the first place.

I'd actually like cg-admin-rewritehist to be merged into git. I think it's 
one of the few things that cogito does that native git doesn't do.

		Linus
