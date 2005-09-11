From: Greg Louis <glouis@dynamicro.on.ca>
Subject: Re: git-clone seems dead
Date: Sun, 11 Sep 2005 18:04:21 -0400
Organization: Dynamicro Consulting Limited
Message-ID: <20050911220421.GA14593@athame.dynamicro.on.ca>
References: <vhp64t7v5ff.fsf@ebar091.ebar.dtu.dk> <7vd5nfs9y0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-From: git-owner@vger.kernel.org Mon Sep 12 00:05:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEZwA-0002u2-Ej
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 00:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbVIKWEb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 18:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbVIKWEb
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 18:04:31 -0400
Received: from csl2r.consultronics.on.ca ([204.138.93.16]:63463 "EHLO
	csl2.consultronics.on.ca") by vger.kernel.org with ESMTP
	id S1750926AbVIKWEa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 18:04:30 -0400
Received: from [70.29.36.34] (helo=athame.dynamicro.internal ident=glouis)
	by csl2.consultronics.on.ca with esmtpsa (SSLv3:AES256-SHA:256)
	(Exim 4.52)
	id 1EEZvx-0004GE-SD
	for git@vger.kernel.org; Sun, 11 Sep 2005 18:04:21 -0400
Received: from root by athame.dynamicro.internal with local (Exim 4.52)
	id 1EEZvx-0003pP-Gj
	for git@vger.kernel.org; Sun, 11 Sep 2005 18:04:21 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vd5nfs9y0.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8336>

On 20050911 (Sun) at 1204:07 -0700, Junio C Hamano wrote:
> Peter Eriksen <s022018@student.dtu.dk> writes:
> 
> > All commands works fine except "git clone" which prints:
> >
> > <cite>
> > defaulting to local storage area
> > * git clone [-l [-s]] [-q] [-u <upload-pack>] <repo> <dir>
> > </cite>
> >
> > and leaves my-git/.git empty.  So the problem is, that I can't
> > get "git clone" to work, and I think, I am making correct steps.
> 
> Hmph.  All your steps seem sane, and after removing my git
> installation on one of my machines I tried the exact steps as
> above but did not get this.
> 
> The message 'defaulting to local storage area' comes from git-init-db,
> and '* git clone ...' comes from usage.
> 
>     dir="$2"
>     mkdir "$dir" &&
>     D=$(
>             (cd "$dir" && git-init-db && pwd)
>     ) &&
>     test -d "$D" || usage
> 
> If you had my-git directory you would get the usage but not
> 'defaulting...', so that is not it.  The only possibility I
> could think of is your 'pwd' says something different than the
> working directory name?  I am very confused..
> 
I had the same.  I was using bash with CDPATH; when CDPATH is in use
and you do a cd to a relative directory, bash prints the absolute
pathname on stdout during the cd.  So all those relative cd's in $(cd
xxx && ... && pwd) in git-clone and a few other places cause bash to
print the absolute path on stdout, greatly confusing the code that uses
the output text that it thinks came from pwd.  I have a patch to add
&>/dev/null in what I think are all the right places, if you want it,
but it may be easiest just to unset CDPATH and see if that fixes the
trouble.

-- 
| G r e g  L o u i s         | gpg public key: 0x400B1AA86D9E3E64 |
|  http://www.bgl.nu/~glouis |   (on my website or any keyserver) |
|  http://wecanstopspam.org in signatures helps fight junk email. |
