From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-fetch per-repository speed issues
Date: Mon, 03 Jul 2006 23:21:12 -0700
Message-ID: <7vsllhnb53.fsf@assigned-by-dhcp.cox.net>
References: <1151949764.4723.51.camel@neko.keithp.com>
	<Pine.LNX.4.64.0607031603290.12404@g5.osdl.org>
	<1151973438.4723.70.camel@neko.keithp.com>
	<Pine.LNX.4.64.0607032008590.12404@g5.osdl.org>
	<1151985747.4723.102.camel@neko.keithp.com>
	<Pine.LNX.4.64.0607032115340.12404@g5.osdl.org>
	<1151989503.4723.126.camel@neko.keithp.com>
	<Pine.LNX.4.64.0607032213030.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 08:21:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxeHi-0001Tm-7h
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 08:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWGDGVP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 02:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWGDGVP
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 02:21:15 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:16571 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751220AbWGDGVO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 02:21:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060704062113.QOGC22974.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 4 Jul 2006 02:21:13 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607032213030.12404@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 3 Jul 2006 22:36:15 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23255>

Linus Torvalds <torvalds@osdl.org> writes:

> Looking closer, I suspect a big part of it is that
>
> 	git-ls-remote $upload_pack --tags "$remote" |
> 	sed -ne 's|^\([0-9a-f]*\)[      ]\(refs/tags/.*\)^{}$|\1 \2|p' |
> 	while read sha1 name
> 	do
> 		..
> 	done
>
> loop.

Yes indeed.  Maybe we can do this loop in Perl.  Doing the whole
thing in C is another option but it would be somewhat painful,
unless we can deprecate all transport but git native protocols.

On the other hand, 5 seconds may not matter that much in practice.
