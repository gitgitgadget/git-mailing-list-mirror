From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Add "--dirstat" for some directory statistics
Date: Mon, 11 Feb 2008 13:17:43 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802111302470.2920@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0802111230200.2920@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 22:24:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOg8H-0002or-HH
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 22:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbYBKVXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 16:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbYBKVXg
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 16:23:36 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58001 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751121AbYBKVXf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Feb 2008 16:23:35 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1BLIdAt029038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 11 Feb 2008 13:19:59 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1BLHhOa000835;
	Mon, 11 Feb 2008 13:18:03 -0800
In-Reply-To: <alpine.LFD.1.00.0802111230200.2920@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.731 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73587>


On Mon, 11 Feb 2008, Linus Torvalds wrote:
> 
> The reporting limit has been arbitrarily set at 3%, which seems to be a 
> pretty good cut-off, but I made it an option variable in case anybody 
> would ever want to make it a dynamic cutoff.

Side note: that 3% isn't actually _too_ arbitrary.  I did actually test
things a bit. 

So it seems to be a good limit that ensures that you'll basically never
see more than one page worth of reporting (if you did, it wouldn't be a
very good summary).  So in theory, if something is _just_ right and
really balanced out across a wide variety of directories, you can get 33
lines of output, but in practice it's unusual to get more than 10-15
entries. 

In the kernel, the most spread out commit I've found so far is 18 entries:

    CONFIG_HIGHPTE vs. sub-page page tables.

   3% arch/powerpc/mm/
   5% arch/sparc/mm/
   6% arch/
   5% include/asm-alpha/
   3% include/asm-avr32/
   3% include/asm-cris/
   4% include/asm-ia64/
   6% include/asm-m68k/
   3% include/asm-mips/
   7% include/asm-powerpc/
   6% include/asm-sh/
   4% include/asm-sparc64/
   3% include/asm-um/
   6% include/asm-x86/
   3% include/asm-xtensa/
   3% include/linux/
  14% include/
   7% mm/
 53 files changed, 326 insertions(+), 132 deletions(-)

but it's not like I looked through all of them (and I'm sure you can get
more if you select just the right commit range to generate the diff).

The point being that a 4-percent cut-off would likely be so big that it
would have hidden the details in the above example.

A 2% cut-off is worth trying, though.  It does get a bit more detail,
and the likelihood of it actually causing a 50-line report is probably
vanishingly small, so it might be worth playing around with.  The above
18-entry example grows to 23 entries with a 2% limit, which is very
borderline on a traditional 80x24 terminal, but still just barely "one
page" which was my personal rule to aim for. 

			Linus
