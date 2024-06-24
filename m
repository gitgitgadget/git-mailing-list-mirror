Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F3F8F6B
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 21:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719263751; cv=none; b=m/UIM4NGshBnotVSqsAuKagi0PRhfIV/JNe3rX1sO4bOMGQQWN4HmlKQQXudhpZ67GRfMNNcZcpEPtL6imOg29hwyswbA6hCsnTHnVswOEjVOAE7tBimSgd/HOR6iuOLbU3WrmfCqju44h6br8wAlhZLM66yhj+lo2XKmXK0iEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719263751; c=relaxed/simple;
	bh=5oY4HWZ5UtBoMEroF+MKXIWNfghzZsHBPRis1q+l1FA=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Od9OtcdK08j84f+rmyVwTk7sBbinz1M9WxpIeZFLh0yvdccu4ySLKF3sA++jOMrTs0/pXScbfbZL+MgVgP/6w77FZHfBgj3L+jedapv0th7L9Z4vylQHkLGakf7Ymk5nWM1o4D0RRLAOhiJiuKlYaU5GevaXMxIVxpeZK24DVIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 45OLFWu9532647
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 21:15:33 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Dragan Simic'" <dsimic@manjaro.org>,
        "'Randall Becker'" <randall.becker@nexbridge.ca>
Cc: "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "'Randall S. Becker'" <the.n.e.key@gmail.com>, <git@vger.kernel.org>
References: <20240621180947.64419-1-randall.becker@nexbridge.ca> <20240621180947.64419-2-randall.becker@nexbridge.ca> <f44f1e25-41ca-0784-3186-f9e1bdae0d4f@gmx.de> <DS0PR17MB603115E943565C4281FBE199F4D42@DS0PR17MB6031.namprd17.prod.outlook.com> <5dc18b418f57cb8376b9fd9a5a4ad9d7@manjaro.org>
In-Reply-To: <5dc18b418f57cb8376b9fd9a5a4ad9d7@manjaro.org>
Subject: RE: [PATCH v2 1/2] Teach git version --build-options about libcurl
Date: Mon, 24 Jun 2024 17:15:27 -0400
Organization: Nexbridge Inc.
Message-ID: <036d01dac67b$a6457da0$f2d078e0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIUAP7e2wQYDPiBW6KIInLGycvnFgIwg5sTAi49iygCg92kzgHU27qKsR84oJA=
Content-Language: en-ca

On Monday, June 24, 2024 1:09 PM, Dragan Simic wrote:
>On 2024-06-24 16:33, Randall Becker wrote:
>> On Monday, June 24, 2024 10:13 AM, Johannes Schindelin wrote:
>>> I am not sure that this is the most helpful information Git can
>>> provide:
>>> It reports the version against which Git was _compiled_, whereas the
>>> version it is _running against_ might be quite different.
>>>
>>> Wouldn't calling `curl_version()` make more sense here?
>>
>> I think the more important information is the build used. My reasoning
>> is that one can call run curl --version to see the current curl
>> install. However, different versions of curl have potential API
>> changes - same argument with OpenSSL. What initiated this for me (the
>> use case) started with a customer who incorrectly installed a git
>> build for OpenSSL 3.2 (and its libcurl friend). Git would then get a
>> compatibility issue when attempting to use either library. The
>> customer did not know (!) they had the git for OpenSSL 3.2 version and
>> I had no way to determine which one they had without seeing their path
>> - hard in an email support situation. Having git version
>> --build-options report what was used for the build *at a compatibility
>> level* would have easily shown that the available library (after
>> running openssl version or curl --version) reported different values.
>> Otherwise, we are back to guessing what they installed. The goal is to
>> compare what git expects with what git has available. The above series
>> makes this comparative information available.
>
>How about announcing both versions of the library if they differ, and only
one
>version if they're the same?  We're building this to serve as a way for
debugging
>various issues, having that information available could only be helpful.

I don't have a huge problem with that except it will significantly decrease
performance. We do not currently have to load libcurl/openssl to obtain the
build version (it is the --build-options flag), so adding additional load on
this command is not really what the series is about. Doing this run-time
check might be something someone else may want to take on separately, but
from a support use-case standpoint, it should be covered as is. Doing a
comparison is a separate use case.
--Randall

