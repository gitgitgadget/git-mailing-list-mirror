Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADDAC8E9
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 01:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712367001; cv=none; b=QkagzY9dEviOYQLrM/UeF/HLHtnGA5txGQIW6ATrTcrHrfokEXO6zzZkf8YXIXMtqctdqNzFyUHbPwGz3Op/7kjWDo3rTpiLrCDcL5WB71HYOcUtzzWlQyNJy+F0ZzpWMpg62NnwHwRVVmKLTj/8HIQz+hxb/lvE4ZDQX4rUXVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712367001; c=relaxed/simple;
	bh=A/NO+ILHtxiJfKoGjg200z5SNUQn64zuVWniSjtnJXU=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yjehj9GOhLc+T5CyQ/3NLfq81HVa6Kh9NRDYvNzjsKszWRz4yHoqjkGLmuwEkItEqjFsxwO1ufx9k6V94ftMLBtcnSbAJ81xso+h4eiKBjHFxNkQSPRx+Essgx8Zq2HDXcVf+/0HTVGKvqbQZAVEriAug4PSbgXIeFFTPhKl8Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 4361TmU73141758
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 6 Apr 2024 01:29:48 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <20240406000902.3082301-1-gitster@pobox.com> <20240406000902.3082301-3-gitster@pobox.com>
In-Reply-To: <20240406000902.3082301-3-gitster@pobox.com>
Subject: RE: [PATCH 2/6] CodingGuidelines: quote assigned value in 'local var=$val'
Date: Fri, 5 Apr 2024 21:29:44 -0400
Organization: Nexbridge Inc.
Message-ID: <02c801da87c1$eac025f0$c04071d0$@nexbridge.com>
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
Thread-Index: AQIcRoOxtIvZzKcRwpuxodxZI2FCSwIN7BUfsMaHFsA=
Content-Language: en-ca

On Friday, April 5, 2024 8:09 PM, Junio C Hamano wrote:
>Dash bug https://bugs.launchpad.net/ubuntu/+source/dash/+bug/139097
>lets the shell erroneously perform field splitting on the expansion of a
command
>substitution during declaration of a local or an extern variable.
>
>The explanation was stolen from ebee5580 (parallel-checkout: avoid dash
local bug
>in tests, 2021-06-06).
>
>Signed-off-by: Junio C Hamano <gitster@pobox.com>
>---
> Documentation/CodingGuidelines | 14 ++++++++++++++
> 1 file changed, 14 insertions(+)
>
>diff --git a/Documentation/CodingGuidelines
b/Documentation/CodingGuidelines
>index 0a39205c48..1cb77a871b 100644
>--- a/Documentation/CodingGuidelines
>+++ b/Documentation/CodingGuidelines
>@@ -194,6 +194,20 @@ For shell scripts specifically (not exhaustive):
>    have changed since then.  We'd need to re-evaluate this rule,
>    together with the rule in t/check-non-portable-shell.pl script.
>
>+ - Some versions of dash have broken variable assignment when prefixed
>+   with "local", "export", and "readonly", in that the value to be
>+   assigned goes through field splitting at $IFS unless quoted.
>+
>+   DO NOT write:
>+
>+     local variable=$value           ;# wrong
>+     local variable=$(command args)  ;# wrong
>+
>+   and instead write:
>+
>+     local variable="$value"
>+     local variable="$(command args)"
>+
>  - Use octal escape sequences (e.g. "\302\242"), not hexadecimal (e.g.
>    "\xc2\xa2") in printf format strings, since hexadecimal escape
>    sequences are not portable.

I can confirm, at least for the set of platforms I work on, that printf with
hex values is definitely not portable.
--Randall

