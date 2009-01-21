From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: how to keeping track of cherry-pick?
Date: Wed, 21 Jan 2009 10:13:12 +0100
Message-ID: <4976E728.5030302@drmicha.warpmail.net>
References: <497663E4.4000302@telenor.com> <7vfxjdjvk8.fsf@gitster.siamese.dyndns.org> <4976E059.6000404@telenor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?S251dCBPbGF2IELDuGhtZXI=?= <knut-olav.bohmer@telenor.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 10:14:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPZAX-0006Kj-I8
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 10:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756299AbZAUJNT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jan 2009 04:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756151AbZAUJNT
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 04:13:19 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33396 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755514AbZAUJNQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jan 2009 04:13:16 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 76E42249716;
	Wed, 21 Jan 2009 04:13:15 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 21 Jan 2009 04:13:15 -0500
X-Sasl-enc: h7CWblJRhrhTyrcd0MEm3GIPi7A6zFT8ZpB7vhGWkSYz 1232529195
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A80A53ABA1;
	Wed, 21 Jan 2009 04:13:14 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
In-Reply-To: <4976E059.6000404@telenor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106582>

Knut Olav B=C3=B8hmer venit, vidit, dixit 21.01.2009 09:44:
> Junio C Hamano wrote:
>> Knut Olav B=C3=B8hmer <knut-olav.bohmer@telenor.com> writes:
>>
>>> svnmerge.py can give us a list of revisions available for merging. =
The
>>> result is similar to "git log --chery-pick master..dev" The differe=
nce
>>> is that svnmerge.py operates on revision-numbers, and --chery-pick =
looks
>>> at the diffs. The result of that is that when we get a conflict whe=
n a
>>> patch is cherry-picked, it will still show up as "available" when I=
 run
>>> "git log --cherry-pick master..dev"
>> I think you are looking at it a wrong way.
>>
>> Because subversion (at least the older one) does not keep track of m=
erges,
>> you had to track cherry-picks.  But cherry-pick is not how you usual=
ly do
>> things in git.  You keep many topic branches with different doneness=
, and
>> you merge well-cooked ones to the more stable integration branch whi=
le
>> leaving others still cooking.  So what you want to know is not cherr=
y-pick
>> status, but merge status.
>=20
>=20
> I was afraid I would get this answer. I know that you change your
> workflow when you migrate to git, but I was looking for a way to reso=
lve
> the situation we are in, due to our old vcs.

In the transition phase, while you still have to work off your
un-gittish svn feature branches, you can mimick svnmerge.py's blocking
at least somewhat: If you merge that branch (or a commit on that branch=
,
i.e. that branch up to that commit) using "git merge -s ours" then git
records a merge but does not change your base branch. This effectively
blocks all commits up that one from being merged in subsequent merges:
They're recorded as merged, but they are not "applied".

The disadvantage is that you have to go through your svn feature branch
sequentially, merge what you want to keep, merge -s ours what you want
to block. You can't easily "unblock" later because that would mean
reverting a merge.

=46or sure, the better option is to rip your svn feature branch apart i=
nto
git feature branches as Junio suggests, maybe using one of the patch
queue like "extensions" to git.

Michael
