From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] submodule merge support
Date: Mon, 7 May 2007 09:02:00 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705070857100.3802@woody.linux-foundation.org>
References: <20070506190224.GG30511@admingilde.org> <20070506220745.GA2439@steel.home>
 <alpine.LFD.0.98.0705061517380.12945@woody.linux-foundation.org>
 <20070507090346.GI30511@admingilde.org> <463EFFC6.12A1B0A1@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Mon May 07 18:02:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hl5fF-0002lb-Rh
	for gcvg-git@gmane.org; Mon, 07 May 2007 18:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965537AbXEGQCL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 12:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965254AbXEGQCL
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 12:02:11 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:50701 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965537AbXEGQCK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2007 12:02:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l47G22WA011454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 7 May 2007 09:02:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l47G20oI008090;
	Mon, 7 May 2007 09:02:01 -0700
In-Reply-To: <463EFFC6.12A1B0A1@eudaptics.com>
X-Spam-Status: No, hits=-4.98 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46468>



On Mon, 7 May 2007, Johannes Sixt wrote:
> 
> I think you missed Linus's point: If the supermodule's merge leads to a
> conflict in the submodule links, it is not appropriate to merge the
> submodule.

That is true, but no, that wasn't what I was trying to say.

What I was trying to say was really that the merge-base in the 
super-module is simply totally irrelevant to the sub-module, and any merge 
at all that thinks it is is obviously broken.

Now, for a _normal_ merge (with just a single merge-base), this is not an 
issue, since the proposed submodule merger wouldn't care about the 
supermodule merge base anyway.

But if you have multiple merge-bases and you do a recursive merge to 
create a new *combined* merge-base, trying to do that for the submodule is 
just pointless. You shouldn't. The merge-base for the submodule will be 
irrelevant for the final merge *anyway* (since the submodule history comes 
from itself), so in a recursive sub-merge, you shouldn't even *try* to 
merge the submodule. The end result would never be used anyway, and the 
only thing you can do is make for more complexity.

So not doing it in the low-level merger is right - because it is simply 
irrelevant at that stage. The low-level merger might as well ignore 
submodules.

I think.

			Linus
