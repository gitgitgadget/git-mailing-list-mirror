Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2111EA87
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 17:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719248943; cv=none; b=b5P33assfoz6mCpWbZsKsknQ6irDkFeKdatlyE26KmJmA9/sdU7Tief279YEMttHQ3KVTY7D6ED1NPGidOphASysqIwILR3CYyX6jznHBGzzqmAfHutglPUg/8A9q3CQfIick2zwtj95PRUIYyMJamu8zC2wz2n+wFqDSvaU4vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719248943; c=relaxed/simple;
	bh=6PW+vPsBGs1HVx7kWjDeOuRR94pesAJZPvtYt8NTTG8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=RRZdcNVgqUU9Q/7MWHI8xJx5hDkHH+X6enxAJu3Nx3IAEWTgbbe04hxCkOybBePI4C50t+tPFJhDjLqHSywviYbvNLBpO+gTrYUj7N50LcOvywXZdeEJ3hBYFR0zEs6RK7gkGlts/0R+430x3X8rbW7s+iXPVTmjwDIUSTkBKlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=GPJd5vmJ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="GPJd5vmJ"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1719248937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tLcZTBr9eEXoLrZ9v3nUMJVA8IjWTI0YttiabzGL2Dc=;
	b=GPJd5vmJw929QXV4rRiwVsuslzd3XWjMtZU7+oMP4FRqM1uISQmvhNfOXcGqzQuBNAKc0S
	iCq95D9H+8amk2OXo8G1s/xDi+6U2Cax5XiB7rTUsUd6ks71/EYSrBelSWw9xK9oT+wiFl
	20Xe599Qu+rd8+QIr9fHJue/x/it9MqiGRys3NM3qeLnVfYG9xJrjq9YKX0+moByU9ZccU
	7GMuqV9GSI6dibS0w5G7yJzEBdhJ7Rq/2t+BHcodIXnCOWLgu4lPOLsD2LFoZ/I8Nzkuf7
	/VvcDAXdxqiWeKM1TVgZc2oNuiI7iG7113UQO3ong97ZS3w63dkrGqfHyx7xoQ==
Date: Mon, 24 Jun 2024 19:08:56 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Randall Becker <randall.becker@nexbridge.ca>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, "Randall S. Becker"
 <the.n.e.key@gmail.com>, git@vger.kernel.org, "Randall S . Becker"
 <rsbecker@nexbridge.com>
Subject: Re: [PATCH v2 1/2] Teach git version --build-options about libcurl
In-Reply-To: <DS0PR17MB603115E943565C4281FBE199F4D42@DS0PR17MB6031.namprd17.prod.outlook.com>
References: <20240621180947.64419-1-randall.becker@nexbridge.ca>
 <20240621180947.64419-2-randall.becker@nexbridge.ca>
 <f44f1e25-41ca-0784-3186-f9e1bdae0d4f@gmx.de>
 <DS0PR17MB603115E943565C4281FBE199F4D42@DS0PR17MB6031.namprd17.prod.outlook.com>
Message-ID: <5dc18b418f57cb8376b9fd9a5a4ad9d7@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-06-24 16:33, Randall Becker wrote:
> On Monday, June 24, 2024 10:13 AM, Johannes Schindelin wrote:
>> I am not sure that this is the most helpful information Git can 
>> provide:
>> It reports the version against which Git was _compiled_, whereas the 
>> version it is
>> _running against_ might be quite different.
>> 
>> Wouldn't calling `curl_version()` make more sense here?
> 
> I think the more important information is the build used. My reasoning
> is that one can call run curl --version to see the current curl
> install. However, different versions of curl have potential API
> changes - same argument with OpenSSL. What initiated this for me (the
> use case) started with a customer who incorrectly installed a git
> build for OpenSSL 3.2 (and its libcurl friend). Git would then get a
> compatibility issue when attempting to use either library. The
> customer did not know (!) they had the git for OpenSSL 3.2 version and
> I had no way to determine which one they had without seeing their path
> - hard in an email support situation. Having git version
> --build-options report what was used for the build *at a compatibility
> level* would have easily shown that the available library (after
> running openssl version or curl --version) reported different values.
> Otherwise, we are back to guessing what they installed. The goal is to
> compare what git expects with what git has available. The above series
> makes this comparative information available.

How about announcing both versions of the library if they differ, and
only one version if they're the same?  We're building this to serve
as a way for debugging various issues, having that information available
could only be helpful.
