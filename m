From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/7] block-sha1: improved SHA1 hashing
Date: Thu, 6 Aug 2009 14:24:30 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908061406330.3390@localhost.localdomain>
References: <alpine.LFD.2.01.0908060803140.3390@localhost.localdomain> <4A7B1166.8020507@gmail.com> <alpine.LFD.2.01.0908061052320.3390@localhost.localdomain> <4A7B2A88.2040602@gmail.com> <alpine.LFD.2.01.0908061233360.3390@localhost.localdomain>
 <4A7B384C.2020407@gmail.com> <alpine.LFD.2.01.0908061329320.3390@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Artur Skawina <art.08.09@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 23:25:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZASZ-0006Sy-9D
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 23:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756248AbZHFVZD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 17:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756232AbZHFVZD
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 17:25:03 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45560 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755728AbZHFVZC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Aug 2009 17:25:02 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n76LOUZb008186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Aug 2009 14:24:31 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n76LOUwE029232;
	Thu, 6 Aug 2009 14:24:30 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0908061329320.3390@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.966 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125127>



On Thu, 6 Aug 2009, Linus Torvalds wrote:
> 
> Hmm. Ok, I just tested with your harness, and I get
> 
> 	#             TIME[s] SPEED[MB/s]
> 	rfc3174           5.1       119.7
> 	rfc3174         5.097       119.7
> 	linus           1.836       332.5
> 	linusas         2.006       304.3
> 	linusas2        1.879       324.9
> 	mozilla         5.562       109.7
> 	mozillaas       5.913       103.2
> 	openssl         1.613       378.5
> 	spelvin         1.698       359.5
> 	spelvina        1.602         381
> 	nettle          1.594       382.9

On atom, I get things like:

	#             TIME[s] SPEED[MB/s]
	rfc3174         2.186       27.92
	rfc3174         2.186       27.92
	linus          0.9492        64.3
	linusas        0.9656       63.21
	linusas2        1.012       60.29
	mozilla         2.492       24.49
	mozillaas         2.5       24.41
	openssl        0.6411        95.2
	spelvin        0.6052       100.8
	spelvina       0.6655       91.71
	nettle         0.7149       85.37

but quite frankly, those timings aren't stable enough to say anything. 
Another few runs got me:

	#             TIME[s] SPEED[MB/s]
	rfc3174         2.207       27.65
	rfc3174          2.21       27.62
	linus           1.022       59.74
	linusas         1.058        57.7
	linusas2        1.008       60.58
	mozilla         2.485       24.56
	mozillaas       2.522        24.2
	openssl        0.6421       95.06
	spelvin        0.5989       101.9
	spelvina       0.6638       91.94
	nettle         0.7132       85.58

	#             TIME[s] SPEED[MB/s]
	rfc3174         2.224       27.44
	rfc3174         2.205       27.68
	linus          0.9727       62.75
	linusas        0.9766        62.5
	linusas2        1.026        59.5
	mozilla          2.52       24.22
	mozillaas       2.547       23.96
	openssl        0.6459        94.5
	spelvin        0.6074       100.5
	spelvina       0.6751       90.41
	nettle         0.7254       84.14

so whatever differences there are between linus*, they seem to be in the 
noise, and the hand-scheduled asm beats all the C versions senseless.

I'd like to get closer to the hand-tuned ones, but I don't see anything to 
do any more. It's all about gcc register choice and avoiding spilling. So 
compiler flags changing small details can have _huge_ differences in 
performance. Here's the Atom numbers with gcc given the "-Os" flag (just 
because I wanted to try):

	linus           1.072       56.94
	linusas        0.9573       63.76
	linusas2       0.9906       61.61

Why did 'linus' numbers go down? No idea. With -O3, it's the other way 
around:

	linus          0.9537          64
	linusas        0.9566        63.8
	linusas2        1.013       60.26

but again, there's variation enough that I'd probabyl need to run ten runs 
just to see how much is noise. But the "linusas2 sucks with -O3" is clear, 
as is the "linus sucks with -Os" thing. Very odd, and very random.

		Linus
