From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] attr: fix off-by-one directory component length
 calculation
Date: Tue, 15 Jan 2013 21:35:21 -0800
Message-ID: <7vtxqhzo4m.fsf@alter.siamese.dyndns.org>
References: <1358256924-31578-1-git-send-email-pclouds@gmail.com>
 <201301152014.28433.avila.jn@gmail.com>
 <7vwqve2qk3.fsf@alter.siamese.dyndns.org>
 <CACsJy8Bn4GKJzi4n5cMPp+26dovT795nUqcXGNLgapf+r_PFCw@mail.gmail.com>
 <20130116020901.GA1041@duynguyen-vnpc.dek-tpc.internal>
 <7vbocp26xa.fsf@alter.siamese.dyndns.org>
 <CACsJy8C2uEgwozpWBfowYJea3XRB72rhzjsSFuG9Ud0afuQy6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>,
	git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 06:35:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvLf7-00011g-9g
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 06:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798Ab3APFfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 00:35:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48318 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751055Ab3APFfY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 00:35:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71A43972B;
	Wed, 16 Jan 2013 00:35:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Sk39K91Lrg6zAS6JbzlqvQ/jzC8=; b=wOuX6y
	2ZPecYl5vUdydnKForw50ZR86qk3nfxzVoaNQ01AzGqcgfKe+Qkk3gVDa5HI5CLJ
	3xfyy/LYVdOtYNmYvEkllkw7a5YwNQbl8V5/I8m7kRNcrw+FkoTZb8oqW7rysnNU
	E3gUiesjDjTX0gCXoi8ll7mRN62OwlVJBG36I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EjVYA1S7wohb21Crj5WdGI66PvWE2gr5
	elQ0Ngp4d1j6PF26QT6xhUW4SAorFn8wnEg99fi80CGcGYW7Z/mA4UWPPhMACaMp
	fMk88x9n8Ru411E49guvkDBm8L+aRroGm/XpNlqOw3Bt6AeNdzpGAu6Z1rMzxVcq
	LazCChdRnwo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6745B972A;
	Wed, 16 Jan 2013 00:35:23 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3A719729; Wed, 16 Jan 2013
 00:35:22 -0500 (EST)
In-Reply-To: <CACsJy8C2uEgwozpWBfowYJea3XRB72rhzjsSFuG9Ud0afuQy6w@mail.gmail.com> (Duy
 Nguyen's message of "Wed, 16 Jan 2013 10:12:16 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 85D60B34-5F9E-11E2-A4CD-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213727>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Jan 16, 2013 at 9:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>>> On Wed, Jan 16, 2013 at 08:08:03AM +0700, Duy Nguyen wrote:
>>>> Actually I'd like to remove that function.
>>>
>>> This is what I had in mind:
>>
>> I think the replacement logic to find the basename is moderately
>> inferiour to the original.  For one thing (this may be somewhat
>> subjective), it is less readable now.
>
> Yeah, maybe it's micro optimization.

Your change is micro unoptimization (and making the result less
readable).  I wouldn't worry too much about micro-optimizing an
existing piece of code, but making an efficient code into a worse
one without a good reason is a different story.

>> Also the original only
>> scanned the string from the beginning once (instead of letting
>> strlen() to scan once and go back).
>
> But we do need to strlen() anyway in collect_all_attrs().

That is exactly my point, isn't it?

The loop to find the basename has to run to the end of the string at
least once, as it cannot not stop at the last slash---it goes from
front to back and it won't know which one is the last slash until it
sees the end of the string.  After the loop exits, you know the
length of the string without running a separate strlen() to assign
to "pathlen".

> So we scan
> the string 3 times (strlen + 2 * find_basename) in the original. Now
> we do it twice.

I already said that overall restructure of the code may be a good
idea to reduce the calls to the function.  I was only comparing the
implementations of the loop that finds the basename, so I do not
understand what you mean by that "2 *" in that comparison.  It does
not make sense to me.
