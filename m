From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] add macro REALLOCARRAY
Date: Tue, 16 Sep 2014 12:27:38 -0700
Message-ID: <xmqqy4tj1i39.fsf@gitster.dls.corp.google.com>
References: <5415C89C.4090509@web.de>
	<CAPc5daXuYVXG=b3Mjn=8oE71FqE_PRZ=XHXW_0F5uHawWwy4HQ@mail.gmail.com>
	<541886D5.8060202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:27:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTyPi-0005IG-GN
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 21:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754921AbaIPT1m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Sep 2014 15:27:42 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50629 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754849AbaIPT1m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2014 15:27:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 52B7939916;
	Tue, 16 Sep 2014 15:27:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=hO6d6W4WJ5KU
	9SwxjRS7tmuPVeg=; b=OhLww2+qPzFd+pIeehnIEU5B8h8HEdEOEXYQrtb1ODIC
	f7dnJTDNeYpwqHccd2W2f2vggHTz8HevwtCEYP/pHpRLBRzwRI53QxJmDCgc+D2e
	DGQ+oTUFs+JgQa2gfPZuxhQREn93ogNXps7obrApHnG/73HuMT2/GZ9b4sOgCt0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=WS830d
	YJzHh1Plh2rVCmSc1i/iqWQNnaxXRIusH2a3uZ8/MAJGPQSK19FjpOosAJs5kMoY
	GWmA+KwEJe/hvPMb9t02hYGf1BiucAOzFrHMl2k8mcgZWeYnqCOSlK0MKuG3RnLd
	uc8Xf+m+Bk6xrCu04SVyOHxIpQQjEGxOZd/CE=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4954539915;
	Tue, 16 Sep 2014 15:27:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C1B8339914;
	Tue, 16 Sep 2014 15:27:40 -0400 (EDT)
In-Reply-To: <541886D5.8060202@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Tue, 16
	Sep 2014 20:52:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 86473156-3DD7-11E4-8FED-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257145>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 16.09.2014 um 05:04 schrieb Junio C Hamano:
>> On Sun, Sep 14, 2014 at 9:55 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wr=
ote:
>>> +#define REALLOCARRAY(x, alloc) x =3D xrealloc((x), (alloc) * sizeo=
f(*(x)))
>>
>> I have been wondering if "x" could be an expression that has an oper=
ator
>> that binds weaker than the assignment '=3D'.  That may necessitate t=
he LHS
>> of the assignment to be somehow marked as bound the tightest, i.e.
>>
>> #define REALLOC_ARRAY(x, alloc) (x) =3D xrealloc((x), (alloc) * size=
of(*(x)))
>>
>> Or am I being overly silly?
>
> ALLOC_GROW did well without that.  I can't think of a good use case
> for a complex expression on the right-hand side.  That said, I think =
I
> still have a spare matching pair of parentheses lying around here
> somewhere, so let's play it safe and use them. :)

Yeah, as long as (any) is still an lvalue for any lvalue for
everybody's compiler, (x) =3D ... expression ... is safer, but
taking cue from ALLOC_GROW(), I would say I was probably being
slightly overly silly.
