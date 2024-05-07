Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA5650A67
	for <git@vger.kernel.org>; Tue,  7 May 2024 17:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715101586; cv=none; b=RltTpKdPjZb6SR2p+DArf70JEzkREu53WPW+cZ4nOBLAXdhNU15vSx1ItSO+2JEZWWJTG/eu+dFCaxBIS0mw1hwhqsjXY0cAZsfTG0w4Lp2m0K1xZ0GL7H/KhlcZ+I4FhvXdfGtp4Vv+epAXpqezsIZT8qLr5YOZ0giRcOyPNWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715101586; c=relaxed/simple;
	bh=3MJ19zqdFrTeg1xZfJ1qquwc/yWOK8lteU7VZreKIKY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K1zT6wbJXiIbQnJGWQgAdfxk0qIHEOMnFe2fVAZbzJ/CepkVs15R+zV1Kh48WWA8R5ZD58mtl8OHQC6fVnfZWO7KoNJ+JaCtierjomdLmaN3n3f6KMoMz90vzP/OnbVzTtvXCfVSEpxaT5QApqNjm8QQyRDyoYAR+USPWXaFWdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VDQpZo8g; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VDQpZo8g"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A77EE32A2C;
	Tue,  7 May 2024 13:06:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3MJ19zqdFrTeg1xZfJ1qquwc/yWOK8lteU7VZr
	eKIKY=; b=VDQpZo8gqlccA9z54qDmbMa1yJvjIFeTg2lM8LNydSgA8Lwh8p/IKV
	VhGn6zVSLUiybQms5GJrjX71w4xOgUyXF1A78XxQP6wDibZx27pYL4Lq0RAg2yVl
	UZrbgnv14nynaZ31o3YZgLIyZugLxVk5TSM2LVHxxHuJ64y7PiTto=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9FF6132A2B;
	Tue,  7 May 2024 13:06:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3137F32A2A;
	Tue,  7 May 2024 13:06:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: John Passaro <john.a.passaro@gmail.com>
Cc: John Passaro via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 1/3] builtin/commit: use ARGV macro to collect trailers
In-Reply-To: <CAJdN7KhFtjWZfuGPsu2gWy7Dqth=PsVpA_d8923aNUqmQu8Phg@mail.gmail.com>
	(John Passaro's message of "Tue, 7 May 2024 11:38:29 -0400")
References: <pull.1723.v4.git.1714488111.gitgitgadget@gmail.com>
	<pull.1723.v5.git.1714934950.gitgitgadget@gmail.com>
	<85f45a57f3529a90324ded07856fca610f7b5eda.1714934950.git.gitgitgadget@gmail.com>
	<CAJdN7KhFtjWZfuGPsu2gWy7Dqth=PsVpA_d8923aNUqmQu8Phg@mail.gmail.com>
Date: Tue, 07 May 2024 10:06:13 -0700
Message-ID: <xmqqttj9pn5m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1CF388E4-0C94-11EF-A04B-A19503B9AAD1-77302942!pb-smtp21.pobox.com

John Passaro <john.a.passaro@gmail.com> writes:

>> From: John Passaro <john.a.passaro@gmail.com>
>>
>> Replace git-commit's callback for --trailer with the standard
>> OPT_PASSTHRU_ARGV macro. The callback only adds its values to a strvec
>> and sanity-checking that `unset` is always false; both of these are
>> already implemented in the parse-option API.
>>
>> Signed-off-by: John Passaro <john.a.passaro@gmail.com>
>
> Looking over the patch series I notice that I left a grammar error in
> this description,
> if the patch makes it to the "next" branch I hope you can amend the
> message first,
> as follows:
>
> Replace git-commit's callback for --trailer with the standard
> OPT_PASSTHRU_ARGV macro. The callback only adds its values to a strvec
> and sanity-checks that `unset` is always false; both of these are
> already implemented in the parse-option API.

Thanks for stopping me before the topic got merged to 'next'.
Amended.
