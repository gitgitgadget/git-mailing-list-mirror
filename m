From: Junio C Hamano <junkio@cox.net>
Subject: Re: [QUESTION] about .git/info/grafts file
Date: Thu, 19 Jan 2006 10:24:11 -0800
Message-ID: <7v3bjkf54k.fsf@assigned-by-dhcp.cox.net>
References: <cda58cb80601170928r252a6e34y@mail.gmail.com>
	<cda58cb80601170932o6f955469y@mail.gmail.com>
	<7v8xtdrqwg.fsf@assigned-by-dhcp.cox.net>
	<cda58cb80601190251v5251c8bdh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 19 19:29:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzeSV-0001bx-5Z
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 19:24:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161173AbWASSYP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 13:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161186AbWASSYP
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 13:24:15 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:60623 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1161173AbWASSYO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2006 13:24:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060119182149.HELT17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 19 Jan 2006 13:21:49 -0500
To: Franck <vagabon.xyz@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14925>

Franck <vagabon.xyz@gmail.com> writes:

> I don't see why it is so bad to create a "grafted" repository ? I want
> it to be small but still want to merge by using git-resolve with XX
> repository.

Franck, and people on the list,

I have a bad habit of responding to a "call for help" request by
stating how things are currently done and why, sometimes with an
outline of how the limitation in the current way can be (or at
least I think it could be, without testing that solution myself)
worked around, but without making it explicit if the limitation
is something that should not be there or if it is something
fundamental.  This often makes it sound as if I am saying I
think the original request is unreasonable, and/or the current
state of affairs is perfect.  This is one of such cases.

I agree it would be nice to support "strictly speaking, the
repository is incomplete but has everything necessary as long as
you operate near the tip of the development" mode of operation.

It only has never been a high priority.

> Well in my graft file I did:
>
>                     $ cat > .git/info/grafts
>                     <shaid> <shaid>
>
>                     $

The trailing empty line at the end is discarded as a comment, I
think, so that should be fine.  "terminated by a newline" in the
documentation talks about each line being terminated by a LF,
not about terminating the file itself with an extra newline.

I think you spotted a bug in a documentation and another in the
code.  I presume these two <shaid> are the same in what you did;
you are saying "this commit has itself as its parent", but that
can never be the case and the graft parser should reject such
line and complain but I do not think the current code does so.

The documentation says "a commit and its fake parents ...
separated by a space and terminated by a newline".  We should at
least say "zero or more fake parents", or make it ever clearer
by giving a couple of examples.
