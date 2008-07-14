From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] core/softirq for v2.6.27
Date: Mon, 14 Jul 2008 10:46:23 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807141026200.3305@woody.linux-foundation.org>
References: <20080714144243.GA21079@elte.hu> <20080714092215.0efd7fa3.akpm@linux-foundation.org> <20080714163141.GA21068@elte.hu> <20080714094422.e7ae255a.akpm@linux-foundation.org> <alpine.LFD.1.10.0807140948220.3305@woody.linux-foundation.org>
 <alpine.LFD.1.10.0807141019010.3305@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ingo Molnar <mingo@elte.hu>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 19:49:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KISBH-0005oD-5K
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 19:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754296AbYGNRss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 13:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754107AbYGNRss
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 13:48:48 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39652 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754117AbYGNRss (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jul 2008 13:48:48 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6EHkOLA027727
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 14 Jul 2008 10:46:25 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6EHkNPj019680;
	Mon, 14 Jul 2008 10:46:24 -0700
In-Reply-To: <alpine.LFD.1.10.0807141019010.3305@woody.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.9 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88439>



On Mon, 14 Jul 2008, Linus Torvalds wrote:
> 
> Some really ugly scripting like this will do it:
> 
> 	#!/bin/sh
> 	git log --pretty='format:commit %H
> 	Author: %an <%ae>

Side note: you can make it a one-liner with '%n' (not \n') if you want, ie

	#!/bin/sh
	git log --pretty='format:commit %H%nAuthor: %an <%ae>%n%n %s (%h)%n' $@ | git shortlog

if you want to make it look even more like line noise.

And if you want to be _really_ fancy, you can even make it a git 
alias. Just add somethign like this to your ~/.gitconfig file:

	[alias]
		mylog=!GIT_PAGER='git --no-pager shortlog' git log --pretty='format:commit %H%nAuthor: %an <%ae>%n%n %s (%h)%n'

which is the _real_ git-mans way to do it.

It does the "shortlog" output by using "git shortlog" as a pager, but then 
to avoid recursion, we have to turn off paging of shortlog output itself. 
Heh. And the reason to do that is that the arguments always go to the end, 
so since we want to give the args to "git log", we can't put the pipe at 
the end.

I will have to go wash up after writing the above.

		Linus
