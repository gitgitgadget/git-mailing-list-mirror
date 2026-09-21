Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA614CB8D4
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 16:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790008988; cv=none; b=u98ZXVxgzi7WMJGBDmMM/MGAjm/OSTuXBrWG2fQbd/DuYWwRGEel/ecmvg4VzGpUkTPXfkxcpEmQUW5Xn/FH0tKbiiFbczI8x31y4uLur2Bvv91uR/Gd0jJ6djOCH7uKI+zlsdgdguJ/1H1Jrf21xWndWC7RAOx8MdbJC7wmaMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790008988; c=relaxed/simple;
	bh=S1r1BmGPuKwQZe0nfVP0i6Qpd/c3iQiMqYJpINowZ+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=e5M8lrzhfzITTzoN7068b9uiXOU5FuzEKWvd/REHhq0E2BBgmUY3L61ptem7W0Nfmxn74+zgoDUoox/QKRG9oF9aYjjbmZFGkexnzvVaOiXOVqLKZl+pgtonSXmosJjWJQOo7WflMr+X6h5vi5IQl96R55A9fLoPPHQsepsLIiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4hpTYf5pDDzRnlL;
	Mon, 21 Sep 2026 18:43:02 +0200 (CEST)
Message-ID: <9d1ac51b-9969-49a1-a911-7669872d28c4@kdbg.org>
Date: Mon, 21 Sep 2026 18:43:02 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] exec_cmd: RUNTIME_PREFIX on OpenBSD systems
Content-Language: en-US
To: Chris Torek <chris.torek@gmail.com>
References: <1789994808-30642-mlmmj-3f9f948b@vger.kernel.org>
 <CAPx1Gvco17vf-rmQsqumLdX8Gcjnu0Qx=e7_PdFw0p7BDRLU7Q@mail.gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
Cc: Git List <git@vger.kernel.org>, brad@comstyle.com
In-Reply-To: <CAPx1Gvco17vf-rmQsqumLdX8Gcjnu0Qx=e7_PdFw0p7BDRLU7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 21.09.26 um 15:00 schrieb Chris Torek:
> [Ugh, somehow plain text mode got turned off, re-sending]
> 
> On Wed, Sep 16, 2026 at 8:41 PM Brad Smith <brad@comstyle.com> wrote:
>>
>> @@ -209,6 +229,10 @@ static int git_get_exec_path(struct strbuf *buf, const char *argv0)
>>          * after the first successful method.
>>          */
>>         if (
>> +#ifdef HAVE_GETEXECPATH
>> +               git_get_exec_path_getexecpath(buf) &&
>> +#endif /* HAVE_GETEXECPATH */
>> +
>>  #ifdef HAVE_BSD_KERN_PROC_SYSCTL
>>                 git_get_exec_path_bsd_sysctl(buf) &&
>>  #endif /* HAVE_BSD_KERN_PROC_SYSCTL */
>> --
>> 2.55.0
> 
> Sort of a minor nit, but given this code construct, there should probably be
> instructions saying to define only one of these.
This caught me too. But notice that the calls are chained by && so that
the first successful call determines the outcome.

-- Hannes

