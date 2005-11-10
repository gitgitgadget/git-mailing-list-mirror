From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/4] Add git-pack-intersect
Date: Wed, 09 Nov 2005 16:15:17 -0800
Message-ID: <7vy83x73ze.fsf@assigned-by-dhcp.cox.net>
References: <43714EFB.5070705@etek.chalmers.se>
	<20051109111917.GB30496@pasky.or.cz> <4371E472.4030902@op5.se>
	<43728523.1040209@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp-2
X-From: git-owner@vger.kernel.org Thu Nov 10 01:16:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ea066-0001C8-Vo
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 01:15:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbVKJAPU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 19:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbVKJAPU
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 19:15:20 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:42200 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751096AbVKJAPS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2005 19:15:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051110001413.OVXW24014.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 9 Nov 2005 19:14:13 -0500
To: git@vger.kernel.org
In-Reply-To: <43728523.1040209@etek.chalmers.se> (Lukas
 =?iso-2022-jp-2?B?U2FuZHN0chsuQRtOdm0ncw==?= message
	of "Thu, 10 Nov 2005 00:24:19 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11452>

Lukas Sandstr.ANvm <lukass@etek.chalmers.se> writes:

> Perhaps if git-daemon ever does caching of packfiles, removing the smaller
> packfiles might not be optimal.

Ah, that reminds me of something.

I did not advertise it too much, but you can put a prepackaged
packs in $GIT_DIR/pack-cache/ and it is used when upload-pack
notices it is creating that exact pack.

This is useless for ordinary repository, but can be useful for
historical repositories whose heads/tags never change (e.g. the
Linux kernel repository resurrected from bkcvs).  There you
could:

	$ git repack -a -d
	$ ln $GIT_DIR/objects/pack/pack-* $GIT_DIR/pack-cache/.

and a clone request would feed the pack, without regenerating
the pack data from scratch.  upload-pack still reads, sorts and
computes SHA1 hash of the list of objects to find the pack name,
but that is a fairly quick operation, compared to the rest of
the pack generation process.
