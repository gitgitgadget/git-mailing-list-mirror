Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA301524D1
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 21:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761860774; cv=none; b=JvwdXe55UvI/8Ogt7ZLzptRJvHwYLy/5eomBUtWFo0UO+MIHlP9/lbdJU1GEtoQEZ6vem6YWgPVFQf6vepyph6AillF93YxFHnipVxdjlvCQXxC07cPkmG4DgFKU1qSpy5zQ192t1L7jarq2Tei3NeK64Fhyo7tBs037YaHc4yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761860774; c=relaxed/simple;
	bh=3ITh7sfWmRwiW4VXuU+5gSNs82g0DVkYoNMQoXGzXxk=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=RdkLGCK7JaRPetiuMddF2fH1bQswI12KS3HsEZ1U/NTCwFN62osgXbIdif+YhnRrCmm6pH8CuY2DBCwHrjjtD0RDBBbuqHRblZAXUREnfUXKLOolot3PbgyHF99lCukpAv2KMLJFyHmi4eJ8rBFdFKR2rPBPUp0Wod0LNmbpMW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 59ULk6Ln2043043
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 21:46:06 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Kristoffer Haugsbakk'" <kristofferhaugsbakk@fastmail.com>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc: <git@vger.kernel.org>
References: <xmqqo6psjq2n.fsf@gitster.g> <000d01dc4831$ff049500$fd0dbf00$@nexbridge.com> <729f9bbf-b75b-4161-b8aa-505ff906bb8a@app.fastmail.com> <xmqqecqk5g7r.fsf@gitster.g> <3dad5cb9-976b-4e60-9e6e-05c12c7d9f2d@app.fastmail.com>
In-Reply-To: <3dad5cb9-976b-4e60-9e6e-05c12c7d9f2d@app.fastmail.com>
Subject: RE: [BUGS] Git v2.51.2 on NonStop5
Date: Thu, 30 Oct 2025 17:46:01 -0400
Organization: Nexbridge Inc.
Message-ID: <009f01dc49e6$98c5ae30$ca510a90$@nexbridge.com>
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
Thread-Index: AdxJ5npzU/tbH9brQluwN8dok3regA==
Content-Language: en-ca
X-Antivirus: Norton (VPS 251030-6, 10/30/2025), Outbound message
X-Antivirus-Status: Clean

On October 30, 2025 4:26 PM, Kristoffer Haugsbakk wrote:
>On Thu, Oct 30, 2025, at 20:42, Junio C Hamano wrote:
>> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>>
>>> On Tue, Oct 28, 2025, at 18:40, rsbecker@nexbridge.com wrote:
>>>>[snip]
>>>
>>> Would it make sense for maintenance releases to have a small release
>>> candidate pre-release?  Both of these maintenance releases have had
>>> issues.
>>
>> Well, that is usually called "the tip of 'master'".  Has NonStop been
>> having issues with the tip of 'master'?  For how long?  Why haven't we
>> heard about it at all?  After things are merged there (which requires
>> them to be cooking in 'next'---oh, has NonStop been having issues with
>> 'next'?  For how long?), only fixes are chosen and merged to 'maint'
>> to be the next maintenance release.
>> ...
>> I doubt any pre-release on 'maint' has much value in that anybody who
>> are not testing the tip of 'master' would not be testing it either.
>
>You are probably 99.9% likely to be correct.

We tried setting up a CI/CD process for git on NonStop. The problem is that
we use Jenkins, which gets triggered each time a change is made on a branch.
The actual difficulty is that a single run takes more than a day. Once the
committer adds each commit to a branch, we end up with a queue that is
2-3 weeks long, so end up not running a continuous process. Instead, we
run about 1 a week, which should catch things. The difficulty is with the
latest release is that 2.25.2 came out before our cycle and the breaks were
in there because of changes to one test that just did not end up dequeuing
in time. NonStop is building and testing fine now after Peff's suggestion on
SHELL_PATH, but that was only apparent at 2.52.2. 2.51.1 did not have this
issue with our inadvertent use of ksh to run each test script.

