From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH 2/2] Introduce git submodule attached update
Date: Mon, 6 Jan 2014 15:18:05 +0100
Message-ID: <20140106141805.GB27265@t2784.greatnet.de>
References: <1388890249-3577-1-git-send-email-ceztko@gmail.com>
 <1388890249-3577-2-git-send-email-ceztko@gmail.com>
 <20140105203349.GB3737@book.hvoigt.net>
 <CALas-ijydCqhx5mgmMkcBE73TqNVckRooZ5x22uSq1Ldm4CGDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <jens.lehmann@web.de>,
	"W. Trevor King" <wking@tremily.us>,
	Junio C Hamano <gitster@pobox.com>
To: Francesco Pretto <ceztko@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 15:18:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0B0V-0006OS-LN
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 15:18:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbaAFOSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 09:18:16 -0500
Received: from smtprelay05.ispgateway.de ([80.67.31.98]:46602 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbaAFOSP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 09:18:15 -0500
Received: from [83.133.105.219] (helo=t2784.greatnet.de)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1W0B0I-0007hB-SI; Mon, 06 Jan 2014 15:18:06 +0100
Content-Disposition: inline
In-Reply-To: <CALas-ijydCqhx5mgmMkcBE73TqNVckRooZ5x22uSq1Ldm4CGDA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240012>

On Mon, Jan 06, 2014 at 12:22:23AM +0100, Francesco Pretto wrote:
> 2014/1/5 Heiko Voigt <hvoigt@hvoigt.net>:
> > Could you please extend the description of your use-case so we can
> > understand your goal better?
> >
> 
> Maybe I found better words to explain you my goal: the current git
> submodule use-case threats the submodule as a project independent
> dependency. My use case threats the submodule as part of the
> superproject repository. It could be easier to say that in this way
> submodules would behave very similarly to "svn:externals", something
> that is actually missing in git. My goal is obtain this without
> altering git behavior for the existing use case.

I am not so sure. svn:externals was IMO a hack in SVN to bind projects
together. It does not record the revision and so has nothing to do
with version control. If you simply want to always checkout the
development tip of some project you could do something like this:

	git submodule foreach 'git fetch && git checkout origin/master'

The demand for this 'missing feature' which we call the 'floating
submodules' model has been around for some time but until now we could
convince people that its not a feature but you are actually loosing
history information.

The workflow could always be changed to allow recording revisions. Which
is why you use git in the first place right? If you discard revisions
for submodules tracking down regression bugs can become a big problem or
completely impossible. Try using git bisect on such a history.

> >  - In which situations does the developer or maintainer switch between
> >    your attached/detached mode?
> 
> As I told you in the other answer this is voluntary done by the
> developer, as he prefers.

Could you tell me a typical reason?


> I came to the conclusion that the
> "--attach|--detach" switches for the "update" command are not that
> useful and can be removed. It's still possible to obtain the switch
> between detached/attached very easily in this way:
> 
> # Attach submodule
> $ git config submodule.<name>.attached "true"
> $ git submodule update
> 
> # Detach submodule
> $ git config submodule.<name>.attached "false"
> $ git submodule update
> 
> # Unset property in both ".gitmodules" and ".git/config" means -> do nothing
> $ git config --unset submodule.<name>.attached
> $ git submodule update
> 
> Also my "submodule.<name>.attached" property at the moment behaves
> like "submodule.<name>.update": it is copied in ".git/config" by "git
> submodule init". This is probably a mistake: the overridden value
> should be stored in ".git/config" only at the developer will, so the
> maintainer has still a chance to modify it in ".gitmodules" and
> propagate the behavior.
> 
> I would send an updated patch but at this point I prefer to wait for a
> full review.

Lets first discuss and figure out what is the real missing feature here
and what should be implemented before working further on the code.

Cheers Heiko
