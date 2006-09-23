From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Remove branch by putting a null sha1 into the ref file.
Date: Sat, 23 Sep 2006 01:04:45 -0700
Message-ID: <7vu02zuhya.fsf@assigned-by-dhcp.cox.net>
References: <20060918065429.6f4de06e.chriscool@tuxfamily.org>
	<Pine.LNX.4.64.0609180926590.4388@g5.osdl.org>
	<7v3baj365g.fsf@assigned-by-dhcp.cox.net>
	<200609230645.37773.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 10:04:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GR2VN-0005k1-I5
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 10:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWIWIEr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 04:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWIWIEr
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 04:04:47 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:34457 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751025AbWIWIEq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Sep 2006 04:04:46 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060923080445.TGZZ2704.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Sat, 23 Sep 2006 04:04:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Rk4n1V00D1kojtg0000000
	Sat, 23 Sep 2006 04:04:47 -0400
To: Christian Couder <chriscool@tuxfamily.org>
In-Reply-To: <200609230645.37773.chriscool@tuxfamily.org> (Christian Couder's
	message of "Sat, 23 Sep 2006 06:45:36 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27568>

Christian Couder <chriscool@tuxfamily.org> writes:

> If we move ".git/refs/heads/frotz/nitfol" 
> to ".git/deleted-refs/heads/frotz/nitfol" when we remove this ref, we only 
> need to try to rmdir all subdirectories under ".git/refs/heads/frotz/" and 
> then ".git/refs/heads/frotz/" to see if we can 
> create ".git/refs/heads/frotz", and if we can, we won't 
> resurect "frotz/nitfol" because ".git/deleted-refs/heads/frotz/nitfol" 
> still exists.

I am not sure if that would be workable.  I suspect that you
would need to do quite an involved sequence in "git branch" to
make this sequence to work with .git/deleted-refs/ scheme:

	git branch frotz/nitfol
        git pack-refs --prune
        git branch -d frotz/nitfol
        git branch frotz
        git pack-refs
        git branch -d frotz

After deleting frotz/nitfol you would create frotz/nitfol in
deleted hierarchy.  Then when you delete frotz you would need to
create frotz in deleted hierarchy, but you cannot, without
losing frotz/nitfol.
