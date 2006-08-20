From: Junio C Hamano <junkio@cox.net>
Subject: Re: Unresolved issues #3
Date: Sun, 20 Aug 2006 16:26:33 -0700
Message-ID: <7vk653xa3a.fsf@assigned-by-dhcp.cox.net>
References: <7vpseyelcw.fsf@assigned-by-dhcp.cox.net>
	<44E546F2.7070902@gmail.com>
	<Pine.LNX.4.64.0608181041420.11359@localhost.localdomain>
	<44E5D522.8030407@gmail.com>
	<Pine.LNX.4.64.0608181119410.11359@localhost.localdomain>
	<44E68DCD.8010603@gmail.com>
	<Pine.LNX.4.64.0608201840310.11359@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Aug 21 01:26:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEwgg-0007bk-G5
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 01:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWHTX0f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Aug 2006 19:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWHTX0f
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Aug 2006 19:26:35 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:12940 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932084AbWHTX0e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Aug 2006 19:26:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060820232633.SHYX6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 20 Aug 2006 19:26:33 -0400
To: A Large Angry SCM <gitzilla@gmail.com>
In-Reply-To: <Pine.LNX.4.64.0608201840310.11359@localhost.localdomain>
	(Nicolas Pitre's message of "Sun, 20 Aug 2006 19:10:23 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25772>

Nicolas Pitre <nico@cam.org> writes:

> On Fri, 18 Aug 2006, A Large Angry SCM wrote:
>
>> Historic fact. Between Thu May 19 08:56:22 2005 and Thu Feb  9 21:06:38
>> 2006 bit 6 of the first byte of a delta hunk was interpreted to mean
>> that the source of the copy was the result buffer. From Thu May 19
>> 08:56:22 2005 on, the code to decode delta hunks in type 2 packs was
>> available to everyone and anyone interested could make a pack encoder
>> that would create packs that the core Git code would correctly read. The
>> commit of Thu Feb  9 21:06:38 2006, d60fc, actually introduced a bug
>> that would treat valid type 2 packs as invalid.

It is more like the said commit made the pack format extensible
by declaring the bit reserved for the future use, by declaring
retroactively that a type 2 pack that used that bit invalid.
And it was deemed a reasonable and safe decision because no
official git ever produced a type 2 pack that used that bit,

Yes, that was a backward incompatible change, strictly speaking,
and probably I should have made an announcement that looked
similar to this by Linus:

        From: Linus Torvalds <torvalds@osdl.org>
        Subject: CAREFUL! No more delta object support!
        Date: Mon, 27 Jun 2005 18:14:40 -0700 (PDT)
        Message-ID: <Pine.LNX.4.58.0506271755140.19755@ppc970.osdl.org>
        To: Git Mailing List <git@vger.kernel.org>

So you could argue I was incompetent not to make a big fuss
about this backward incompatibility back then, if you like.

I did not think it was worth it back then, and I do not think it
is worth it now, either.  But if it makes you feel better, I
could retroactively make such an announcement about the
unofficial bit 6.

The announcement would have read like this:

    The current git code does not support type #2 packs that
    uses delta with bit 6 to mean "copy inside destination
    buffer".  Although the code that interpreted delta data
    supported bit 6 that way for a brief period of time, no
    official git ever released produced delta that used the
    bit that way.

    In other words, if you have created packs with your own,
    modified git, that took advantage of "copy inside
    destination buffer" feature in the delta interpretation
    code, such packs are not usable by the official git, so
    you need to unpack them using your own version of git
    and then repack with the official version of git.
