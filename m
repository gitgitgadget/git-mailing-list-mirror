From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: git rebase failing when using ZFS partition on Mac OS X
Date: Thu, 7 May 2009 01:26:43 +0200
Message-ID: <200905070126.43651.robin.rosenberg.lists@dewire.com>
References: <1FF266A7-CD80-4471-A837-D64007EE530A@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Alex Blewitt <alex.blewitt@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 01:27:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1qWK-0000L6-EO
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 01:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753353AbZEFX0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 19:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753023AbZEFX0t
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 19:26:49 -0400
Received: from mail.dewire.com ([83.140.172.130]:27409 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751741AbZEFX0s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 19:26:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 0737414A8B5B;
	Thu,  7 May 2009 01:26:46 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2-jiWb4CP4U7; Thu,  7 May 2009 01:26:45 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.7])
	by dewire.com (Postfix) with ESMTP id 0E4C914A8B5A;
	Thu,  7 May 2009 01:26:44 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <1FF266A7-CD80-4471-A837-D64007EE530A@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118409>

onsdag 06 maj 2009 23:14:11 skrev Alex Blewitt <alex.blewitt@gmail.com>:
> I've found out why git rebase wasn't working for me. It appears to be  
> something to do with the fact that the filesystem is running on ZFS  
> (and frankly, could well be a ZFS bug). I'd be loathe to move away  
> from ZFS generally but it would be good to find out why it's  
> complaining.
> 
> apple:egit alex$ git status
> # On branch master
> # Your branch is ahead of 'origin/master' by 3 commits.
> #
> nothing to commit (working directory clean)
> apple:egit alex$ git rebase -i HEAD~1
> Working tree is dirty
> 
> Here's what running a stat on TODO (an arbitrary file at the head of  
> the project) gives on a ZFS mounted file:
> 
> apple:egit alex$ stat -r TODO
> 754974724 135333 0100644 1 1000 100 0 2179 1241639236 1241034917  
> 1241639236 1241034917 2560 5 0 TODO
> apple:egit alex$ stat TODO
> 754974724 135333 -rw-r--r-- 1 alex bandlem 0 2179 "May  6 20:47:16  
> 2009" "Apr 29 20:55:17 2009" "May  6 20:47:16 2009" "Apr 29 20:55:17  
> 2009" 2560 5 0 TODO
> 
> Here's what running a stat on the same file on an HFS partition gives:
> 
> apple:egit alex$ stat -r TODO
> 234881026 930759 0100644 1 1000 0 0 2179 1241643695 1241034917  
> 1241643690 1241034917 4096 8 0 TODO
> apple:egit alex$ stat TODO
> 234881026 930759 -rw-r--r-- 1 alex wheel 0 2179 "May  6 22:01:35 2009"  
> "Apr 29 20:55:17 2009" "May  6 22:01:30 2009" "Apr 29 20:55:17 2009"  
> 4096 8 0 TODO
> 
> These are repeatable; if I re-run this periodically, it doesn't seem  
> to change. However, I wonder if there's any dependency on an 'inode'  
> or similar, which doesn't really have a comparable concept in ZFS.
> 
> Is there any more information that I can provide to assist with  
> finding out what's going on?

Try mine or Linus patch at http://thread.gmane.org/gmane.comp.version-control.git/117649/
and so what that gives.

-- robin
