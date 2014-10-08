From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/5] add "unset.variable" for unsetting previously set variables
Date: Wed, 08 Oct 2014 10:14:33 -0700
Message-ID: <xmqqy4sqbi12.fsf@gitster.dls.corp.google.com>
References: <1412256292-4286-1-git-send-email-tanayabh@gmail.com>
	<xmqqvbo2meg5.fsf@gitster.dls.corp.google.com>
	<5433CBC3.5010202@gmail.com>
	<xmqq1tqjkexe.fsf@gitster.dls.corp.google.com>
	<vpqzjd7kta6.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Rasmus Villemoes <rv@rasmusvillemoes.dk>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Oct 08 19:14:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xbup0-0006QL-Fj
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 19:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbaJHROi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Oct 2014 13:14:38 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57537 "EHLO sasl.smtp.pobox.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752036AbaJHROh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Oct 2014 13:14:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4CCA51486F;
	Wed,  8 Oct 2014 13:14:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jDst2pMsgxA9
	IyOSoV9veeAJMyE=; b=QliVip2rrCQX6IowQKgkrJaE31uxAqPQUTR/KSjLn1Zw
	d2CShigrCGuXLurKHyllVL4VNl20kN+/KJegCqMoTAyLDFzMVUm/o527yGXQ8ORs
	FsWtxOLvgvQumwgZ2fPyZoYA7GiVFRZbDQGbtBTSMNH2gof5zAR4el2SsPECh2A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=UYXw+s
	maoo+ln/H3Rhscn8hJHAqA05FavoKdlONlMs37RFI7qbq+SrD0It4NIg/pqVKhZh
	XW1aqCdBBs+te+XjEE8DsAe/DF0+b80m60cyfPVgIO/aL5gd/EO/U9y2ngWB9DxQ
	MuyFeRgPEznJ0SKCoV4XRLwfoaPRrA+h4SZzo=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 405F41486E;
	Wed,  8 Oct 2014 13:14:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B0BED14869;
	Wed,  8 Oct 2014 13:14:34 -0400 (EDT)
In-Reply-To: <vpqzjd7kta6.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	08 Oct 2014 07:46:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 935685AC-4F0E-11E4-BD67-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Jakub Nar=C4=99bski <jnareb@gmail.com> writes:
>>
>>> Junio C Hamano wrote:
>>>
>>>>   - "[config] safe =3D section.variable" will list variables that =
can
>>>>     be included with the config.safeInclude mechanism.  Any variab=
le
>>>>     that is not marked as config.safe that appears in the file
>>>>     included by the config.safeInclude mechanism will be ignored.
>>>
>>> Why user must know which variables are safe, why it cannot be left =
to
>>> Git to know which configuration variables can call external scripts=
?
>>
>> That's a fallback to let them take responsibility for variables we
>> do not mark as "safe"; and having that fallback mechanism lets us
>> keep the set of variables we by default mark as safe to the absolute
>> minimum.
>
> Perhaps this would need a way to say "this value is safe for this
> variable" too. I don't have a real use-case, but one could say someth=
ing
> like "I'm OK with the file overriding core.editor, but the only value=
s I
> accept are nano, vim and emacs".
>
> It doesn't seem to be a prerequisite to implement the safeInclude
> feature, but we should live room in the namespace for the day we want=
 to
> add it.
>
> I don't have really good idea for it. The first I could think of was
>
> [config "safe"]
>     core.editor =3D nano
>     core.editor =3D vim
>     core.editor =3D emacs
>
> but it's not accepted by the current parser, hence not backward
> compatible.

Interesting thought (I've cc'ed Rasmus who did an RFC patchset on
the safe include feature).  I do not offhand think of a good example
of an variable that we may want to allow overriding but still want
to limit its values myself.  Almost all variables I would rather not
to see in-tree .gitconfig to touch at all, and the ones that I may
want to allow to be futzed with I can think of offhand are booleans.
With more people and time we might find a better example to illustrate
why we may want to have such a feature added.

Thanks.
