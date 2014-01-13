From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Submodule relative URL problems
Date: Mon, 13 Jan 2014 21:31:18 +0100
Message-ID: <20140113203118.GA2606@sandbox-ub>
References: <DC691CA7-BE36-4FE7-895A-FE8E1FD0C080@kcl.ac.uk>
 <DAD6CF7D-49F2-4FB5-9EF2-EBAAF86881AA@kcl.ac.uk>
 <20140113195518.GB18964@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lianheng Tong <lianheng.tong@kcl.ac.uk>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 13 21:31:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2oAS-0000El-VY
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jan 2014 21:31:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbaAMUbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jan 2014 15:31:25 -0500
Received: from smtprelay02.ispgateway.de ([80.67.29.24]:34526 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbaAMUbX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jan 2014 15:31:23 -0500
Received: from [77.20.146.74] (helo=sandbox-ub)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1W2oAK-00013T-K5; Mon, 13 Jan 2014 21:31:20 +0100
Content-Disposition: inline
In-Reply-To: <20140113195518.GB18964@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240373>

Hi,

On Mon, Jan 13, 2014 at 11:55:18AM -0800, Jonathan Nieder wrote:
> Lianheng Tong wrote:
> 
> > git clone W1:<path to A on W1>/.git  <path to A on W2>
> 
> Interesting.
> 
> Thoughts:
> 
>  * More typical usage is to clone from a bare repository (A.git), which
>    wouldn't have this problem.  But I think your case is worth
>    supporting, too.
> 
>  * What would you think of putting symlinks in A's .git directory?
> 
> 	cd A/.git
> 	ln -s ../B ../C ../D .
> 
>  * Perhaps as a special case when the superproject is foo/.git, git
>    should treat relative submodule paths as relative to foo/ instead
>    of relative to foo/.git/.  I think that would take care of your
>    case without breaking existing normal practices, though after the
>    patch is made it still wouldn't take care of people using old
>    versions of git without that patch.  What do you think?

I do not fully get the repository layout, since some commands simply do
not work. Nevertheless I think what Lianheng Tong is running into is
the following:

 * If a superproject has *no remote* a relative submodule url is relative
   to the *superproject itself*
 * If a superproject has *a remote* a relative submodule url is relative
   to the *superprojects remote*

The simplest solution is: Have central bare repositories for everything
so that every workstation has the same remote.

The second solution: Make sure both repositories have each other as a
remote. But then you run into a chicken/egg problem when setting the two
up.

The interpretation of relative urls was a design decision back when the
relative urls were introduced. I am quite sure it would produce a lot of
fallout if we change that.

If I get your usecase wrong it would be very helpful if you could
provide us with a working script that creates the repository setup your
are using.

Cheers Heiko
