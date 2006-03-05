From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-blame: Make the output human readable
Date: Sun, 05 Mar 2006 13:28:57 -0800
Message-ID: <7vveuseg2u.fsf@assigned-by-dhcp.cox.net>
References: <20060305110351.GA23448@c165.ib.student.liu.se>
	<7vbqwlgkhk.fsf@assigned-by-dhcp.cox.net>
	<20060305123800.GD23448@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Sun Mar 05 22:29:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG0mm-0007ie-Ry
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 22:29:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbWCEV3A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 16:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751817AbWCEV3A
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 16:29:00 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:56509 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751839AbWCEV27 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Mar 2006 16:28:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060305212903.JLWG25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Mar 2006 16:29:03 -0500
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20060305123800.GD23448@c165.ib.student.liu.se> (Fredrik
	Kuivinen's message of "Sun, 5 Mar 2006 13:38:01 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17244>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> I find the first format easier to read since everything is aligned (we
> always output 15 characters for the committer's name padded with
> spaces if necessary and the line numbers are padded appropriately). It
> also takes up less space on screen since it doesn't use tabs.

Careful.  The convention for names is to encode them in UTF-8,
so if you mean 15 "characters" that might be OK but if it can
truncate in the middle of a multibyte sequence of UTF-8 encoded
single character it is a no-no.

We are talking about "casual" aligning, so I would not bring up
"proportional fonts", but even on a monospace terminal and
line-printer output, there still is the issue of byte count not
matching columns.  In an i18nized environment, aligning columns
by counting bytes is a lost battle.

In any case, please make sure you do not chop a character in the
middle at least [*1*].

> We may want to add an output format suitable for scripts too, which
> just lists the SHA1. But I don't think it is much more difficult to
> parse the format above, at least not if you just want the SHA1s.

Fair enough.

> It uses log(3) to compute the number of digits needed to represent the
> last line number. It is probably better to this some other way
> though...

Yup.


[Footnote]

*1* I was kind of impressed that Linus was careful about this
issue when I saw the commit log chopping is only done at line
boundaries.  A very careful coder would have chopped the last
line in the middle at character boundary, but if you do not want
to bother that much, chopping at line boundary is better than
chopping the last line in the middle of a character ;-).
