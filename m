From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] git-fetch - repack in the background after fetching
Date: Sat, 24 Jun 2006 20:12:32 -0700
Message-ID: <7vy7vmormn.fsf@assigned-by-dhcp.cox.net>
References: <11511486003924-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 05:12:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuL36-0007EO-SJ
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 05:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWFYDMe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 23:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWFYDMe
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 23:12:34 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:60873 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751360AbWFYDMe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 23:12:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060625031233.CHJP12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Jun 2006 23:12:33 -0400
To: Martin Langhoff <martin@catalyst.net.nz>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22581>

Martin Langhoff <martin@catalyst.net.nz> writes:

> This is a follow up to a similar patch earlier
> http://www.gelato.unsw.edu.au/archives/git/0605/21401.html -- is there 
> interest in making GIT more friendly to users who don't know or care
> about packing and repacking their repos?

I would be a bit worried about the niced background repack
racing against another instance of itself spawned by the same
parent.

> I loathe to do this conditionally only on the count of unpacked
> objects. If there's a quick'n'dirty way of asking portably whether
> the machine is busy or otherwise resource-constrained (ie: on battery)
> it should use it to avoid running repack at inconvenient times.

count-objects might be lighter weight than rev-list --unpacked.

If you mean to make core.autorepack to be boolean, checking for
string 'no' is not the right way.

	git repo-config --bool --get core.autorepack

But it does not matter if that variable is a string that is
almost always true unless the value is "no".
