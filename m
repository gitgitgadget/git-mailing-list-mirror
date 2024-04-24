Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B13219FC
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 07:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713944261; cv=none; b=VPJYDSU6qF0mB5oX/tKlUkh5gBxm+swqkvuwewEki0e3EOr7C2SE084i3I/WpLR2PDxGLqCNtEfm/0/Afpe4FUpQB/1n39cTlD7ek3L6FWO0mjb27uVKUya0EFNCgjNlGhrRzTPY8JeYxNz9bw0AUojDl+nuaYnhsyqGAzRGQTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713944261; c=relaxed/simple;
	bh=4etF0lpPFL3LshqGDWoYOroxOcMcZ7x2ADy0Z2/D10E=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=dYE5Hvf+vC/hUxpJ3RbPfY1fTHQG3Q3Eiyfv2QecpWNbHbxOlIpfvX8E/2mITogdoiLCXb1IseLZKWuTdgMTSr2NiVwp8zs/Q6Sw8ky7JNlHI6ma/XvP6hnK+Cn1xNsd4XyYJ9rNRkO9nHXlsDoYYYqtgVTmbMeQo1D/way5q/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=YncPMN2Y; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="YncPMN2Y"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713944257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cLMq5pDAwEULqz3dEJpO/DMbOwr8QkdCMDBE2J2Sg4U=;
	b=YncPMN2Y/JqHMtOuBbdlNTZ8WPtw4ijyJ3+1F6woWtn3RBV5ftkQxGreQ1Qm5K99R50aJf
	x8Nf4B76gn2cSDx0Epw94thsr3O8S0xl06a84au+f0uDXG4Ck0tH8WyyOtZR8lAp3PzkmY
	NnIchr3IUTBalsUK3z0iIGW/0vAi6DihzDWjeDoTJaMvAkZ+Wufyb9lu4Wl6X8K9lHvWr0
	H8oDmiViiNKc/CjGkB1U2kx+jxECOteL8+9gbIZpVsNnekysDhQDpIIOOnwPv6XiSPOQ/g
	1P6X2bwhZPKs+kwo6bYMhNOGWvciQKyuVaNaEGtIhg+A6MjOnRkI0cYHz5zyIA==
Date: Wed, 24 Apr 2024 09:37:36 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: James Liu <james@jamesliu.io>, git@vger.kernel.org
Subject: Re: [PATCH 0/2] advice: add "all" option to disable all hints
In-Reply-To: <xmqqo79z2s24.fsf@gitster.g>
References: <20240424035857.84583-1-james@jamesliu.io>
 <xmqqo79z2s24.fsf@gitster.g>
Message-ID: <6516b832041a1d5020f1297c17419279@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-24 08:28, Junio C Hamano wrote:
> James Liu <james@jamesliu.io> writes:
> 
>> This patch series adds an "all" advice hint type that can be used as a
>> convenience option for disabling all advice hints.
> 
> Hmph.  I thought this was rejected already and not in so distant
> past, but I am not finding a discussion thread in the archive.
> 
> The design to support the advice.* variables to let individual ones
> to be squelched, without allowing "all", is very much deliberate.
> 
> A user may think they are familiar with all the advices already, but
> with "all", they'll never get a chance to learn new ones added after
> they set the configuration.  Looking from the other direction, a new
> advice message is a way for us to tell our users something important
> for them to know.  For example, we may plan to improve a high-level
> Porcelain command so that it will eventually error out when given an
> input that used to be accepted but behaved in a way that newbies
> felt confusing.  In the first step of such a transition, we will
> introduce a new (and hopefully better) way to achieve what the user
> wants to do, and add an advice message to tell the user, when they
> trigger the codepath whose behaviour will change in the future, in
> the old way that will eventually go away.

I'd agree with Junio.  Having "advice.all" is like a chainsaw, very
useful, but also quite dangerous if not used properly.
