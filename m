Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E4E1E2107
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 22:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724107155; cv=none; b=ikU/Tpv8I22tiRzGDa4iVqfCc76cdMiJ0I4Z9cwzf/1qmiAifu2nTjMAPMiNukjwNuYKC2DnCg8G306kHHFf64hZf4XdCatqiM1mncYZxJEDXDb2kpqK81Lzj+213yXQ+MR3zevYnyTm4kEfB7JRa27XFIeaUEday41+uQS5ndA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724107155; c=relaxed/simple;
	bh=36z+dL6ejp0HYS2sXiooK26LgBczEdZoEG1KcfhraVI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=VsrELBIwigFK9taJtOAFrAf3by9t9Iy+oIdSr20qAkhViGeYaPB5bCzi2HK7sBLHIUcNhvQcg5G0f5Pjdg+P62rhkCQEvI75cTQQ6l1TZAEkydv52yUQlvgPfq0rv2hv49bcA75ikXDSUoWM4nAucWsYY6f4IMSTT3OvTA6eTAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 47JMd1MY3039552
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 22:39:02 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: "'Patrick Steinhardt'" <ps@pks.im>, <git@vger.kernel.org>,
        "=?UTF-8?Q?'Ren=C3=A9_Scharfe'?=" <l.s.r@web.de>,
        "'Kyle Lippincott'" <spectral@google.com>,
        "'Phillip Wood'" <phillip.wood@dunelm.org.uk>,
        "'Josh Steadmon'" <steadmon@google.com>,
        "'Edward Thomson'" <ethomson@edwardthomson.com>
References: <cover.1722415748.git.ps@pks.im> <cover.1723791831.git.ps@pks.im>	<369060793306daab1796ae3063b4eaacc287f12d.1723791831.git.ps@pks.im>	<xmqqr0akcion.fsf@gitster.g>	<01ed01daf281$c5dba4a0$5192ede0$@nexbridge.com> <xmqqmsl8cga2.fsf@gitster.g>
In-Reply-To: <xmqqmsl8cga2.fsf@gitster.g>
Subject: RE: [PATCH v5 2/9] t: import the clar unit testing framework
Date: Mon, 19 Aug 2024 18:38:56 -0400
Organization: Nexbridge Inc.
Message-ID: <01ee01daf288$97977310$c6c65930$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQE2Q9x0fuag13GoRDOLG7kBaq5wcQNmbeWFAk1tFCACHM9gHgLyowdHApuuR5yzDZFkMA==

On Monday, August 19, 2024 6:14 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>> On Monday, August 19, 2024 5:22 PM, Junio C Hamano wrote:
>>>Patrick Steinhardt <ps@pks.im> writes:
>>>
>>>> diff --git a/t/unit-tests/clar/clar.c b/t/unit-tests/clar/clar.c new
>>>> file mode 100644 index 0000000000..3fc2c76815
>>>> --- /dev/null
>>>> +++ b/t/unit-tests/clar/clar.c
>>>> @@ -0,0 +1,842 @@
>>>> ...
>>>> +
>>>> +#ifdef _WIN32
>>>> +#	include <windows.h>
>>>> +#	include <io.h>
>>>> +#	include <shellapi.h>
>>>> +#	include <direct.h>
>>>
>>>This seems to break Windows build
>>>
>>>  In file included from t/unit-tests/clar/clar.c:22:
>>>  D:/git-sdk-64-minimal/mingw64/include/windows.h:89:10: fatal error:
>shellapi.h:
>>>No such file or directory
>>>     89 | #include <shellapi.h>
>>>        |          ^~~~~~~~~~~~
>>>  compilation terminated.
>>>
>>>https://github.com/git/git/actions/runs/10459342252/job/28963152995
>>>
>>>As we have other topics that I do want to do well in 'seen' before
>>>merging them to 'next', I'd temporarily drop this topic from 'seen'
>>>and push out the rest of the topics.
>>
>> shellapi.h is not portable. This breaks the NonStop build also.
>
>Even inside "#ifdef _WIN32"?

Good point, but I did not see that in the prior review. My apologies.

