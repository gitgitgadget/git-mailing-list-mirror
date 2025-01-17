Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C171DE88A
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 22:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737154204; cv=none; b=WcqjjQV28wIPzAc0rYtTx11fqE0RdZi4cRyGar7uGcLjL+nKBzNp9ZMVI6T8KIVE8uOunGx/75pjOrM8lymZ77oPZdxxKakG3j6TamEUTnDycm8/eKrJCJMdsHhu9F7yupFUdPqlUjORN5bZ9vzyNqYpyOq+SKdNER0ocjFrgtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737154204; c=relaxed/simple;
	bh=5z7qH3imKDW0SywvYFT1tCAojZQM8BFKaClRDYi2UIA=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=BA3AjIjyFCo9ZifsVpse0mvcnYKDh1toXFqTFWZgTrEnfijvqOpqVVfWv3DDjdvIdclujqAH57i5bGUq8FQsIbFVBt+lMBkLI9AIZTeZVLZC/xM4iBgSErrEzV2K6VS0Qif1NjQnxJ/F5rEvCIxfGj5HxafiDm7aTlzXctPxFig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 50HMnpII3832107
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 22:49:52 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>,
        "'Usman Akinyemi'" <usmanakinyemi202@gmail.com>
Cc: <git@vger.kernel.org>, <christian.couder@gmail.com>, <ps@pks.im>,
        <johncai86@gmail.com>, <Johannes.Schindelin@gmx.de>, <me@ttaylorr.com>,
        <phillip.wood@dunelm.org.uk>, <sunshine@sunshineco.com>,
        "'Christian Couder'" <chriscool@tuxfamily.org>
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>	<20250117104639.65608-1-usmanakinyemi202@gmail.com>	<20250117104639.65608-7-usmanakinyemi202@gmail.com> <xmqqwmethxyq.fsf@gitster.g>
In-Reply-To: <xmqqwmethxyq.fsf@gitster.g>
Subject: RE: [PATCH v2 6/6] version: introduce osversion.command config for os-version output
Date: Fri, 17 Jan 2025 17:49:46 -0500
Organization: Nexbridge Inc.
Message-ID: <00bc01db6932$1eed21a0$5cc764e0$@nexbridge.com>
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
Thread-Index: AQL1iKQeqDpt8guF+jE2EcHccRlcdgGGCMwEAb1tHEECbCriYbC51a3g
Content-Language: en-ca
X-Antivirus: Norton (VPS 250117-8, 1/17/2025), Outbound message
X-Antivirus-Status: Clean

On January 17, 2025 5:34 PM, Junio C Hamano wrote:
>Usman Akinyemi <usmanakinyemi202@gmail.com> writes:
>
>> Let's introduce a new configuration option, `osversion.command`, to
>> handle the string exchange between servers and clients. This option
>> allows customization of the exchanged string by leveraging the output
>> of the specified command. This customization might be especially
>> useful on some quite uncommon platforms like NonStop where interesting
>> OS information is available from other means than uname(2).
>
>After reading the above rationale, I doubt the usefulness of this feature
even more.
>
>Shouldn't that kind of anomalies be handled by compat/ layer to make their
>uname(2) emulated, or allow get_uname_info() to be customized at compile
time
>by platform implementations, to yield more useful pieces of information
instead?
>
>That way, we do not need to add another mechanism that lets people spawn an
>arbitrary command while Git is running, we do not need to worry about
security
>implications, and we do not need to worry about people abusing the facility
to
>throw totally random and useless garbage information at the other end to
make
>their stats useless.
>
>I'll skip the overly wide documentation changes.
>
>> diff --git a/Documentation/config/transfer.txt
>> b/Documentation/config/transfer.txt
>> ...
>> diff --git a/Documentation/gitprotocol-v2.txt
>> b/Documentation/gitprotocol-v2.txt
>> ...
>
>> +test_expect_success 'test capability advertisement with
osVersion.command
>config set' '
>> +	test_config osVersion.command "uname -srvm" &&
>
>If osversion.command configuration variable turns out to be acceptable
addition, I
>do not think we want to use "uname -srvm" as its value for its test.  Do
you know
>for sure how portable srvm is?
>
>If you use something like "printf ' \001a\011b\015\012c '", you do not even
have
>to worry about how portable srvm is and on top, you can test your
unprintable-
>redacting logic in the code.
>
>But all of that may be moot, if we take the "fewer customization at
runtime"
>approach.

On my box, uname -srvm = "NONSTOP_KERNEL L24 08 NSV-D". Is this going to
Break anything?

