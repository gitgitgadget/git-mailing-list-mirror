From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] core/softirq for v2.6.27
Date: Mon, 14 Jul 2008 10:23:15 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807141019010.3305@woody.linux-foundation.org>
References: <20080714144243.GA21079@elte.hu> <20080714092215.0efd7fa3.akpm@linux-foundation.org> <20080714163141.GA21068@elte.hu> <20080714094422.e7ae255a.akpm@linux-foundation.org> <alpine.LFD.1.10.0807140948220.3305@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ingo Molnar <mingo@elte.hu>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 19:26:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIRp1-000470-Lj
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 19:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755943AbYGNRZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 13:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755375AbYGNRZs
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 13:25:48 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47431 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755261AbYGNRZr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jul 2008 13:25:47 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6EHNFSJ025241
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 14 Jul 2008 10:23:16 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6EHNF3D018751;
	Mon, 14 Jul 2008 10:23:15 -0700
In-Reply-To: <alpine.LFD.1.10.0807140948220.3305@woody.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.9 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88437>



On Mon, 14 Jul 2008, Linus Torvalds wrote:
> 
> As it is, that is one ugly function that only takes the one-liner thing - 
> at least partly because of how it traditionally worked (as a a filter over 
> the log messages, rather than as a "git shortlog xyz..abc" kind of 
> stand-alone thing).

Heh. I guess you _could_ use the filter capability here (but it will 
sometimes truncate the line, so..)

Some really ugly scripting like this will do it:

	#!/bin/sh
	git log --pretty='format:commit %H
	Author: %an <%ae>
	
	  %s (%h)
	' $@ | git shortlog

where we use the regular "git log" with a user-supplied format to generate 
a log with the subject line and the shortened hash appended (the "%s (%h)" 
part) and then we use "git shortlog" as a filter to sort things together 
by author etc.

There is absolutely _nothing_ that git won't do with a little bit of 
scripting, but I do have to admit that this one isn't a wonderfully 
beautiful script ;)

		Linus
