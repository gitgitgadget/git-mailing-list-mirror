Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B4729CF2
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 06:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712729267; cv=none; b=MLKB+7wKASDcGzWXj+RS8wL63tcVsLSDcZ7ns5rnCDxpBMgWsYmunKHs1KO3gxud0ylu07rSCVm5cF3s0ItS+tMLGnlh6x2TJWTJ9OhHEnyzPHAUwW0fL71B/7AfSwXkU7FgZfXVifAighF9pucN8VCjotfktNC13udHsyVE5ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712729267; c=relaxed/simple;
	bh=f4gCXzblQ0xqke3LuA2v+hv6ppdC/flrByaonzMlYvg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=gOKMPduprClr60vzhNwWvk6hC9weCwORHHgD0uZ+UJKspOJwBvIvNUK4AF2tv4UyGKat+8BQm5u8wwtBIscNhVGsiybhVpSJhBf0I6h5hK0gckCQbIt13MAtOoxPmhmJbTMTAbBCnOTcndm7yx7swiyGvs9h3cLovjuOdTuFONs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=RyKuCiLi; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="RyKuCiLi"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712729263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=61xGBVODq3Y1vqMJqMCJedNKYrxmjHbuvjE3hfQs8oI=;
	b=RyKuCiLiE/dw2lofwUDrMd/U+Se8ssV8AECuhhXjbQe/1tYtmNAgtCanIJETsDQ69Le8+l
	j/nIBDdDcK8ZynecAupJmsurXsX5svz+mwCuwXhdnUrk3iHKeVFxibHG7nDIv08LW8E4ZG
	oeOIwx/lJYWEPumU2+oARzuD9Jj2nMvrEZ3Sq1NoBJqWyp675cWNcafXeJfAO5UCt+657b
	91LEGNaXPS0Wrps4LI0AmlzrW6KJsIrDcD9XZLeiodFVzabsWA+z0Zi3359icHQKmpygin
	3e3o5vc/lyVZ2P1YSVwLBVdBdGNWEbpGQ6NcOZqgCOwRPcBcuX/kyR7Ik6l/nA==
Date: Wed, 10 Apr 2024 08:07:42 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, code@khaugsbakk.name
Subject: Re: [PATCH v5 3/3] send-email: separate the confirmation prompts from
 the messages
In-Reply-To: <feabd3a4b4fc6f03d31b59340bc238cc@manjaro.org>
References: <cover.1712486910.git.dsimic@manjaro.org>
 <7b99e5c7c0b0c8d3d7eaaae169e650ebe81964a1.1712486910.git.dsimic@manjaro.org>
 <xmqq1q7fa6u7.fsf@gitster.g> <bc3998b1c9bbdbc75287735b42013f52@manjaro.org>
 <feabd3a4b4fc6f03d31b59340bc238cc@manjaro.org>
Message-ID: <a70e1098f177cc84f8834fac0ac6f253@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-10 05:53, Dragan Simic wrote:
> On 2024-04-09 05:25, Dragan Simic wrote:
>> On 2024-04-08 23:21, Junio C Hamano wrote:
>>> When $confirm is set to 'never', you have both $needs_separtor and
>>> $prompt_separator set.  Would it mean you'd have two extra blank
>>> lines for that message?
>> 
>> Actually, there are no unneeded blank lines in that case, which
>> I've also tested before sending the patches.  One of the blank
>> lines (the one for $needs_separator) goes after the patch messages,
>> and the other one (the one for $prompt_separator) goes after the
>> prompt, which is displayed before the patch messages.
> 
> Actually, there's a much, _much_ simpler solution for everything,
> which also works as expected when running "git send-email --quiet"
> with sendmail.confirm set to "auto" or "never".
> 
> I need to test it a bit more, and I'll send the updated patches.

This new, simplified approach works well, but I've spotted some
more scenarios that also require addition of newlines.  Though,
based on previous lessons, :) I'll leave that to the follow-up
patches.
