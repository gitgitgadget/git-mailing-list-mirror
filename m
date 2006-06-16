From: Junio C Hamano <junkio@cox.net>
Subject: Re: Security problem
Date: Thu, 15 Jun 2006 17:12:53 -0700
Message-ID: <7vbqsuc60q.fsf@assigned-by-dhcp.cox.net>
References: <200606151709.22752.lan@academsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 16 02:13:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fr1xS-0004WP-5g
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 02:13:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWFPAMz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 20:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWFPAMz
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 20:12:55 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:45448 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750779AbWFPAMy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jun 2006 20:12:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060616001254.XARB554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 15 Jun 2006 20:12:54 -0400
To: Alexander Litvinov <lan@academsoft.ru>
In-Reply-To: <200606151709.22752.lan@academsoft.ru> (Alexander Litvinov's
	message of "Thu, 15 Jun 2006 17:09:22 +0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21923>

Alexander Litvinov <lan@academsoft.ru> writes:

> Why does not git-checkout check if file content match name of the object ?

Good point.  We could do a few things:

 - entry.c:write_entry() could validate after read_sha1_file(). 

 - read_sha1_file() could do the checking; this has performance
   implications, though.

Cloning over git aware protocols validate the objects coming
over the wire, so it may make sense to cheat and do the former,
so that we do not have to pay the validation cost every time we
access any object.
