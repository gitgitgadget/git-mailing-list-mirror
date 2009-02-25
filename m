From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git push
Date: Tue, 24 Feb 2009 23:44:44 -0800
Message-ID: <7v4oyjc64z.fsf@gitster.siamese.dyndns.org>
References: <43d8ce650902242238s7ab4c851p9c820c96b67aa62b@mail.gmail.com>
 <7vskm3c84t.fsf@gitster.siamese.dyndns.org>
 <43d8ce650902242309nef12bd9j9088170b18cc8d4e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 08:46:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcETI-0002ty-VF
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 08:46:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755768AbZBYHox convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Feb 2009 02:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755707AbZBYHox
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 02:44:53 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42747 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755355AbZBYHow convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Feb 2009 02:44:52 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B71BB9D256;
	Wed, 25 Feb 2009 02:44:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 79AFF9D254; Wed,
 25 Feb 2009 02:44:47 -0500 (EST)
In-Reply-To: <43d8ce650902242309nef12bd9j9088170b18cc8d4e@mail.gmail.com>
 (John Tapsell's message of "Wed, 25 Feb 2009 07:09:42 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2ECD6C7C-0310-11DE-8384-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111383>

John Tapsell <johnflux@gmail.com> writes:

> 2009/2/25 Junio C Hamano <gitster@pobox.com>:
>
>> Having an easy way to ask to push only one branch (typically the cur=
rently
>> checked-out one) is a good thing. =C2=A0You can obviously say "git p=
ush origin
>> master" (or whatever branch you are on). =C2=A0We also added "git pu=
sh origin
>> HEAD". =C2=A0I thought we even added "git push HEAD" or "git push --=
current",
>> but I may be mistaken.
>>
>> But if you are talking about changing the default when "git push" is=
 run
>> without any parameter, I have to say it is a terrible idea, for two
>> reasons, and one is too obvious to state so I wouldn't repeat it and=
 talk
>> only about the other one.
>
> Presumably the obvious is that it might be confusing to existing
> users?  Perhaps, but it doesn't cause any damage.  It's moving to a
> 'safer' default.

No, it is not merely confusing but is outright dangerous to people who
expect the "matching refs" behaviour.  It is not safer at all.

=46or example, I almost always have some topic branch checked out and
working on changes that are still not in any of my integration branches=
=2E
The workflow is to first finish topics to satisfaction, merge the ones
that are ready into their respective integration branches, and in other
work trees (created by contrib/workdir/git-new-workdir) run the whole
build and test cycle for them in the background.  While waiting for the=
m
to build and verified, the repository I primarily work in will have a
checkout of some other uncooked topic branch that I have no intention t=
o
push out yet because I am still working on it.  After a while, the
background build and test will complete and all integration branches pr=
ove
themselves to be ready to be pushed out, and I can say "git push", full=
y
expecting that the "matching refs" behaviour will push out the integrat=
ion
branches and nothing else, because they are the only ones I have on the
public side for people (either git or day-job) to look at.  I would nev=
er
want "push current branch" to send the uncooked topic branch, which I
would never want to have on the other side even if it is fully cooked.

Even when I am on 'master', when I push things out, I do not want to he=
ar
from people that I have been forgetting to push out integration branche=
s
other than 'master' only because you suddenly changed the default under
me after a few days.

Please don't talk about changing the default without thinking the
ramifications through.

>> I've noticed that people who ask for such a default tend to push too=
 often
>> and worse they tend to push before they have their act together. =C2=
=A0Surely
>> their other branches may not be ready, but it is likely their curren=
t
>> branch isn't either ;-)
>
> You're against making push affect only the current branch in order to
> punish people who push too often?  Okaaay..

"Too often" is not a problem by itself per-se, but "still broken"
certainly is, and "not thought through" also is to a certain degree.  Y=
ou
often see people commit and push out an early part of a series, and the=
n
later regret that they realize the approach in these initial segment do=
es
not pan out and another avenue was much better, but it is too late to t=
ake
them back and rebase.

And there unfortunately is a correlation between "too often" and the ot=
her
two.  Not very strong correlation with "still broken", but moderately
strong correlation with "not thought through".

And this is not about punishing.  It is about getting into a different
mindset.  Unlike CVS/SVN, committing and publishing can be made into
different phases with git, and not pushing too early allows you produce=
 a
lot better results.  "I want to push only this branch" is often (not
always, but "often" stands with strong correlation) a sign that other
things are not ready, and by definition you couldn't have thought throu=
gh
interactions between what you _think_ is ready (i.e. the current branch=
)
and the other ones that are not ready.  In other words, it is about
encouraging people to think things through before publishing.

>> If you shoot for the least damage for such people, the sanest defaul=
t for
>> "git push" would be to do nothing. =C2=A0You *always* say what to pu=
sh where,
>> then there is no risk of pushing something you did not intend to. =C2=
=A0Perhaps
>> "push.default =3D never" configuration may not be such a bad idea?
>
> That wouldn't be a terrible idea, although perhaps a bit strange.

I would say that is the sanest default, and I often wish people in the =
git
training industry never teach "git push" without $remote and $refs
parameter to new people until they understand what they are doing.

You can add words other than 'never' to the repertoire, such as 'curren=
t',
or 'matching'.  I think the configuration actually should be
"remote.<name>.push", not "push.default", though.

Oh, and the value 'current' can be spelled as 'HEAD' already there.
