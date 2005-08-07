From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-format-patch-script bug?
Date: Sun, 07 Aug 2005 12:55:50 -0700
Message-ID: <7viryhv7w9.fsf@assigned-by-dhcp.cox.net>
References: <m1d5oqxkqm.fsf@ebiederm.dsl.xmission.com>
	<7vhde1y85y.fsf@assigned-by-dhcp.cox.net>
	<m1y87dwpak.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 07 21:56:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1rFa-0006Uz-1b
	for gcvg-git@gmane.org; Sun, 07 Aug 2005 21:56:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657AbVHGTzx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Aug 2005 15:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752658AbVHGTzx
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Aug 2005 15:55:53 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:4333 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1752657AbVHGTzw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2005 15:55:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050807195552.RULU7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 7 Aug 2005 15:55:52 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <m1y87dwpak.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
	message of "Sun, 07 Aug 2005 12:54:43 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> What format-patch does is currently is fine.  If format-patch would
> simply notice the case and fail gracefully that would be sufficient to
> avoid giving false impressions.

Hmph.  Since it uses merge-order, We should be able to change it
use the tagged output format of rev-list to detect the revision
list discontinuity and skip generating diff for such.  Or as you
suggest just run "diff-tree with the first parent".

I've been wanting to update format-patch to take the commit
begin-end pair in the rev-parse format, that is:

    $ git format-patch his..mine

I am reluctant to actually do this right away, because this is
an incompatible change from the current format:

    $ git format-patch his mine

The same goes for rebase (and therefore cherry).  I could use an
ugly heuristics for backward compatibility like "if invoked with
exactly two parameters, and there is no prefix ^ nor .. in these
two, then use the old interpretation, otherwise give them to
rev-parse", but I think this is ugly.

So my question to the list is: do people mind this change?
