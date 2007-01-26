From: Junio C Hamano <junkio@cox.net>
Subject: Re: grafts+repack+prune = history at danger
Date: Fri, 26 Jan 2007 03:29:39 -0800
Message-ID: <7vodomxbz0.fsf@assigned-by-dhcp.cox.net>
References: <45B8E61E.C9C5E6C6@eudaptics.com>
	<7vireu7lj0.fsf@assigned-by-dhcp.cox.net>
	<45B9B80E.E2534F97@eudaptics.com>
	<7vr6ti183o.fsf@assigned-by-dhcp.cox.net>
	<45B9C836.728F31EC@eudaptics.com>
	<7vzm86yw0q.fsf@assigned-by-dhcp.cox.net>
	<45B9CE56.D16DFC81@eudaptics.com>
	<7vmz46ytyy.fsf@assigned-by-dhcp.cox.net>
	<45B9DAC8.C04C6D3F@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Fri Jan 26 12:29:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAPH9-0003mv-0T
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 12:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933187AbXAZL3l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 06:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933200AbXAZL3l
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 06:29:41 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:39864 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933187AbXAZL3k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 06:29:40 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070126112940.QQKV16632.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Fri, 26 Jan 2007 06:29:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id FnUi1W00D1kojtg0000000; Fri, 26 Jan 2007 06:28:43 -0500
In-Reply-To: <45B9DAC8.C04C6D3F@eudaptics.com> (Johannes Sixt's message of
	"Fri, 26 Jan 2007 11:41:12 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37841>

Johannes Sixt <J.Sixt@eudaptics.com> writes:

> - the grafts file is not part of the objects database

This is a very conscious design decision from an ancient times.
It used to be fashionable to share object store across different
repositories (you literally symlinked .git/objects), and grafts
are local in the sense that they are per-repository, and that is
the reason it lives in .git/info.  There is not much reason
either way and if I were doing this from scratch I would
probably place it in .git/objects/info next to alternates.

> - it is manipulated manually instead of by tools the check for errors

Yes, but that is only because nobody saw need for such a tool so
far.  In reality, grafts have been pretty much "install and
forget" thing.  You graft 2.6.12-rc2 on top of the bkcvs tip
once, and then do not think about it after doing so.

When somebody sees a need, you know what will happen ;-).

> - it is not transferred across clones/pulls/pushes (it's even possible
> to create an inconsistent clone)

Yes, as I already said that is where we punted and declared that
the grafts are local matter.

Even though your resulting clone is inconsistent, I do not even
have to say "tough".  You can just tell what the necessary graft
file should look like to the repository owner at the other end,
and the life will be peachy again.

I even outlined the issues you (or somebody else who may be
interested) would need to look into to make it more global.  Do
you need anything more?

> The way out that I see is to make grafts much, much less important.

Breaking what already works does not sound like a way out.  

For local-only, "install and forget" use, what the current setup
does is consistent and works reasonably well.  I would not say
it is perfect, but I do not know of any outstanding bugs (and
what you mentioned in these message are certainly not).
