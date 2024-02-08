Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B861144C73
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 20:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707424558; cv=none; b=JoiZ8klop7lrto+JtFEqhc4TnNZVSMQEtFLxcmSfeFdbpNHdwsn5L6sRdRzCWOmGc7HrhpZzT/yDlrut0C3dVztgtryNEolBidDcedxDfVY5LTYtKeAvHQ+sekq6apkQgMjfr/BHcbmkWAt9LDU1OR3AS3C8Z9qFgKduFzpQSKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707424558; c=relaxed/simple;
	bh=bOjJQ4zogdOxwyYdqTKW0dU/D1Wm6BCzLZEoHFYpQsY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=kuc1Grrum+RchIeWoe8pnaS84jhZSo7EqLMQq6UFsmlB06NOecoedDtBpYajHejb9FkVYtr/e5rV3axkl7J4f7mv2+mbLlss7Bp5+DnKUOW7vp6ey3alKZRqHLjoU3hJrf7Ksce321SlejooQnPH8jue2N7aPIokP59xIcW4od0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=DpBxOezB; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="DpBxOezB"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1707424553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SAd8TTLaBlMXcnKMSN9DFSYmqn1JD0y3eIVi47u7Lbo=;
	b=DpBxOezB+vK16x2KGFEiB8c++bnjVZ/kHjs0UsXQ2WrXUGikAoX8lhXQclETqyE3jF1IL4
	H7a7kFs9fynj4TAIPxotIMqT6pxL2P9+8T0zosLXpeI0TRjXlsBKlS/q0uolNUdAoIkf7E
	gcNvMbM7XNxCUT3s0LuTJN2zFba+YmA47cNFl3g8BKlGc2Kr1TJ2rl2sFEfb8pLlWijpzS
	E77jbv0htS2iQQRvDwIk6BWWItdlwRStxhdf34QGQwyBMe3qaiTxjTsTynnSjvNn0II85v
	wqP+Lkt2JtnEJh69Hbb8Y/3Q3ZaikDltCnw5VGiXR2JoZgc5K9RvfXsLfjPzYw==
Date: Thu, 08 Feb 2024 21:35:52 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: cloning the linxu kernel repo at a VPS with small RAM
In-Reply-To: <6c4e309aa77e534cffdba9ae56032b99@manjaro.org>
References: <2f773980-70ec-4ad0-a49c-3ac12c294a39@gmx.de>
 <6c4e309aa77e534cffdba9ae56032b99@manjaro.org>
Message-ID: <b532a9fd7b363b1dd8da2e8d15d995cc@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-02-08 21:16, Dragan Simic wrote:
> On 2024-02-08 18:32, Toralf Förster wrote:
>> Situation:
>> 
>> The command
>>     git clone
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
>> fails at a virtual server with about 2 GiB RAM under a recent Debian
>> bookworm with git 2.39.2. What works for me:
>>       git clone --depth=1
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable
>>       cd ./linux
>>       git config gc.auto 0
>>       git config pack.threads 1
>>       git fetch --tags
>> as seen in [1].
>> 
>> Q:
>> I do wonder if Git could automatically try to deal with only 1.5 GiB
>> available RAM?
> 
> Here's an excerpt from my ~/.bashrc, which sets the things up
> on my Pinebook Pro laptop with an RK3399 SoC and 4 GB of RAM,
> which is also thermally constrained:
> 
> # Missing nproc(1) is handled properly
> REASONABLE_THREADS=$(nproc 2> /dev/null || echo 1)
> REASONABLE_THREADS=$((${REASONABLE_THREADS} / 2))
> ((${REASONABLE_THREADS} == 0)) && REASONABLE_THREADS=1
> 
> export GIT_CONFIG_COUNT=3
> export GIT_CONFIG_KEY_0='grep.threads'
> export GIT_CONFIG_VALUE_0=${REASONABLE_THREADS}
> export GIT_CONFIG_KEY_1='index.threads'
> export GIT_CONFIG_VALUE_1=${REASONABLE_THREADS}
> export GIT_CONFIG_KEY_2='pack.threads'
> export GIT_CONFIG_VALUE_2=${REASONABLE_THREADS}
> 
> export ZSTD_NBTHREADS=${REASONABLE_THREADS}
> unset REASONABLE_THREADS
> 
> Obviously, this does a bit more than configuring git only.
> 
> Perhaps modifying this to additionally take the amount of RAM
> into the calculation of REASONABLE_THREADS could be a solution
> for your use case?

Actually, perhaps we could provide the following files as part
of the git project, which would take the above-described approach,
and let the distributions package them:

  - /etc/profile.d/git.sh
  - /etc/profile.d/git.csh

If everyone agrees, I'd we willing to take a crack on these.
Of course, all suggestions and thoughts are more than welcome.
