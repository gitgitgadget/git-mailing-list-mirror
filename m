From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Notes on Using Git with Subprojects
Date: Wed, 27 Sep 2006 09:58:43 -0700
Message-ID: <451AADC3.40201@gmail.com>
References: <45196628.9010107@gmail.com> <Pine.LNX.4.64.0609261629160.9789@iabervon.org> <20060926213003.GA8177@spearce.org> <4519AACD.7020508@gmail.com> <20060927080652.GA8056@admingilde.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 19:00:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSclL-000061-7i
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 18:59:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbWI0Q7J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 12:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030234AbWI0Q7J
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 12:59:09 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:8557 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030231AbWI0Q6q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 12:58:46 -0400
Received: by nz-out-0102.google.com with SMTP id n1so113810nzf
        for <git@vger.kernel.org>; Wed, 27 Sep 2006 09:58:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=g/gNMXO8pbeMVa/RqFBVbGLKZyyjznXUXHFvKiV7JQX3zVomNbOzTB3GKA/zue6QLJp9zvIcY3ZCkt7TBfH3tkN+EjewZmzFYsqnqB2Icfc2Iutlb+EULOeLeCBsCD87Dqn9O60loAUAPsTvpLx0eV21fyoAjlMem3jHm1co1Zc=
Received: by 10.64.180.4 with SMTP id c4mr291209qbf;
        Wed, 27 Sep 2006 09:58:46 -0700 (PDT)
Received: from ?10.0.0.6? ( [67.20.67.46])
        by mx.gmail.com with ESMTP id e17sm1001971qba.2006.09.27.09.58.44;
        Wed, 27 Sep 2006 09:58:45 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20060927080652.GA8056@admingilde.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27913>

Martin Waitz wrote:
[...]
> My current approach is like this:
> 
>  * create a .gitmodules file which lists all the directories
>    which contain a submodule.
>  * the .git/refs/heads directory of the submodule gets stored in
>    .gitmodule/<modulename> inside the parent project
>  * both things above should be tracked in the parent project.
>    This way you always store the current state of each submodule
>    in each commit of the parent project.  And you don't have to
>    create a new parent commit for each change.  You can commit
>    to the parent project when you think that all your modules are
>    in a good state.

This means that modules are not separate, stand alone projects but, 
rather, just a sub part of your bigger project. Very useful and 
applicable in some situations but other situations want/need separate, 
stand alone subprojects.

>  * When checking out a project, all submodules listen in .gitmodules
>    get checked out, too.
>  * If there is a merge conflict in the module list or its refs/heads,
>    this is handled specially, e.g. by triggering a new merge inside
>    the submodule.
>  * The object directory is shared between the parent and all modules.
>    To make fsck-objects happy, the parent gets a refs/module link
>    pointing to .gitmodule/ and all submodules get a refs/parent
>    link pointing to the refs directory of the parent.
> 
[...]
> By storing the complete refs/heads directory for each submodule instead
> of only one head, it is possible to track multiple branches of a
> subproject.  I'm don't know yet how this works out in praktice but I
> think that it can be nice to be able to atomically commit to several
> branches of one submodule (perhaps one branch per customer, per
> hardware platform, whatever).

It's not immediately clear to me if tracking several long term 
(globally) visible branches in a checkout sub module is generally useful 
or only useful in special situations. I need to think about this...

[...]

You solved a similar problem to the one I'm working on; and one that is 
applicable to a number of projects. Namely, projects where all the parts 
are under the control of the same entity. For projects looking to escape 
  CVS, that use CVS modules, this looks like a Git solution.

The problem I'm working on is how to deal with the sub parts of a larger 
project when those sub parts are controlled by different entity. Silly 
example: the kernel is controlled by Linus; glibc is controlled by the 
GNU folks, gcc is controlled by some other GNU folks, the web server is 
controlled by the Apache Foundation, the X server is controlled by Xorg, 
etc.
