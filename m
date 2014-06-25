From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG: git request-pull broken for plain branches
Date: Wed, 25 Jun 2014 13:41:23 -0700
Message-ID: <xmqqoaxg90y4.fsf@gitster.dls.corp.google.com>
References: <20140625095535.GA27365@pengutronix.de>
	<CA+55aFwZb7tT7xb7y2XJpzcmrxB=Rf--bjz5XbBcxC-7MMm9eg@mail.gmail.com>
	<20140625132131.GO14781@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>, kernel@pengutronix.de
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Jun 25 22:41:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wzu0f-0007cV-Fi
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 22:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755212AbaFYUld convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Jun 2014 16:41:33 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62268 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754214AbaFYUld convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Jun 2014 16:41:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 92D42212EC;
	Wed, 25 Jun 2014 16:41:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=mEERHcdEINAR
	/n0+LLava62UUTQ=; b=ruDLoRfrsZgyly27Z2iPC9ZmCPm92k09fDZZPb339D2Z
	fh5fFzzjXDN+Q/6DVTygpr7Z3nZtgiHjWvcTvN2r2VwJd3peLy8PTyW5T7y8tOvD
	HCc3AXnbUyLqs1Gx4nDRaqJG5bXYARZwIXRyA+b3Obmp+V9Mg99mqMoYcWxY4to=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=icEqKq
	EqvKHTMHmIjNudD2ks+Ewj06YSuL2hrCdYlHp5j/tP6ny4wTPUFqySB+6/ykbVav
	cD6msaozuDxhvQTkXRy01RbYwGLCPyreSi/PRl8Pny9Bz6rTuCGUWKm+fyTrb4Aj
	gWSbzKf3Qk0dsR6MltFjyg57QVxlfXVxrQ8lk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 877A1212EB;
	Wed, 25 Jun 2014 16:41:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 225AA212E5;
	Wed, 25 Jun 2014 16:41:20 -0400 (EDT)
In-Reply-To: <20140625132131.GO14781@pengutronix.de> ("Uwe =?utf-8?Q?Klein?=
 =?utf-8?Q?e-K=C3=B6nig=22's?=
	message of "Wed, 25 Jun 2014 15:21:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 10217924-FCA9-11E3-96FB-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252459>

Uwe Kleine-K=C3=B6nig  <u.kleine-koenig@pengutronix.de> writes:

> Hello Linus,
>
> On Wed, Jun 25, 2014 at 05:05:51AM -0700, Linus Torvalds wrote:
>> On Wed, Jun 25, 2014 at 2:55 AM, Uwe Kleine-K=C3=B6nig
>> <u.kleine-koenig@pengutronix.de> wrote:
>> >
>> >         $ git rev-parse HEAD
>> >         9e065e4a5a58308f1a0da4bb80b830929dfa90b3
>> >         $ git ls-remote origin | grep 9e065e4a5a58308f1a0da4bb80b8=
30929dfa90b3
>> >         9e065e4a5a58308f1a0da4bb80b830929dfa90b3        refs/heads=
/ukl/for-mainline
>> >         $ git request-pull origin/master origin HEAD > /dev/null
>> >         warn: No match for commit 9e065e4a5a58308f1a0da4bb80b83092=
9dfa90b3 found at origin
>> >         warn: Are you sure you pushed 'HEAD' there?
>>=20
>> Notice how "HEAD" does not match.
>>=20
>> The error message is perhaps misleading. It's not enough to match th=
e
>> commit. You need to match the branch name too. git used to guess the
>> branch name (from the commit), and it often guessed wrongly. So now
>> they need to match.
>>=20
>> So you should do
>>=20
>>     git request-pull origin/master origin ukl/for-mainline
>>=20
>> to let request-pull know that you're requesting a pull for "ukl/for-=
mainline".

Or

	git request-pull origin/master origin HEAD:ukl/for-mainline


I am not Linus, and do not speak for him, but FWIW here are some
comments on the ideas.

> I liked git guessing the branch name, maybe we can teach it to guess =
a
> bit better than it did before 2.0? Something like:
>
>  - if there is a unique match on the remote side, use it.

I am on the fence but slightly leaning to the negative side on this
one.  The branch/ref the object was took from when "git pull" is run
does matter, because the name is recorded in the merge summary, so
we cannot say "There are refs that happen to point at the object you
wanted to be pulled, so we'll pick one of them let the integrator
pull from that ref we randomly chose" is not something we would
want.  "If there is a unique one, that must be the one the user has
meant; there is nothing else possible" feels like a strong argument,
and I was actually contemplating about doing an enhancement on top
of Linus's original myself along that line, back when we queued that
patch exactly for that reason.

But a counter-argument, in the context of Linus's change in question
being primarily to avoid end-user mistakes resulting in a bogus
request, is that the ref on the remote that happens to match the
object but is different from what the user named may be a totally
unrelated branch before the user actually has pushed the set of
changes the request is going to ask to be pulled.  The mistake that
this extra strictness tries to avoid is to compose request-pull
before pushing what to be pulled and then forgetting to push.

>  - if there are >=3D 1 match on the remote side and exactly one match=
es
>    what I specified as <end>, use it.

The original change by Linus being about avoiding mistakes by
requiring the user to name what to be pulled, i.e. <end>, this point
of "other refs also happen to point at the same object" is made
irrelevant---if <end> does have the object the user named to be
pulled, that should be used regardless of where other refs point at.

>  - if there are >=3D 1 match on the remote side and exactly one of th=
em is
>    a tag, use the tag
>
>  - if there are two matches on the remote side, and one is "HEAD",
>    pick the other one.

Assuming that <end> does not match the object in these two cases
(otherwise your second condition would have caught it), they share
the same potential objection as the first one.

I dunno.
