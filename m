From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: rsync deprecated but promoted?
Date: Mon, 26 Sep 2005 10:55:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509261038460.3308@g5.osdl.org>
References: <20050925163201.GA29198@tumblerings.org> <4d4586301dca616f42880612fae01492@cream.org>
 <20050926133204.GB21019@pasky.or.cz> <Pine.LNX.4.58.0509260801430.3308@g5.osdl.org>
 <dh98gk$6rp$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 19:56:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJxCk-00071d-PL
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 19:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbVIZRzw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 13:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbVIZRzw
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 13:55:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31913 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932450AbVIZRzw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2005 13:55:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8QHtn4s001945
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 26 Sep 2005 10:55:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8QHtnYm005380;
	Mon, 26 Sep 2005 10:55:49 -0700
To: walt <wa1ter@myrealbox.com>
In-Reply-To: <dh98gk$6rp$1@sea.gmane.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9317>



On Mon, 26 Sep 2005, walt wrote:
> 
> Just because you mentioned it, I did a git-fsck-objects on my local
> copies of your kernel tree and Junio's git tree.
> 
>  From git I got this:
> $git-fsck-objects
> missing commit 00d8bbd3c4bba72a6dfd48c2c0c9cbaa000f13c2
> broken link from     tag 02b2acff8bafb6d73c6513469cdda0c6c18c4138
>                to  commit d5bc7eecbbb0b9f6122708bf5cd62f78ebdaafd8
> <similar lines snipped>
> 
>  From your tree I got only this single line:
> dangling commit 02459eaab98a6a57717bc0cacede148fc76af881

That commit shouldn't be dangling, but I suspect it is harmless and is
most likely because you have pack-files. Use "git-fsck-cache --full" if
you are downloading with http/rsync (since that gets packs without
unpacking them, and you haven't re-packed everything).

The git thing may be similar, although it sounds unlikely. A more likely
reason is that earlier http pulling got incomplete trees if you ever
interrupted it with ^C.

> Yet both trees compile and run perfectly.  Are these messages
> worrisome?  (BTW, git was cloned and updated using http.)

Yes, they can be worrisome. Some of it may be normal (I really suspect 
that the kernel tree is that kind - a "dangling commit" is almost always 
either because you've lost a tag or because of a pack-file that wasn't 
examined).

Your git tree is quote possibly corrupted.

The good news is that if "git checkout" works, then the corruption is all
old - you may not have all of the history, but the corruption is
"harmless".

There's nothing fundamentally wrong with not having all of history: it
will cause fsck to complain (unless you "plug" the history by using a
graft file). And obviously it means that you may not be able to go back in 
time - but you may never even care. 

A "git-http-fetch --recover HEAD <url>" _should_ fix it, but I don't think 
that works right now. It's documented, but it doesn't do anything. Junio?

			Linus
