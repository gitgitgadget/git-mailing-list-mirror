From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Wrong file diff for merge conflict
Date: Sun, 5 Jul 2009 17:33:36 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907051726020.3210@localhost.localdomain>
References: <loom.20090704T072854-229@post.gmane.org> <alpine.LFD.2.01.0907051113240.3210@localhost.localdomain> <8cdebd3f0907051523q73494603ka8a50b19b1238a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
To: Stefan Bucur <stefan.bucur@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 02:40:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNcGI-0003cd-EK
	for gcvg-git-2@gmane.org; Mon, 06 Jul 2009 02:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756022AbZGFAdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2009 20:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755794AbZGFAdh
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jul 2009 20:33:37 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53221 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754695AbZGFAdg (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jul 2009 20:33:36 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n660Xb2M004753
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 5 Jul 2009 17:33:38 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n660XajW024184;
	Sun, 5 Jul 2009 17:33:36 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <8cdebd3f0907051523q73494603ka8a50b19b1238a@mail.gmail.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.467 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122769>



On Mon, 6 Jul 2009, Stefan Bucur wrote:
> 
> Thank you for your suggestions for a better and more efficient merging
> experience, as I'm sure they will help me from now on. However, I
> think I did not make myself clear: I was not arguing the fact that the
> merge result was suboptimal, but the fact that _the generated conflict
> file is semantically wrong_.

Oh. 

No, you're confused about what a conflict file is.

> Basically, if one would take the common (successfully merged) parts
> and keep the "left" parts in the conflict sections, one would obtain
> the first branch version of the file (with minor modifications).

No. This is not how conflicts work.

If you blindly do that, you'll always get the wrong answer. Why? Because 
you're ignoring the parts of the file that didn't conflict. Those will be 
_outside_ the conflict markers in all cases.

> Similarly, if one would opt to keep only the "right" parts in the
> conflict section, one would obtain the version found in the second
> branch before merge.

Same problem. What you expect from a conflicting file is simply not true.

The fact is, a traditional rcs three-way merge (which is pretty much what 
you get with git, ignoring the fact that we have other tools in addition 
to it, and ignoring things like criss-cross merges etc) just doesn't work 
the way you seem to think it should work. You simply don't get the 
original of one side by picking one side of the conflict markers. It will 
have merged the stuff that it thought merged cleanly, and not have any 
conflict markers at all for those parts.

Of course, "what it thought merged cleanly" may not be what you want it to 
be. Sometimes you get a clean merge for things that you'd have wanted to 
conflict. And sometimes you get conflicts for stuff that you'd think is 
just silly and shouldn't have. 

There are no perfect file merge algorithms that I know of. Lots of people 
hate the diff3/merge behavior - it's by no means perfect. But so far, I've 
never seen anybody successfully advocate anything better either.

		Linus
