From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/7] block-sha1: improved SHA1 hashing
Date: Thu, 6 Aug 2009 15:33:45 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908061531310.3390@localhost.localdomain>
References: <alpine.LFD.2.01.0908060803140.3390@localhost.localdomain> <4A7B1166.8020507@gmail.com> <alpine.LFD.2.01.0908061052320.3390@localhost.localdomain> <4A7B2A88.2040602@gmail.com> <alpine.LFD.2.01.0908061233360.3390@localhost.localdomain>
 <4A7B384C.2020407@gmail.com> <alpine.LFD.2.01.0908061329320.3390@localhost.localdomain> <4A7B4D84.80906@gmail.com> <4A7B509A.5010405@gmail.com> <alpine.LFD.2.01.0908061502570.3390@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Artur Skawina <art.08.09@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 00:34:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZBXR-00056A-2C
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 00:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754687AbZHFWdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 18:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754557AbZHFWdr
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 18:33:47 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38433 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750982AbZHFWdq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Aug 2009 18:33:46 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n76MXjhu013755
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Aug 2009 15:33:46 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n76MXjIE015970;
	Thu, 6 Aug 2009 15:33:45 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0908061502570.3390@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.966 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125134>



On Thu, 6 Aug 2009, Linus Torvalds wrote:
> 
> Anyway, on P4 I think you have two double-speed integer issue ports (ie 
> max four ops per cycle), but only one of them takes a rotate, and only in 
> the first half of the cycle (ie just one shift per cycle).
> 
> And afaik, that is actually the _improved_ state in Prescott. The older 
> P4's didn't have a full shifter unit at all, iirc: shifts were "complex 
> instructions" in Northwood and weren't even single-clock.

Yeah, verified. Google for

	northwood "barrel shifter"

and you'll find a lot of it.

Basically, older P4's will I think shift one bit at a time. So while even 
Prescott is relatively weak in the shifter department, pre-prescott 
(Willamette and Northwood) are _really_ weak. If your P4 is one of those, 
you really shouldn't use it to decide on optimizations.

		Linus
