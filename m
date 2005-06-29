From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] denser delta header encoding
Date: Tue, 28 Jun 2005 21:58:56 -0700
Message-ID: <7vmzp9kbcf.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0506290021050.1667@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 29 06:52:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnUYC-00018M-24
	for gcvg-git@gmane.org; Wed, 29 Jun 2005 06:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbVF2E7B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 00:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbVF2E7B
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 00:59:01 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:13782 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S262286AbVF2E66 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2005 00:58:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050629045857.GILE17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 29 Jun 2005 00:58:57 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.63.0506290021050.1667@localhost.localdomain> (Nicolas Pitre's message of "Wed, 29 Jun 2005 00:27:45 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus, please do not apply this as is.

There are code other than what Nico updated with this patch in
sha1_file.c that also need updating, that count the number of
bytes in the delta-patch result by reading from the delta
header.

I wonder if we can have a helper function in delta suite
somewhere (maybe in diff-delta.c):

    int look_at_delta_header(void **delta_data, ulong delta_size,
    	                     ulong *src_size, ulong *dst_size)

that:

    - checks delta size and barf if it is small;
    - reads the header and fills src_size and dst_size;
    - advances *delta_data pointer;

and have count-delta, patch-delta and sha1_file.c users use it
consistently.  Nico, what do you think?
