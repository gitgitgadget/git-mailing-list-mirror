Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4FF134404
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 19:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712258868; cv=none; b=mCJ3j4Nt+88BX8tvn8/tZNXBPzDBBmhLFf9+G4VadKeLbUAztFar9qhMvs0SlY3K3jIOWhYC1FMSYrSUXKYgtSoYYmTXLtrx/9CYv0rAVup+ypLM71ZweI6GInwfROT2WOV3ZdmiMJeM+tlPRKTXSiqHAKDs0eh7u46+LncSH4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712258868; c=relaxed/simple;
	bh=ycue1c7lUWUppymEfgQI/YbQRREM0PlOiS9teXTaW+A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sB0myCZet9W24CzMWEdiQLS/RiBix2v69LwZ7xg4VYke70d5St9KyiLr5QxQX0qbQGG/TbdrMvYmeus67QRHGxPntUAmtX17DAvn4hMxOEJ0EbyQYt5n9UKcfyWa1DrZZbv9PUb2qPfoAjuKGY6SLJAgF4BblOFukAf0ApS1qR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=yMsUOFX8; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yMsUOFX8"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3B7F61F65F8;
	Thu,  4 Apr 2024 15:27:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ycue1c7lUWUppymEfgQI/YbQRREM0PlOiS9teX
	TaW+A=; b=yMsUOFX8qyCB1bJ/aDHoqlMHz/Z//E4m2ezgtqhOR3BNK2dDy0Z8WV
	pkIhdkg/zXHpVBZ9j8DU69lK4e0rke09/Ph4fguUzwBdAe8OFxBzNA7464GaywV5
	66JiIwznSAKonLY2vv7W4Nw9+HCb8+4hTq30/TmZEzrhjEQbRRxjs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 32DD61F65F7;
	Thu,  4 Apr 2024 15:27:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 910C81F65F6;
	Thu,  4 Apr 2024 15:27:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Philip <philip.c.peterson@gmail.com>
Cc: Philip Peterson via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 1/2] apply: add unit tests for parse_range and rename to
 parse_fragment_range
In-Reply-To: <CAJ6X7_Uc0OdzYToJSs15+vbydraKAB8x4DPj7UsL1PKLzyY0dQ@mail.gmail.com>
	(Philip's message of "Wed, 3 Apr 2024 23:53:27 -0400")
References: <pull.1677.git.git.1708317938.gitgitgadget@gmail.com>
	<2c60c4406d4eb1307a32f23604f3ef8e34ad56d6.1708317938.git.gitgitgadget@gmail.com>
	<xmqqil2k5e8u.fsf@gitster.g>
	<CAJ6X7_Uc0OdzYToJSs15+vbydraKAB8x4DPj7UsL1PKLzyY0dQ@mail.gmail.com>
Date: Thu, 04 Apr 2024 12:27:44 -0700
Message-ID: <xmqqsf01yllb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 69FD0D80-F2B9-11EE-8614-25B3960A682E-77302942!pb-smtp2.pobox.com

Philip <philip.c.peterson@gmail.com> writes:

> On Mon, Feb 19, 2024 at 4:35 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> "Philip Peterson via GitGitGadget" <gitgitgadget@gmail.com> writes:

It's quite a blast from a long time ago that I no longer remember.

>> Alternatively we could do something like this to make the blast
>> radius of this patch smaller.
>>
>> -static int parse_range(const char *line, int len, int offset, const char *expect,
>> +#define apply_parse_fragment_range parse_range
>> +int parse_range(const char *line, int len, int offset, const char *expect,
>>                         unsigned long *p1, unsigned long *p2)
>
> From what I understand, this still creates a new extern symbol
> called parse_range.

Sorry, I misspoke.  The direction of #define is the other way
around.  That is, we may have to give the function a name that is
overly long because it needs to be externally linkable only to
support for your test, but we would want to locally rename that long
name down to the name currently used by the primary callers of that
function, so that the patch does not have to touch these existing
calling sites.  After all, this function is a small implementation
detail and not a part of the official apply.c API, and the only
reason why we are making it extern is because some new tests want to
link with it from the side.

So, in the <apply.h> header file you'll do

	/* 
	 * exposed only for tests; do not call this as it not
	 * a part of the API
	 */
	extern int apply_parse_fragment_range(...);

and then in the original file that used to have "static int
parse_range(...)", you'd add

	#define parse_range apply_parse_fragment_range

near the top, after the header files are included.

Thanks.
