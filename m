From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Sun, 6 May 2007 12:54:10 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705061243490.25245@woody.linux-foundation.org>
References: <vpqwszm9bm9.fsf@bauges.imag.fr>
 <alpine.LFD.0.98.0705060951460.25245@woody.linux-foundation.org>
 <vpqbqgxak1i.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun May 06 21:54:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkmoq-0004ZO-TL
	for gcvg-git@gmane.org; Sun, 06 May 2007 21:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755212AbXEFTyy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 15:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755135AbXEFTyy
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 15:54:54 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:58042 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755212AbXEFTyx (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2007 15:54:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l46JsBEE004312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 6 May 2007 12:54:12 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l46JsA2P015731;
	Sun, 6 May 2007 12:54:10 -0700
In-Reply-To: <vpqbqgxak1i.fsf@bauges.imag.fr>
X-Spam-Status: No, hits=-3.484 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46370>



On Sun, 6 May 2007, Matthieu Moy wrote:
> 
> Well, git's index still tells more than "the content FOOBAR exists,
> somewhere". It also "contains", if not "points to", the file name.

Indeed. 

Git's index is basically very much defined as

 - sufficient to contain the total "content" of the tree (and this 
   includes all metadata: the filename, the mode, and the file contents 
   are all *parts* of the "content", and they are all meaningless on their 
   own!)

 - additional "stat" information to allow the obvious and trivial (but 
   hugely important!) filesystem comparison optimizations.

So you really should see it as *being* the content. The content is not the 
"file name" or the "file content" as separate parts. You really cannot 
separate the two. Filenames on their own make no sense (they have to have 
file content too), and file content on its own is similarly senseless (you 
have to know how to reach it).

What I'm trying to say is that git fundmaentally doesn't _allow_ you to 
see a filename without its content. The whole notion is insane and not 
valid. It has no relevance for "reality".

Also, you should realize that when you do

	git add X

you are *not* adding the filename X. No, "X" is literally a "content path 
pattern", the same way it is when you do something like

	gitk X

and it's worth always keeping in mind that in neither case is "X" 
necessarily a single file, but literally a pathname pattern that is used 
as a "filter" on all the possible patterns.

(Of course, the filtering rules are different for "git add" and "gitk": in 
the "git add" example, you filter the working tree files, while in "gitk" 
you filter the files that git already knows about, so they are different, 
but in both cases you really should think of them as filters, not as 
"filenames", even though one _trivial_ filter is to give a filter that 
matches exactly one pathname).

> The reason why I'm posting this is that I was wondering whether
> "commit -a" not being the default was supposed to be a message like
> "you shouln't use it too often".

No, "git commit -a" is undoubtedly _convenient_. You can use it as often 
as you like.

So as long as you see it as a convenience feature, and realize that "git 
commit" is actually a lot more powerful than just being able to always do 
the convenient, go on and use "git commit -a" all the time.

When you hit a situation where you want to do something slightly subtler, 
you'll suddenly be really happy that you always had the convenience 
feature, but that git didn't make you think that it was how you _had_ to 
work.

> > [...] it basically could be used ass a definition of CVS: [...]
>                                    ^^^
> Not sure this was intentional, but your spelling of "as" when used to
> talk about CVS seems to reveal something about your state of mind ;-).

Indeed ;)

Freudian slip. But yes, I'm really down on CVS. The only thing I like less 
than CVS is SVN, and that's just because I think it's such a sad waste, 
not because it's actually _worse_ than CVS. (Ie I dislike SVN from a "it 
could have been so much better" perspective).

			Linus
