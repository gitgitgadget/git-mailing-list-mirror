From: Wincent Colaiuta <win@wincent.com>
Subject: Re: FEATURE suggestion git commit --amend <ref>
Date: Fri, 27 Feb 2009 10:55:57 +0100
Message-ID: <DE8E2AF9-9BE6-4FB9-84EF-650EDAA9881B@wincent.com>
References: <81bfc67a0902262345i63386076rbcf6d71ed88c29ac@mail.gmail.com> <fabb9a1e0902270037s3355e8e3m1533f86fd3ce2e8f@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Caleb Cushing <xenoterracide@gmail.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 10:57:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LczTN-0004mC-Dy
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 10:57:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754885AbZB0J4I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Feb 2009 04:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754858AbZB0J4I
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 04:56:08 -0500
Received: from wincent1.inetu.net ([209.235.192.161]:40367 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753573AbZB0J4G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Feb 2009 04:56:06 -0500
Received: from cuzco.lan (139.pool85-53-16.dynamic.orange.es [85.53.16.139])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n1R9tw70008131
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 27 Feb 2009 04:56:00 -0500
In-Reply-To: <fabb9a1e0902270037s3355e8e3m1533f86fd3ce2e8f@mail.gmail.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111654>

El 27/2/2009, a las 9:37, Sverre Rabbelier escribi=F3:

> Heya,
>
> On Fri, Feb 27, 2009 at 08:45, Caleb Cushing =20
> <xenoterracide@gmail.com> wrote:
>> git rebase -i seems a little more tedious/unfriendly than I'd like i=
f
>> all I want to do is edit HEAD~2 (assuming no merges) it's a bit of a
>> pain to do a rebase -i and then pick which patches to edit. might be
>> nice to be able to do stuff like git commit --amend <ref> and have
>> that call rebase  (as I think not rebasing is impossible?) with edit
>> only on the ref I picked.
>
> Ah, yes, I would like this feature as well. But this could probably b=
e
> solved with a custom editor script that does a simple sed 's/pick
> $TARGET/edit $TARGET/'?

I'm not sure if this proposed feature would actually be very convenient=
=2E

Think about the way "git commit --amend" currently works: it just =20
takes the current index and uses it to create a new commit, replacing =20
the current HEAD commit, and of course gives the user the opportunity =20
to edit the commit message.

If you want to "git commit --amend HEAD~2" then how will you prepare =20
your index in a convenient fashion?

The way "rebase -i" works is to actually stop on the "edit" commit so =20
that you have an opportunity to tweak things in the index (or even =20
create a _series_ of new commits). But giving the user a chance to =20
edit _after_ doing "git commit --amend HEAD~2" would be a little =20
surprising seeing as "git commit" generally means "create a commit =20
object right now". And the user would then have to indicate that he/=20
she was ready to go ahead and actually create the commit; and so you'd =
=20
need an ugly "git commit --continue" or similar to indicate that =20
you're done tweaking.

Alternatively, you could say you don't care about the index and you =20
only want to edit the commit message. Then you'd be breaking with the =20
existing semantics of "git commit --amend" which _does_ pay attention =20
to the state of the index.

Basically, I think that the easiest workflow for doing what you want =20
to do is actually just to use "git rebase -i". And if you have a very =20
specific special-case workflow that you want to automate then you =20
could indeed make a custom editor script, but it would have such a =20
narrow, specialized use that I'd question the value of it.

Cheers,
Wincent
