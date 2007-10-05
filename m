From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Question about "git commit -a"
Date: Fri, 5 Oct 2007 12:48:11 +0200
Message-ID: <227149BF-1220-43F2-8B0B-B7E9FCA002B1@wincent.com>
References: <4d8e3fd30710040838t48bb590erbd90a8c4a1c6e932@mail.gmail.com> <545CB3B2-96B3-4853-9397-B42F4F268A15@wincent.com> <fcaeb9bf0710041333l636b2c1fn4d8f3298000127c7@mail.gmail.com> <Pine.LNX.4.64.0710042209410.4174@racer.site> <4d8e3fd30710050139j45a5a924t5c048994e3457c5f@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Nguyen Thai Ngoc Duy" <pclouds@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 12:48:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdkjQ-0003vc-CB
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 12:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252AbXJEKsY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Oct 2007 06:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752107AbXJEKsY
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 06:48:24 -0400
Received: from wincent.com ([72.3.236.74]:53331 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752081AbXJEKsX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Oct 2007 06:48:23 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l95AmIKS008026;
	Fri, 5 Oct 2007 05:48:19 -0500
In-Reply-To: <4d8e3fd30710050139j45a5a924t5c048994e3457c5f@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60068>

El 5/10/2007, a las 10:39, Paolo Ciarrocchi escribi=F3:

> So you are used to do something like (please correct me if I'm wrong)=
:
> - modify A
> - modify B
> - modify C
> - modify D
> - modify E
>
> $ git A B E
> $ git add A B E (A, B and E are now in the staging area)
> $ git commit -m "I just modified A,B and E"
> $ git C D
> $ git add C D (C and D are now in the staging area)
> $ git commit -m "I just modified C and D"

The conceptual shift is that in Git your index and not your working =20
directory is your staging area, unlike (most/all?) other SCMs. If you =20
fire up gitk and look at the development history of Git itself you'll =20
see that it's one of the "cleanest" out there, and as you learn Git =20
you learn about the various tools and tricks that it provides that =20
makes it easier for a developer community to produce such a clean =20
history; the index as a staging area is one of the key factors.

The basic workflow is:

   # work on a single change
   edit A
   git add A
   edit B
   git add B

   # see unrelated thing that needs to be fixed, but don't add =20
(stage) it yet
   edit C

   # commit first change, then second one
   git commit -s
   git commit -s C

This is just one example of how having a staging area that you can =20
control independently of your working tree can help you. There are =20
other possible workflows and you discover them through use, but they =20
all share the basic idea that you use the staging area to provide you =20
with better control.

Sometimes you're trying to work on a single thing and you see a =20
change within a single file that isn't related. In that case you have =20
an even finer level of granularity available and can use "git add --=20
interactive" to add only specific hunks.

=46inally, closely related to this idea of maintaining a clean history =
=20
is the newly-added and wonderful "git stash". If you have a =20
relatively complicated work in progress already half-staged in the =20
index and you see something else relatively complicated that you want =20
to attend to straight away then you can easily switch to the second =20
task, commit it, and go back to the first task, thus keeping your =20
development history nice and clean. This is a beautiful example of =20
your SCM facilitating your work and making it easy rather than =20
forcing you to jump through hoops. See the git-stash man page for =20
more details.

I think all of this is incredibly powerful useful stuff, and all of =20
it comes at a very low cost; it's easy to learn and doesn't require =20
you to do any magical and complex history rewriting in order to get a =20
nice clean history.

And on the subject of staging areas, thanks to "git commit --amend" =20
you can even use the last commit as a kind of secondary, addditional =20
staging area, providing you haven't published that commit yet. In =20
other words, I frequently do:

   git show HEAD

Immediately after committing and if I don't like what I see I make =20
modifications as necessary and do:

   git commit --amend

Cheers,
Wincent
