Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88B5625
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713707459; cv=none; b=UXn29zvjKlbWAzi6wL3+RFsaZEdDXzm/k7cKW/2paiM7oqCUiWWa6oiZ+m7KrU4eEskRKt8Ab7FPUJZeOqbXN9SG01fCLSfy6l7i7ar2HC9m/Ccb24Qq+g1xpoWrPQ3UmF1Efxn2G6DlRqenvxjQoteucqbQtjdhfgsATK4HvhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713707459; c=relaxed/simple;
	bh=/dHg7M+NQdlRY6YAqKUstOwmAdQMql5eujdT7pD4dIc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=gwqxwcqrzThLtFiJY01bMfI4O02rgEIq1r2jUuCOSp3eUtW0X90Aw5Ut6pJf8OeSSQ86kkc8mtjzKjiYiZhxEMc5DC5j4FXcCcgOFtNYCH3hEPLkxDdmyVlDyyZWPtWrrxp/tHooyN0vWJoiUavJgffDifjg9qi3zN4WG9KjhGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ZS/ArKma; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ZS/ArKma"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713707447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WI/rQlDeZKtJ6HVjk/tV5gXP8hC5GpsQL6r1VKcMcXk=;
	b=ZS/ArKmaYc+yajngZmVNfdYM3Fr5BkWJBMYEMABXQ6Cgjqw6ggK1fhbaiZZQgMCFGKT0pr
	4s0m2qZWB45G1dQhUpsr9Iz+QS7LvMcx8r8NHR/TypaNDALa009C+8NPeOvGuqYZ6RSfS4
	qVF+d0782yLw3B6FwwfDJGSvotZOukLH+NUwQksXSos4JNhjePc/D0p302WA9LQT0AXhKD
	ue9RpmWVkZnSsl9asSymbxQ+XmekGuaLBL+3T7yXdBnR00E6uEdHy+ShpIWwmmiMZznSCK
	MvGdjQb3oL1bNg6LjuiOBvtlSgvDuT0IK+aO3NVKBlmc6uN170NGDU5wislgEg==
Date: Sun, 21 Apr 2024 15:50:45 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Junio C Hamano <gitster@pobox.com>, Eric Sunshine
 <sunshine@sunshineco.com>, Phillip Wood <phillip.wood123@gmail.com>, Patrick
 Steinhardt <ps@pks.im>, git@vger.kernel.org, Drew DeVault <sir@cmpwn.com>
Subject: Re: [PATCH] format-patch: ensure that --rfc and -k are mutually
 exclusive
In-Reply-To: <0d584b86-0b48-4e7f-b81c-fdb672dac98b@app.fastmail.com>
References: <71d195c248879e7c46fac0e84c6b0a8aa90bd2c2.1713488563.git.dsimic@manjaro.org>
 <0d584b86-0b48-4e7f-b81c-fdb672dac98b@app.fastmail.com>
Message-ID: <2ffb6a2c888e5bc901e0c903c335d0f7@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-19 15:43, Kristoffer Haugsbakk wrote:
> On Fri, Apr 19, 2024, at 03:05, Dragan Simic wrote:
>> Fix a bug that allows the "--rfc" and "-k" options to be specified 
>> together
>> when "git format-patch" is executed, which was introduced in the 
>> commit
>> e0d7db7423a9 ("format-patch: --rfc honors what --subject-prefix 
>> sets").
>> 
>> Add a couple of additional tests to t4014, to cover additional cases 
>> of
>> the mutual exclusivity between different "git format-patch" options.
>> 
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> 
> Looks good to me FWIW. Also very good description of the changes from
> the previous version to this one.

Thank you!
