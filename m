From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] format-patch: Use --mbox by default.
Date: Sun, 08 Jan 2006 12:28:58 -0800
Message-ID: <7vhd8ezcol.fsf@assigned-by-dhcp.cox.net>
References: <20060108140109.909925BE8D@nox.op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 08 21:29:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvhA6-0000cy-0t
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 21:29:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932768AbWAHU3B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jan 2006 15:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932769AbWAHU3B
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jan 2006 15:29:01 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:55484 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932768AbWAHU3A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2006 15:29:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060108202710.RSGO17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 8 Jan 2006 15:27:10 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <20060108140109.909925BE8D@nox.op5.se> (Andreas Ericsson's
	message of "Sun, 8 Jan 2006 14:01:25 +0000 (UTC)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14332>

Andreas Ericsson <ae@op5.se> writes:

> This patch enables a slightly modified and more correct --mbox
> output by default. The --date, --author and --mbox options
> are obsoleted and removed.

I always use format-patch with -k -m (or -k --stdout), so I have
no objections to making --mbox the default.  I do not think
anybody uses --date or --author in their scripts, but removing
the --mbox option _might_ break things for people's scripts.
Maybe it is worthwhile to keep it as a no-op option for a while.

> Previously, author-info and date was by default only printed if the
> commit was made by someone else, irrespective of the obsoleted options.
> Since it does no harm having ones own info there too it shouldn't really
> matter much, and should lessen the confusion regarding how to use
> git-format-patch with git-am.

True.  Originally it was really "format my changes to
submission" tool (--signoff option is a sure sign to tell you
that) and propagating authorship info was added as afterthought.

> The patches generated also had bad mail headers for sendmail (of
> postfix 2.2.2 at least) to use directly (From: line must be on top,
> Subject: last of header),...

I do not think RFC2822 specifies that.  See "3.6 Field
definitions", third paragraph, first two sentences.

In that sense, technically they are not "bad mail headers", but
at the same time, since it is valid in any order, if _one_
popular MTA is unconfortable with a particular ordering, we
could order things differently to make it happier (mind you,
this would not work for more than one such broken MTAs).

Another thing I've been considering is to handle UTF-8 (or
i18n.commitencoding in general) a bit better.  We currently do
not have Content-Type: header, so if you pipe the output to
"am", it must be invoked without "-u" to make sure that it takes
things as-is ("am -u" assumes things are in latin1 without
Content-Type:).  If we start to tackle that issue, we might also
want to do RFC2047 in headers.
