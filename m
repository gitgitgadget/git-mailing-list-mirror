Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B2224B231
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 19:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736536328; cv=none; b=NfrShN3wZ+wckLzs0zgSV3DVrj8G98eFIrnFfRcrVrTS90d+U43XCIQZ8Z2t5TqqTg6eLNP6QR8Ne6evZM3pBxBOCdWAHT8pz9j2wkzpFl7vgcAmUwErKbRGbamnAy0sV1hVAVOuqIR3J1KpHPSVpNy5KcLFVz6oyDdcNZHlIT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736536328; c=relaxed/simple;
	bh=tEZQp0yWlffcH0PsynqKiQBai8Wx1inZ8plw/ynHHjc=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=afhmv7Ieq4dhkNwwmfnSNdlOt6xznRvbnQSvowXu6Kvz0Ncn1g6RVMY7BpfHYFqc0YxbR6R/peMfv+YVR9Se98tXGT+5QZPtWdTMLCyrQyAj5K/rABqEZt6wnFOOZ/vlZhMFahJeenQFO1ygbxZHH/Mxhh4KFInXpTuiqtPtplk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 50AJBjEv2282718
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 19:11:46 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>,
        "'M Hickford via GitGitGadget'" <gitgitgadget@gmail.com>
Cc: <git@vger.kernel.org>, <sandals@crustytoothpaste.net>,
        <derrickstolee@github.com>, <stolee@gmail.com>,
        <Johannes.Schindelin@gmx.de>, <peff@peff.net>,
        "'M Hickford'" <mirth.hickford@gmail.com>
References: <pull.1851.git.1736458019921.gitgitgadget@gmail.com> <xmqqwmf27cvv.fsf@gitster.g>
In-Reply-To: <xmqqwmf27cvv.fsf@gitster.g>
Subject: RE: [PATCH] docs: discuss caching personal access tokens
Date: Fri, 10 Jan 2025 14:11:40 -0500
Organization: Nexbridge Inc.
Message-ID: <017f01db6393$7e3fe2e0$7abfa8a0$@nexbridge.com>
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
Thread-Index: AQGZb6ZyOtAUQRecREjAkEOL1ekTjwFb2waps4loVsA=
Content-Language: en-ca
X-Antivirus: Norton (VPS 250110-6, 1/10/2025), Outbound message
X-Antivirus-Status: Clean

On January 10, 2025 1:17 PM, Junio C Hamano wrote:
>Subject: Re: [PATCH] docs: discuss caching personal access tokens
>
>"M Hickford via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: M Hickford <mirth.hickford@gmail.com>
>>
>> Describe problems storing personal access tokens in
>> git-credential-cache and suggest alternatives.
>
>> +PERSONAL ACCESS TOKENS
>> +----------------------
>> +
>> +Some remotes accept personal access tokens, which are randomly
>> +generated and hard to memorise. They typically have a lifetime of
>> +weeks or months.
>> +
>> +git-credential-cache is inherently unsuitable for persistent storage
>> +of personal access tokens. The credential will be forgotten after the
>> +cache timeout. Even if you configure a long timeout, credentials will
>> +be forgotten if the daemon dies.
>
>Very true.
>
>> +To avoid frequently regenerating personal access tokens, configure a
>> +credential helper with persistent storage.
>
>Like libsecret and osxkeychain, you mean?  I am wondering if we want to be
a bit
>more helpful by being explicit.  I think there is a section in a maual page
that has a
>list of known and often-used credential backends, so referring the readers
to that
>section may be helpful.
>
>> Alternatively, configure an
>> +OAuth credential helper to generate credentials automatically. See
>> +linkgit:gitcredentials[7].
>
>Indeed.

My solution for this is to write a custom credential manager that is PAT
aware. The one I built
does not support OAuth or OAuth2. This is non-trivial when dealing with a
CLI. Integrating
with something like MS Authenticator might be a reasonable option for some.

