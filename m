Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7073C32
	for <git@vger.kernel.org>; Sat,  9 Mar 2024 23:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710026388; cv=none; b=YiMMcwKG4dVq01A/lUUbek3OFD0qY1CIzQe5Y2XQMFZdr0SEOOuPwReJAR/+eg0M7qGNWKo3MbzlCZxlvAKE4TQOCzS9FJYMCgdi2MrGvPdo1DXpua+dw3YojqctMVgJTizw+qdNZg3aqmwBk5Egfou9R7covxpylHC/fjsrqnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710026388; c=relaxed/simple;
	bh=1j+oonR4ed9eLGYGxsw4t4XO78ejXPmCdLAg54P5KKQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kO5trhszxg/5dkdkIcHBYDbvZbpPdMrlucnmfCKiZNY1eKrVQlL74yAdTgMc+/xNiGXTBRpQZCqRbDmkesIsK2IeSg17H/l8c3Cnym2rmS5Xw81dqT1kCq/iWmgPTK1a/AmkV1jR8dg5vzuWyUE9vZQMr66v4sNwvED0oAiycQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vpoDLUaQ; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vpoDLUaQ"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C4E1A1DA895;
	Sat,  9 Mar 2024 18:19:45 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1j+oonR4ed9eLGYGxsw4t4XO78ejXPmCdLAg54
	P5KKQ=; b=vpoDLUaQeuOzJt4+tofhBFSDFJoly8FZI6nTwjiIbAKz2XF8pCnrYy
	hm0axBdsRPICed0HF8spOAUiW51THHuePNYzqKUusZIFh6gpBkfh7qeDzSTbQZz2
	/HDI0fsNhyq0y8zhoFXTDTw5HPLYqUAAIJnTkhj6OpfQtuhvpRRAc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BD1781DA894;
	Sat,  9 Mar 2024 18:19:45 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 316311DA893;
	Sat,  9 Mar 2024 18:19:45 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] sequencer: allow disabling conflict advice
In-Reply-To: <xmqqle6rch89.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	09 Mar 2024 11:55:50 -0800")
References: <pull.1682.git.1709396291693.gitgitgadget@gmail.com>
	<xmqqwmqiudna.fsf@gitster.g>
	<6ef490d2-ce0a-f8bd-8079-6b4ef3e37eda@gmail.com>
	<570a8736-5552-6279-4aea-8acdf8af50df@gmail.com>
	<xmqqle6rch89.fsf@gitster.g>
Date: Sat, 09 Mar 2024 15:19:44 -0800
Message-ID: <xmqqh6hf0z8v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 83FB3F48-DE6B-11EE-8D13-25B3960A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Philippe Blain <levraiphilippeblain@gmail.com> writes:
>
>> Thinking about this more and looking at the code, using 'advice_enabled' in the condition
>> instead of using 'advise_if_enabled' for each message has a side effect:
>> the text "hint: Disable this message with "git config advice.sequencerConflict false"
>> will not appear, which I find less user friendly...
>
> Good eyes.
>
> I agree that you have to do that part yourself at the end of that
> "if () { ... }" block using turn_off_instructions[] string.

Forgot to add "... which is an unnecessary chore" at the end.

Thanks.
