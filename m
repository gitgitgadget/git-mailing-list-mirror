From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Speedup recursive by flushing index only once for all entries
Date: Wed, 10 Jan 2007 16:34:11 -0800
Message-ID: <7v4pqy8kqk.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0701040247k47e398e6q34dd5233bb5706f6@mail.gmail.com>
	<Pine.LNX.4.63.0701041327490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<81b0412b0701040447u329dcf9bvcd7adb9e9d199f18@mail.gmail.com>
	<7v8xgileza.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0701050322u67131900xea969b2da9981a94@mail.gmail.com>
	<20070107163112.GA9336@steel.home>
	<7vr6u2adgx.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0701101507n764aed73p31c7533e743283f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 01:34:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4ntn-0002Cr-4Q
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 01:34:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965257AbXAKAe2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 19:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965253AbXAKAe2
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 19:34:28 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:41677 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965257AbXAKAe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 19:34:28 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070111003427.HJCC18767.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Wed, 10 Jan 2007 19:34:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9cZc1W00J1kojtg0000000; Wed, 10 Jan 2007 19:33:37 -0500
To: "Alex Riesen" <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0701101507n764aed73p31c7533e743283f0@mail.gmail.com>
	(Alex Riesen's message of "Thu, 11 Jan 2007 00:07:39 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36542>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> On 1/10/07, Junio C Hamano <junkio@cox.net> wrote:
>> This comes on top of yours.
>>
>> I'm reproducing all the merges in linux-2.6 history to make sure
>> the base one, yours and this produce the same result (the same
>> clean merge, or the same unmerged index and the same diff from
>> HEAD).  So far it is looking good.
>
> Yep. Tried the monster merge on it: 1m15sec on that small laptop.

Is that supposed to be a good news?  It sounds awfully slow.

> For whatever reason your patch left an "if (cache_dirty) flush_cache()",
> that's after my patch + yours. Had it removed.

That's because my copy of "your patch" has the fix-up I
suggested to remove the flush from process_renames() already --
the removal of that one and removal from process_entry() you did
logically belong to each other.
