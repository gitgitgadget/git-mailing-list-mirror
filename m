From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Added hook in git-receive-pack
Date: Mon, 01 Aug 2005 01:14:13 -0700
Message-ID: <7vzms2xeei.fsf@assigned-by-dhcp.cox.net>
References: <200507312117.43957.Josef.Weidendorfer@gmx.de>
	<7v3bpuenpi.fsf@assigned-by-dhcp.cox.net>
	<200508010117.41848.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 01 10:16:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzVSm-0007DY-4n
	for gcvg-git@gmane.org; Mon, 01 Aug 2005 10:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263220AbVHAIPf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Aug 2005 04:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263233AbVHAIPd
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Aug 2005 04:15:33 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:52379 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S263220AbVHAIOP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2005 04:14:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050801081413.FXIJ19627.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 1 Aug 2005 04:14:13 -0400
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200508010117.41848.Josef.Weidendorfer@gmx.de> (Josef Weidendorfer's message of "Mon, 1 Aug 2005 01:17:41 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Josef, I've committed a version that has slightly different
semantics from what you originally posted.

The differences are:

 - Instead of being post-change hook, the script is run just
   before each ref is updated.  The script can exit with
   non-zero status to tell receive-pack not to update that ref
   if it wants to.  This means that you should explicitly exit
   with zero status if all you want to do in the hook is to send
   a mail out.

 - The script is called once at the very end with a single
   parameter "" (i.e. $refname == ""), to signal that
   receive-pack is about to finish.  This is a good place to add
   any "final cleanup" hook.

The latter change allowed me to remove the mandatory
update_server_info call Linus did not like and make it
optional.

-jc
