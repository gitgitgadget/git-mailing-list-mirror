From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Implementing branch attributes in git config
Date: Thu, 11 May 2006 11:17:48 +1200
Message-ID: <46a038f90605101617x1aa9bd2du959ead77ebf61795@mail.gmail.com>
References: <1147037659.25090.25.camel@dv>
	 <7vzmhr3wje.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0605091215340.3718@g5.osdl.org>
	 <BAYC1-PASMTP02C02EAC2F64AC00BB5801AEA90@CEZ.ICE>
	 <BAYC1-PASMTP04D623089E043F1C792A37AEA90@CEZ.ICE>
	 <Pine.LNX.4.64.0605091543100.3718@g5.osdl.org>
	 <BAYC1-PASMTP037EBB0237B35C5F92FB0BAEAE0@CEZ.ICE>
	 <Pine.LNX.4.64.0605091854380.3718@g5.osdl.org>
	 <46a038f90605100019q3b44b87kf49e456668f2e249@mail.gmail.com>
	 <Pine.LNX.4.64.0605100823350.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: sean <seanlkml@sympatico.ca>, junkio@cox.net,
	Johannes.Schindelin@gmx.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 11 01:17:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdxwG-0001UL-Bs
	for gcvg-git@gmane.org; Thu, 11 May 2006 01:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965074AbWEJXRt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 May 2006 19:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965076AbWEJXRt
	(ORCPT <rfc822;git-outgoing>); Wed, 10 May 2006 19:17:49 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:19045 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965074AbWEJXRt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 May 2006 19:17:49 -0400
Received: by wr-out-0506.google.com with SMTP id i28so18598wra
        for <git@vger.kernel.org>; Wed, 10 May 2006 16:17:48 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P4pbqViuJZVMIkKvBk1BtaFVzefgU/1AZzguP13YPLdsZafpfVXG51wMeZExr5+jtivCI7FDe7qW92skekQfA7SBFUW5+8XYyxz01yOTNF1aQo2//eOuhhaT4Z6BG5yQr44v8Ewnzg/Z/55kbxXf8kUkz5Rdhoh+BVEMTEs3hOk=
Received: by 10.54.96.18 with SMTP id t18mr95769wrb;
        Wed, 10 May 2006 16:17:48 -0700 (PDT)
Received: by 10.54.127.17 with HTTP; Wed, 10 May 2006 16:17:48 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605100823350.3718@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19897>

On 5/11/06, Linus Torvalds <torvalds@osdl.org> wrote:
> Sure. It clearly _is_ a bike shed, which is why I posted patches: I think
> the way to resolve bike sheds is to "just do it". In the kernel, the

there's no disputing that!

> So don't knock the bike sheds. It's a BSD term, and I think there's a
> _reason_ why it's a BSD term. Those people seem to sometimes like to

Apologies -- I didn't want to know it, but I do wonder what the gain
behind the change is. It seems to me that it would be a bad idea to
store refs in the config file and, in my mind at least, branch info is
closer to refs.

> > As an end-user, I have personally stayed away from the increasingly
> > complex scheme for remotes waiting for it to settle, and stuck with
> > the old-styled .git/branches stuff which is slam-dunk simple and it
> > just works.
>
> It does work, and I think it's nice in many ways. It was certainly a good
> way to prototype things.
>
> At the same time, especially with moving things more to C (or almost any
> other language, for that matter - shell is really pretty special in making
> it _easier_ to have things in individual files), it's in many ways nicer
> to have a more structured representation that has a nice fixed interface
> and a library and known access methods behind it.

But it is a bit of a loss for perl/shell porcelains, and for users
that abuse the contents of .git directly on a regular basis...

there's nothing to stop us from having a structured representation of
what's in .git/branches/

> And I'm personally actually pretty fed up with the .git/branches/ and
> .git/remotes/ thing, partly because I can never remember which file is
> which. I had to look at the code of git-parse-remote.sh to remind me

Agreed, it's a mess, but I suspect it's still there to support cogito.
In keeping with the 'talk code' ethos, I'll work on adding support for
.git/remotes in cogito.

> And if we truly have separate files, we should go all the way, and have
> the good old "one file, one value" rule.

What about one semantics, one file? So far we have had 3 semantics:
git config, remotes, refs. And git config has been mostly
project-indepentent. In fact, I have been copying it across my
checkouts of different, unrelated projects. You just don't do that
with remotes or refs.

cheers,


martin
