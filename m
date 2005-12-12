From: Junio C Hamano <junkio@cox.net>
Subject: Delitifier broken (Re: diff-core segfault)
Date: Mon, 12 Dec 2005 10:59:24 -0800
Message-ID: <7virtui1kj.fsf_-_@assigned-by-dhcp.cox.net>
References: <1134404990.5928.4.camel@localhost.localdomain>
	<7vmzj6i206.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Dec 12 20:02:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElstV-00074t-BJ
	for gcvg-git@gmane.org; Mon, 12 Dec 2005 19:59:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbVLLS70 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 13:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbVLLS70
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 13:59:26 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:22989 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932120AbVLLS70 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2005 13:59:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051212185831.OPQD20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 12 Dec 2005 13:58:31 -0500
To: Darrin Thompson <darrint@progeny.com>
In-Reply-To: <7vmzj6i206.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 12 Dec 2005 10:50:01 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13534>

Junio C Hamano <junkio@cox.net> writes:

> Darrin Thompson <darrint@progeny.com> writes:
>
>> Could someone confirm that this exists on more recent git heads and fix
>> if needed?
>
> (1) Yup.  I can reproduce it.
> (2) Will look into it when able.

This is not just "diff".  Our deltify code is half-broken, and
in the worst case this can corrupt our packs if an empty blob is
involved.

The problem is if from_size or to_size is empty, it does not
produce any.

        if (!from_size || !to_size || delta_prepare(from_buf, from_size, &bdf))
                return NULL;
	

I think either we need to make the users more careful or fix
deltifier to produce trivial delta.  I'd vote for the latter;
let me rig up something.
