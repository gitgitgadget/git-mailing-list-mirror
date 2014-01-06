From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH 2/2] Introduce git submodule attached update
Date: Mon, 6 Jan 2014 15:06:27 +0100
Message-ID: <20140106140627.GA27265@t2784.greatnet.de>
References: <1388890249-3577-1-git-send-email-ceztko@gmail.com>
 <1388890249-3577-2-git-send-email-ceztko@gmail.com>
 <20140105203349.GB3737@book.hvoigt.net>
 <CALas-ijjzyRVuc0NaAS5QS98pX2198mv4HoHDacgYFYNLXbXFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <jens.lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>
To: Francesco Pretto <ceztko@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 15:06:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0ApI-0001tM-4F
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 15:06:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbaAFOGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 09:06:40 -0500
Received: from smtprelay04.ispgateway.de ([80.67.31.31]:36886 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbaAFOGj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 09:06:39 -0500
Received: from [83.133.105.219] (helo=t2784.greatnet.de)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1W0Ap5-0006Vi-NN; Mon, 06 Jan 2014 15:06:31 +0100
Content-Disposition: inline
In-Reply-To: <CALas-ijjzyRVuc0NaAS5QS98pX2198mv4HoHDacgYFYNLXbXFw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240011>

On Sun, Jan 05, 2014 at 10:46:11PM +0100, Francesco Pretto wrote:
> 2014/1/5 Heiko Voigt <hvoigt@hvoigt.net>:
> > The following questions directly pop into my mind:
> >
> >  - What means the maintainer does not track the submodules sha1? Does
> >    that mean the superproject always refers to submodule commits using
> >    branches?
> 
> It means he doesn't need to control other developers commit to be
> checked out so he sets "submodule.<name>.ignore" to "all". In this way
> he and the developers can work actively in their submodule copy.

So practically speaking: You mean that the value of
submodule.<name>.ignore is set to "all" in the master branch of the
superproject? From your other email referring to svn:externals I figure
that.

> >  - What happens if you want to go back to an earlier revision? Lets say
> >    a tagged release? How is ensured that you get the correct revision in
> >    the submodules?
> 
> "submodule.<name>.branch" is one setting that is not copied in
> ".git/config" by "git submodule init". "git submodule update" will use
> the setting in ".gitmodules" if not overridden voluntarily by the
> developer in ".git/config". The maintainer can change that setting in
> ".gitmodules" and commit the change. Modifies will be propagated by
> the next "git pull && git submodule update" of the developer in the
> superproject.

I do not understand how does that ensure you get the correct submodule
revision when checking out a tagged release? To get a precise revision
the superproject needs to track a sha1 of a submodule commit. I do not
see how that has anything to do with submodule.<name>.branch?

> >  - In which situations does the developer or maintainer switch between
> >    your attached/detached mode?
> 
> The developer/maintainer does so optionally and voluntarily and it
> effects only its private working tree.

This does not answer my question. I would like to find out the reason
why one would do the switch.

> >  - What is the "repository branch" which is given to the developer by
> >    the maintainer used for? Who creates this branch and who merges into
> >    it?
> 
> The branch of course must exist prior submodule adding. In this
> use-case it does not really matter who creates it and who merges into
> it. Everyone with the right to merge into it has to work in the
> submodule seamlessly, as it was working on separate clone of the same
> repository used as the submodule.
o
Here is the same. I am searching for a description like:

If the developer works on a feature that needs a submodule change he:
  - creates a submodule branch
  - configures that submodule branch in the superproject:
  	git config -f .gitmodules submodule.common.branch dev/some-feature
	git commit -am "TEMP: track submodule common on branch"
 - and pushes out his superproject branch

The submodule branch is then posted for review and continued to work on.

Once everyone involved is happy with the submodule change the branch in
there gets merged to master.

Now the branch in the superproject is modified to drop the change in
.gitmodules and the sha1 reference in the superproject is updated to the
current master of the superproject.

The superproject branch is posted for review.

...

Could you describe something like this for your workflow? A complete
change lifecycle when a developer works, as you call it, "actively" in a
submodule?

> >  - What are these subsequent "merge" or "rebase" update operations? Do
> >    you mean everyone has submodule.name.update configured to merge or
> >    rebase?
> >
> 
> subsequent "merge" or "rebase" update operations are just the ones
> after the initial clone/checkout, nothing particular.

To clarify you are talking about issuing "git merge" or "git rebase"
commands in the superproject?

Cheers Heiko
