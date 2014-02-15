From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: Git GSoC 2014
Date: Sat, 15 Feb 2014 13:17:50 +0100
Message-ID: <87fvnk4ljl.fsf@thomasrast.ch>
References: <20140213091037.GA28927@sigill.intra.peff.net>
	<87bnya8z6q.fsf@thomasrast.ch> <87d2iq58qk.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Feb 15 13:18:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEeCI-00022d-ES
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 13:18:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753155AbaBOMSN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Feb 2014 07:18:13 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:48425 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753118AbaBOMSE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Feb 2014 07:18:04 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 1B5BD4D658D;
	Sat, 15 Feb 2014 13:18:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id wlZ_uebjjHIf; Sat, 15 Feb 2014 13:17:51 +0100 (CET)
Received: from hexa.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 605774D64BD;
	Sat, 15 Feb 2014 13:17:51 +0100 (CET)
In-Reply-To: <87d2iq58qk.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Fri, 14 Feb 2014 10:44:35 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242187>

David Kastrup <dak@gnu.org> writes:

> Thomas Rast <tr@thomasrast.ch> writes:
>
>> Motivation: I believe that migrating to libgit2 is the better approa=
ch,
>> medium term, than rewriting everything ourselves to be nice, clean a=
nd
>> thread-safe.  I took a shot a while ago at making the pack reading c=
ode
>> thread-safe, but it's adding mess when we could simply replace it al=
l by
>> the already thread-safe libgit2 calls.  It also helps shake out
>> incompatibilities in libgit2.
>
> That would either require forking libgit2 for Git use or stop dead an=
y
> contributions to that rather central part of the git codebase from
> contributors not wanting their contributions to get reused in binary
> proprietary software.
>
> It would also mean that no serious forward-going work (like developin=
g
> new packing formats or network protocols) can be done on a pure GPLv2
> codebase any more.  So anybody insisting on contributing work under t=
he
> current Git license only would be locked out from working on signific=
ant
> parts of Git and could no longer propose changes in central parts.
>
> Now this can all be repealed by the "developing the atomic bomb does =
not
> mean that one has to use it" argument but even if one does not use it=
,
> the world with and without it are different worlds and occupy mindsha=
re
> and suggest "solutions" and "diplomacy" involving it.
>
> So this is definitely a large step towards a situation where erosion =
of
> the existing license and related parts of the community becomes more
> attractive.
>
> There is the rationale "we can always say "no" at the end".  How do y=
ou
> explain this "no" to the student who invested significant amounts of
> work into this, in a project proposed by the Git developers?
>
> This definitely should not be "we'll think about it if and when that
> project is finished" material.

Yes, all of this is true.  However, you are painting a big devil on the
wall.

=46irst, one very plausible outcome of such a project is that there is =
a
more narrowly defined interface to the object-reading component of the
git codebase, and that libgit2 can be "plugged in" at that interface
instead of the existing routines.  This would help both clean up our
code, and test libgit2 against existing git tests.

Your scenario above mostly applies if and when we really go the way of
my dream and scrap the code that is in git.  (I have similar long-term
dreams for other git components like ref storage and diffs, but that's
just me.)

Second, how many contributions would actually have been prevented by
GPLv2+LE licensing?

The only data I have on this is libgit2/git.git-authors, which records
who has consented for their _existing_ code to be relicensed.  I
consider this to be a higher barrier than contributing new code, since
there's no clear gain for the author in the relicensing.

That file is a sizeable list, and covers most contributions to
sha1_file.c lately:

  [git shortlog -sn --since=3D2.year.ago sha1_file.c, edited in the ans=
wer
  from git.git-authors]

   ok     15  Jeff King
   ok     11  Michael Haggerty
           6  Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
   ok      5  Christian Couder
   ask     5  Thomas Rast
   ok      2  Brandon Casey
           2  Heiko Voigt
           2  Pete Wyckoff
           1  Felipe Contreras
           1  Joachim Schmitz
           1  Johan Herland
   ask     1  Jonathan Nieder
           1  Ramsay Allan Jones
           1  Steven Walter
           1  Vicent Marti

  (My "ask" is because of $DAYJOB legal reasons, and in fact the
  contributions above fall under the "ok before Oct 7, 2013" remark in
  git.git-authors.)

It also includes an "ok" from Nicolas Pitre, who has been the driving
force behind packv5 development.  The only thing that makes me uneasy i=
s
that Duy is not in the list (Duy, have you been asked by libgit2 about
possible relicensing?).  Other than that, I do not see a cause for
concern.


Conversely, contributions to clean up that corner of code have not
exactly been forthcoming at a great rate in the first place.  The recen=
t
work I can recall off hand was bug fixing and the introduction of pack
bitmaps.  The only work that I know is within reach is the packv5 draft=
s
that Nicolas and Duy tossed around.

(It is an odd coincidence that this thread runs in parallel with [1].
If that gains some traction, more power to them.)


So you may disagree, and other contributors should probably comment on
their stance.  But taking the above together, I think we stand to gain
more than we would lose.


[1] http://thread.gmane.org/gmane.comp.version-control.git/241965

--=20
Thomas Rast
tr@thomasrast.ch
