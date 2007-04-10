From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] git-archive: document CWD effect
Date: Tue, 10 Apr 2007 16:24:34 +0200
Message-ID: <461B9E22.5020102@lsrfire.ath.cx>
References: <esc64d$d2u$1@sea.gmane.org> <7virc68nc1.fsf@assigned-by-dhcp.cox.net> <461A55FB.6070600@lsrfire.ath.cx> <200704092137.22781.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Nick Williams <njw@jarb.freeserve.co.uk>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 16:33:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbHHB-0005aN-Oo
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 16:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030608AbXDJOYu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 10 Apr 2007 10:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030636AbXDJOYu
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 10:24:50 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:50542
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030608AbXDJOYs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Apr 2007 10:24:48 -0400
Received: from [10.0.1.201] (p508e6b24.dip.t-dialin.net [80.142.107.36])
	by neapel230.server4you.de (Postfix) with ESMTP id 99D8522003;
	Tue, 10 Apr 2007 16:24:46 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
In-Reply-To: <200704092137.22781.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44125>

Andy Parkins schrieb:
> On Monday 2007, April 09, Ren=C3=A9 Scharfe wrote:
>=20
>> I agree with (1) and (3), meaning that we are free to change the
>> behaviour.  I don't agree with (2), though.  I'd find it strange if
>> changing the working directory wouldn't change the archive contents.
>>
>> We should keep consistency with the rest of git here.  Since
>> git-archive is just a fancy git-ls-tree, I think we should mirror it=
s
>> behaviour with respect to the working directory.  (Which is what the
>> current code does. Modulo bugs, of course.)
>=20
> I don't agree with the supposition that git-archive is a fancy=20
> git-ls-tree.  If it were, then you'd be right.  It's not though.  It'=
s=20
> more like a git-read-tree or git-checkout-index; those both don't car=
e=20
> where you are in the working tree.
>
> Argument 1)
> git-archive should have nothing to do with a working tree in fact; it=
's=20
> perfectly reasonable to expect that it would work in a bare repositor=
y=20
> in fact - that's almost the definition of a command that shouldn't be=
=20
> working directory aware.

It works in bare repositories, as does git-ls-tree.  There the question
of what to do in subdirectories doesn't even come up, because there are
none. :)

But just because it works in situations where there are no
subdirectories that doesn't mean that it has to ignore them in other
situations.

> Argument 2)
> Consider the --remote option.  What "working path" should be relevant=
=20
> when "--remote" is passed?  For consistency, git-archive should alway=
s=20
> refer to the repository root.

'git-archive --remote' passes the options to the remote system, ignorin=
g
the local working directory.  What matters in this case is the working
directory on the remote end, which is the repository's root.

But just because there is currently no way (that I know of) to change
the working directory on the remote end that doesn't mean the command
needs to ignore the working directory when operating locally, where it
can be changed easily.

> Argument 3)
> git-archive is similar to other VCS's "export" command; and for those=
=20
> the export command in it's default form will work without a local=20
> checkout and they export from the repository root.

OK, I haven't seen other tools, so I can't really comment on them.
git-archive _does_ work without a checkout, though.

> Argument 4)
> What if the repository has multiple root commits, similar to git's ht=
ml=20
> and todo branches.  Now, use git-archive and reference one of those=20
> commits.  The working directory you're in now has no relevance at all=
=20
> to the commit your targeting - it need not even exist.  The same=20
> problem exists of course if you are now in a directory that didn't=20
> exist in the past.

Yes, that's true; git-archive will tell you that your current working
directory is untracked in that case.  (git-ls-tree in that case lists:
nothing.)  But if you want to create a full archive you need to be in
the repository's root directory anyway, so this is no new issue.

What it comes down to is the decision between consistency with third
party export tools or with its (implementation-wise) brother
git-ls-tree, between the convenience of not needing to care where in th=
e
repository you are or the convenience of being able to let the working
directory determine the file set that ends up in the archive.

I'd rather keep it consistent from a technical, implementation point of
view and not care too much about other export tools, and I like my
working directory to influence which files I'm working with.  Working
directory sensitivity is just another input method, like parameters and
environment variables.  I still see no benefit in removing it.  But
perhaps I'm in a rut, unable to see the difficulties with this way to w=
ork.

Re(not getting it ;-)n=C3=A9
