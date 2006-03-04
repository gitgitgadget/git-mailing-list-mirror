From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: On recording renames
Date: Sat, 4 Mar 2006 09:36:09 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603040929540.22647@g5.osdl.org>
References: <7vfylyx3e3.fsf@assigned-by-dhcp.cox.net> <7v64muvin9.fsf@assigned-by-dhcp.cox.net>
 <7v8xrqqrdd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, paul@hibernia.jakma.org
X-From: git-owner@vger.kernel.org Sat Mar 04 18:39:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFaj2-0008Js-Qq
	for gcvg-git@gmane.org; Sat, 04 Mar 2006 18:39:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWCDRj0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Mar 2006 12:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWCDRj0
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Mar 2006 12:39:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7068 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932213AbWCDRjZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Mar 2006 12:39:25 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k24HaADZ022832
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 4 Mar 2006 09:36:10 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k24Ha9fJ026997;
	Sat, 4 Mar 2006 09:36:09 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xrqqrdd.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17190>



On Sat, 4 Mar 2006, Junio C Hamano wrote:
> 
> An ideal merge strategy would handle the case where pieces of
> code gradually moves around across file boundaries.  I do not
> think this is something you can sensibly do by recording file
> rename history.  It would not help the situation a bit even if
> you gave each file (or content or object or whatever you want to
> call it) a persistent ID.

Actually, we have an absolutely perfect example of this much closer to 
home.

I originally did the "rev-list split" series on an older version of git, 
before you did the --objects-edge and the full pathname hashing 
improvements. But when I was done, you'd merged that, and I needed to 
merge my rev-list.c split with your improvements in order to send it to 
you.

Now, the whold file hadn't actually been renamed, but about 50% of that 
file had been split into a new one. So effectively you had a merge where 
part of the new stuff had to be merged into another file.

Now, I think this is actually more common than renames in many ways. It's 
not a "complete" rename, but as far as _part_ of your changes were
concerned, it was one.

And yes, such a split can be something that is done in stages, again 
exactly the same way about 85% of rev-list.c was moved into revision.c in 
two stages: the first stage was the argument parsing and setup, and the 
second stage was the actual revision walking logic.

		Linus
