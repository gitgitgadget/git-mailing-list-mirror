Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CF51E520
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 20:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708114380; cv=none; b=Wtvilq8GPsm7lrERv1H9XLd4DQA2Lg/kr/CvvTIYXdgGGofElweSpfY466OKlQcot7w46ILS+fMvNiyScGQdj73Rz96pBKzVMaYVKwzEnpAuW2TkKoQJwdUl6K8/f9SZnTNry839vAZm+iwREls2uQy/D7y10hPxChST8+UsvU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708114380; c=relaxed/simple;
	bh=BCsBw0W/k988qD9BJERTnz0aVI1SlPC95VF6B6s6iHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=taGCRyvlkgZ3VV0Bx9eMpqztiW35DzsRIvwX8VL/kpmhdnJq7Riqix88F8e7LgccsqRFjVZL9/gU6MJFe2+r3wW4HoTt3OS1Vw/A3zEzCL4DpRaWq/9QNOcS1e1RXYl9Fw/MtWkxavgOYEJiVH7PTAeMaEx7Jo5M9iIbIc2gj/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jF+Y89//; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jF+Y89//"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3CC241E6365;
	Fri, 16 Feb 2024 15:12:52 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=BCsBw0W/k988qD9BJERTnz0aVI1SlPC95VF6B6
	s6iHo=; b=jF+Y89//7FXgcCWYo8GWyFkltNr2Nr6Wg3E+XjKI9SzC5Bn/UlGYkl
	ljzD4+sJ18YSfIv+skyr7pR81vZ2YwJbJVuKwDA4gtplsQNFynDIybDWtEIqSPRq
	MaLfXObAa8Wfe7S7VobTv7f3jn5/HZjvqztu+Cq+F/afGXv5Aac0o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3365A1E6364;
	Fri, 16 Feb 2024 15:12:52 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 91F401E6363;
	Fri, 16 Feb 2024 15:12:51 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: Beat Bolli <dev+git@drbeat.li>,  git@vger.kernel.org,  =?utf-8?B?w4Z2?=
 =?utf-8?B?YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] completion: use awk for filtering the config entries
In-Reply-To: <fcd3f999-a8d1-9f9d-e8fd-071b38124edc@gmail.com> (Philippe
	Blain's message of "Fri, 16 Feb 2024 13:47:42 -0500")
References: <20240216171046.927552-1-dev+git@drbeat.li>
	<xmqqr0hcjorg.fsf@gitster.g>
	<fcd3f999-a8d1-9f9d-e8fd-071b38124edc@gmail.com>
Date: Fri, 16 Feb 2024 12:12:50 -0800
Message-ID: <xmqqwmr4gocd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C31066B0-CD07-11EE-9563-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Philippe Blain <levraiphilippeblain@gmail.com> writes:

>>> Junio, this goes on top of 'pb/complete-config' which is on next
>>> currently.
>> 
>> Alternatively we could redo the topic, squashing this fix in, after
>> the release when we rewind 'next'.
>> 
>> Thanks.
>
> Actually you already merged this topic to master in 89400c3615, so it would 
> go on top, no ? 

Ah, then that's fine.  I didn't check what I read above myself
before responding X-<.

