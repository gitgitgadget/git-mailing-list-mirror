From: Greg KH <greg@kroah.com>
Subject: Re: gitweb on kernel.org broken
Date: Mon, 16 Jan 2006 12:28:53 -0800
Message-ID: <20060116202853.GA5676@kroah.com>
References: <43CBE993.9060701@zytor.com> <20060116185342.GA14088@vrfy.org> <20060116190556.GA14184@vrfy.org> <7vwth0rlfm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, gregkh@kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 21:29:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eyayb-0000Kv-BU
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 21:29:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWAPU3O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 15:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbWAPU3O
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 15:29:14 -0500
Received: from mail.kroah.org ([69.55.234.183]:62667 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750932AbWAPU3N (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jan 2006 15:29:13 -0500
Received: from [192.168.0.25] (c-24-22-115-24.hsd1.or.comcast.net [24.22.115.24])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id k0GKT5L07650;
	Mon, 16 Jan 2006 12:29:05 -0800
Received: from greg by press.kroah.org with local (masqmail 0.2.20) id
 1EyayE-1Th-00; Mon, 16 Jan 2006 12:28:54 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwth0rlfm.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14759>

On Mon, Jan 16, 2006 at 12:02:05PM -0800, Junio C Hamano wrote:
> Kay Sievers <kay.sievers@vrfy.org> writes:
> 
> >> Junio, seems your "textual symref HEAD" change is causing this?
> 
> Yeah, I assumed git_read_head() is called only on a repository
> that was verified to be valid, and the subroutine did not check
> the case where HEAD does not verify.  My bad.  The attached
> patch should solve this.
> 
> The error log says hotplug-ng.git is triggering it.  I wonder what
> is so special about that repository.  I hope it is transient
> during mirroring that mirrored HEAD before objects, not a
> corrupt repository at the mirroring source.
> 
> 	... goes to kernel.org mirroring source machine ...
> 
> Ugh.  It is _not_ a valid git repository.  HEAD should be either a symlink
> or a symref pointing somewhere under refs/heads/, but in that
> directory, it instead is a regular file that contains an object
> name.  There is nothing under refs/ either:
> 
>         $ ls -l /pub/scm/linux/hotplug/hotplug-ng.git/HEAD
>         -rw-r--r--  2 gregkh users 41 May  6  2005 /pub/s...ug-ng.git/HEAD
> 	$ cat /pub/scm/linux/hotplug/hotplug-ng.git/HEAD
>         b26bec9f620a969fe5238e8666ab698f197df488
> 	$ ls -l /pub/scm/linux/hotplug/hotplug-ng.git/refs
> 	total 0
> 	$ exit
> 
> Greg, could you let me know what is going on with this
> repository, please?
> 
> First of all, I am wondering if this repository is still used
> (maintained); a regular file HEAD that contains an object name
> would have stopped working on Aug 27 2005 with this commit at the
> latest, maybe even before that:

That's a very old git tree, and the development tree is pretty much dead
too.  I'll just go delete the thing.

Sorry about that.

greg k-h
