From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Does git belong in root's $PATH?
Date: Sat, 7 Jan 2006 10:31:52 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601071023250.3169@g5.osdl.org>
References: <Pine.LNX.4.64.0601070838470.6317@x2.ybpnyarg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 07 19:32:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvIrE-0003Oj-0t
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 19:32:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578AbWAGSb6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 13:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752582AbWAGSb6
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 13:31:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31651 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752578AbWAGSb5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jan 2006 13:31:57 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k07IVrDZ024171
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 7 Jan 2006 10:31:54 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k07IVqlY019602;
	Sat, 7 Jan 2006 10:31:53 -0800
To: walt <wa1ter@myrealbox.com>, Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <Pine.LNX.4.64.0601070838470.6317@x2.ybpnyarg>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14268>



On Sat, 7 Jan 2006, walt wrote:
>
> When updated my kernel this morning, the same way I've been doing
> it for many months, I noticed that the -gxxxxxxx localversion
> string was missing from the new kernel's name.
> 
> I finally figured out that this happened because /usr/local/bin
> is not in my root's $PATH, and the setlocalversion script depends
> on git.  (The only thing I do as root is 'make install').

Ok, sounds like a build buglet to me. If you've done a "make" as a regular 
user, and just do a "make install" as root, I'd argue that the "make 
install" should do as little as humanly possible, and literally just 
install the kernel. If it starts changing the version, that sounds a bit 
fishy.

Sam, anything we can do?

That said:

> I suppose I'm asking a philosophical question here:  do you
> guys install git where root can find it (as a system tool)?

I don't, but I don't use "make install" anyway, I just do "make 
modules_install". I install the kernel by hand, I always have.

Of course, that's partly because I've always felt that "make install" does 
too much (I think "make modules_install" is better - it really only 
installs the already-built modules).

Maybe it would be best to remove the "vmlinux" dependency from "make 
install" (so that "make install" will do exactly that: just install).  I 
think all the documentation already tells you to do a "make" and then a 
"make install".

The other make targets really _are_ different: "make fdimage" depends on 
vmlinux, but that's because it literally just builds the image. "make 
install" is special.

Sam, what say you? I forget what the kbuild mailing list is, but maybe 
you can forward this suggestion there..

		Linus
