From: Junio C Hamano <junkio@cox.net>
Subject: Re: Change set based shallow clone
Date: Sat, 09 Sep 2006 22:46:37 -0700
Message-ID: <7vejukuvcy.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com>
	<Pine.LNX.4.64.0609082054560.27779@g5.osdl.org>
	<e5bfff550609090147q37d61f37j9c3e8ae6d3a0cf35@mail.gmail.com>
	<Pine.LNX.4.64.0609091022360.27779@g5.osdl.org>
	<e5bfff550609091104s3709b82fld3057a07a84ae857@mail.gmail.com>
	<Pine.LNX.4.64.0609091256110.27779@g5.osdl.org>
	<e5bfff550609092049t5e016cacr2502ce81bbb6489e@mail.gmail.com>
	<7vpse4uzos.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550609092123t1d8b6c70s5750fbb787534812@mail.gmail.com>
	<7virjwuxrz.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550609092214t4f8e195eib28e302f4d284aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Sep 10 07:46:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMI90-0001iK-Uw
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 07:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965264AbWIJFqA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 01:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965266AbWIJFqA
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 01:46:00 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:9939 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S965264AbWIJFqA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 01:46:00 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060910054559.VUBA12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Sun, 10 Sep 2006 01:45:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id LVm01V00U1kojtg0000000
	Sun, 10 Sep 2006 01:46:00 -0400
To: git@vger.kernel.org
In-Reply-To: <e5bfff550609092214t4f8e195eib28e302f4d284aa@mail.gmail.com>
	(Marco Costalba's message of "Sun, 10 Sep 2006 07:14:09 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26785>

"Marco Costalba" <mcostalba@gmail.com> writes:

> On 9/10/06, Junio C Hamano <junkio@cox.net> wrote:
>> "Marco Costalba" <mcostalba@gmail.com> writes:
>>
>> > >>
>> > >>                     A           <--- tip of branch
>> > >>                    / \
>> > >>                   B   E
>> > >>                   |   |
>> > >>                   |   F
>> > >>                   | /
>> > >>                   C
>> > >>                   |
>> > >>                   D
>> > >>                 ...
>> > >>
>> >
>> > Ok. What about something like this?
>> > A, B, C, D, E, (-3, 1)F
>> >
>> > where -3 is the correct position in sequence and 1 is the number of
>> > revisions before F to whom apply the -3 rule.
>>
>> That means F knows who its descendants are, and commit objects
>> do not have that information, so while traversing you need to
>> keep track of all the descendants yourself, doesn't it?
>>
>
> Yes! it is, but you do it in git instead of in the visualizer ;-)
> because I think in any case someone defenitly needs to keep track of
> it.

Not really.

To git-rev-list, which does not know how the visualizer uses the
data, what you are saying essentially means that it needs to
hold onto the data it parsed forever.  That's where my earlier
suggestion for visualizers to take advantage of the "windowing"
information comes from.  Since the chain depicted in the above
between E..F can be arbitrary long (and you would need to keep
track of information for B and C too, well, essentially
everything), that is unacceptable for rev-list if you do not
give it additional clue when it can discard that information.
