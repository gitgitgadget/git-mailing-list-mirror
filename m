From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Re: Relative submodule URLs
Date: Tue, 26 Aug 2014 08:28:47 +0200
Message-ID: <20140826062847.GA12216@book.hvoigt.net>
References: <CAHd499CRNjp-UzXiTt=xgDJWGOEqew+AuPFmrF3-VsEGefXiuA@mail.gmail.com>
 <20140818205505.GA20185@google.com>
 <CAHd499DVf4N3Y6m5qoiy-WQGX4K54umefRzehZMsrxiWbaiZ=g@mail.gmail.com>
 <53F76907.1090904@xiplink.com>
 <20140824133428.GA2839@book.hvoigt.net>
 <CAHd499Bat5AFc1E4Sfezx9Qi8LPsxkyKKkBb2eg8JQb9kdPzgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 08:29:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMAFs-0000bp-60
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 08:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbaHZG3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 02:29:16 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.42]:55552 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755535AbaHZG3P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 02:29:15 -0400
Received: from [77.21.76.69] (helo=book.hvoigt.net)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1XMAFQ-0005QB-0L; Tue, 26 Aug 2014 08:28:52 +0200
Content-Disposition: inline
In-Reply-To: <CAHd499Bat5AFc1E4Sfezx9Qi8LPsxkyKKkBb2eg8JQb9kdPzgg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255878>

On Mon, Aug 25, 2014 at 09:29:07AM -0500, Robert Dailey wrote:
> On Sun, Aug 24, 2014 at 8:34 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > New --with--remote parameter for 'git submodule'
> > ------------------------------------------------
> >
> > While having said all that about submodule settings I think a much
> > much simpler start is to go ahead with a commandline setting, like
> > Robert proposed here[2].
> >
> > For that we do not have to worry about how it can be stored,
> > transported, defined per submodule or on a branch, since answers to this
> > are given at the commandline (and current repository state).
> >
> > There are still open questions about this though:
> >
> >   * Should the name in the submodule be 'origin' even though you
> >     specified --with-remote=somewhere? For me its always confusing to
> >     have the same/similar remotes named differently in different
> >     repositories. That why I try to keep the names the same in all my
> >     clones of repositories (i.e. for my private, github, upstream
> >     remotes).
> >
> >   * When you do a 'git submodule sync --with-remote=somewhere' should
> >     the remote be added or replaced.
> >
> > My opinion on these are:
> >
> > The remote should be named as in the superproject so
> > --with-remote=somewhere adds/replaces the remote 'somewhere' in the
> > submodules named on the commandline (or all in case no submodule is
> > specified). In case of a fresh clone of the submodule, there would be no
> > origin but only a remote under the new name.
> >
> > Would the --with-remote feature I describe be a feasible start for you
> > Robert? What do others think? Is the naming of the parameter
> > '--with-remote' alright?
> >
> > Cheers Heiko
> >
> > [1] http://article.gmane.org/gmane.comp.version-control.git/255512
> > [2] http://article.gmane.org/gmane.comp.version-control.git/255512
> > [3] https://github.com/jlehmann/git-submod-enhancements/wiki#special-ref-overriding-gitmodules-values
> 
> Hi Heiko,
> 
> My last email response was in violation of your request to keep the
> two topics separate, sorry about that. I started typing it this
> weekend and completed the draft this morning, without having read this
> response from you first.

Thats fine, no problem.

> Here is what I think would make the feature most usable. I think you
> went over some of these ideas but I just want to clarify, to make sure
> we're on the same page. Please correct me as needed.
> 
> 1. Running `git submodule update --with-remote <name>` shall fail the
> command unconditionally.

I am not sure but I think you mean

	git submodule update --with-remote=<name>

With the equals sign, without it you would name the submodule paths to
update. No I think that should just add the remote <name> to all
submodules that would be updated and do the normal update operation on
them (with the new remote of course).

> 2. Using the `--with-remote` option on submodule `update` or `sync`
> will fail if it detects absolute submodule URLs in .gitmodule

Yes, almost. Since you can have a mixture I suggest to only fail if the
submodules that would be processed have an absolute url in them. If
processed submodules are all relative it can go ahead.

> 3. Running `git submodule update --init --with-remote <name>` shall
> fail the command ONLY if a submodule is being processed that is NOT
> also being initialized.

No since the --init flag just tells update to initialize submodules
on-demand. It should just go ahead the same way as without
--with-remote.

> 4. The behavior of git submodule's `update` or `sync` commands
> combined with `--with-remote` will REPLACE or CREATE the 'origin'
> remote in each submodule it is run in. We will not allow the user to
> configure what the submodule remote name will end up being (I think
> this is current behavior and forces good practice; I consider `origin`
> an adopted standard for git, and actually wish it was more enforced
> for super projects as well!)

No please carefully read my email again. I specifically was describing
the opposite. --with-remote=<name> creates/replaces the remote <name> in
the submodule. I do not see a benefit in restricting the user from
creating different remote names in the submodule. I think it would be
more confusing if the remote 'origin' in the superproject does not point
to the same location as 'origin' in the submodule.

> Let me know if I've missed anything. Once we clarify requirements I'll
> attempt to start work on this during my free time. I'll start by
> testing this through msysgit, since I do not have linux installed, but
> I have Linux Mint running in a Virtual Machine so I can test on both
> platforms as needed (I don't have a lot of experience on Linux
> though).

I think it does not matter which development environment you use. In my
experience though Linux is around 30x faster when it comes to the
typical operations you do when developing git. Especially for running
the testsuite that makes a difference between a few hours and minutes.

> I hope you won't mind me reaching out for questions as needed, however
> I will attempt to be as resourceful as possible since I know you're
> all busy. Thanks.

No problem, just post here and we will see.


On Mon, Aug 25, 2014 at 09:32:27AM -0500, Robert Dailey wrote:
> Thought of a few more:
> 
> 5. If `--with-remote` is unspecified, behavior will continue as it
> currently does (I'm not clear on the precedence here of various
> options, but I assume: `remote.default` first, then
> `branch.name.remote`)

Yes. And I hope that is ensured enough through the testsuite for this
case. So run it to ensure this. Have a look what kind of tests exist and
maybe even write one or two for the code you change. Thats a good start
for practise and also makes sure you do no break existing behavior.

Johan Herland also recently collected some update tests here[1]

AFAIK, remote.default was WIP and does not exist yet. So you only need
to worry 

> 6. `--with-remote` will take precedence over `remote.default` and
> `branch.name.remote`.

Yes.

> I'll add more as I think of them... Sorry for the spam.

I think the code for the new commandline switch will not be too
complicated/big so I think its best if you just go ahead, write it and
then send a patch to the list once you are happy. Its common to add a
RFC if you just want some comments on your current status and do not
think its ready for inclusion yet. Expect it to go a few rounds until
everything is ironed out.

Cheers Heiko

[1] http://thread.gmane.org/gmane.comp.version-control.git/246312
