From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Added --mirror-all to git-fetch.
Date: Wed, 20 Sep 2006 14:36:26 -0700
Message-ID: <7vslimfcf9.fsf@assigned-by-dhcp.cox.net>
References: <20060919232851.GA12195@spearce.org>
	<7vac4ujzf0.fsf@assigned-by-dhcp.cox.net>
	<20060920161407.GQ8259@pasky.or.cz>
	<20060920162145.GA23260@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 23:36:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ9k7-0001Yg-Jo
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 23:36:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWITVg2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 17:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWITVg2
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 17:36:28 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:18409 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932140AbWITVg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 17:36:27 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060920213627.VHQA18985.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Wed, 20 Sep 2006 17:36:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id QlcC1V00q1kojtg0000000
	Wed, 20 Sep 2006 17:36:13 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060920162145.GA23260@spearce.org> (Shawn Pearce's message of
	"Wed, 20 Sep 2006 12:21:45 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27410>

Shawn Pearce <spearce@spearce.org> writes:

>> >      (the archive vs active repacking strategy we talked about,
>> 
>> Hmm, I think I've missed this, I must look that in the archive.
>
> Junio pushed the core code out but nobody has done the Porecelain
> for it.  The basic idea is to prevent repacking every pack all of
> the time; there's probably no reason to repack a 100 MiB pack file
> every time you repack your loose objects so you might want to keep
> say a <5 MiB "active pack" holding your recent created objects
> and repack that frequently and a larger 100+ MiB "history pack"
> holding everything else.  Maybe you repack everything on a longer
> time scale, such as once a year.

And IIRC we were stuck on the convention to tell which ones are
archives and which ones are actives (i.e. fair game for
repacking).  We were trying to figure out how to mark active
ones (whose name changes every time you repack).

I realized that there is a very simple and obvious solution for
it.  Introduce $GIT_OBJECT_DIRECTORY/info/archived-packs, a flat
text file that lists the names of the archive packs.  Any pack
not listed there are active one and are subject to repacking.
