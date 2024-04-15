Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F03156969
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 21:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713216245; cv=none; b=dt3iUXVhQdEY3VGWgVgXvv/ioXZq2Zlhl/Q3N+Wn8jtqrbtKnDEjUJkeXIAN0lzPx9eh/ohF8Z2rJmM8Owj+3IbUkrMTBgUGmv8RWW5SKwwXjQpU4zETxCeCvK1Hl0OQ5GsYZ7M3ve+E3RewgLM2WMAsP3vCSeGhyjaJCZzZ9jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713216245; c=relaxed/simple;
	bh=ByJt2IfKdmvbNY3XpPb++FXbAoeF/ZUOuOtavh7PXYI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NhLbbhZo65AZ4OAXLiD+9jvzjN2XKjAaRQzheYIiNn2JYBjcmgMgjc1ssDgQRkEQ3SzoF40E9Bj7bgsH9jGGadCpXPYzRWLptmTr7ALxFs/4+1Df716yJZN35iuaErPFdLtVq8GvbPUuadv8goQPnZRd+WkyIwua7aGIYEEQy1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gL/2qiis; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gL/2qiis"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ACF6C1F1459;
	Mon, 15 Apr 2024 17:24:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ByJt2IfKdmvbNY3XpPb++FXbAoeF/ZUOuOtavh
	7PXYI=; b=gL/2qiispOB+pNXqQIxZe2lXGcywtQzLQfTrbMtWPTOnY4GKTez9Wa
	Ia5Um5UFAfLISQ4My0SPiedeVCO9YzDDJ+C/H+uGh9/E06GwJoRpyRR2CVX4kXoj
	LM1cM/dZhFH+Ey1iOescd5GghomsX6/Wquty+Wjc6D5Yj2bj34H+U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A39F81F1458;
	Mon, 15 Apr 2024 17:24:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 60AD11F1455;
	Mon, 15 Apr 2024 17:24:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Peter Krefting <peter@softwolves.pp.se>,  git@vger.kernel.org,  Jeff
 King <peff@peff.net>,  Christian Couder <christian.couder@gmail.com>,
  Michael Osipov <michael.osipov@innomotics.com>
Subject: Re: [PATCH v3] bisect: report the found commit with "show"
In-Reply-To: <CAPig+cQu15HzZkeT3+oG3U7iFax5_GYUB=uqwuJxshw-PD=VHQ@mail.gmail.com>
	(Eric Sunshine's message of "Sat, 13 Apr 2024 21:28:40 -0400")
References: <965ae345-fd58-c46c-5a7a-de181e901f21@softwolves.pp.se>
	<CAPig+cQu15HzZkeT3+oG3U7iFax5_GYUB=uqwuJxshw-PD=VHQ@mail.gmail.com>
Date: Mon, 15 Apr 2024 14:24:00 -0700
Message-ID: <xmqq7cgyl3pr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7A78B444-FB6E-11EE-8F4C-25B3960A682E-77302942!pb-smtp2.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

>> Pass some hard-coded options to "git show" to make the output similar
>> to the one we are replacing, such as showing a patch summary only.
>>
>> Signed-off-By: Peter Krefting <peter@softwolves.pp.se>
>> ---

Curious how you trimmed the trailers from the submitted patch ;-)

Although we do not use Cc: in this project, we do recommend use of
the "Reported-by" trailer in Documentation/SubmittingPatches.

>> diff --git a/bisect.c b/bisect.c
>> ...

> Style nit: On this project, multi-line comments are formatted like this:
>
>     /*
>      * This is a multi-line
>      * comment.
>      */

True.

> It also feels slightly odd to place each option on its own line in the
> call to strvec_pushl() but then place the terminating NULL on the same
> line as the oid_to_hex() call. But that's a minor and subjective point
> hardly worth mentioning.

I think that is because we may want to tweak the list of options,
but no matter what change we make to them in the future, the object
name as the last parameter is likely to remain the last one, and
with that reasoning, I agree with the layout in the patch as posted.

What is more problematic is that the message is sent with

	Content-Type: text/plain; format=flowed; charset=US-ASCII

and the contents of the message is in that flawed format, possibly
corrupting whitespaces in irrecoverable ways.

I _think_ "git am" (actually, "git mailsplit" that is called from
it) did a reasonable job this time, but I do not have a lot of
confidence in the resulting commit---I would not be surprised if it
is not identical to what Peter wanted to give us.

Peter, if the resulting commit I push out later today botches some
whitespaces due to this issue, please complain.  I'll fix the
multi-line comment thing on my end before pushing the today's
integration result out.

Thanks.
