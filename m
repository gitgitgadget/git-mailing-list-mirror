From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: checkout-cache -f: a better way?
Date: Fri, 20 May 2005 16:33:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505201626560.2206@ppc970.osdl.org>
References: <428E5102.60003@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 21 01:31:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZGxM-0004Ky-7I
	for gcvg-git@gmane.org; Sat, 21 May 2005 01:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbVETXb3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 19:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVETXbY
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 19:31:24 -0400
Received: from fire.osdl.org ([65.172.181.4]:58322 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261467AbVETXbM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 19:31:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4KNV9jA003366
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 May 2005 16:31:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4KNV8ad008621;
	Fri, 20 May 2005 16:31:08 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <428E5102.60003@pobox.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 20 May 2005, Jeff Garzik wrote:
> 
> Problem is, 'git-checkout-cache -q -f -a' really pounds the disk, and 
> takes quite a while.

No. "git" is perfect, and "git-checkout-cache -f" already does exactly 
what you want.

> Is there any way to avoid -f, while ensuring that the working directory 
> truly represents the new branch?

You don't need to avoid -f, it already has the logic to avoid writing 
files that are already up-to-date.

HOWEVER, your script is broken:

	git-read-tree $(cat .git/HEAD) && \
	        git-checkout-cache -q -f -a && \
	        git-update-cache --refresh

you need to use the "-m" switch to git-read-tree to tell it to merge the 
index information from your previous tree with the new one.

Also, don't do the "$(cat .git/HEAD)" thing any more, since modern git 
does this so much more nicely, and allows you to use your branch names 
directly.

Finally, use the new "-u" flag to git-checkout-cache, which will update 
the cache as it goes along. 

In other words, those lines in your script should look like this:

	git-read-tree -m HEAD && git-checkout-cache -q -f -u -a

and you'll be a lot happier.

			Linus
