From: Junio C Hamano <junkio@cox.net>
Subject: Re: auto-packing on kernel.org? please?
Date: Mon, 21 Nov 2005 11:58:35 -0800
Message-ID: <7v3blprcwk.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0510131113490.15297@g5.osdl.org>
	<20051121190151.GA2568@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.64.0511211110480.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 21:01:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeHoO-0007zX-Pm
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 20:58:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbVKUT6i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 14:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbVKUT6i
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 14:58:38 -0500
Received: from fed1rmmtai08.cox.net ([68.230.241.51]:6788 "EHLO
	fed1rmmtai08.cox.net") by vger.kernel.org with ESMTP
	id S1750755AbVKUT6h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 14:58:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051121195731.JHAR26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 21 Nov 2005 14:57:31 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511211110480.13959@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 21 Nov 2005 11:24:11 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12475>

Linus Torvalds <torvalds@osdl.org> writes:

> Can anybody tell me how to do that sanely? Right now we do
>
> 	..
> 	name=$(git-rev-list --objects $rev_list $(git-rev-parse $rev_parse) |
> 	        git-pack-objects --non-empty $pack_objects .tmp-pack) ||
> 	        exit 1
> 	..
>
> and the thing is, the "git-pack-objects" thing is happy, it's the 
> "git-rev-list" that fails. So because the last command in the pipeline 
> returns ok, we think it all is ok..

One cop-out: do fsck-objects upfront before making a pack.  This
would populate your buffer cache so it might not be a bad thing.

Alternatively:

        name=$( {
                git-rev-list --objects $rev_list $(git-rev-parse $rev_parse) ||
                echo Gaaahhh
        } | git-pack-objects --non-empty $pack_objects .tmp-pack)
