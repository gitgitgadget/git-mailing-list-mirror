From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] branch: add --unset-upstream option
Date: Mon, 27 Aug 2012 11:01:26 -0700
Message-ID: <7vy5l0qknd.fsf@alter.siamese.dyndns.org>
References: <1345470460-28734-1-git-send-email-cmn@elego.de>
 <1345470460-28734-3-git-send-email-cmn@elego.de>
 <7vpq6h2tmk.fsf@alter.siamese.dyndns.org> <87a9xgnsxx.fsf@centaur.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: cmn@elego.de (Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto)
X-From: git-owner@vger.kernel.org Mon Aug 27 20:01:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T63d2-0001cE-2f
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 20:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439Ab2H0SB3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Aug 2012 14:01:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38188 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750825Ab2H0SB2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Aug 2012 14:01:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40B777A75;
	Mon, 27 Aug 2012 14:01:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=NBdxEOq/dPCJ
	gECdT+44Da2DJsI=; b=haKPk23xCMh7Nazl9Mx+Vp070mD2lX4SEpfnC5JJupTg
	+w2v3+kFkjZFdZhR9+tKAzTG+ZXxxDAZF10vfLG9I+xVI8lJ6UXXhdElKfTGlPqP
	iJYfyRwBT3jNJDVIrKYF1wlrxCUzujSeC4JpZId+2FzV+6WB2Vkwio8llOmi4w4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=PTPkOd
	dMm/fM5EoJTgFbxOvpnn4dJgVRH8G/sWvOilQUWOZvjk7Vmgmf9wT9bdAfWAOmF5
	+/ACG2aFeB96ysiuHg2IZn26ywjMAGvN51F4Q2gaUKzIDM6vmcFfpm41PcSUqjsy
	Cp6IHwSLMf+xQ728eUB5Iuh3vcJl9ld7WBw7U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D7E47A74;
	Mon, 27 Aug 2012 14:01:28 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8787E7A73; Mon, 27 Aug 2012
 14:01:27 -0400 (EDT)
In-Reply-To: <87a9xgnsxx.fsf@centaur.cmartin.tk> ("Carlos =?utf-8?Q?Mart?=
 =?utf-8?Q?=C3=ADn?= Nieto"'s message of "Mon, 27 Aug 2012 19:30:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 38F8C532-F071-11E1-934D-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204362>

cmn@elego.de (Carlos Mart=C3=ADn Nieto) writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>>
>>> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
>>> index e9019ac..93e5d6e 100755
>>> --- a/t/t3200-branch.sh
>>> +++ b/t/t3200-branch.sh
>>> @@ -383,6 +383,22 @@ test_expect_success 'use --set-upstream-to mod=
ify a particular branch' \
>>>       test "$(git config branch.my13.remote)" =3D "." &&
>>>       test "$(git config branch.my13.merge)" =3D "refs/heads/master=
"'
>>> =20
>>> +test_expect_success 'test --unset-upstream on HEAD' \
>>> +    'git branch my14
>>> +     test_config branch.master.remote foo &&
>>> +     test_config branch.master.merge foo &&
>>> +     git branch --set-upstream-to my14 &&
>>> +     git branch --unset-upstream &&
>>> +     test_must_fail git config branch.master.remote &&
>>> +     test_must_fail git config branch.master.merge'
>>> +
>>> +test_expect_success 'test --unset-upstream on a particular branch'=
 \
>>> +    'git branch my15
>>> +     git branch --set-upstream-to master my14 &&
>>> +     git branch --unset-upstream my14 &&
>>> +     test_must_fail git config branch.my14.remote &&
>>> +     test_must_fail git config branch.my14.merge'
>>> +
>>
>> What should happen when you say "--unset-upstream" on a branch B
>> that does not have B@{upstream}?  Should it fail?  Should it be
>> silently ignored?  Is it undefined that we do not want to test?
>
> I'd say it should be ignored, as the end result we want is for there =
to
> be no upstream information. What we do underneath is remove a couple =
of
> config options, wich doesn't fail if they didn't insist in the first
> place.

I am not sure about that reasoning.

    $ git config --unset core.nosuchvariable ; echo $?
    5

looks like a failure to me.

More importantly, wouldn't we want to catch typo in

	git branch --unset-upstream mext

which admittedly should come from a different codepath (I do not
think your patch checks if "mext" branch exists before going ahead
to the config--unset dance)?
