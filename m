From: Junio C Hamano <junkio@cox.net>
Subject: Re: Patch (apply) vs. Pull
Date: Mon, 20 Jun 2005 10:22:58 -0700
Message-ID: <7vbr61j631.fsf@assigned-by-dhcp.cox.net>
References: <1119284365.3926.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 20 19:17:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkPtd-0003se-Dr
	for gcvg-git@gmane.org; Mon, 20 Jun 2005 19:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVFTRXI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Jun 2005 13:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVFTRXI
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jun 2005 13:23:08 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:40941 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261386AbVFTRXB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2005 13:23:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050620172300.UPCM550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 20 Jun 2005 13:23:00 -0400
To: Darrin Thompson <darrint@progeny.com>
In-Reply-To: <1119284365.3926.15.camel@localhost.localdomain> (Darrin
 Thompson's message of "Mon, 20 Jun 2005 11:19:25 -0500")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DT" == Darrin Thompson <darrint@progeny.com> writes:

DT> How exactly are these patches being generated? Is there a right-way(tm)
DT> which causes the recipient's a later pullers' histories to be
DT> intelligently handled in the future?

Those patches are, as far as GIT is concerned, out of band
communications.  You could still merge the result if the patch
was picked up by more than one tree independently, but the
behaviour is a bit less than ideal.  Usually the merge ends up
to be still manageable.

FYI, here is what I have been doing:

 (1) Start from Linus HEAD.

 (2) Repeat develop-and-commit cycle.

 (3) Run "git format-patch" (not in Linus tree) to generate
     patches.

 (4) Send them out and wait to see which one sticks.

 (5) Pull from Linus.

 (6) Throw away my HEAD, making Linus HEAD my HEAD, while
     preserving changes I have made since I forked from him.  I
     use "jit-rewind" for this.

 (7) Examine patches that Linus rejected, and apply ones that I
     still consider good, making one commit per patch.  I use
     "jit-patch" and "jit-commit -m" for this.

 (8) Go back to step 2.

