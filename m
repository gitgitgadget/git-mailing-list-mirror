From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "git-send-pack"
Date: Thu, 30 Jun 2005 14:08:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506301357280.14331@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506301025510.14331@ppc970.osdl.org>
 <Pine.LNX.4.58.0506301242470.14331@ppc970.osdl.org> <7vll4r1sxz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 23:01:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do69N-0008Ah-Fg
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 23:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263111AbVF3VHF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 17:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263105AbVF3VHA
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 17:07:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62393 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263077AbVF3VGS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2005 17:06:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5UL63jA026305
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 30 Jun 2005 14:06:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5UL62UP000373;
	Thu, 30 Jun 2005 14:06:03 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vll4r1sxz.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 30 Jun 2005, Junio C Hamano wrote:
> 
> Now is there anything for us poor mortals who would want to have
> a "pull" support?  Logging in via ssh and run send-pack on the
> other end is workable but not so pretty ;-).

I'm thinking about it. You can't actually do send-pack from the other end,
since send-pack needs to know what the base is, and the base you have may
not even exist in the remote.

So a "git-pull-pack" will follow the objects on the other side until it 
hits one we have, and _then_ it can send a nice pack. It's not hard per 
se, and some of the problems are actually simpler than git-send-pack, but 
it needs more communication (and in order to be efficient you want to not 
ping-pong a "do-you-have-it" query every time around).

I also want to make sure that the biggest burden is on the pull side, not 
the push side. I have a plan, though.

		Linus
