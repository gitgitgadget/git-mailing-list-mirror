From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: running git-update-cache --refresh on different machines on a
 NFS share always ends up in a lot of io/cpu/time waste
Date: Sun, 22 May 2005 12:09:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505221205580.2307@ppc970.osdl.org>
References: <20050522122849.GJ15178@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 22 21:07:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZvmR-0004j5-Gb
	for gcvg-git@gmane.org; Sun, 22 May 2005 21:06:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVEVTHr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 15:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVEVTHr
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 15:07:47 -0400
Received: from fire.osdl.org ([65.172.181.4]:17329 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261339AbVEVTHm (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 May 2005 15:07:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4MJ7ajA014342
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 22 May 2005 12:07:38 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4MJ7aPR024756;
	Sun, 22 May 2005 12:07:36 -0700
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050522122849.GJ15178@cip.informatik.uni-erlangen.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 22 May 2005, Thomas Glanzmann wrote:
>
> I wonder why 'git-update-cache --refresh' running in the same directory
> shared via NFS ends up in reindexing the whole files when running on
> different machines on a NFS share.

It does?

Can you check what 

	ls -li --time=atime

shows on the different clients? Also, try "ctime".

> Is there a reason for this or can it easily be fixes. I also wonder if
> the locking which is used to lock the cache is 'nfs safe'.

It _should_ be safe. It does the old lockfile thing, with a "link()" that
should guarantee atomicity. No fcntl locking or similar that can have
problems with networked filesystems and different UNIXes.

		Linus
