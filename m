From: Junio C Hamano <junkio@cox.net>
Subject: Re: using the same repo with different OS
Date: Sun, 25 Feb 2007 10:20:29 -0800
Message-ID: <7v3b4ut7yq.fsf@assigned-by-dhcp.cox.net>
References: <906f26060702250913g41658be6mffea613f25f9a847@mail.gmail.com>
	<Pine.LNX.4.63.0702251829530.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefano Spinucci <virgo977virgo@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 25 19:20:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLNzC-0008Vo-NE
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 19:20:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932963AbXBYSUb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 13:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932978AbXBYSUa
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 13:20:30 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:34786 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932963AbXBYSUa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 13:20:30 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070225182031.JWGL3546.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sun, 25 Feb 2007 13:20:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id TuLV1W0051kojtg0000000; Sun, 25 Feb 2007 13:20:29 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40564>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> It could be possible that the index is saved in a slightly different 
> format, due to different alignment strategies. Maybe 64-bit vs 32-bit has 
> differences there. I have no idea.

As far as I am aware of, there should be no such difference,
although we probably rely on int being 32 and long being 64
bit.  We do store our numbers in network byte order.

However, did somebody say FAT-32?  I seem to recall that that
filesystem lacks uid/gid, so I am reasonably sure there would be
different return values for the same path from lstat(2) between
git on Cygwin/MinGW and on Linux that mounts the same filesystem
using vfat driver with different uid= & gid= mount options.
That difference which would make the paths stat-dirty.

Also there is the problem of i-num we discussed lately.  The
i-num we get for the same path from lstat(2) can be different
when same filesystem is mounted by different operating systems
(remember that NTFS on Linux and Cygwin?).

So even though file format of the index may be designed and
implemented to be portable, it might not be practical to use
the same physical repository from different OSes, depending on
the combination of things.
