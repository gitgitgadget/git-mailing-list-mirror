From: Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: reducing prune sync()s
Date: Thu, 29 May 2008 17:32:30 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805291727490.3141@woody.linux-foundation.org>
References: <20080529205743.GC17123@redhat.com> <alpine.LFD.1.10.0805291656260.3141@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: "Frank Ch. Eigler" <fche@redhat.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 30 02:33:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1sZ1-0001E1-UM
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 02:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508AbYE3Acy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 20:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754296AbYE3Acy
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 20:32:54 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48687 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752707AbYE3Acx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 May 2008 20:32:53 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4U0WVpm008259
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 29 May 2008 17:32:32 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4U0WUDv030912;
	Thu, 29 May 2008 17:32:30 -0700
In-Reply-To: <alpine.LFD.1.10.0805291656260.3141@woody.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-2.812 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83260>



On Thu, 29 May 2008, Linus Torvalds wrote:
> On Thu, 29 May 2008, Frank Ch. Eigler wrote:
> > 
> >	  Or perhaps having the blanket sync be replaced a
> > list of fsync()s for only the relevant git repository files?
> 
> That would be much better.

Side note: a lot of systems make "fsync()" pretty expensive too. It's one 
of my main disagreements with most log-based filesystems - fsync() can in 
theory be fast, but almost always implies flushing the whole log, even if 
99.9% of that log is totally unrelated to the actual file you want to 
fsync().

So fsync() isn't always all that much better than sync(). It *should* be, 
but reality sometimes bites. So testing should include at least some level 
of "yes, it actually improves things at least on xyz"...

			Linus
