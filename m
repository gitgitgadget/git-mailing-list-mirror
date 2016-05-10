From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] modernize t1500
Date: Tue, 10 May 2016 11:26:32 -0700
Message-ID: <xmqqeg99py5j.fsf@gitster.mtv.corp.google.com>
References: <20160510052055.32924-1-sunshine@sunshineco.com>
	<xmqqfutqsaxn.fsf@gitster.mtv.corp.google.com>
	<xmqqmvnxpyw6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 10 20:26:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0CMj-0000NE-9c
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 20:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbcEJS0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 14:26:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56040 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751325AbcEJS0g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 14:26:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 80EA218621;
	Tue, 10 May 2016 14:26:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r9ymq6faX+APL6xFPyS4D6D4QvY=; b=ng02Vk
	AvSsuXXqmLufnZbQNju//o/rhTilsAJfG3NL1taT5hJIral/As2t8s1AGtwNe+kW
	zdUScEHz9isCbFIcZiAdW5Ri386SzcmBtCHd8Vavkum32/yiWZrE2ycfAyuOtaDI
	UAQ7p3OTDaDCrDogGLten6QOOv7dlTGbBZjB8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ajYrdslDcMpFmiKRiwW6KdMdhiJawCDt
	RMgBuYDG9WXZWPj5rVNr9Mw1lSpRgg249va5dA64fW7AdaVad+5xQa7cpHc454ro
	Cm8KPFJ6cYW+TUySoZUwINiFmZjjmkcPc7udK/ldI1NyIAV7OOSCFrRJRtdNXSWK
	9gdypjEBWn8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 777E41861E;
	Tue, 10 May 2016 14:26:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E2BF71861B;
	Tue, 10 May 2016 14:26:34 -0400 (EDT)
In-Reply-To: <xmqqmvnxpyw6.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 10 May 2016 11:10:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B9F93C9E-16DC-11E6-9535-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294170>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>
>>> This series modernizes t1500; it takes an entirely different approach
>>> than [1][2] and is intended to replace that series.
>>
>> Turns out that it wasn't so painful after all.
>>
>> The only small niggle I have is on 6/6; my preference would be,
>> because once we set up .git we do not add objects and refs to it, to
>> make a copy a lot earlier before the tests start.
>
> -- >8 --
> Subject: [PATCH 7/6] t1500: finish preparation upfront
>
> The earlier tests do not attempt to modify the contents of .git (by
> creating objects or refs, for example), which means that even if
> some earlier tests before "cp -R" fail, the tests in repo.git will
> run in an environment that we can expect them to succeed in.
>
> Make it clear that tests in repo.git will be independent from the
> results of earlier tests done in .git by moving its initialization
> "cp -R .git repo.git" much higher in the test sequence.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

I think the same logic applies to other preparatory things like
creation of sub/dir in the working tree etc.
