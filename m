From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git-svnimport failed and now git-repack hates me
Date: 03 Jan 2007 18:40:02 -0800
Message-ID: <86ps9vbjlp.fsf@blue.stonehenge.com>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com>
	<Pine.LNX.4.64.0701031737300.4989@woody.osdl.org>
	<20070104023350.GA1194@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Lee <chris133@gmail.com>, Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	Shawn Pearce <spearce@spearce.org>,
	Sasha Khapyorsky <sashak@voltaire.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 04 03:40:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2IWX-0002dE-T2
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 03:40:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbXADCkF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 21:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbXADCkF
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 21:40:05 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:20044 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932194AbXADCkD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 21:40:03 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id C170A8DC23;
	Wed,  3 Jan 2007 18:40:02 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 11501-01-12; Wed,  3 Jan 2007 18:40:02 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 40A0E8DC8A; Wed,  3 Jan 2007 18:40:02 -0800 (PST)
To: Eric Wong <normalperson@yhbt.net>
x-mayan-date: Long count = 12.19.13.17.1; tzolkin = 9 Imix; haab = 14 Kankin
In-Reply-To: <20070104023350.GA1194@localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35907>

>>>>> "Eric" == Eric Wong <normalperson@yhbt.net> writes:

Eric> Part of it is Perl, which (as far as I know) never frees allocated
Eric> memory back to the OS (although Perl can reuse the allocated memory for
Eric> other things).

It does on Linux, of all things.  That's because Linux has a smarter
malloc/free that uses mmap(2) for the large chunks.  On Linux, Perl memory
size can apparently grow and shrink nicely.  The "old school" advice about
Perl comes from sbrk(2)-driven malloc/free.

Try:

        $x[1e6] = "0";
        sleep 10; # do a ps here
        @x = ();
        sleep 30; # do a ps here

and watch the process on Linux.  If I'm right, this should show a large
process,  then a smaller one.

If you're getting a growing process though, you probably have a circular data
reference.  Maybe you have a tree with backpointers, and those backpointers
should have been weakened?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
