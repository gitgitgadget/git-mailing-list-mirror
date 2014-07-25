From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 3/5] checkout --to: no auto-detach if the ref is already
 checked out
Date: Fri, 25 Jul 2014 08:51:34 +0200
Message-ID: <53D1FE76.5080708@drmicha.warpmail.net>
References: <1406115795-24082-1-git-send-email-pclouds@gmail.com>	<1406115795-24082-4-git-send-email-pclouds@gmail.com>	<53CFBD2A.9030803@drmicha.warpmail.net>	<CACsJy8DwPM68j-=LDDbq1H_bT1gD=aLQ8x6C1qiwF79=ai14dg@mail.gmail.com> <xmqq8uni8mx4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 08:51:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAZLx-0001Fz-Pl
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 08:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758027AbaGYGvi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jul 2014 02:51:38 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58434 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753086AbaGYGvh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jul 2014 02:51:37 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by gateway1.nyi.internal (Postfix) with ESMTP id 2209321BFF
	for <git@vger.kernel.org>; Fri, 25 Jul 2014 02:51:37 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 25 Jul 2014 02:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=nNYFt/P+N8pR8VdA41PH3X
	ki1+g=; b=b5LsSdd706KBk0tJTVymVdA3qvCC4YQWeCbUm7K88q90Ycp1TNLzVy
	jbAYacdRDU/OQBMd2ao0jLsKJHWUso1bA3f8CfMo0vrvrsfaovIfXcFnp56u9cDo
	Qin8CKaQnS9YGliCE4FcTan9Wf49lcba3jnT1SykaVt1TrL8k1RX4=
X-Sasl-enc: DZEa0johvHnAVPJKmhge7mo7z83Hu99qSJMWNKT5hjBy 1406271096
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 4B89168014B;
	Fri, 25 Jul 2014 02:51:36 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqq8uni8mx4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254199>

Junio C Hamano venit, vidit, dixit 24.07.2014 23:30:
> Duy Nguyen <pclouds@gmail.com> writes:
>=20
>> On Wed, Jul 23, 2014 at 8:48 PM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy venit, vidit, dixit 23.07=
=2E2014 13:43:
>>>> +     if (advice_checkout_to)
>>>> +             die(_("%s is already checked out at %s.\n"
>>>> +                   "Either use --detach or -b together with --to =
"
>>>> +                   "or switch branch in the the other checkout.")=
,
>>>
>>> "or switch to a different branch in the other checkout". But maybe =
we
>>> can be even more helpful, like:
>>>
>>> "%s is already checked out at %s.\n"
>>> "Either checkout the detached head of branch %s using\n"
>>> "    git checkout --detach --to %s %s\n"
>>> "or checkout a new branch based off %s using\n"
>>> "    git checkout --to %s -b %s newbranch %s\n"
>>> "or switch to a different branch in the other checkout."
>>>
>>> if we can figure out the appropriate arguments at this point in the=
 code.
>>
>> We would not be able to construct the exact command that the user ha=
s
>> entered, so perhaps
>>
>>   git checkout --detach <more options> %s
>>   git checkout -b <new branch> <more options> %s
>>
>> ?
>>
>> Note that this does not only occur when --to is given. If you have t=
wo
>> checkouts associated to the same repo, "git checkout foo" on one
>> checkout when "foo" is held by another checkout would cause the same
>> error. I'll need to think of a better name than advice.checkoutTo.
>=20
> I am not sure if we need to say anything more than the first line of
> the message you have in your patch.  To fork a new branch at the
> commit the user is interested in to check it out, or not bothering
> with the branch and detach, are both very normal parts of user's Git
> toolchest, nothing particularly special.  As long as the most
> important point, i.e. "in the new world order, unlike the
> contrib/workdir hack, you cannot check out the same branch at two
> different places", is clearly conveyed and understood, everything
> else should follow naturally, no?

As an error message that is completely sufficient.

The advice messages are meant to teach the user about the normal parts
of the toolchest to use in a situation of "conflict", aren't they? Mayb=
e
we should ask someone who hasn't turned them off...

Michael
