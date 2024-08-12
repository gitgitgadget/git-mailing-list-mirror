Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F26C18E030
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 18:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486412; cv=none; b=gFsYM+vwrwjf7Y54yU6T1KixOFoy4cXbxcLUfuyFwWnOz2UHdOFb6CiDFf0lhG8cZ65MykspVzEo5CTb6u7UMmKvmusUUL1jlNSZCsfRCdX7xZ/AMgqcOD+PrqMb4yHZBdJ0gdzhDmPVHihTaiPKIEQw515RPEc5zOtXrhD1cpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486412; c=relaxed/simple;
	bh=lAkCZlng009dOjzNX+I2gvDQaF9mMzGtxR1MWeFlPrk=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=kLDwdkIx59AjpirCc3eIOGtDhjUQOI1m+3GNK8hK8ZyjAkpkE6knY4R5wVe1UduMczT91hsZvKdwxRX23AkwXZx8/+694F/77kZdS+e9Uvd2kR3No0D3Ofejgn6nsq0JR8Q709SOV7mByuzxrxyU6/SLipUz39z5nY3JCFFzEt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 47CIDI0j1495609
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 18:13:18 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Josh Steadmon'" <steadmon@google.com>,
        "'Patrick Steinhardt'" <ps@pks.im>
Cc: <git@vger.kernel.org>, "=?iso-8859-1?Q?'Ren=E9_Scharfe'?=" <l.s.r@web.de>,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "'Kyle Lippincott'" <spectral@google.com>,
        "'Phillip Wood'" <phillip.wood@dunelm.org.uk>,
        "'Edward Thomson'" <ethomson@edwardthomson.com>
References: <cover.1722415748.git.ps@pks.im> <cover.1723095269.git.ps@pks.im> <k6uar46lu7ffbnboguca65afwegpcpfrivzfm7gspcorfefxnw@csqkd7wsoggk>
In-Reply-To: <k6uar46lu7ffbnboguca65afwegpcpfrivzfm7gspcorfefxnw@csqkd7wsoggk>
Subject: RE: [RFC PATCH v3 0/7] Introduce clar testing framework
Date: Mon, 12 Aug 2024 14:13:13 -0400
Organization: Nexbridge Inc.
Message-ID: <031401daece3$4f6d5eb0$ee481c10$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE2Q9x0fuag13GoRDOLG7kBaq5wcQJKqFjGAgrSzsizSpLFEA==
Content-Language: en-ca

On Monday, August 12, 2024 2:11 PM, Josh Steadmon wrote:
>On 2024.08.08 07:38, Patrick Steinhardt wrote:
>> Hi,
>>
>> this is the third version of my RFC patch series that introduces the
>> clar testing framework into our unit tests. The intent is to not have
>> to hand-craft all features of a proper unit testing framework, while
>> still not painting us into a corner. As such, the clar itself is small
>> and extensible while still bringing some nice features to the table.
>>
>> Changes compared to v2:
>>
>>   - Fix a copy/paste error for the clar license. It's ISC, not LGPL.
>>
>>   - Include "clar.h" via "clar/clar.h" such that we do not have to add
>>     "clar/" as in preprocessor include directive.
>>
>>   - Adapt strvec unit test to use `cl_assert_equal_i()` instead of
>>     `cl_assert()`.
>>
>> Thanks!
>>
>> Patrick
>>
>> Patrick Steinhardt (7):
>>   t: do not pass GIT_TEST_OPTS to unit tests with prove
>>   t: import the clar unit testing framework
>>   t/clar: fix whitespace errors
>>   t/clar: fix compatibility with NonStop
>>   Makefile: wire up the clar unit testing framework
>>   t/unit-tests: convert strvec tests to use clar
>>   t/unit-tests: convert ctype tests to use clar
>
>I'm generally in favor of this change, but I'm still unsure what our plan
is for
>importing this from upstream clar. Are we going to vendor our own copy here
and
>(hopefully) someone will pay attention to upstream fixes and apply them to
our
>copy? Or will we replace this with a submodule?

I think we have our own copy of clar, customized to integrate with the
existing make
infrastructure.

