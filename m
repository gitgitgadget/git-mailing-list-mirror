From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-daemon: --inetd implies --syslog
Date: Mon, 14 Nov 2005 14:01:55 -0800
Message-ID: <7vfypyx50s.fsf@assigned-by-dhcp.cox.net>
References: <20051114164101.58A495BF92@nox.op5.se>
	<7vlkzrx84p.fsf@assigned-by-dhcp.cox.net> <4379006E.8020607@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 23:06:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbmOy-00073T-Db
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 23:02:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbVKNWB6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 17:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbVKNWB6
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 17:01:58 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:62620 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751274AbVKNWB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 17:01:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051114220132.VFEO15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 14 Nov 2005 17:01:32 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <4379006E.8020607@op5.se> (Andreas Ericsson's message of "Mon, 14
	Nov 2005 22:23:58 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11853>

Andreas Ericsson <ae@op5.se> writes:

> That shouldn't be a problem because;
> 1) handle() dupes the connected socket to stdin and stdout, but not stderr.

I am afraid that

$ git whatchanged -s -S'FIXME' daemon.c

tells me otherwise.  Whatever we do in handle() is too late to matter.

diff-tree 7c3693f1f240e17772c864fad35bc16226038fc8 (from 6a2e50f9dfdca7ac572bbe30dd0efdf19ca250f6)
Author: lars.doelle@on-line.de <lars.doelle@on-line.de>
Date:   Thu Sep 8 03:50:01 2005 +0200

    [PATCH] git-daemon --inetd
    
    git-daemon using inetd. does not work properly. inetd routes stderr onto the
    network line just like stdout, which was apparently not expected to be so.
    
    As the result of this, the stream is closed by the receiver, because some
    "Packing %d objects\n" originating from pack_objects is first reported over
    the line instead of the expected pack_header, and so the SIGNATURE test
    fails.  Here is a workaround.
    
    Signed-off-by: Junio C Hamano <junkio@cox.net>
