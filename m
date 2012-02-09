From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [StGit PATCH] Parse commit object header correctly
Date: Wed, 08 Feb 2012 19:58:54 -0800
Message-ID: <7v39akzmgx.fsf@alter.siamese.dyndns.org>
References: <4F3120D4.1050604@warmcat.com>
 <7vvcni1r5u.fsf@alter.siamese.dyndns.org>
 <7vd39pzsmq.fsf_-_@alter.siamese.dyndns.org> <4F3247CA.1020904@alum.mit.edu>
 <CAH6sp9P=vNjLycgzoWzRbeEsW-kQ5e4HgGYf2jP1+u9rtWV4dg@mail.gmail.com>
 <4F32A014.1000608@alum.mit.edu> <op.v9dl1e0v0aolir@keputer.lokaal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael Haggerty" <mhagger@alum.mit.edu>,
	Karl =?utf-8?Q?Hasselstr?= =?utf-8?Q?=C3=B6m?= 
	<kha@treskal.com>, "Catalin Marinas" <catalin.marinas@gmail.com>,
	=?iso-2022-jp?B?QW5keSBHcmVlbiAo?=
	 =?iso-2022-jp?B?GyRCTlMwQlcvGyhCKQ==?= <andy@warmcat.com>,
	git@vger.kernel.org
To: "Frans Klaver" <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 09 04:59:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvLA2-00035S-06
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 04:59:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758012Ab2BID67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Feb 2012 22:58:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64483 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757646Ab2BID67 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2012 22:58:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 238216FA9;
	Wed,  8 Feb 2012 22:58:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bJm7biIaBDVgsQfYwPdccKMjfZI=; b=VdS8Zt
	0rn/E4Zyc5POn19ffW9IMD6VOMILe1C7U2QPlS/2UIrB/mUtIpGufqyzNHNN4rvh
	fdTEycSoQs6YdsY3JRa0B649emeZ4xDB73OHznYDQKvt5ymxbmti3fF372Psc8n0
	uNrKpqA/ymOBsGym7L07X9VbKTaIvZbT/Eh2k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Llji3LapuY9AmIR506/rrH/hk1TjlmHz
	7sHjOaUa+UFD5TsiBLyKUIXXuB9vUM/WYN1+liwYqz8H16RxYyiiX+JRxyF3v+6B
	rRV2KaDEz9zTpLuB+0e83rF0Z8qnnQjpVENhuOLDHv2s2/8+27jqI1r0YetORDMZ
	ZpMWcCfKeug=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1ADDF6FA8;
	Wed,  8 Feb 2012 22:58:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 917976FA7; Wed,  8 Feb 2012
 22:58:55 -0500 (EST)
In-Reply-To: <op.v9dl1e0v0aolir@keputer.lokaal> (Frans Klaver's message of
 "Wed, 08 Feb 2012 21:04:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 630A9FE0-52D2-11E1-88E8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190268>

"Frans Klaver" <fransklaver@gmail.com> writes:

>>>>           for line in lines:
>>>>               try:
>>>>                   key, value = line.rstrip('\n').split(' ', 1)
>>>>               except ValueError:
>>>>                   continue
>>>
>>> This is generally considered more pythonic: "It's easier to ask for
>>> forgiveness than to get permission".
>>
>> Given that Junio explicitly wanted to allow lines with no spaces, I
>> assume that lack of a space is not an error but rather a conceivable
>> future extension.  If my assumption is correct, then it is misleading
>> (and inefficient) to handle it via an exception.
>
> I find the documenting more convincing than the efficiency, but from
> the phrasing I think you do too.

A line that consists entirely of non-SP may or may not a conceivable
future extension, but the point is to "skip without barfing anything you
do not understand".

I wouldn't oppose the rewrite that uses try/except ValueError if
"everything in this try block will parse what I understand correctly, and
any ValueError exception this try block throws is an indication that I
encountered what I do not understand and I must skip" is the more pythonic
way to express that principle. Python is not my primary language as I
said, and in addition StGit may have its own style I haven't learned.
