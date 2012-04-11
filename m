From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] add mergesort() for linked lists
Date: Wed, 11 Apr 2012 09:44:52 -0700
Message-ID: <7vlim2md4r.fsf@alter.siamese.dyndns.org>
References: <201203291818.49933.mfick@codeaurora.org>
 <7v7gy2q1kq.fsf@alter.siamese.dyndns.org>
 <60bff12d-544c-4fbd-b48a-0fdf44efaded@email.android.com>
 <20120330093207.GA12298@sigill.intra.peff.net>
 <20120330094052.GB12298@sigill.intra.peff.net>
 <4F7780C3.2050408@lsrfire.ath.cx> <4F85226A.7050709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Jeff King <peff@peff.net>, Martin Fick <mfick@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 18:45:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI0fE-0000kQ-0Y
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 18:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522Ab2DKQoz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 12:44:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57070 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932471Ab2DKQoy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Apr 2012 12:44:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25367639D;
	Wed, 11 Apr 2012 12:44:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=kGlcIUnrCjDB
	f9doA6Tny9iEtrA=; b=n3Bwg8ZAxXvY/EapwqRmG8e2qMzvavsfSyiQUgLtxwcD
	/oXM/KMpqw8DtoGZEUnDENlao6HuOjnn1BkTfXvoIfEC0An7hymxvBPnI6vORpk8
	c+xEyrJI2g6fhAR86Vx8ibSXi/wl9Q4jjlEhG6signUqSSAVDsLNfMK58r5PEVg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xN+aq8
	RI896HdFpy2XP3tAFRNoyiD1ixeYKXnt+iPMwaxW5iCUwwVSya+bHb8Lzknwwp1D
	SJV+tbdoZz7GYdJNh2fcTt2bXVj1bT9KnDa8ANyRFPNb/sBiyIOVTLW+7JY5dtJ8
	bVH0TYxwp1ftC+sCI9vev8o6qL0RzettFO7L8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BE1D639C;
	Wed, 11 Apr 2012 12:44:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8FE75639B; Wed, 11 Apr 2012
 12:44:53 -0400 (EDT)
In-Reply-To: <4F85226A.7050709@gmail.com> (Stephen Boyd's message of "Tue, 10
 Apr 2012 23:19:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A9C04BFC-83F5-11E1-B0AA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195210>

Stephen Boyd <bebarino@gmail.com> writes:

> On 03/31/2012 03:10 PM, Ren=C3=A9 Scharfe wrote:
>> diff --git a/mergesort.c b/mergesort.c
>> new file mode 100644
>> index 0000000..c0f1874
>> --- /dev/null
>> +++ b/mergesort.c
>> @@ -0,0 +1,75 @@
>> +#include "cache.h"
>> +#include "mergesort.h"
>> +
>> +#include "commit.h"
>
> This is an unnecessary include, right?
>
> diff --git a/mergesort.c b/mergesort.c
> index c0f1874..d084c60 100644
> --- a/mergesort.c
> +++ b/mergesort.c
> @@ -1,8 +1,6 @@
>  #include "cache.h"
>  #include "mergesort.h"
>
> -#include "commit.h"
> -
>  struct mergesort_sublist {
>         void *ptr;
>         unsigned long len;

Yes. I'll squash in, as I tentatively kicked many topics out of 'next' =
and
this was among them.
