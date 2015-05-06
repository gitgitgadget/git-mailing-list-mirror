From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] upload-pack: Optionally allow fetching reachable sha1
Date: Wed, 06 May 2015 13:19:13 -0700
Message-ID: <xmqqy4l1sblq.fsf@gitster.dls.corp.google.com>
References: <1430604075-5951-1-git-send-email-fredrik.medley@gmail.com>
	<1430860888-6146-1-git-send-email-fredrik.medley@gmail.com>
	<xmqqmw1id610.fsf@gitster.dls.corp.google.com>
	<CABA5-zm-PxX-WWtoDnLhtJVZFhO2G1pOTApoz4DtmmUQ61iC6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Dan Johnson <computerdruid@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Fredrik Medley <fredrik.medley@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 06 22:19:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yq5mq-0001Os-U6
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 22:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbbEFUTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 16:19:17 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60608 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751947AbbEFUTP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 16:19:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B4FE14F811;
	Wed,  6 May 2015 16:19:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o3LO89qaowMkZSNJIHvbecBnkpU=; b=oPeclj
	W9g/Wk9/viNm/SG8HhYEdkacjPuRJXxGPydu6CB5/qtfuv6BohIrHL1Q5IwDvH1V
	B3yFI8GC/N9bruFITJa/DKxp08UTvtED+F2K1iljIR5UxZQ1vtagA/fZFaQgi9CO
	d5c5YuofnZnUIc/MYoriPnIeKa/41R0SlFnwE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qF1VSldqA40Q9dvJVUSkxOtjgVdKcKOX
	xoqKjZ5dd/w1+4pzv80/mm8RbZG93Q46xr2AQxcpapbOjA3hliQeXEGNBoDVRYJk
	kumcOzquvDoOC9WqtQ9B0ADqa19Z6+j4AA6I81bmdJl3lMSS8c/z4MpH0RCIxxIA
	bEVKYkzwfrI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AC5794F810;
	Wed,  6 May 2015 16:19:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2ABDA4F80D;
	Wed,  6 May 2015 16:19:14 -0400 (EDT)
In-Reply-To: <CABA5-zm-PxX-WWtoDnLhtJVZFhO2G1pOTApoz4DtmmUQ61iC6w@mail.gmail.com>
	(Fredrik Medley's message of "Wed, 6 May 2015 22:10:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 29F508B2-F42D-11E4-951C-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268493>

Fredrik Medley <fredrik.medley@gmail.com> writes:

> 2015-05-06 0:16 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
>> Fredrik Medley <fredrik.medley@gmail.com> writes:
>>>
>>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>>> index 2e5ceaf..76cd713 100644
>>> --- a/Documentation/config.txt
>>> +++ b/Documentation/config.txt
>>> @@ -2538,6 +2538,12 @@ uploadpack.allowtipsha1inwant::
>>>       of a hidden ref (by default, such a request is rejected).
>>>       see also `uploadpack.hideRefs`.
>>>
>>> +uploadpack.allowreachablesha1inwant::
>>
>> I know that the existing allowtipsha1inwant is spelled that way, and
>> it may be better done as a separate clean-up patch (either before or
>> after this step), but the documentation and the first line of the
>> log message would be easier to read with
>>
>>         uploadpack.allowReachableSHA1InWant
>>
>> I'd think.
>>
>
> I would prefer using allowReachableSha1InWant. Please tell
> me if I should use SHA1InWant instead of Sha1InWant.
> (I cannot find anything similar in the repository.)

Keep in mind what was discussed recently:

  http://thread.gmane.org/gmane.comp.version-control.git/265225/focus=265322

I would think SHA1 should be upcased (so should SSL, SMTP, etc.)
even in the existing ones when we do the "clean-up" pass.  Even
though this patch is not about cleaning up existing mess, there
is no point adding more cruft that we need to clean up later ;-)
