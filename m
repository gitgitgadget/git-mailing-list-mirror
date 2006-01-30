From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Set errno to EEXIST if mkdir returns EACCES or EPERM
Date: Tue, 31 Jan 2006 00:16:22 +0100
Message-ID: <20060130231622.GB3857@limbo.home>
References: <20060130193839.GA6575@steel.home> <7vvew14frk.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 22:00:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F42b9-0003UV-9O
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 21:59:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbWAaU7c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 15:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWAaU7c
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 15:59:32 -0500
Received: from devrace.com ([198.63.210.113]:35341 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1751480AbWAaU7b (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 15:59:31 -0500
Received: from tigra.home (p54A07FD9.dip.t-dialin.net [84.160.127.217])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k0VKxKO6078016;
	Tue, 31 Jan 2006 14:59:21 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from [192.168.1.24] (helo=limbo.home ident=200)
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1F42ap-0003vh-00; Tue, 31 Jan 2006 21:59:15 +0100
Received: by limbo.home (Postfix, from userid 1000)
	id DD3B2EC418; Tue, 31 Jan 2006 00:16:22 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vvew14frk.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.1i
X-Spam-Status: No, score=1.3 required=4.5 tests=AWL,DATE_IN_PAST_12_24,
	RCVD_IN_NJABL_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15344>

Junio C Hamano, Mon, Jan 30, 2006 21:33:51 +0100:
> and have current callers of mkdir() use it, regardless of the
> platform.  It may not worth saving mkdir_errno, though.

errno may be worth saving. I find the process of finding
"why-the-f$%^-did-the-windows-broke-again" really tedious:
1. find the application which failed (grep for the die message)
2. put "%s", strerror(errno) in the die
3. retest
4. find out errno is 0 (success)
5. remove close(fd), munmap, whatever before the die
6. retest
7. repeat

> Then everybody but entry.c one would say force=0, and entry.c
> one passes force appropriately using the condition it uses in
> its current if() statement.

I like it :)
