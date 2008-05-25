From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: rev-list --parents --full-history + path: something's fishy
Date: Sat, 24 May 2008 18:21:54 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805241817500.3081@woody.linux-foundation.org>
References: <e1dab3980805230808s59798351r9ed702c7d0dedd2a@mail.gmail.com> <1211660214.483877b69a107@webmail.nextra.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, David Tweed <david.tweed@gmail.com>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun May 25 03:23:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K04xH-0007A7-Un
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 03:23:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754679AbYEYBWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 21:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753677AbYEYBWH
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 21:22:07 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59292 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750805AbYEYBWG (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 May 2008 21:22:06 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4P1Lujs022182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 24 May 2008 18:21:57 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4P1Lsnm000889;
	Sat, 24 May 2008 18:21:55 -0700
In-Reply-To: <1211660214.483877b69a107@webmail.nextra.at>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.406 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82844>



On Sat, 24 May 2008, Johannes Sixt wrote:
> 
> but this does not:
> 
> $ git rev-list --full-history --parents HEAD -- a
> M A B
> B A
> A

That is the "correct" output.

That's what "--full-history" means: do not simplify merges away when all 
the data comes from just one branch (in this case from "B").

So it shows you commit 'M' because you asked for full-history.

Commit 'M' has parents 'C' and 'B', but since 'C' doesn't actually modify 
the file at all, the regular commit simplification will simplify 'C' away, 
so now that parent 'C' will become 'A'. So 'M' has the _simplified_ 
parent's 'A' and 'B'.

Then it shows 'B' (parent 'A') and 'A' (no parent).

> Of course, I'd expected to see this:
> 
> $ git rev-list --full-history --parents HEAD -- a
> B A
> A

Why did you ask for --full-history, if you're not interested in merges 
that are irrelevant? To get what you wanted, just do

	git rev-list --parents HEAD -- a

and it should give you exactly that output.

		Linus
