From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Bizarre missing changes (git bug?)
Date: Sat, 26 Jul 2008 12:58:21 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org>
References: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com> <alpine.LFD.1.10.0807211331390.31863@woody.linux-foundation.org> <200807260512.40088.zippel@linux-m68k.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Roman Zippel <zippel@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat Jul 26 22:03:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMpyt-0000g3-7X
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 22:03:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755882AbYGZUCG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 16:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755951AbYGZUCF
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 16:02:05 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37523 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755884AbYGZUCD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Jul 2008 16:02:03 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6QK1Jum030095
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 26 Jul 2008 13:01:20 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6QK1IbJ016889;
	Sat, 26 Jul 2008 13:01:19 -0700
In-Reply-To: <200807260512.40088.zippel@linux-m68k.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.406 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90278>



On Sat, 26 Jul 2008, Roman Zippel wrote:
> >
> > So without --full-history, if any parent matches the state, it just
> > removes the merge and picks that parent that contained all the state.
> > Obviously, any changes to that file can be sufficiently explained by
> > walking just that limited history, because they must have changed in
> > _that_ history too!
> 
> Is that really a good default behaviour?

Yes. It's the only sane default right now. See below.

> Is there a way to change that default?

Use an alias or something.

To see why it's the default, do a few tests. In particular, try it with 
gitk on the kernel. Try it on some fairly simple file that doesn't get a 
lot of churn. Example:

	gitk lib/vsprintf.c

vs

	gitk --full-history lib/vsprintf.c

and if you don't _immediately_ see why --full-history isn't the default, 
there's likely something wrong with you. One is useful. The other is not.

So we absolutely _have_ to simplify merges. There is no question about it.

That said, we currently simplify merges the simple and stupid way, and 
I've hinted several times on this mailing list that there is a better way 
to do it (last time it was the discussion about "filter-branch".

In fact, if you google for 

	filter-branch full-history

you'll find some of the discussion. In order to make --full-history useful 
as a default, we'd need to do an after-the-fact merge cleanup (ie remove 
lines of development that are later found to really be totally 
uninteresting), but that is *hard*.

But if we did that, I'd agree to making --full-history the default (and it 
would be a good thing, no doubt about it - I just cannot see how to do ti 
simply and sanely enough)

		Linus
