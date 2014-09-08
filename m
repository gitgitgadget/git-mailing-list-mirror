From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/2] headers: include dependent headers
Date: Mon, 08 Sep 2014 11:05:50 -0700
Message-ID: <xmqqbnqqng1t.fsf@gitster.dls.corp.google.com>
References: <1410031211-14599-1-git-send-email-davvid@gmail.com>
	<1410031211-14599-2-git-send-email-davvid@gmail.com>
	<540B7AA3.1090201@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Sep 08 20:06:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XR3KD-0004Bi-N5
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 20:06:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047AbaIHSFz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Sep 2014 14:05:55 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57302 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752748AbaIHSFx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Sep 2014 14:05:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 43EA237B46;
	Mon,  8 Sep 2014 14:05:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BwjfzbfTqnBM
	4/3+xqYKJcA+dRk=; b=bcLhVONfXx8YB1/81L3a2upiDKGkr3W4q7rUr92755SE
	h8zxvgw1SJ0PENOL+qmn0qATP08OZhBj6lfA5DueMol9oP5ESuXo/B88jQ+sqwD1
	1dj/3MzGGbB5YV3jqm3jQte79jxsFzOgrtCghnydJLTaet9rfq3EM/LfuQuBSEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dDVEE6
	XSkzBwDhLPBnGKbDqNnkpWmFTgeyvbk7LeSDAGp6bPMpqlROHE1zVzqM3QfVpbam
	l1ieWLacKZ9qCUavspRvRcme0icsIzaKxyb8zsHMxUX6tQOXRMS8dhPpofRFE0TI
	FVWBh8Sd7AOCmF07nBPv8z0+4SWb0KwNKaw4I=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 38C2437B45;
	Mon,  8 Sep 2014 14:05:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AD5A037B44;
	Mon,  8 Sep 2014 14:05:52 -0400 (EDT)
In-Reply-To: <540B7AA3.1090201@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Sat, 06
	Sep 2014 23:20:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C5873A06-3782-11E4-8AC5-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256663>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 06.09.2014 um 21:20 schrieb David Aguilar:
>> Add dependent headers so that including a header does not
>> require including additional headers.
>>
>> This makes it so that "gcc -c $header" succeeds for each header.
>>
>> Signed-off-by: David Aguilar <davvid@gmail.com>
>> ---
>
>> diff --git a/branch.h b/branch.h
>> index 64173ab..a61fd1a 100644
>> --- a/branch.h
>> +++ b/branch.h
>> @@ -3,6 +3,9 @@
>>
>>   /* Functions for acting on the information about branches. */
>>
>> +#include "cache.h"
>> +#include "strbuf.h"
>
> cache.h includes strbuf.h, so the line above isn't necessary.

I think the primary objective of these two patches is to allow
anybody who wants to use a feature X to include the header H that is
about that feature without having to know what other header F and G
are required by the implementation of header H.

And I think that cuts both ways.  Somebody who wants to use a
feature defined in the header H shouldn't have to know that other
headers I and J he includes to use other features from happen to
already include H for their own use.

Here, branch.h does want to see "struct strbuf" for its own use, so
including "strbuf.h" is the right thing to do and in line with the
primary objective, no?  It shouldn't have to know that "cache.h"
happens to include "strbuf.h".

While assessing these two patches, we would need to decide what to
do with the "include git-compat-util.h first in any C source" rule
in the coding guidelines.  I think it is still a good practical
exception (in the sense that even if you do not use FLEX_ARRAY,
signed_add_overflows(), etc. yourself, you should follow the rule),
even if we choose to adopt "One that wants to use features from a
header only needs to include that header".
