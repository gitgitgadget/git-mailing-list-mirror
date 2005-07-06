From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-pull-script hates me
Date: Wed, 6 Jul 2005 13:37:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507061335100.4159@g5.osdl.org>
References: <20050706203139.GA19198@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 06 22:54:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqGtu-0001zH-1E
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 22:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262292AbVGFUtC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 16:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262516AbVGFUkj
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 16:40:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39874 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262523AbVGFUiA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2005 16:38:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j66KbujA029314
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 6 Jul 2005 13:37:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j66Kbtbx021820;
	Wed, 6 Jul 2005 13:37:55 -0700
To: Greg KH <greg@kroah.com>
In-Reply-To: <20050706203139.GA19198@kroah.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 6 Jul 2005, Greg KH wrote:
>
> I just updated to the latest git tree, and now get the following when I
> try to pull from a ssh repo:
> 
>  $ git-pull-script gregkh@someserver.org:/public_html/udev.git/
>  fatal: I don't like '@'. Sue me.
> 
> So I drop the @ and then get:
>  $ git-pull-script someserver.org:/public_html/udev.git/
>  fatal: I don't like '_'. Sue me.

Heh. It really is personal.

The new git-pack handling tries to avoid special characters, because it 
passes some things off to a shell (ie it opens up an ssh connection.

But yeah, it's being a bit too anal. Just look at connect.c: shell_safe(),
and add both '_' and '@' to the safe list (and any other safe characters),
and off you go.

And if somebody wants to add code to do proper escaping of the non-safe 
ones, we can do that too. I was just lazy and added the characters I ever 
use ;)

		Linus
