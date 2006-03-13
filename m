From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Possible --remove-empty bug
Date: Mon, 13 Mar 2006 11:03:32 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603131058270.3618@g5.osdl.org>
References: <e5bfff550603120612k555fc7f3v9d8d17b1bd0b9e41@mail.gmail.com>
 <7vk6azz6xx.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0603121450210.3618@g5.osdl.org>
 <7vlkvfw3px.fsf@assigned-by-dhcp.cox.net> <7v4q22ucio.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marco Costalba <mcostalba@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 13 20:07:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIsKU-0005Uu-Uf
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 20:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbWCMTDk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 14:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbWCMTDk
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 14:03:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55488 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751728AbWCMTDj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Mar 2006 14:03:39 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2DJ3YDZ019738
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 13 Mar 2006 11:03:34 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2DJ3W6N019948;
	Mon, 13 Mar 2006 11:03:33 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q22ucio.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17575>



On Sun, 12 Mar 2006, Junio C Hamano wrote:
> 
> It removes the grandparents from the parent, and leaves the
> parent still interesting.  As a result, in your example:
> 
>     ... if you have
> 
>                 a
>                / \
>               b   c
>                \ /
>                 d
> 
>     where the pathname disappeared in "b"...
> 
> we would get this world view:
> 
>                 a
>                / \
>               b   c
>                  /
>                 d

Yeah, that's correct. That way you still see all the history that is 
relevant to the tree that became empty.

However, to be honest, the only reason to ever use --remove-empty is for 
rename detection, and Frederik's approach of doing that through the 
library interface directly is actually a much superior option. So we might 
as well drop the compilcation of --remove-empty entirely, unless somebody 
has already started using it.

The _real_ optimization would be to make the pathname based pruning be 
done incrementally instead of having to build up the whole tree. That 
would be much more important than the --remove-empty stuff from a 
usability standpoint. I'm absolutely sure it's possible, and I simplified 
the code earlier so that it should be simpler to do, but every time I 
actually look at the code I get confused again.

		Linus
