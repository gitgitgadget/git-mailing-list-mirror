From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to keeping track of cherry-pick?
Date: Wed, 21 Jan 2009 01:47:19 -0800
Message-ID: <7v63k9gfdk.fsf@gitster.siamese.dyndns.org>
References: <497663E4.4000302@telenor.com>
 <7vfxjdjvk8.fsf@gitster.siamese.dyndns.org> <4976E059.6000404@telenor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Knut Olav =?utf-8?Q?B=C3=B8hmer?= <knut-olav.bohmer@telenor.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 10:48:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPZhc-0006RD-CZ
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 10:48:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754632AbZAUJr1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jan 2009 04:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754544AbZAUJr1
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 04:47:27 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62867 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753392AbZAUJr0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jan 2009 04:47:26 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D38E91CA24;
	Wed, 21 Jan 2009 04:47:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C88581CEDA; Wed,
 21 Jan 2009 04:47:21 -0500 (EST)
In-Reply-To: <4976E059.6000404@telenor.com> (Knut Olav =?utf-8?Q?B=C3=B8hm?=
 =?utf-8?Q?er's?= message of "Wed, 21 Jan 2009 09:44:09 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 81BEF472-E7A0-11DD-AF4C-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106585>

Knut Olav B=C3=B8hmer <knut-olav.bohmer@telenor.com> writes:

> Junio C Hamano wrote:
>> Knut Olav B=C3=B8hmer <knut-olav.bohmer@telenor.com> writes:
>>=20
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
>>=20
>> I think you are looking at it a wrong way.
>>=20
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
>
>
> I was afraid I would get this answer. I know that you change your
> workflow when you migrate to git, but I was looking for a way to reso=
lve
> the situation we are in, due to our old vcs.

Maybe I should rephrase the answer, then.

I had an impression that you made it sound as if svnmerge.py is a tool
only meant for a workflow of always cherry-picking, but it actually is
not.  It also enhances your SVN experience by giving something closer t=
o
proper merge tracking.  Even though you only mentioned cherry-picks and
merge blocking, if you like things offered by svnmerge.py other than th=
ese
two, you might find that git already has them natively.

When your workflow is based on a single large, unfocused, everything
mixed-in, playpen branch, plus one stable integration branch, you have =
to
cherry pick to keep the stable integration branch sane, and you need a
good tool to help you keep track of what is cherry picked and what isn'=
t
(yet).  Maybe your SCM has such a tool natively, or maybe it doesn't an=
d
needs a third party tool support (similar to users of older SVN needed =
to
use svnmerge.py for merge tracking) bolted on.

    ---A1--B1--C1--A2--A3--C2--D1--...  playpen kitchen-sink

    ---o---o---o---A1'--A2'--A3'...     stable integration

The workflow when using git is typically merge based, and git lets you
manage topic branches well and helps you merge easily by keeping track =
of
merges.

I am reading from http://www.orcaware.com/svn/wiki/Svnmerge.py while I =
am
typing this, but here is a summary:

 (1) Because merge tracking is built-in to git, you do not need "someth=
ing
     like svnmerge.py" bolted on.  If you have been using topic branche=
s
     in your established SVN-based workflow, you can keep the same
     workflow and git will do the right thing when you merge your
     branches naturally.

 (2) We didn't have need for "cherry-pick tracking" part of what
     svnmerge.py offers, because we do not do cherry-picks as often.

     You can call this shortcoming if you want, but it should be easy f=
or
     you to contribute a patch to add such a tool if you miss this part=
 of
     svnmerge.py; essentially, you need to keep a database of commit
     object names on the "playpen branch" depicted above, and
     corresponding commit objects cherry-picked from them into the
     integration branch.

 (3) We have "listing changes that are available for merging" natively,=
 as
     I've already explained in the previous message.

 (4) Bidirectional merges, merging from multiple branches, reverting
     merges, and merge commit message generation are all native feature=
s
     of "git merge".  If you have git, you already have them.  If you d=
o
     not like the merge result, you can always amend it; commit-free-ne=
ss
     is listed as if it is a feature but it does not matter here.

 (5) We do not have "merge blocking".  This falls into the same categor=
y
     as (2) above.
