From: Christopher Faylor <me@cgf.cx>
Subject: Re: [PATCH] "sleep 1" sleeps too little on cygwin
Date: Thu, 19 Jan 2006 17:25:53 -0500
Message-ID: <20060119222553.GB7567@trixie.casa.cgf.cx>
References: <81b0412b0601170325y60094b4w693ac37490c67410@mail.gmail.com> <7vmzhtzzlf.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0601181233460.8678@wbgn013.biozentrum.uni-wuerzburg.de> <7v4q41zd1t.fsf@assigned-by-dhcp.cox.net> <20060118185229.GA3001@steel.home> <7vmzhtqakl.fsf@assigned-by-dhcp.cox.net> <81b0412b0601190701g2696b1a9l14f3d288875e11ab@mail.gmail.com> <20060119182822.GA32022@trixie.casa.cgf.cx> <20060119221227.GB3601@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jan 19 23:26:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EziEE-00056E-Vj
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 23:26:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161264AbWASWZz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 17:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161449AbWASWZz
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 17:25:55 -0500
Received: from c-24-61-23-223.hsd1.ma.comcast.net ([24.61.23.223]:43243 "EHLO
	cgf.cx") by vger.kernel.org with ESMTP id S1161264AbWASWZy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2006 17:25:54 -0500
Received: by cgf.cx (Postfix, from userid 201)
	id C51B24A8575; Thu, 19 Jan 2006 17:25:53 -0500 (EST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060119221227.GB3601@steel.home>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14942>

On Thu, Jan 19, 2006 at 11:12:27PM +0100, Alex Riesen wrote:
>Christopher Faylor, Thu, Jan 19, 2006 19:28:22 +0100:
>>>>By the way, if you have an access to git on cygwin with FAT, could you
>>>>test your patch ($SECONDS) and then i-num patch (the machine with
>>>>cygwin I can borrow has only NTFS) please?
>>>
>>>Works if sleep is for 2 secs (I completely forgot about that stupid FAT
>>>granularity!) st_ino is always the same (it is a hash of pathname).
>>>Christopher, how is that supposed to work with hardlinks?  (NTFS has
>>>hardlinks, BTW)
>>
>>There is OS support hardlinks work on NTFS/NT but not on FAT*
>>"filesystems" or Windows 9x variants.  Hardlink support on Cygwin
>>mirrors this.
>
>No, I rephrase the question: how does the method of calculating .st_ino
>from pathname handles hardlinked files on NTFS?  By briefly looking at
>the code it does not seem to be possible.

Cygwin doesn't create an inode from the path name on NTFS.  NT gives you
a 64 bit unique number which identifies a file so we use that.  That
means that the inodes of hardlinked files should be the same, just like
on linux.

Inodes are only calculated by hashing the path name when the OS lacks
the support to provide a "real" inode and in that case there is no hard
link support available so it's a non-issue.

cgf
