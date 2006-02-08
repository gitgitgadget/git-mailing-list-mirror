From: Pavel Roskin <proski@gnu.org>
Subject: Re: gitk changing line color for no reason after merge
Date: Tue, 07 Feb 2006 19:54:07 -0500
Message-ID: <1139360047.13646.22.camel@dv>
References: <1138900897.28967.18.camel@dv> <1139289517.15955.23.camel@dv>
	 <7vlkwnxz5t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 08 01:54:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6dbA-00017A-Kw
	for gcvg-git@gmane.org; Wed, 08 Feb 2006 01:54:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030325AbWBHAyR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 19:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbWBHAyR
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 19:54:17 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:34991 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1030325AbWBHAyQ
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Feb 2006 19:54:16 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1F6db3-0008Qm-6l
	for git@vger.kernel.org; Tue, 07 Feb 2006 19:54:13 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1F6dax-0006vh-AR; Tue, 07 Feb 2006 19:54:07 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlkwnxz5t.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.5.90 (2.5.90-1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15726>

On Tue, 2006-02-07 at 02:04 -0800, Junio C Hamano wrote:
> Pavel Roskin <proski@gnu.org> writes:
> 
> > I still stand behind this patch because it eliminates color changes on
> > the nodes that have exactly one child and parent.  $nparents($id) is
> > irrelevant here, because it characterizes the current node, but the code
> > decides whether the line should change color at the child node.
> 
> It all depends on what you are trying to achieve with colours.

I'm trying to make it easier to follow a line.  It's easier if its color
is not changing, especially on trivial nodes (one parent, one child).

> Being a bit colour-challenged, I am not in a good position to
> comment on how much gitk's use of different colours is helping
> the readability, but I suspect not very much.  Use of too many
> colours just makes things distracting.  Especially weaker
> colours like light yellow are very hard to see on a white
> background, at least to me.

My point is not to use to many colors.  There is one case when gitk
changes line color for no reason, and that case should be fixed.  Since
the colors rotate as gitk picks them, extra color switch means that the
colors repeat more often.

By the way, there are some nice colors to add (lightblue darkcyan pink),
but let's use effectively what we've got.

> Trying to differenciate "trunk" with "side branches" may be
> sometimes useful in a small one-man project, but it quickly
> breaks down once you start merging from all over the place,
> since merges in distributed development do not have inherent
> distinction between "trunk" and "side branches".

It's not my point.  My point is to make it easier to follow the lines,
without making any assumptions about "real" branches.

> One thing it _could_ do is to assign different colours to edges
> coming into a merge node, and match the colour of the edge that
> leads to a parent to the colour in which the diff text from
> that parent is shown.  Then the colouring becomes somewhat
> meaningful.

Yes, that would be great.

> Maybe gitk is already doing it, but it makes me suspect it
> doesn't, to read the way the code initialises "$ctext tag conf
> m$N" and uses the m$N tag for each diff output line, which is
> done pretty much independently from the procedure that paint
> edges (the one you touch in your patch).

Correct.

To illustrate my point, I put some examples online:

http://red-bean.com/proski/gitk/gitk-before.png - what gitk is showing
now.  There are color changes on trivial nodes both below and above
merges.

http://red-bean.com/proski/gitk/gitk-after.png - with my patch.  Color
changes on trivial nodes only happen below merges.

http://red-bean.com/proski/gitk/gitk-ideal.png - made in GIMP.  Trivial
nodes never change line color, because it changes as soon as the line
forks.

-- 
Regards,
Pavel Roskin
