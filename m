From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] Diff overhaul, adding the other half...
Date: Sat, 21 May 2005 13:10:26 -0700
Message-ID: <7vk6lsgx1p.fsf@assigned-by-dhcp.cox.net>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org>
	<7vzmuokjhg.fsf@assigned-by-dhcp.cox.net>
	<7vfywgkj90.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505211016140.2206@ppc970.osdl.org>
	<7vzmuoh2ma.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505211124440.2206@ppc970.osdl.org>
	<Pine.LNX.4.58.0505211128570.2206@ppc970.osdl.org>
	<Pine.LNX.4.58.0505211137250.2206@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 22:10:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZaI2-0004Xu-HM
	for gcvg-git@gmane.org; Sat, 21 May 2005 22:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVEUUKd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 16:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVEUUKd
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 16:10:33 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:61356 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261467AbVEUUK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 16:10:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050521201027.SMWQ26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 May 2005 16:10:27 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505211137250.2206@ppc970.osdl.org> (Linus
 Torvalds's message of "Sat, 21 May 2005 11:45:30 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Hmm.. It's not working well. Not only does it take a lot of
LT> CPU time...

LT> 	torvalds@ppc970:~/v2.6/linux> wc -c drivers/media/dvb/bt8xx/dst_ca.h drivers/usb/misc/emi62_fw_m.h
LT> 	  1591 drivers/media/dvb/bt8xx/dst_ca.h
LT> 	795679 drivers/usb/misc/emi62_fw_m.h
LT> 	797270 total

Yup.  diffcore-rename bases the similarity index on the average
of src and dst files.  Maybe the similarity check should also
say they should be comparable size, like this upfront before
even going into delta:

    abs(src-dst) < avg(src,dst) * (1 - minscore/maxscore)

