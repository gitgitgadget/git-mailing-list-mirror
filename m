From: Junio C Hamano <junkio@cox.net>
Subject: EAGAIN?
Date: Mon, 19 Dec 2005 02:07:27 -0800
Message-ID: <7vhd95h02o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org
X-From: git-owner@vger.kernel.org Mon Dec 19 11:10:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EoHvm-00023a-9I
	for gcvg-git@gmane.org; Mon, 19 Dec 2005 11:07:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932714AbVLSKH3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Dec 2005 05:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932715AbVLSKH3
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Dec 2005 05:07:29 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:44516 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932714AbVLSKH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2005 05:07:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051219100542.VRLN17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Dec 2005 05:05:42 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13820>

I am embarrassed to ask this in public, but anyway.

I was looking at "git grep -n EAGAIN" output and found that many
places check "errno == EAGAIN" without checking "errno ==
EINTR", both for read(2) and write(2).  I feel that EAGAIN is
probably not that useful (it probably would not hurt us, though)
because we do not set up nonblocking ourselves, but I am
wondering if there is particular reason to only check EAGAIN but
not EINTR, or if they are just cut and paste errors.

	apply.c:: read checks EAGAIN only, write checks both.
        cat-file.c: write checks EAGAIN only.
        copy.c:: read checks EAGAIN only, write checks both.
        mktag.c::  read checks EAGAIN only.
        pkt-line.c:: both read and write checks both.
	tar-tree.c:: write checks EAGAIN only.
        unpack-objects.c:: both read and write checks both.
