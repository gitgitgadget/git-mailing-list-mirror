From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-diff-tree -M performance regression in 'next'
Date: Sun, 12 Mar 2006 17:22:20 -0800
Message-ID: <7vhd63w33n.fsf@assigned-by-dhcp.cox.net>
References: <20060311172818.GB32609@c165.ib.student.liu.se>
	<7voe0bdeyr.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603120858230.3618@g5.osdl.org>
	<7vk6azcv9y.fsf@assigned-by-dhcp.cox.net>
	<7vwtezw4ye.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603121700410.3618@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 13 02:22:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIblS-0004e0-0f
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 02:22:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWCMBWX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Mar 2006 20:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751789AbWCMBWX
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Mar 2006 20:22:23 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:50612 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751421AbWCMBWW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Mar 2006 20:22:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060313012227.QTSX25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 12 Mar 2006 20:22:27 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603121700410.3618@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 12 Mar 2006 17:09:47 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17533>

Linus Torvalds <torvalds@osdl.org> writes:

> Umm. Why do you rehash at all?
>
> Just take the size of the "src" file as the initial hash size. 

The code uses close to 16-bit hash and I had 65k flat array as a
hashtable.  That one was what you commented as "4-times as many
page misses".

Interestingly enough, that kind of flat array representation
seems to be too sparse and gives very bad performance behaviour.

The improvement I mentioned in the message you are replying to
is the result of making it into smaller (starting at (1<<9) or
something like that) linear-overflowing hash.

The latter suggestion I need to think about it a bit more.
