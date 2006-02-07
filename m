From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitk changing line color for no reason after merge
Date: Tue, 07 Feb 2006 02:04:46 -0800
Message-ID: <7vlkwnxz5t.fsf@assigned-by-dhcp.cox.net>
References: <1138900897.28967.18.camel@dv> <1139289517.15955.23.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 11:05:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6PiV-0001sb-A7
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 11:04:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWBGKEt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 05:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWBGKEt
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 05:04:49 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:43752 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S964833AbWBGKEs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2006 05:04:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060207100227.YQFK17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 7 Feb 2006 05:02:27 -0500
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1139289517.15955.23.camel@dv> (Pavel Roskin's message of "Tue,
	07 Feb 2006 00:18:37 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15688>

Pavel Roskin <proski@gnu.org> writes:

> I still stand behind this patch because it eliminates color changes on
> the nodes that have exactly one child and parent.  $nparents($id) is
> irrelevant here, because it characterizes the current node, but the code
> decides whether the line should change color at the child node.

It all depends on what you are trying to achieve with colours.
Being a bit colour-challenged, I am not in a good position to
comment on how much gitk's use of different colours is helping
the readability, but I suspect not very much.  Use of too many
colours just makes things distracting.  Especially weaker
colours like light yellow are very hard to see on a white
background, at least to me.

Trying to differenciate "trunk" with "side branches" may be
sometimes useful in a small one-man project, but it quickly
breaks down once you start merging from all over the place,
since merges in distributed development do not have inherent
distinction between "trunk" and "side branches".

One thing it _could_ do is to assign different colours to edges
coming into a merge node, and match the colour of the edge that
leads to a parent to the colour in which the diff text from
that parent is shown.  Then the colouring becomes somewhat
meaningful.

Maybe gitk is already doing it, but it makes me suspect it
doesn't, to read the way the code initialises "$ctext tag conf
m$N" and uses the m$N tag for each diff output line, which is
done pretty much independently from the procedure that paint
edges (the one you touch in your patch).
