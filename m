From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Add core.trustlowlevelstat for diffs in dev,ino,uid and
 gid
Date: Mon, 27 Apr 2009 08:00:38 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0904270757410.22156@localhost.localdomain>
References: <1240743317-10117-1-git-send-email-robin.rosenberg@dewire.com> <200904261306.15448.robin.rosenberg.lists@dewire.com> <7vocujjm5r.fsf@gitster.siamese.dyndns.org> <alpine.LFD.2.00.0904261159190.7331@localhost.localdomain>
 <7vab628u23.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kjetil Barvik <barvik@broadpark.no>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Git Mailing List <git@vger.kernel.org>, spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 17:04:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LySNx-0002eJ-VL
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 17:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754899AbZD0PEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 11:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754643AbZD0PEc
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 11:04:32 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42957 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754304AbZD0PEc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Apr 2009 11:04:32 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3RF0eiG021353
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 27 Apr 2009 08:01:16 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3RF0c7H003673;
	Mon, 27 Apr 2009 08:00:39 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vab628u23.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.456 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117675>



On Sun, 26 Apr 2009, Junio C Hamano wrote:
> 
> Was ignoring st_dev checking primarily for a work tree over NFS?

Yes, but I think there were other issues too (like git repositories on 
removable media).

The inode number really has similar concerns - different operating systems 
will use different inode numbers for both NFS and for things like FAT. 
It's not nearly as noticeable, because people don't tend to switch OS's as 
much as they might switch between two machines.

> I like the end result.
> 
> But I am not sure about dropping the nanosecond resolution timestamps.
> The area was extended recently in preparation for ext4; we can take
> advantage of it to reduce the chance the racy-git avoidance codepath
> triggers if we keep it.
> 
>     fba2f38 (make USE_NSEC work as expected, 2009-02-19)
> 
>     c06ff49 (Record ns-timestamps if possible, but do not use it without
>     USE_NSEC, 2009-03-04)

Hey, we can leave the NSEC support in. Admittedly removing that was about 
half the patch, but even with it left in, it would be a cleanup.

		Linus
