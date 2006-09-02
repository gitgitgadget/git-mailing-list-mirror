From: Junio C Hamano <junkio@cox.net>
Subject: Re: Mozilla .git tree
Date: Sat, 02 Sep 2006 04:02:50 -0700
Message-ID: <7v3bba1qg5.fsf@assigned-by-dhcp.cox.net>
References: <20060829190548.GK21729@spearce.org>
	<9e4733910608291252q130fc723r945e6ab906ca6969@mail.gmail.com>
	<20060829232007.GC22935@spearce.org>
	<9e4733910608291807q9b896e4sdbfaa9e49de58c2b@mail.gmail.com>
	<20060830015122.GE22935@spearce.org>
	<9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com>
	<20060830031029.GA23967@spearce.org>
	<Pine.LNX.4.64.0608300124550.9796@xanadu.home>
	<7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net>
	<7vr6yw58xp.fsf@assigned-by-dhcp.cox.net>
	<20060902020426.GF24234@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Sep 02 13:03:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJTHA-0006wJ-HP
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 13:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWIBLCt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Sep 2006 07:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbWIBLCt
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 07:02:49 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:20648 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751032AbWIBLCs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Sep 2006 07:02:48 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060902110248.JZOT4015.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Sat, 2 Sep 2006 07:02:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id HP2i1V00U1kojtg0000000
	Sat, 02 Sep 2006 07:02:43 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060902020426.GF24234@spearce.org> (Shawn Pearce's message of
	"Fri, 1 Sep 2006 22:04:27 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26330>

Shawn Pearce <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
> [snip]
>> +A new style .idx file begins with a signature, "\377tOc", and a
>> +version number as a 4-byte network byte order integer.  The version
>> +of this implementation is 2.
>
> Ick.  I understand why you did this (and thanks for such a good
> explanation of it by the way) but what a horrible signature number
> and way to wedge in a version number.

I do not think it is particularly horrible.  

I initially was planning to introduce a new file extention .toc
(table of contents), not just because that would let us start
afresh with file format that has version number from the
beginning, but also because we use the word "index" to mean
"cache" these days, and it would be a good idea to use a
different word to mean different things.  The latter 3 bytes
reflects that.

> I think we probably should have done this when the binary headers
> were introduced into loose objects.

No.  That was purely .pack format and did not affect .idx
format.  Honestly .idx is purely a local matter and not as
important to keep stable as the .pack format.

> Sure the scheme you outlined allows a 64 bit difference but
> uncompressed objects already can't be larger than 2**32-1...

Where do we have that limitation?

In any case, the next round I am planning to get rid of this
"where the tail is" business.  I do not think it buys us much
and inflates the 46MB index you need to deal with even more.

I think your "allow zlib to eat the remainder of the current
window and slide window when it exhausts the current window"
logic is a very good on and makes it unnecessary to know the
tail of each object.



-- 
VGER BF report: U 0.5
