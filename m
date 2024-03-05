Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4B0127B5A
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709653340; cv=none; b=Ar9KFBsvu6nRzqPcxj6uSKgR6EHIccVmUv5IQHcrJW3tfk9yEz78dHe0ZqUPZOUfk/OETueTdwOijH9Y7twwxnLTmmYWC7Q9iaBeyMuT1cgoMvvtPDLPC1AzG2HGMAxPzP+w93+J+cg8/Ens7LLY7Z98f2dGGFmSFUhDCOkeg4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709653340; c=relaxed/simple;
	bh=ly6C8h0hVJRTv7zQDI3/LNOmm4qt1mGPwAqqv39sbWc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=HeK4ZfyXW4zZL0SnqxoXw7rds/CSOFhq2FgG3ejtpXekK1zO5jEZzy5693ShZJDbytxuzsGo+7msTLeoMwPvh/khK0k+BvMEvTw9C13GarNdA9nZ9WKKyeJXmleKeoK7ZBs3X8KBNKfFzia5srx0WeCk3FB9Z8TSYlRI98W1qro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=fo6yjjVQ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="fo6yjjVQ"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1709653328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H9K4PFiDttAIH+lc0UcIEFIB0PimSXvMcpFbzGoUmu8=;
	b=fo6yjjVQlAV2jOw1g/zjk2wVUeeGEk44N0oPp41xWNwbvPMAMJzdWioQeTvdiMGqqUSq6m
	jEspkeLCpGc4wU5RTS/udvUNPCeMpAnibbZlhgGAnttqbtL1tKQwsDiL588WMIPcNYaSWW
	QQkrneqESNXO8kkDM113imt/rkGtfis3vL7d8e4+/GO/AyHQJdIKxpCKJLuvSO3ErAJJfc
	t3qZ2S/sdrVk/1FMX3NH+LWav1e2UTnHIuTyjKunVGOAYe3wmJih8amctGG9c1HQ4GNOje
	SYc4X6ieLCUWK6MwCD1dQWXPqxsIfVCiGuKYSJG+03IY4fE/XnXiPviOiGRH5A==
Date: Tue, 05 Mar 2024 16:42:07 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, Manlio Perillo
 <manlio.perillo@gmail.com>, git@vger.kernel.org
Subject: Re: Clarify the meaning of "character" in the documentation
In-Reply-To: <xmqqsf1466eh.fsf@gitster.g>
References: <CAAToxAEE-2B_8Wqrquk1peOnqTbOpV_8KZmsJ2dgk-mfCZXHiA@mail.gmail.com>
 <5e10f1e5-b87f-43cd-ac1e-d7c01b7dad21@app.fastmail.com>
 <xmqqsf1466eh.fsf@gitster.g>
Message-ID: <52d6850914982ffaf15dda937d611ffb@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-05 16:32, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:
>> I think this is more about `git config --add` not doing any
>> validation. It just sets things. You can do `git config --add
>> core.commentChar 'ffd'` and get the same effect.
> 
> As you said, we should document core.commentChar as limited to an
> ASCII character, at least as a short term solution.
> 
> I personally do not see a reason, however, why we need to be limited
> to a single byte, though.  If a patch cleanly implements to allow us
> to use any one-or-more-byte sequence as core.commentChar, I do not
> offhand see a good reason to reject it---it would be fully backward
> compatible and allows you to use a UTF-8 charcter outside ASCII, as
> well as "//" and the like.

May I ask why would we want the comment character to possibly be
a multibyte character?  I mean, I support localization, to make it all
easier for the users who opt not to use English, but wouldn't allowing
multibyte characters for the comment character simply be a bit unneeded?

Maybe I'm missing something?
