From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Thu, 2 Mar 2006 15:10:30 +0100
Message-ID: <81b0412b0603020610q41d0ec98x80d112b7daa179fa@mail.gmail.com>
References: <81b0412b0602220835p4c4243edm145ee827eb706121@mail.gmail.com>
	 <81b0412b0602230000t58a88af6na1aa7e323dc0179d@mail.gmail.com>
	 <7vwtfmihts.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0602230135w472aa6f3v72980f6f63bb355f@mail.gmail.com>
	 <81b0412b0602230141g46dbfaev6baa5083dee2d42@mail.gmail.com>
	 <43FD84EB.3040704@op5.se>
	 <81b0412b0602230210r3ffe6e2dta5dc86d6516692b9@mail.gmail.com>
	 <43FDB8CC.5000503@op5.se>
	 <81b0412b0602230607n22146a77k36929f0ad9e44d53@mail.gmail.com>
	 <20060226195552.GA30735@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 02 15:10:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEoVo-0000FK-1H
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 15:10:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWCBOKd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 09:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWCBOKd
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 09:10:33 -0500
Received: from nproxy.gmail.com ([64.233.182.193]:37333 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751200AbWCBOKc convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 09:10:32 -0500
Received: by nproxy.gmail.com with SMTP id l36so280537nfa
        for <git@vger.kernel.org>; Thu, 02 Mar 2006 06:10:31 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nwnCUN1gySWkUwg9PGXKeDYwRUnwOEHEHMBnRLlnibiGNMPQ9Dk9q4os1RuZVim3NHuW1ChZz02FDHB4DZwk8q6bDEGxK44t2ODde4ECeOlWLaw3nhWZRFWTpRTIfQ42ELE5isMZQFwg4QQDH1qvOVD3C0887qxLjlC6LLLdCfA=
Received: by 10.48.238.3 with SMTP id l3mr657243nfh;
        Thu, 02 Mar 2006 06:10:30 -0800 (PST)
Received: by 10.49.88.16 with HTTP; Thu, 2 Mar 2006 06:10:30 -0800 (PST)
To: "Christopher Faylor" <me@cgf.cx>
In-Reply-To: <20060226195552.GA30735@trixie.casa.cgf.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17072>

Christopher, I'm terribly sorry for the long delays,
but that is something I can't change at this moment.

On 2/26/06, Christopher Faylor <me@cgf.cx> wrote:
> >>>It's not activestate perl actually.  It's only one platform it also
> >>>_has_ to support.  Is it worth supporting Windows?
> >>
> >>With or without cygwin?  With cygwin, I'd say "yes, unless it makes
> >>things terribly difficult to maintain and so long as we don't take
> >>performance hits on unices".  Without cygwin, I'd say "What?  It runs
> >>on windows?".
> >
> >There not much difference with or without cygwin.  The penalties of
> >doing any kind of support for it will pile up (as they started to do
> >with pipes).  Someday we'll have to start dropping features on Windows
> >or restrict them beyond their usefullness.  The fork emulation in
> >cygwin isn't perfect,
>
> If the speed of cygwin's fork is an issue then I'd previously suggested
> using spawn*.  The spawn family of functions were designed to emulate
> Windows functions of the same name.  They start a new process without
> the requirement of forking.

The effort of porting git to spawn-like interface has already started,
so there's no much left to say about the fork's speed...

> >signals do not work reliably (if at all),
>
> I'm not sure if you're mixing cygwin with windows here but if signals do
> not work reliably in Cygwin then that is something that we'd like to
> know about.  Signals *obviously* have to work fairly well for programs
> like ssh, bash, and X to work, however.

That's not enough.
Try interrupting busy processes. Like "git pull", "git clone" or make.

> Native Windows, OTOH, hardly has any signals at all and deals with
> signals in a way that is only vaguely like linux.

That makes the rest of installed system kind of useless in cygwin
environment. After interrupting a build process, which uses java
(don't ask) only make stops. The rest of the process runs happily
away.

Now, I know that windows has no signals at all and nothing which
even closely resembles them. I wont be pressing anyone to
implement them in windows, having the knowledge.
What I'd actually suggest is to drop their implementation entierly,
returning ENOSYS, so that programs are not fooled into believing
that the system will work as expected. It never will.
"Ctrl-C" in windows console is just a shortcut to TerminateProcess,
live with that.

> >filesystem is slow and locked down, and exec-attribute is NOT really
> >useful even on NTFS (it is somehow related to execute permission and
> >open files.  I still cannot figure out how exactly are they related).
>
> Again, it's not clear if you're talking about Windows or Cygwin but
> under Cygwin, in the default configuration, the exec attribute means the
> same thing to cygwin as it does to linux.

I'm talking about git and native windows interaction: I cannot use umask,
because I have to use stupid windows programs, and they always create
"executable" *.c and *.h, and I cannot blindly remove it with something
like "chmod -R -x", because it'd remove it also from executables. The
poor executables lose their _rights_ to be executed (why does cygwin use
windows permissions? They cannot correlate to unix attributes, can they?)
An .bat or .cmd without right to execute it is a pain in my build system
(and no, I'm not allowed to change that damn stupid build system).

Is there any way to tell cygwin that the files it hasn't seen or touched yet
are _not_executables_?
