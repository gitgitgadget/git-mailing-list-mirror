From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Make "git clone" less of a deathly quiet experience
Date: Sat, 11 Feb 2006 19:39:59 +0100
Message-ID: <20060211183959.GA9984@steel.home>
References: <Pine.LNX.4.64.0602102018250.3691@g5.osdl.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Feb 11 19:40:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7zfV-0000OX-St
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 19:40:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWBKSkR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 13:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbWBKSkR
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 13:40:17 -0500
Received: from devrace.com ([198.63.210.113]:2826 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S932346AbWBKSkQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2006 13:40:16 -0500
Received: from tigra.home (p54A05B96.dip.t-dialin.net [84.160.91.150])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k1BIe1lE055947;
	Sat, 11 Feb 2006 12:40:02 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1F7zf6-0003yZ-00; Sat, 11 Feb 2006 19:40:00 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1F7zf5-0002cl-PE; Sat, 11 Feb 2006 19:39:59 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602102018250.3691@g5.osdl.org>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=0.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL 
	autolearn=no version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15955>

Linus Torvalds, Sat, Feb 11, 2006 05:31:09 +0100:
> So with this patch, I get something like this on my DSL line:
> 
> 	[torvalds@g5 ~]$ time git clone master.kernel.org:/pub/scm/linux/kernel/git/torvalds/linux-2.6 clone-test
> 	Packing 188543 objects
> 	  48.398MB  (154 kB/s)

I get this:

    $ git clone . ../cloned
    Packing 15440 objects
    $ 2 kB/s)

I'd put a \n before finish_pack to make it nicer.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

diff --git a/fetch-clone.c b/fetch-clone.c
index b67d976..37141e9 100644
--- a/fetch-clone.c
+++ b/fetch-clone.c
@@ -193,5 +193,7 @@ int receive_keep_pack(int fd[2], const c
 		}
 	}
 	close(ofd);
+	if ( !quiet )
+	    fputc('\n', stderr);
 	return finish_pack(tmpfile, me);
 }
