From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: [PATCH] Add core.trustlowlevelstat for diffs in dev,ino,uid and gid
Date: Mon, 27 Apr 2009 17:58:17 +0200
Organization: private
Message-ID: <86skjudr6u.fsf@broadpark.no>
References: <1240743317-10117-1-git-send-email-robin.rosenberg@dewire.com>
 <200904261306.15448.robin.rosenberg.lists@dewire.com>
 <7vocujjm5r.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0904261159190.7331@localhost.localdomain>
 <7vab628u23.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0904270757410.22156@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Git Mailing List <git@vger.kernel.org>, spearce@spearce.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 27 17:59:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyTEF-0004QH-3y
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 17:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754592AbZD0P6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 11:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753639AbZD0P6g
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 11:58:36 -0400
Received: from osl1smout1.broadpark.no ([80.202.4.58]:53439 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753339AbZD0P6g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 11:58:36 -0400
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KIR00C6NODMGT20@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Mon, 27 Apr 2009 17:58:34 +0200 (CEST)
Received: from localhost ([80.203.106.123]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KIR00KQCODLAJ10@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Mon, 27 Apr 2009 17:58:34 +0200 (CEST)
In-reply-to: <alpine.LFD.2.00.0904270757410.22156@localhost.localdomain>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117682>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 26 Apr 2009, Junio C Hamano wrote:
>> I like the end result.
>> 
>> But I am not sure about dropping the nanosecond resolution timestamps.
>> The area was extended recently in preparation for ext4; we can take
>> advantage of it to reduce the chance the racy-git avoidance codepath
>> triggers if we keep it.
>> 
>>     fba2f38 (make USE_NSEC work as expected, 2009-02-19)
>> 
>>     c06ff49 (Record ns-timestamps if possible, but do not use it without
>>     USE_NSEC, 2009-03-04)
>
> Hey, we can leave the NSEC support in. Admittedly removing that was about 
> half the patch, but even with it left in, it would be a cleanup.

  I think we should have the NSEC support, as it is a performance
  impromvent, at least on my laptop.  OK, not a huge improvment, but
  still.

  For git version 1.6.3.rc3 I made a litle test, and the difference was
  the following for the 'git checkout my-v2.6.25' (from my-v2.6.27):

                 for git compiled with    for git compiled without
                 'make USE_NSEC=1 ...':   the 'USE_NSEC=1' part:

   OK open calls:       13872                   14386
   OK close calls:      13872                   14386
   OK mmap2 calls:        102                     649
   OK munmap calls:        61                     608

  so, an improvment of 514 open() and close() calls, and 547 mmap2() and
  munmap() calls, for this particular test on my particular slow laptop
  disk.

  As I wrote in fba2f38 I would guess that the improvment is larger for
  a faster disk, and a SSD disk should be able to see a larger
  improvment that I did above.

  -- kjetil
