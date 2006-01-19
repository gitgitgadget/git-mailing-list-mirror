From: Junio C Hamano <junkio@cox.net>
Subject: Re: /etc in git?
Date: Wed, 18 Jan 2006 23:50:22 -0800
Message-ID: <7vvewgirlt.fsf@assigned-by-dhcp.cox.net>
References: <b476569a0601181943y6a14e703k1b521a7edb9e2e2@mail.gmail.com>
	<7vlkxckf7o.fsf@assigned-by-dhcp.cox.net>
	<b476569a0601182040w581b72b7xbb99845da4085646@mail.gmail.com>
	<7v64ogkdtu.fsf@assigned-by-dhcp.cox.net>
	<43CF3061.2030504@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Hunt <kinema@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 08:50:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzUZ0-0000x4-1p
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 08:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161135AbWASHuZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 02:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161130AbWASHuZ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 02:50:25 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:24794 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1161135AbWASHuY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2006 02:50:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060119074925.YGMK15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 19 Jan 2006 02:49:25 -0500
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <43CF3061.2030504@michonline.com> (Ryan Anderson's message of
	"Thu, 19 Jan 2006 01:23:29 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14891>

Ryan Anderson <ryan@michonline.com> writes:

> Junio C Hamano wrote:
>> Adam Hunt <kinema@gmail.com> writes:
>> 
>> 
>>>Do you have any more details by chance?  Does it work?  Does it work
>>>well?  How does one do it?
>> 
>> 
>> I personally feel it is a horrible and stupid thing to do, if by
>> "version control /etc" you mean to have /.git which controls
>> /etc/hosts and stuff in place.  It would work (git does not
>> refuse to run as root).  But being a *source* control system, we
>> deliberately refuse to store the full permission bits, so if
>> your /etc/shadow is mode 0600 while /etc/hosts is mode 0644, you
>> have to make sure they stay that way after checking things out.
>
> This is, admittedly, a major problem.

An SCM is not a replacement of a backup.

>> You are much better off to keep /usr/src/rootstuff/.git (and
>> working tree files are /usr/src/rootstuff/etc/hosts and
>> friends), have a build procedure (read: Makefile) there, and
>> version control that source directory.  I usually have 'install'
>> and 'diff' target in that Makefile, so that I can do this:
>>... 
> If you're doing this, especially if you're doing this on multiple
> machines, creating a package is probably a worthwhile thing to
> contemplate as well.

In my workplace environment, the equivalent of the above
/usr/src/rootstuff is accessible throughout the networked
machines (mostly NFS mounted); for things that needs per-host
customization, we do not have /usr/src/rootstuff/etc/hosts but
keep /usr/src/rootstuff/etc/hosts.in as the source, and Makefile
customizes that into a form suitable for installation for each
machine.  Especially useful is vfstab.in --- a single source
builds fstab for local mounting and nfs exports, while other
machines have mountpoints and project symlinks pointing into
location automounted from that machine with disk, generated
automatically.  This does not match typical "package" use.
