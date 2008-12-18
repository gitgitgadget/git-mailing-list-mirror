From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH] Committer, author and tagger time should not be parsed as 32 bit signed int
Date: Thu, 18 Dec 2008 01:09:51 +0100
Message-ID: <200812180109.51987.robin.rosenberg.lists@dewire.com>
References: <200812172328.07371.robin.rosenberg.lists@dewire.com> <1229553172-2038-1-git-send-email-robin.rosenberg@dewire.com> <20081217224844.GK32487@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Dec 18 01:11:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD6Ty-0005cV-20
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 01:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559AbYLRAJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 19:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752560AbYLRAJ4
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 19:09:56 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:40726 "EHLO
	pne-smtpout2-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752284AbYLRAJz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Dec 2008 19:09:55 -0500
Received: from sleipner.localnet (213.67.100.250) by pne-smtpout2-sn1.fre.skanova.net (7.3.129)
        id 4843FAEB02F2A564; Thu, 18 Dec 2008 01:09:53 +0100
User-Agent: KMail/1.10.3 (Linux/2.6.27-10-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <20081217224844.GK32487@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103415>

onsdag 17 december 2008 23:48:44 skrev Shawn O. Pearce:
> Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> > If not dates past 2038 will be parsed the wrong way when
> > parsed into a RevCommit or RevTag object.
> 
> Uhm, sure.
> 
> But there's also the commitTime field in RevCommit, its used to
> sort commits during walking.  In 2038 that will also overflow.

Ok, but that's not used for display purposes, which what I saw. How
huge is the cost of a long here. Most processor handle longs
well today, though many megs of them will hurt the cache.

> Also, if you search the code for '2038' you'll find a remark
> about the year 2038 in DirCacheEntry.smudgeRacilyClean.  Last
> I looked at the git sources I think this field in the index is
> treated as a signed time_t so we can't set the high bits and
> extend it out another 60+ years.

That is another time stamp. It is a file time stamp, which we
never store in the Git object database. The index can be revised over time since
it is purely local structure. If it weren't for the need to operate
with C Git in the same repo we could have used a different format,
and nobody would notice. (The first jgit versions used a different
index structure). 

time_t is signed, but it is also 64 bit on 64-bit linux so it doesn't overflow in 2038.

$ cev 'printf("sizeof time =%d\n",sizeof(time_t));'
sizeof time =8

> I'd rather just tag the fields with "2038" so we can search for
> them in the future.  Like say this:

There should be a comment on the commitTime field too if we choose
that option.

-- robin
