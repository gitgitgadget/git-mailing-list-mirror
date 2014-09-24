From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] add macro REALLOC_ARRAY
Date: Wed, 24 Sep 2014 10:59:29 -0700
Message-ID: <xmqqbnq4hpby.fsf@gitster.dls.corp.google.com>
References: <5415C89C.4090509@web.de>
	<CAPc5daXuYVXG=b3Mjn=8oE71FqE_PRZ=XHXW_0F5uHawWwy4HQ@mail.gmail.com>
	<541886D5.8060202@web.de> <541887F0.1050007@web.de>
	<54227379.5010708@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Sep 24 19:59:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWqqo-0003Ee-Fl
	for gcvg-git-2@plane.gmane.org; Wed, 24 Sep 2014 19:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbaIXR7e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Sep 2014 13:59:34 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63374 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751184AbaIXR7d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Sep 2014 13:59:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9AB533BBCC;
	Wed, 24 Sep 2014 13:59:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1dZPG2VpKFHe
	1+E4rqOAR7ctksU=; b=yk48hQKQbx17mM8zY7BGH9rn1AqbRZxm7BZqlxodvP/u
	cqpgdpAx0ejnI3rb//ny6DEd8113Os1m2jl9IUxYTxKTp1USG3tIMySn8Siwrh0b
	27irlON5BtsINPCdj6povOhVBNv+7V3KDh53IkkwSQ+fNAmSpq1nnJ+P2iEASAg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=nEFM7j
	uccZir3lVz/lHbCfUeetPl98FTSTmNVWPIpaBBQ4GeWs1ycZibJfNd7SNQRTJqRU
	NEn5sESNs7sGGpfwhrN6uxu6u0uoBpDNYA3SEoXzJ4/oJjyLIHAMNLeBV7jcrgSS
	T48eUYcy0R7GSoL+3EeLB9OZRYtbxCsX/aZnE=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A3B593BBCB;
	Wed, 24 Sep 2014 13:59:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 113933BBC8;
	Wed, 24 Sep 2014 13:59:30 -0400 (EDT)
In-Reply-To: <54227379.5010708@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 24 Sep 2014 09:32:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 88A9A378-4414-11E4-ADA2-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257463>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 09/16/2014 08:56 PM, Ren=C3=A9 Scharfe wrote:
>> The macro ALLOC_GROW manages several aspects of dynamic memory
>> allocations for arrays: It performs overprovisioning in order to avo=
id
>> reallocations in future calls, updates the allocation size variable,
>> multiplies the item size and thus allows users to simply specify the
>> item count, performs the reallocation and updates the array pointer.
>>=20
>> Sometimes this is too much.  Add the macro REALLOC_ARRAY, which only
>> takes care of the latter three points and allows users to specfiy th=
e
>> number of items the array can store.  It can increase and also decre=
ase
>> the size.  Using the macro avoid duplicating the variable name and
>> takes care of the item sizes automatically.
>
> Is there a reason that ALLOC_GROW and REALLOC_ARRAY are defined in tw=
o
> separate header files (cache.h and git-compat-util.h, respectively)? =
It
> seems to me that they are close siblings and therefore I find it
> surprising that they are not defined right next to each other.

That was my initial reaction, but on the other hand, because
REALLOC_ARRAY() should never be used on an array managed by
ALLOC_GROW() without mucking with internal implementation details of
what ALLOC_GROW() does yourself, there is not much reason for them
to be listed and live together in the same place.

Listing them together might even invite confusion and mixed use by
mistake.
