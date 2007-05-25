From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] Add git-submodule command
Date: Fri, 25 May 2007 22:29:41 +0200
Message-ID: <8c5c35580705251329u33ac1462m9db35cac0c37e3a9@mail.gmail.com>
References: <8c5c35580705250752k2021f02dv804d87da5c0d5da7@mail.gmail.com>
	 <11801165433267-git-send-email-hjemli@gmail.com>
	 <Pine.LNX.4.64.0705251924280.4648@racer.site>
	 <7vodk8r97s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	"Linus Torvalds" <torvalds@linux-foundation.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 25 22:30:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrgQa-0000XU-8g
	for gcvg-git@gmane.org; Fri, 25 May 2007 22:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753592AbXEYU3o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 16:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755162AbXEYU3o
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 16:29:44 -0400
Received: from nz-out-0506.google.com ([64.233.162.228]:34564 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753592AbXEYU3m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 16:29:42 -0400
Received: by nz-out-0506.google.com with SMTP id n1so423861nzf
        for <git@vger.kernel.org>; Fri, 25 May 2007 13:29:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KfTC4tXjVbM0dVgXUnzmyV94TF5Or3wWZG+T/2sJLFwniF/urNlmR75UItZTnaVLxWR8Qn6mWmrCDwDfOATR5yiqLOGjuk8O7duU6EwoK5r4Jfa/nyKnrGx6w8eICbhZ3FGtINQZi9rlMSfZ+8UtFRicblD/hKx3w/ddEvpvTrA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MAMum2seVqJFNzelxvDU5eg9Cw7Sv3qLAwODXYAHeus5S757kDrD6hvVLgu4ZaIxNqp0725isQNGq+QrpLh2eAo9gcs0IqzYa099G88tNAPdvUfQgmEinyqeBSu7LiNZ/wRmvh62HIigIcUqSbW0XGKXPPkFQAVCx5mUWa4WSFs=
Received: by 10.115.33.1 with SMTP id l1mr1664989waj.1180124981782;
        Fri, 25 May 2007 13:29:41 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Fri, 25 May 2007 13:29:41 -0700 (PDT)
In-Reply-To: <7vodk8r97s.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48408>

On 5/25/07, Junio C Hamano <junkio@cox.net> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Fri, 25 May 2007, Lars Hjemli wrote:
> >
> >> Btw: testing this quickly becomes tedious, so I'll try to make a proper
> >> testscript later tonight.
> >
> > Very good.
> >
> >> +'git-submodule' [--init | --update | --cached] [--quiet] [--] [<path>...]
> >
> > I did not realize this earlier, but we seem to have more and more programs
> > where actions are specified without "--", i.e. "git-svn fetch", or
> > "git-bundle create".
> >
> > I actually like that, to separate actions from options. Hmm?
>
> I think it is a sensible thing to do for this kind of "wrapper
> of different functionalities related to one area".

Ok, there seems to be general agreement on this, so how about
something like this instead:

  git-submodule [--quiet] [--cached] [init | update] [--] [<path>...]

or would you rather have

  git-submodule [--quiet] [--cached] <cmd> [<path>...]

with cmd being one of init, update, status?

> >> +FILES
> >> +-----
> >> +When cloning submodules, a .gitmodules file in the top-level directory
> >> +of the containing work-tree is examined for the url of each submodule.
> >> +The url is the value of the key module.$path.url.
> >
> > IIRC Junio talked about a name for overriding. But I think it would be
> > even better to to override by mapping the URLs from .gitmodules to the
> > locally-wanted URLs.
> >
> > Junio?
>
> I really do not want that (mis)conception that .gitmodules
> specify the default and .git/config the override.  I really
> think we should use the .git/config as _the_ only authority to
> get URL, but keyed with the three-level scheme, with URL in
> .gitmodules used _solely_ as a hint when setting up the URL in
> the .git/config file.
>
>         cf. $gmane/47502, 47548, 47621
>

I've read these articles, but I think much of the concerns about
trusting the url supplied by upstream goes away when the submodule
clone/checkout isn't an integrated part of the superproject
clone/checkout. Besides, if you trust your upstream enough to clone
their repository (the superproject), why wouldn't you trust the data
(.gitmodules) in that very repository?

Still, a way to locally override the suggested url is probably needed.
 This can be easily achieved by either yours or Linus' suggestion
about 'url rewriting'. And if clone/checkout doesn't touch the
submodules at all, the downstream user can look at/override the
.gitmodules file in his local tree before deciding to do the submodule
 clone or checkout. I don't think there is any need for an interactive
tool here.

Another possibility is simply doing the submodule clone/checkout by
hand (i.e. do 'git clone preferred-url path', don't do 'git submodule
init path').


> >> +When updating submodules, the same .gitmodules file is examined for a key
> >> +named 'module.$path.branch'. If found, and if the named branch is currently
> >> +at the same revision as the commit-id in the containing repositories index,
> >> +the specified branch will be checked out in the submodule. If not found, or
> >> +if the branch isn't currently positioned at the wanted revision, a checkout
> >> +of the wanted sha1 will happen in the submodule, leaving its HEAD detached.
> >
> > A very good description, and I think this is the only method to checkout
> > the submodule which makes sense. (Just maybe default the value of
> > module.<path>.branch to "master"?)
>
> I suspect leaving the HEAD always detached if the superproject
> tree names a concrete commit object name would be less confusing
> and consistent.

And easier to explain :)


>When the name of the commit object in the
> superproject tree and/or index is 0{40}, it would be a good
> extension to use "whatever commit that happens to be at the tip
> of this branch" taken from the .gitmodules file.
>

I really can't imagine what kind of superproject would have such a
setup. Why would this be needed?

-- 
larsh
