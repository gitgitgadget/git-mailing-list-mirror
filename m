From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Am able to delete a file with no trace in the log
Date: Tue, 2 Jun 2009 18:20:44 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906021811440.4880@localhost.localdomain>
References: <EB2D87B9-3B03-431A-B204-C7799F9BA291@ausperks.net>  <20090602213439.GA7584@coredump.intra.peff.net>  <alpine.LFD.2.01.0906021439030.4880@localhost.localdomain> <2e24e5b90906021747v327c9db1o16d03af5dcf50546@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Graham Perks <gperks@ausperks.net>,
	Git List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 03:20:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBfA2-0006tr-TB
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 03:20:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747AbZFCBUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 21:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbZFCBUu
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 21:20:50 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42853 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751264AbZFCBUt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jun 2009 21:20:49 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n531Ki6U028793
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 2 Jun 2009 18:20:45 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n531KivT002359;
	Tue, 2 Jun 2009 18:20:44 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <2e24e5b90906021747v327c9db1o16d03af5dcf50546@mail.gmail.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.463 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120569>



On Wed, 3 Jun 2009, Sitaram Chamarty wrote:
> 
> "git merge -s ours" would do precisely the same thing, wouldn't it?

Yes. It doesn't matter which way it goes - if a file is seen as being 
identical (and "none" very much counts) in one parent, it's not judged 
"interesting" from a merge patch standpoint, or even from a "git log" 
(aka "revision history") standpoint.

> That has happened to me before, and I noticed that git log does not
> show the deletion, but rationalised it as being because I had
> explicitly done a "-s ours".
> 
> Fixing this would fix that (maybe more common) case too, and show that
> the merge commit removed the file.

The problem is that quite often, a merge that removes a file _is_ the 
correct thing when it was removed in one branch, and a merge that adds a 
file is even more common, and in no way special. We don't show the whole 
diff in a merge, because the whole diff is often nonsensical (ie so 
trivial that showing it all just hides the parts that are actually 
relevant).

So I'll have to think about it a bit more. We clearly don't generate good 
diffs for file deletion/creation in merges, and we should improve on it, 
but it's definitely not a trivial issue either.

		Linus
