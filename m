From: Junio C Hamano <gitster@pobox.com>
Subject: Re: auto gc again
Date: Wed, 19 Mar 2008 16:25:28 -0700
Message-ID: <7vd4pq1el3.fsf@gitster.siamese.dyndns.org>
References: <20080318180118.GC17940@kernel.dk>
 <7vd4pq2ymo.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0803191444490.3020@woody.linux-foundation.org>
 <7vod9a1h8e.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0803191910170.2947@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <jens.axboe@oracle.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Mar 20 00:26:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc7g8-00026J-Ar
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 00:26:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933154AbYCSXZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 19:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932698AbYCSXZq
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 19:25:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55067 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933215AbYCSXZn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 19:25:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4406F20D2;
	Wed, 19 Mar 2008 19:25:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 68F0F20D1; Wed, 19 Mar 2008 19:25:35 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.00.0803191910170.2947@xanadu.home> (Nicolas
 Pitre's message of "Wed, 19 Mar 2008 19:16:15 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77587>

Nicolas Pitre <nico@cam.org> writes:

> On Wed, 19 Mar 2008, Junio C Hamano wrote:
>
>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>> 
>> > On Wed, 19 Mar 2008, Junio C Hamano wrote:
>> ...
>> >  - make the default for autopacklimit rather higher (pick number at 
>> >    random: 50 instead of 20).
>> >
>> >    Rationale: the reason for "git gc --auto" wasn't to keep things 
>> >    perfectly packed, but to avoid the _really_ bad cases. The old default 
>> >    of 20 may be fine if you want to always keep the repo very tight, but 
>> >    that wasn't why "git gc --auto" was done, was it?
>> 
>> I do not think "very tight" was the reason, but on the other hand, my
>> personal feeling is that 20 was already 10 too many pack idx files we have
>> to walk linearly while looking for objects at runtime.
>
> Since commit f7c22cc68ccb this is no longer such an issue.

Notice that I did not say "19 too many".  I know f7c22cc (always start
looking up objects in the last used pack first, 2007-05-30) was meant to
alleviate the situation, but isn't "no longer" a gross exaggeration?

> Note that the current fetch.unpackLimit might play a role as well, 
> especially if you fetch often (often meaning that you're more likely to 
> have the received pack exploded into loose objects, or you're 
> accumulating many small packs).

Ah, yes, native fetch will also result in a new pack, so even if you do
not do anything else, if you fetch once a day, you will accumulate 20
packs in that many days.
