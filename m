From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Cogito: Support for implicit remote branches in cloned repositories
Date: Fri, 04 Nov 2005 13:50:22 -0800
Message-ID: <7voe50rskh.fsf@assigned-by-dhcp.cox.net>
References: <200511041701.48881.Josef.Weidendorfer@gmx.de>
	<7vvez8wbpz.fsf@assigned-by-dhcp.cox.net>
	<20051104210820.GM1431@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 22:51:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY9S7-0000wg-Fy
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 22:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbVKDVuZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 16:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbVKDVuY
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 16:50:24 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:23689 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750949AbVKDVuY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2005 16:50:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051104214938.BQYW776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 4 Nov 2005 16:49:38 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051104210820.GM1431@pasky.or.cz> (Petr Baudis's message of
	"Fri, 4 Nov 2005 22:08:20 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11163>

Petr Baudis <pasky@suse.cz> writes:

> I still believe we need the notion of private tags which shouldn't be
> cloned.

I agree with you violently.  I just do not know what is the
right convention to tell which is private and which is not.

Fetching used to be a different matter, because we did not do
'git-fetch --tags' for a reason: you do not have any business
with my tags unless I tell you about them.  But now we tell
others about what tags we have, so...

> All right. git-update-server-info ignores hidden refs, but referencing a
> hidden ref works all right (unsurprisingly). So let's just codify that
> private tags which shan't be fetched (unless requested explicitly) start
> with a dot (/^\./) and we are all set...?

Except that I suspect refs.c::check_ref_format() will barf on it
instead of ignoring it, and obviously you would want it to do
two different things depending on what kind of operation you are
doing.  You for example would want to change git-branch or
git-tag not to refuse creating such "private" tag.  You would
still want git-upload-pack to show it to the other end, for
better common commit computation purposes, especially if the tag
is of lightweight kind, but would want git-clone to ignore
them.  It should be doable but we first need a plan.
