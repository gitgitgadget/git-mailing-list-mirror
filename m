From: Wincent Colaiuta <win@wincent.com>
Subject: Re: how to create v2 patch
Date: Fri, 7 Dec 2007 09:11:56 +0100
Message-ID: <71AAB890-A1BC-49AA-9695-9701356DB514@wincent.com>
References: <47515693.9070405@imap.cc> <47515EF3.8010507@obry.net> <20071201134321.GA10997@glandium.org> <475855D6.201@imap.cc>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Hommey <mh@glandium.org>, Pascal Obry <pascal@obry.net>,
	git@vger.kernel.org
To: Tilman Schmidt <tilman@imap.cc>
X-From: git-owner@vger.kernel.org Fri Dec 07 09:12:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0YK1-000416-9Z
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 09:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbXLGIMM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Dec 2007 03:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbXLGIML
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 03:12:11 -0500
Received: from wincent.com ([72.3.236.74]:41311 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750940AbXLGIMK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Dec 2007 03:12:10 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lB78BvC6007200;
	Fri, 7 Dec 2007 02:11:58 -0600
In-Reply-To: <475855D6.201@imap.cc>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67396>

El 6/12/2007, a las 21:04, Tilman Schmidt escribi=F3:

> Am 01.12.2007 14:43 schrieb Mike Hommey:
>> On Sat, Dec 01, 2007 at 02:17:39PM +0100, Pascal Obry wrote:
>>> Tilman Schmidt a =E9crit :
>>>> I have produced a patch, submitted it to LKML, received a few
>>>> comments, committed appropriate changes to my local git tree,
>>>> and now want to submit a revised patch. How do I do that?
>>>> If I just run git-format-patch again, it produces my original
>>>> patch plus a second one containing my updates, but what I need
>>>> is a single new patch replacing the first one.
>>> Can't you merge both of your changes in your local repository? I =20
>>> would
>>> do that with an interactive rebase.
>>
>> Or just git commit --amend when committing.
>
> Hmm. But wouldn't each of these approaches lead to my original
> commit being removed from my git repository?

Not immediately, but eventually. Let's say you have a history like this=
:

A--B--C--D

And you amend commit D to become D':

A--B--C--D'
        \
         D

You effectively have two "branches" now, but one of them (the original =
=20
D) is unreferenced and will eventually be garbage collected. In other =20
words, your ongoing development will look like this:

A--B--C--D'-E--F--G
        \
         D

At this point the only thing which references commit D will be your =20
reflog, and with default settings that means that the commit will hang =
=20
around for at least 90 more days before being pruned during garbage =20
collection.

> And isn't removing
> commits that have already been published strongly discouraged?

Yes, normally that statement is true (because someone else may have =20
based work on top of "D" and if you delete "D" then you just pulled =20
the rug out from under them). But as others have pointed out, posting =20
a PATCH to a mailing list isn't the same thing as "publishing a =20
commit", so I won't repeat what's already been explained.

If, however, you really had *published* the commit (ie. pushed it out =20
to an accessible repository) then you'd want to use "git revert" =20
rather than "git commit --amend".

A--B--C--D--D'--E--F

Reverting doesn't delete any commits at all; instead it introduces a =20
new commit (D') which undoes the change introduced in D. So you're =20
undoing the *effect* of D without actually "undoing" the fact that you =
=20
committed and published it.

Cheers,
Wincent
