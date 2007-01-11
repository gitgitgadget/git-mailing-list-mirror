From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Speedup recursive by flushing index only once for all entries
Date: Thu, 11 Jan 2007 12:37:36 -0800
Message-ID: <7v8xg947vz.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0701040247k47e398e6q34dd5233bb5706f6@mail.gmail.com>
	<81b0412b0701040447u329dcf9bvcd7adb9e9d199f18@mail.gmail.com>
	<7v8xgileza.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0701050322u67131900xea969b2da9981a94@mail.gmail.com>
	<20070107163112.GA9336@steel.home>
	<7vr6u2adgx.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0701101507n764aed73p31c7533e743283f0@mail.gmail.com>
	<Pine.LNX.4.64.0701101521410.3594@woody.osdl.org>
	<Pine.LNX.4.63.0701110913140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<81b0412b0701110103p5f67b955gee6ff6194e6ea68d@mail.gmail.com>
	<81b0412b0701110411s7ccb45c1t9ececa9301760bae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 21:41:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H56jO-0002cZ-2l
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 21:41:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbXAKUk6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 15:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbXAKUk6
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 15:40:58 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:64499 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510AbXAKUk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 15:40:57 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070111204056.XYXR19398.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Thu, 11 Jan 2007 15:40:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9wd01W00B1kojtg0000000; Thu, 11 Jan 2007 15:37:00 -0500
To: "Alex Riesen" <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0701110411s7ccb45c1t9ececa9301760bae@mail.gmail.com>
	(Alex Riesen's message of "Thu, 11 Jan 2007 13:11:28 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36608>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> Well, tried it now. Strangely enough - there is almost no speedup with
> Junio's patch on top of mine.

Mine is primarily meant to be a conceptual clean-up.  While it
does save unnecessary write-tree at the end, and it also saves
unnecessary write-cache/read-cache for the recursive part when
you have more than one merge base, I would not be surprised if
the effect of tons of unnecessary write-index, once per path
involved in the merge, which was what your patch removed, would
drawf anything else.

Since single merge base cases dominate in practice, you might
see improvements from the avoidance of the final write-tree but
probably would not see much benefit of write-cache/read-cache
avoidance unless your merge has many merge bases.
