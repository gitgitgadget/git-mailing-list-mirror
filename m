From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Corrupted (?) commit 6e6db85e confusing gitk
Date: Sun, 2 Dec 2007 12:34:57 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712021229300.8458@woody.linux-foundation.org>
References: <5F1A20CC-7427-4E7A-AB95-E89C9FA17951@zib.de> <7vir3hx70y.fsf@gitster.siamese.dyndns.org> <20071202193918.GQ6212@lavos.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Sun Dec 02 21:36:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyvY1-0002O6-PE
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 21:36:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754351AbXLBUfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 15:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754470AbXLBUfU
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 15:35:20 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:59600 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754224AbXLBUfT (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Dec 2007 15:35:19 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB2KYwqs011873
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 2 Dec 2007 12:34:59 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB2KYvEt031445;
	Sun, 2 Dec 2007 12:34:57 -0800
In-Reply-To: <20071202193918.GQ6212@lavos.net>
X-Spam-Status: No, hits=-2.727 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66815>



On Sun, 2 Dec 2007, Brian Downing wrote:
>
> With the above, something like:
> 
> echo msg | GIT_AUTHOR_DATE='' git commit-tree sha1
> 
> will produce a broken commit without a timestamp, since fmt_ident is
> also used for the committer and author lines.

Ouch. And I notice that fsck doesn't even warn about the resulting broken 
commit. Partly because I was lazy, but partly because originally I was 
thinking that maybe we'll have more header lines, so fsck basically just 
checks the ones that git *really* cares about (parenthood and tree), and 
the rest is not really even looked at (well, it does check that the next 
line starts with "author", but that's it).

I guess the breakage is pretty benign, but this is still very wrong.

Junio: that broken commit seems to be in "pu" only - we should make sure 
that it never makes it into next or master, so that it will eventually get 
pruned out of history.

		Linus
