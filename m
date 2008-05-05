From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: merge renamed files/directories?
Date: Mon, 5 May 2008 15:20:14 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805051512060.32269@woody.linux-foundation.org>
References: <4819CF50.2020509@tikalk.com> <481D52CC.1030503@tikalk.com> <32541b130805050940x1297e907ofc67ee65494897eb@mail.gmail.com> <200805052349.35867.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Ittay Dror <ittayd@tikalk.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Tue May 06 00:21:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jt93i-00062q-Gi
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 00:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760598AbYEEWUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 18:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760477AbYEEWUd
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 18:20:33 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58575 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756544AbYEEWUc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 May 2008 18:20:32 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m45MKGsg027798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 5 May 2008 15:20:17 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m45MKEZ6008010;
	Mon, 5 May 2008 15:20:15 -0700
In-Reply-To: <200805052349.35867.robin.rosenberg.lists@dewire.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.425 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81311>



On Mon, 5 May 2008, Robin Rosenberg wrote:
> 
> You will always find corner cases.

.. and btw, this is why merging should always 

 - be predictable (which implies "simple": overly clever merging, and 
   especially merging that takes complex history into account is *bad*, 
   because it's still going to do the wrong thing, but now it's going to 
   do so much less predictable)

 - be amenable to manual fixes even when it succeeds (ie even if an 
   automatic merge completes without errors, a subsequent build may find 
   problems, and a "git commit --amend" may well be the right thing to 
   do!)

 - aim for (preferrably easily-handled) conflicts when the unusual cases 
   happen.

   Conflicts for *common* things are bad, because they just cause more 
   work, and people get too complacent about fixing them. But similarly, 
   thinking that the unusual cases should be handled automatically is also 
   wrong - because the unusual cases are likely the ones that need some 
   manual resolution anyway.

Git will never do merges "perfectly", if only because it's fundamentally 
impossible to do that. But one thing git *does* do is to make it pretty 
damn easy to handle it.

I really don't understand why people expect a directory rename to be 
handled automatically, when it is (a) not that common and (b) not obvious 
what the solution is, but MOST OF ALL (c) so damn _easy_ to handle it 
manually after-the-fact when you notice that something doesn't compile!

Really. If you have a file that was created in the wrong subdirectory (and 
please admit that this is not common - it requires not just a directory 
rename, but also a file create in another branch at the same time), what's 
so hard with just doing

	make
	.. oh, oops, that was pretty obviousm, the expected source file 
	   didn't exist ..
	git mv olddir/file newdir/file
	git commit --amend

and "Tadaa! All done". Your merge that was *fundamentally impossible* to 
do automatically, was trivially done manually, with no actual big 
head-scratiching involved.

		Linus
