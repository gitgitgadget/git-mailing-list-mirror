From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] checkout --to: no auto-detach if the ref is already checked out
Date: Thu, 24 Jul 2014 14:30:31 -0700
Message-ID: <xmqq8uni8mx4.fsf@gitster.dls.corp.google.com>
References: <1406115795-24082-1-git-send-email-pclouds@gmail.com>
	<1406115795-24082-4-git-send-email-pclouds@gmail.com>
	<53CFBD2A.9030803@drmicha.warpmail.net>
	<CACsJy8DwPM68j-=LDDbq1H_bT1gD=aLQ8x6C1qiwF79=ai14dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 23:30:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAQb6-0007qI-V0
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 23:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934176AbaGXVal convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jul 2014 17:30:41 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65513 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759602AbaGXVak convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jul 2014 17:30:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 93F932A22E;
	Thu, 24 Jul 2014 17:30:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=UIe2B0ImPK6Q
	PgZxu7dTavAHNnk=; b=pKie8c9lhz+RQ5FlNY11Ffzz08NTidWaowY2QCnKBjsS
	wLohSOWf+VXhWecf8cZoYyX2kzgon/rswEO+nLKpVNfi39PK8Y0KGzbqV6Z2NGLV
	fMyly8yR8d5KdeWqz1jhkOP7d6MxCETb6Ncg2Zo5yx19zMPvAYxb5vm5dDE+c5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=tUpRGt
	wCEkZszNdX+Elt+NdqD1gI7/IEYLBanw3D1F5BVwy7lfoD3jZHn1rFZpHZdJbPHJ
	0lHEUGXlq7Y8YDGfgh75K+yhk8kDSGjr2gcS2a2E3RuVoEccrCpirspgQacVoYNW
	aq0ei3pKkRQmPvyCIhSQCQhMdA/TQpXUFWEJ0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 892FD2A22C;
	Thu, 24 Jul 2014 17:30:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 122362A21D;
	Thu, 24 Jul 2014 17:30:33 -0400 (EDT)
In-Reply-To: <CACsJy8DwPM68j-=LDDbq1H_bT1gD=aLQ8x6C1qiwF79=ai14dg@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 24 Jul 2014 16:58:31 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BE3246B0-1379-11E4-98BD-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254187>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Jul 23, 2014 at 8:48 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy venit, vidit, dixit 23.07.=
2014 13:43:
>>> +     if (advice_checkout_to)
>>> +             die(_("%s is already checked out at %s.\n"
>>> +                   "Either use --detach or -b together with --to "
>>> +                   "or switch branch in the the other checkout."),
>>
>> "or switch to a different branch in the other checkout". But maybe w=
e
>> can be even more helpful, like:
>>
>> "%s is already checked out at %s.\n"
>> "Either checkout the detached head of branch %s using\n"
>> "    git checkout --detach --to %s %s\n"
>> "or checkout a new branch based off %s using\n"
>> "    git checkout --to %s -b %s newbranch %s\n"
>> "or switch to a different branch in the other checkout."
>>
>> if we can figure out the appropriate arguments at this point in the =
code.
>
> We would not be able to construct the exact command that the user has
> entered, so perhaps
>
>   git checkout --detach <more options> %s
>   git checkout -b <new branch> <more options> %s
>
> ?
>
> Note that this does not only occur when --to is given. If you have tw=
o
> checkouts associated to the same repo, "git checkout foo" on one
> checkout when "foo" is held by another checkout would cause the same
> error. I'll need to think of a better name than advice.checkoutTo.

I am not sure if we need to say anything more than the first line of
the message you have in your patch.  To fork a new branch at the
commit the user is interested in to check it out, or not bothering
with the branch and detach, are both very normal parts of user's Git
toolchest, nothing particularly special.  As long as the most
important point, i.e. "in the new world order, unlike the
contrib/workdir hack, you cannot check out the same branch at two
different places", is clearly conveyed and understood, everything
else should follow naturally, no?
