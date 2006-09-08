From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Change set based shallow clone
Date: Fri, 08 Sep 2006 10:36:13 +0200
Organization: At home
Message-ID: <edra0v$42a$1@sea.gmane.org>
References: <9e4733910609071252ree73effwb06358e9a22ba965@mail.gmail.com> <20060908010112.6962.qmail@science.horizon.com> <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Sep 08 10:37:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLbrG-0008EJ-Um
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 10:37:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbWIHIgz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 8 Sep 2006 04:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbWIHIgz
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 04:36:55 -0400
Received: from main.gmane.org ([80.91.229.2]:21124 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751061AbWIHIgy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Sep 2006 04:36:54 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GLbqJ-0007yU-PM
	for git@vger.kernel.org; Fri, 08 Sep 2006 10:36:07 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Sep 2006 10:36:07 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Sep 2006 10:36:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26685>

Jon Smirl wrote:

> Here is another way to look at the shallow clone problem. The only
> public ids in a git tree are the head and tag pointers. Send these to
> the client. Now let's modify the git tools to fault the full objects
> in one by one from the server whenever a git operation needs the
> object. =A0Dangling references would point to 'not-present' objects.
>=20
> For a typical user using a model like this, how much of the Mozilla
> repository would end up being faulted into their machine? Mozilla has
> 2M objects and 250K commits in a 450MB pack. My estimate is that a
> typical user is going to touch less than 200K of the objects and mayb=
e
> less than 100K.
>=20
> Of course always faulting in full objects is wasteful. A smart scheme
> would be to try and anticipate with some read ahead and figure out
> ways to send deltas. Tools like gitk would need to only touch the
> objects needed to draw the screen and not run the full commit chain a=
t
> startup.

Yes, that is also recurring _lazy_ clone idea (or remote alternatives[*=
1*]
idea). With it's own set of difficulties, like cache management, readah=
ead
and such, and of course differentiating between not present, and presen=
t on
the remote server. And what to do when network fails... wouldn't it be =
just
easier to use networking system like Coda or InterMezzo?


[*1*] From Documentation/repository-layout.txt or
http://www.kernel.org/pub/software/scm/git/docs/repository-layout.html

You can be using `objects/info/alternates` mechanism, or
`$GIT_ALTERNATE_OBJECT_DIRECTORIES` mechanism to 'borrow'
objects from other object stores.  A repository with this kind
of incomplete object store is not suitable to be published for
use with dumb transports but otherwise is OK as long as
`objects/info/alternates` points at the right object stores
it borrows from.

[...]

objects/info/alternates::
        This file records absolute filesystem paths of alternate
        object stores that this object store borrows objects
        from, one pathname per line.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
