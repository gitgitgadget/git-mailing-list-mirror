From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Cygwin: problem with renaming and case
Date: Fri, 21 Mar 2008 11:09:56 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803211105190.3020@woody.linux-foundation.org>
References: <47E3DD28.4030302@tiscali.it>  <alpine.LFD.1.00.0803211037160.3020@woody.linux-foundation.org> <32541b130803211057h22310557ne605e39e6b894e11@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frank <streamlake@tiscali.it>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 19:11:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jclhx-0003uh-Bj
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 19:11:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755676AbYCUSKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 14:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756210AbYCUSKb
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 14:10:31 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56356 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755676AbYCUSKb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Mar 2008 14:10:31 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2LI9vtb013431
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 21 Mar 2008 11:09:58 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2LI9uf0003454;
	Fri, 21 Mar 2008 11:09:56 -0700
In-Reply-To: <32541b130803211057h22310557ne605e39e6b894e11@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.256 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77753>



On Fri, 21 Mar 2008, Avery Pennarun wrote:
> 
> I don't know if this helps, but if git would delete the files it's 
> planning to forget before checking the existence of files it's planning 
> to create, case sensitivity problems like these would automatically 
> disappear and you wouldn't have to worry about case (and accent, and 
> and...) folding by hand.

Yeah, but the whole logic of git-read-tree (which is what does this all) 
is to verify everything is up-to-date and a-ok before doing anything to 
your filesystem. Which is just a good idea in general.

Basically, we don't want to do something part-way, and then notice later 
that "oh, but.." and have to try to undo the thing we did partially.

So I agree, in this case the "remove files that go away first" would work 
around the problem, and we could look into whether that is reasonable in 
some cases, but in general it's not trivial either.

My personal guess is that it's probably better to start teaching git about 
case-broken filesystem, even if we start it with some common special case 
rather than getting every case right from the beginning.

		Linus
