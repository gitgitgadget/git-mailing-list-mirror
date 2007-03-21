From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Bisect: fix calculation of the number of suspicious
 revisions
Date: Wed, 21 Mar 2007 15:27:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703211521290.6730@woody.linux-foundation.org>
References: <20070317141209.GA7838@cepheus>
 <Pine.LNX.4.63.0703171845541.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070317195840.GA20735@informatik.uni-freiburg.de> <20070321210454.GA2844@lala>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463790079-884347500-1174516049=:6730"
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Wed Mar 21 23:28:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HU9Ht-0006DG-0n
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 23:28:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965424AbXCUW2A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 18:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965415AbXCUW2A
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 18:28:00 -0400
Received: from smtp.osdl.org ([65.172.181.24]:56640 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965404AbXCUW17 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 18:27:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2LMRUG9007625
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 21 Mar 2007 15:27:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2LMRTWN005440;
	Wed, 21 Mar 2007 15:27:30 -0700
In-Reply-To: <20070321210454.GA2844@lala>
X-Spam-Status: No, hits=-2.473 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42822>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463790079-884347500-1174516049=:6730
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



On Wed, 21 Mar 2007, Uwe Kleine-König wrote:
>
> Up to now the number printed was calculated assuming that the current revision
> to test is bad.  Given that it's not possible that this always matches the
> number of suspicious revs if the current one is good, the maximum of both is
> taken now.

How about adding a new flag to "git-rev-list", to make it count both ways? 
Doing this whole

	nr = $(eval "git-rev-list ... | wc -l")

was ugly to begin with, and you just made it doubly ugly.

And the thing is, "git-rev-list --bisect" will obviously already have 
calculated these numbers just to _pick_ the revision in the first place, 
so it's a bit sad then execute it twice more (giving it back the result 
*it* gave us in the first place!).

So we could perhaps change the original

	rev=$(eval "git-rev-list --bisect $good $bad -- $(cat $GIT_DIR/BISECT_NAMES)")

with something nicer.

(In fact, I would also suggest we drop or try to fix BISECT_NAMES support, 
while at it - it never really worked, and iirc it was partly exactly 
*because* of the end-condition not being handled right).

		Linus
---1463790079-884347500-1174516049=:6730--
