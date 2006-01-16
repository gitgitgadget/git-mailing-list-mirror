From: Junio C Hamano <junkio@cox.net>
Subject: Re: dangling commits
Date: Mon, 16 Jan 2006 01:27:12 -0800
Message-ID: <7vr778wmj3.fsf@assigned-by-dhcp.cox.net>
References: <7vslrp2nw0.fsf@assigned-by-dhcp.cox.net>
	<20060115221108.3ED2E352659@atlas.denx.de>
	<20060116085238.GA3768@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 10:28:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyQev-0003le-9Y
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 10:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWAPJ1U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 04:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWAPJ1T
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 04:27:19 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:64450 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932283AbWAPJ1O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2006 04:27:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060116092556.GJKV20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 16 Jan 2006 04:25:56 -0500
To: Marco Roeland <marco.roeland@xs4all.nl>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14733>

Marco Roeland <marco.roeland@xs4all.nl> writes:

> As far as I know although packs are used in transferring the commits to
> your local repository they are stored there as separate objects,...

That is true only when you are using git native protocols
(i.e. git:// and git over ssh).  Some people pull over dumb
transport (http -- some others still use rsync which is even
dumber and has serious limitations), and when you need objects
that are contained in a pack at the upstream, the packfile is
downloaded as a whole, and it is left packed on your end.

Even when you use git native protocol, the objects the initial
clone gives you are kept packed, so when I rewind and rebuild
"pu" to make some of these objects orphaned, they will stay in
the pack the initial clone gave you.  Unpack+repack is needed to
get rid of them.

As you said, they should not hurt much in practice, though.
