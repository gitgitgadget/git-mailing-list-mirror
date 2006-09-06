From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/5] autoconf: Preliminary check for working mmap
Date: Wed, 06 Sep 2006 01:15:52 -0700
Message-ID: <7vodtt8l6v.fsf@assigned-by-dhcp.cox.net>
References: <200609050054.24279.jnareb@gmail.com>
	<200609050056.52590.jnareb@gmail.com>
	<7vy7szjjal.fsf@assigned-by-dhcp.cox.net> <edidlp$d3d$1@sea.gmane.org>
	<20060905030929.GA29865@spearce.org>
	<7vu03mkiei.fsf@assigned-by-dhcp.cox.net>
	<20060905062531.GA30496@spearce.org>
	<7v1wqqkbbv.fsf@assigned-by-dhcp.cox.net>
	<20060906034054.GB30598@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 06 10:16:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKsZh-0000VI-3G
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 10:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbWIFIPx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 04:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWIFIPx
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 04:15:53 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:60564 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750859AbWIFIPw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 04:15:52 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060906081549.FKKD27846.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Wed, 6 Sep 2006 04:15:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id JwFi1V0071kojtg0000000
	Wed, 06 Sep 2006 04:15:43 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060906034054.GB30598@spearce.org> (Shawn Pearce's message of
	"Tue, 5 Sep 2006 23:40:54 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26507>

Shawn Pearce <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> Shawn Pearce <spearce@spearce.org> writes:
>> 
>> > I don't know if I've made this more complex than I really need to
>> > but I've permitted multiple windows per pack.  There is just one
>> > LRU of all windows across all packs and a maximum amount of address
>> > space to use for pack mappings.  Least recently used window gets
>> > tossed when we need a different window.  This permits us to keep
>> > say a window active on the front of a pack (near the commits) and
>> > another different active window closer to the back (near the blobs).
>> 
>> Sounds good. That is exactly what I was expecting it to be done.
>
> So I have this implemented but its against the 32 bit index.
> It passes the full test suite and appears to be working as intended.

Well, if you are talking about git.git t/ directory, I bet that
"the full test suite" easily fits in a single window so much of
the new code is not exercised, unless you have a runtime option
to make use of very tiny window (32kB would be nice) for testing
;-).

> I am going to rebase the changes to the 64 bit index in `pu`
> and clean up my history.  Its currently one massive commit with
> lots of changes that should be broken down into slightly more
> digestable chunks.

Breaking things up would be nice.  Do you have a good testcase
out of Mozilla repository that _needs_ 64-bit index?  The code
in "pu" uses 64-bit index only 32-bit offset cannot describe the
pack, so I only tested with an artificial case with the kernel
archive with .idx converted with convert-idx to 64-bit.
