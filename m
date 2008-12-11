From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Fwd: after first git clone of linux kernel repository there are
 changed files in working dir
Date: Thu, 11 Dec 2008 09:41:34 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812110934180.3340@localhost.localdomain>
References: <d304880b0812101019ufe85095h46ff0fe00d32bbd0@mail.gmail.com>  <d304880b0812101022u2abe5d68ub3bda68ed39f830b@mail.gmail.com>  <e32b7bb40812101220s370a64f1n3f7ecb56dd352405@mail.gmail.com>  <d304880b0812110142g41b80745ic09a7200e02dcdb0@mail.gmail.com>
 <d304880b0812110915o6968050cufbb1e29c8bcea984@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: rdkrsr <rdkrsr@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 18:43:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LApZ0-0002YZ-7W
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 18:43:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757303AbYLKRlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 12:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757697AbYLKRlj
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 12:41:39 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52807 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758050AbYLKRlh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Dec 2008 12:41:37 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBBHfZx1008754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 11 Dec 2008 09:41:36 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBBHfYXU012207;
	Thu, 11 Dec 2008 09:41:35 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <d304880b0812110915o6968050cufbb1e29c8bcea984@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.427 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102809>



On Thu, 11 Dec 2008, rdkrsr wrote:
>
> I'm sorry that I didn't answer to git mailing list address. So here
> comes the email again.

You have a broken filesystem.

> $ git status
> # On branch master
> # Changed but not updated:
> #   (use "git add <file>..." to update what will be committed)
> #
> #       modified:   Documentation/IO-mapping.txt
> #       modified:   include/linux/netfilter/xt_CONNMARK.h
> #       modified:   include/linux/netfilter/xt_DSCP.h
> #       modified:   include/linux/netfilter/xt_MARK.h
> #       modified:   include/linux/netfilter/xt_RATEEST.h
...

This is _exactly_ what happens if you try to develop the Linux kernel on a 
case-insensitive filesystem. The kernel source tree has several files that 
differ only in case, eg

	Documentation/IO-mapping.txt
	Documentation/io-mapping.txt
	include/linux/netfilter/xt_tcpmss.h
	include/linux/netfilter/xt_TCPMSS.h
	..

and if you try to check it out on a broken filesystem, then the second 
file will overwrite the first one, and git will think that you have 
modified it. 

OS X? Afaik, you can fix it by using NFS or UFS. And I think ZFS has a 
case-sensitive mode too (and it may even be the default). In fact, I think 
newer versions of OS X even allow that piece-of-sh*t HFS+ to be case 
sensitive (and thus make it much less sh*tty).

Of course, there are reports of some Mac software breaking when they use a 
real filesystem, but hey, what else is new?

			Linus
