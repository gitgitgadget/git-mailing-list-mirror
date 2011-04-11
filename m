From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: What's cooking in git.git (Apr 2011, #02; Wed, 6)
Date: Mon, 11 Apr 2011 19:55:38 +0200
Message-ID: <4DA3409A.9090206@web.de>
References: <7v8vvni1t3.fsf@alter.siamese.dyndns.org>	<BANLkTinTVinnDLPnHGoF9DY97ky_MFiLAQ@mail.gmail.com>	<4DA23551.4040304@web.de> <BANLkTinRRJAvMrbUUwGTcgK+9-Bh5QATcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 19:55:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9LL1-0008Aa-RB
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 19:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754845Ab1DKRzn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Apr 2011 13:55:43 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:55683 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754775Ab1DKRzm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 13:55:42 -0400
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate01.web.de (Postfix) with ESMTP id 2874E18C0F126;
	Mon, 11 Apr 2011 19:55:41 +0200 (CEST)
Received: from [93.240.123.81] (helo=[192.168.178.43])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Q9LKv-0005Zw-00; Mon, 11 Apr 2011 19:55:41 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.15) Gecko/20110303 Lightning/1.0b2 Thunderbird/3.1.9
In-Reply-To: <BANLkTinRRJAvMrbUUwGTcgK+9-Bh5QATcA@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/6pbikpOU8YpgqKT1aDoDkz90k3nhC8cIkKg7J
	mwlB3xTAS35iLieziFQD85I5iBqO+lKfznNCG9FAxWY9HcqDLa
	/9VIW15CBCQDBWQ/epZw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171339>

Am 11.04.2011 11:00, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> On Mon, Apr 11, 2011 at 00:55, Jens Lehmann <Jens.Lehmann@web.de> wro=
te:
>> Am 10.04.2011 20:52, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>> On Wed, Apr 6, 2011 at 22:04, Junio C Hamano <gitster@pobox.com> wr=
ote:
>>>
>>>> * jl/submodule-fetch-on-demand (2011-03-06) 7 commits
>>>>  (merged to 'next' on 2011-03-20 at a5e452d)
>>>>  + fetch/pull: Describe --recurse-submodule restrictions in the BU=
GS section
>>>>  + submodule update: Don't fetch when the submodule commit is alre=
ady present
>>>>  + fetch/pull: Don't recurse into a submodule when commits are alr=
eady present
>>>>  + Submodules: Add 'on-demand' value for the 'fetchRecurseSubmodul=
e' option
>>>>  + config: teach the fetch.recurseSubmodules option the 'on-demand=
' value
>>>>  + fetch/pull: Add the 'on-demand' value to the --recurse-submodul=
es option
>>>>  + fetch/pull: recurse into submodules when necessary
>>>
>>> This series needs to be fixed to not fail tests with GETTEXT_POISON=
=3DYesPlease.
>>
>> Maybe something like this? Junio, do you want me to squash the chang=
es in
>> the patch series and resend it or should I send a new commit?

Ok, as that series already hit master I'll hack up a new commit.

> Sorry about the short mail yesterday, I had to take care of something=
=2E

Same here :-)

> Anyway, that looks like it'll work, but the preferred way of doing it
> is like it's done at the bottom of t3700-add.sh. I.e.:
>=20
> test_expect_success 'git add --dry-run --ignore-missing of
> non-existing file' '
>     test_must_fail git add --dry-run --ignore-missing track-this
> ignored-file >actual.out 2>actual.err
> '
>=20
> test_expect_success C_LOCALE_OUTPUT 'git add --dry-run
> --ignore-missing of non-existing file output' '
>     test_cmp expect.out actual.out &&
>     test_cmp expect.err actual.err
> '
>=20
> That is, split up each test into a test that tests the functionality
> (i.e. exit codes) and one that tests the output.
>=20
> That way we make sure that only things dependent on C locale output
> are skipped under non-C locales.

Thanks for explaining, that makes sense. Jonathan mentioned some time a=
go
that t5526 would benefit from testing the functionality rather than the
output like it does now, so rewriting that test is on my maintenance li=
st
anyway. I'll have to find a locale independent way to check if the
submodule paths are printed correctly, but I'll see if I can chop off t=
he
language specific parts of the output before doing the compare.

> Sometimes that's hard, in which case it's fine to just skip the entir=
e thing.

That shouldn't be necessary for t5526, I'll tackle that when I find som=
e
time. The question is: Do we need a commit now adding the prerequisite =
as
a band aid fix to restore the ability to successfully run the test suit=
e
with GETTEXT_POISON=3DYesPlease, or do we have some time so I can rewri=
te
t5526 properly to not depend on the language anymore?
