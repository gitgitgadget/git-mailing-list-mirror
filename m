Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D240712FF77
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 18:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706724884; cv=none; b=DmddHBWeGYbE8NUVhVt5NpdP/VtZ4qUHb7aKsrtdCAJygSi3BNe2kX8vov5sJR0GILrpUVVPetmD9wvWSKWf9TzRARNbUri0dcFc6d7k39Te+Z7Zcoyj1A5EfkmKJymyM+Jm2SWADEN3BlNK10OsP5Ou5cRSEblZWu7uyQCdGK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706724884; c=relaxed/simple;
	bh=VABSXniSuNGAsaZXwq6MDHqlLW6COnIyMfBydB626pY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nmUsvM6YkjRDXzNyueDjFiNgUdnTC4cz5rHI/JsjEAoExGZ/lbsLa91ZjccQKfFh1gwZqZx3E2WmSYqOvlfcIxT09Fb3eFmbIuZNpxeqMJy1hF1CuPDv9yxwV8C221rafdzlX/u2SNTvvHSJP3+v5BnZ8tapOqw0i1KpeIPe4vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mhUw6srX; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mhUw6srX"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 639541E9E02;
	Wed, 31 Jan 2024 13:14:41 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=VABSXniSuNGA
	saZXwq6MDHqlLW6COnIyMfBydB626pY=; b=mhUw6srXTQlKGIwynVPoPYzkAg8B
	9k+c//Pnu4JiQqSfUpVtDxWujERivB5uqpQ0ejAETxnKuMcuuAxKTJ/aacUKANc/
	YpcZgioI9D8MCamWtZcEB6/PCNIzv/+NiiKpaBe84Cu99aHiesN+MrPtuP7p92gz
	ej/FYrKVy5sb5+4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B10A1E9E01;
	Wed, 31 Jan 2024 13:14:41 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9CA7F1E9E00;
	Wed, 31 Jan 2024 13:14:40 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] merge-tree: accept 3 trees as arguments
In-Reply-To: <CABPp-BEDLsVFxjr13XJX9eBLeqD+tRoeHxwJyPsc_+AgGY2GTw@mail.gmail.com>
	(Elijah Newren's message of "Wed, 31 Jan 2024 08:34:13 -0800")
References: <pull.1647.git.1706277694231.gitgitgadget@gmail.com>
	<CABPp-BFPe_RrX5ZHo7-mMHHS96j_O+1wiEwGC5+zGPP5h+686Q@mail.gmail.com>
	<xmqqbk92bv43.fsf@gitster.g>
	<CABPp-BEDLsVFxjr13XJX9eBLeqD+tRoeHxwJyPsc_+AgGY2GTw@mail.gmail.com>
Date: Wed, 31 Jan 2024 10:14:39 -0800
Message-ID: <xmqqil3974kw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 99E9F8DC-C064-11EE-BD0F-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Elijah Newren <newren@gmail.com> writes:

> On Tue, Jan 30, 2024 at 9:15=E2=80=AFAM Junio C Hamano <gitster@pobox.c=
om> wrote:
>> ...
>> > but aaaaaaa and bbbbbbb are not commits that they can find.
>>
>> Correct.  They are what they fed as two trees to be merged, aren't
>> they?  They (or the script that drives merge-tree and fed these two
>> trees) should be recognise these two trees, as long as they are told

I notice "able to" is missing here...

>> that is what we show, no?
> ...
> Yeah, I was worried though that the end user wasn't the one running
> the git-merge-tree command, and was trying to dig more into usage
> cases.

Sure.  That is exactly why I wrote "They (or the script that
drives..."  above.
