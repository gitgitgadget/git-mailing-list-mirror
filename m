From: linux@horizon.com
Subject: Re: [Census] So who uses git?
Date: 1 Feb 2006 02:08:47 -0500
Message-ID: <20060201070847.2021.qmail@science.horizon.com>
Cc: git@vger.kernel.org, linux@horizon.com
X-From: git-owner@vger.kernel.org Wed Feb 01 08:09:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4C78-0001bT-U8
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 08:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWBAHJM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 02:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbWBAHJM
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 02:09:12 -0500
Received: from science.horizon.com ([192.35.100.1]:36395 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751331AbWBAHJL
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Feb 2006 02:09:11 -0500
Received: (qmail 2025 invoked by uid 1000); 1 Feb 2006 02:08:47 -0500
To: torvalds@osdl.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15390>

> Yes, I think the "assume unchanged" flag goes well together with making 
> sure that the checked-out file is non-writable at the time.
> 
> Of course, any number of editors and other actions won't care: if you do 
> anything like
> 
> 	for i in *.c
> 	do
> 		sed 's/xyzzy/bas/g' < $i > $i.new
> 		mv $i.new $i
> 	done
> 
> you'll never have even noticed that the old file was marked read-only. So 
> it's obviously not in any way any guarantee, but it probably makes sense 
> as a crutch.

At the risk of complicating something already very complicated, and
possibly breaking on Microsoft file systems, that case can be detected
by reading the directory and noticing that the inode number changed.

Would it be worth validating the inode numbers (which can be retrieved
in a batch) even if you don't do a full lstat()?

Or is that too Unix-centric and prone to performance problems on other
file systems?  I'd think that, even if a file system used fake inode
numbers, they'd be pretty consistent if you didn't touch the file at all,
and being different would just cause a more expensive validation.
Which would be okay as long as it's infrequent.
