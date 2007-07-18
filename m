From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Empty directories...
Date: Wed, 18 Jul 2007 09:33:43 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707180925030.27353@woody.linux-foundation.org>
References: <85lkdezi08.fsf@lola.goethe.zz> <Pine.LNX.4.64.0707180135200.14781@racer.site>
 <858x9ez1li.fsf@lola.goethe.zz>
 <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jul 18 18:34:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBCTR-0000SO-23
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 18:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933206AbXGRQd4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 12:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933139AbXGRQd4
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 12:33:56 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49367 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932924AbXGRQdz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jul 2007 12:33:55 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6IGXnml025280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Jul 2007 09:33:50 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6IGXhpE018251;
	Wed, 18 Jul 2007 09:33:43 -0700
In-Reply-To: <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.67 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52878>



On Wed, 18 Jul 2007, Linus Torvalds wrote:
> 
> So "existence" != "content". Git very much does not track "existence" of 
> files, it tracks the total content of them too.

Btw, don't get me wrong: I think that in order to be better at tracking 
other SCM's idiotic choices, we could (and I foresee that we eventually 
have to) try to track empty directories as a special case too.

So I'm not _against_ the notion of tracking empty directories, and I would 
welcome patches that do so. As I mentioned in some earlier thread when 
this came up a few weeks ago, I actually suspect that the "subproject" 
support probably ended up making it easier, because in many ways an "empty 
directory" is very close to a "anonymous subproject" from a low-level 
plumbing standpoint (even if it is *not* so from a high-level standpoint).

So I suspect that adding support for empty directories ends up being about 
just slightly extending the places that now have subproject support to 
know about a new situation.

But I do want to point out that "tracking a directory" is not at all the 
same thing as "tracking a file", no matter how much you try to argue 
otherwise. The semantics are totally different, and it all boils down to 
the fact that when you track a file, you are always talking about the 
*full* content of the file, while tracking a directory is always about 
tracking just a *subset* of the contents of the directory.

Of course, with directories, there's the trivial case where the subset 
happens to be everything, but that is neither the common nor the 
interesting case. All the interesting and complex cases happen exactly 
when the directory has untracked files in it, and at that point 

 - you really aren't tracking "contents" any more
 - you can no longer recreate the directory from the data you have (so you 
   cannot remove it on branch switches etc)
 - ergo: you're not a content tracker any more, you're a "container" 
   tracker.

And really, the "nontracked files in a directory" is the *default* thing, 
not some really unusual thing that we could disallow.

But I'm not against adding support for "container tracking". I just want 
people to understand that it's something totally different from what we do 
now. It's much more like subproject support than tracking files.

		Linus
