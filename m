Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11FD762DC
	for <git@vger.kernel.org>; Thu, 23 May 2024 19:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716491174; cv=none; b=Z2TCMo4+WBGsNHOMLnUbRQ2TbNrckPmWs1t2/9tKi5PuqyGZf8evmFMv7vIj+A0GxUa2imx9uYX+0gfnrfRJjKRyHKuyFdSkQJJj/rtaBSGNLsOt5O7+ZvNrrPF7KpClzkwh68EOImVq19gu6i+jgdBE24Za7GWgp8IpdRkPgaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716491174; c=relaxed/simple;
	bh=JUOth9nzJO3mpmrgGTz4VoCrE0Ku/osePZfCpPHxiRU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UjSnBhsln9JiPmhpENRlwVvGwjb87aM2JKCJjORx4YOwg7UebMBCRRffslo5cbb5uTiJFfsb0evwobuAOZ7ktM/Xrz7BCaZ3+1QApwGRAdIi0q3/WjtlQfOIbrBULRs4pcHUOIBzD/H9c1Ago3UC/o3GoVmZUPslzNRA/McOrD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=c+y2BOVp; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="c+y2BOVp"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 46D0732D49;
	Thu, 23 May 2024 15:06:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=JUOth9nzJO3mpmrgGTz4VoCrE0Ku/osePZfCpP
	HxiRU=; b=c+y2BOVptB2IP3iKBmO0KrSfu/bJbBgmiYmhHTPmHjfFrMDFn5yhsN
	Uiix5gFGJlYYg9NM0bK5I/9muwUaqOHUrpQ71Wwe7/aCI5ogngzXRXlaVYCBu4gx
	nMh8hRSMe0xugalZ8YLvI/ObkJLbbPFhtj7ifEz8B0zKbkBTkhDNY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3FA7832D48;
	Thu, 23 May 2024 15:06:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A7B9532D47;
	Thu, 23 May 2024 15:06:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2 0/6] update-ref: add symref support for --stdin
In-Reply-To: <CAPig+cT71R1qYTkshvQNpOepOskz3LNDCc4eiih-8H9LDJmf-A@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 23 May 2024 14:50:03 -0400")
References: <20240514124411.1037019-1-knayak@gitlab.com>
	<20240522090326.1268326-1-knayak@gitlab.com>
	<xmqqbk4wy3ji.fsf@gitster.g>
	<CAOLa=ZS31CuL8kDODNfM5L8gXN6RUOG5uEP5Q9JzEuaxtLEZ8g@mail.gmail.com>
	<xmqqr0dsv6e8.fsf@gitster.g>
	<CAPig+cT6_j80vh_HEjg6HWKXpkv-huggudShh_RgzLSKvV_bOA@mail.gmail.com>
	<xmqqo78wtn7y.fsf@gitster.g>
	<CAPig+cT71R1qYTkshvQNpOepOskz3LNDCc4eiih-8H9LDJmf-A@mail.gmail.com>
Date: Thu, 23 May 2024 12:06:08 -0700
Message-ID: <xmqq4jaotkkf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 83CF0098-1937-11EF-8CAF-25B3960A682E-77302942!pb-smtp2.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

> Placement of the range-diff in the cover-letter was a deliberate choice[1].

OK, and the reasoning in [1] still makes sense.  Short-and-sweet
stuff with denser information contents first, before a bulky "diff
of diff" we add as an auxiliary piece of information.

> Regarding your experiment[2] to place the range-diff at the end of a
> single-patch, apparently that idea had been considered, as well, but
> it was noted[3,4] that, by default, some MUIs hide everything after
> the "--" line.

That is different from what [3] noted, though.  It was "the stuff
after '-- ' not included in a reply/reply-all when responding".

 (1) As we'd rather want to see the actual patch, not a part of
     range-diff in the cover letter, responded, placing it under the
     "-- " mark and excluded from the response is actually a
     feature.

 (2) If we wanted to, we can show the log message, "---", output of
     "git diff --stat -p", output of "git range-diff" and finally
     the "-- " signature mark.  Receiving end will not mistake the
     range-diff output as part of the last hunk of the last patch.

So, I do not see it as a reason to refrain from placing the range
diff output after the main patch.

Thanks.

