From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/5] merge-recursive: handle D/F conflict case more carefully.
Date: Tue, 10 Apr 2007 11:20:30 -0700
Message-ID: <7vabxgw0pd.fsf@assigned-by-dhcp.cox.net>
References: <7v6488ckk0.fsf@assigned-by-dhcp.cox.net>
	<20070409185809.GA13212@steel.home>
	<7vk5wlz5mg.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0704100140g7684e128g75c986c213ac9d0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Johannes Schindelin" <johannes.schindelin@gmx.de>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 03:41:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbKxH-0007MY-5F
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 20:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031380AbXDJSUc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 14:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031382AbXDJSUc
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 14:20:32 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:34222 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031380AbXDJSUb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 14:20:31 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070410182030.HPWW1266.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 10 Apr 2007 14:20:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id lWLW1W0091kojtg0000000; Tue, 10 Apr 2007 14:20:30 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44158>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> On 4/9/07, Junio C Hamano <junkio@cox.net> wrote:
>> Alex Riesen <raa.lkml@gmail.com> writes:
>>
>> > Junio C Hamano, Sat, Apr 07, 2007 16:42:55 +0200:
>> >> +                    if (unlink(path)) {
>> >> +                            if (errno == EISDIR) {
>> >> +                                    /* something else exists */
>> >> +                                    error(msg, path, ": perhaps a D/F conflict?");
>> >
>> > isn't this one an F/D conflict?
>>
>> Yes, as I said in a separate message, the current D/F detector
>> code in merge-recursive does not catch this case in t3030 test
>> and comes to this codepath to write it out:
>>
>
> I mean, maybe the error could be spelled differently:
> ": perhaps an F/D conflict?"
> Right now we have two exactly the same errors,
> as seen on the output. The messages refer to different
> conflicts, though. It is usually useful to know what is really
> going on.

Perhaps, but I think the bigger issue is that existing D/F or
F/D conflict detection is simply buggy, and this patch shouldn't
be needed if they were working correctly.
