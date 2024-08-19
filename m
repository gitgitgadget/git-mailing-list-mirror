Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2A1158DC6
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 21:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724104234; cv=none; b=nSqu+qUpU8iHUH5Y8IF5Q9+wf8VcFmkBreTkv4hjRuHLtUQXmuY9MCwOqQ72Fbyd9NchLBXdvo78FF2Acl0jIf/8mHl0Uoeul2eybWPiOxQ5IOIjf2pL+yZFLina7OKzJNGonqAaJd7AdRWnzxiGniMHMnx1TW6geFHu6DMIZyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724104234; c=relaxed/simple;
	bh=7GSzbYx/54h555AJED84KdyZrFDlq4yJjy4hYW4OjNU=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=tufpUyQ1S/SWqXU4jjSPaYc0nj+DcLKL0ip076cjsi3oClqQSMnboqCEyUnjaUKrYSsvASfwviiXFOSFaTRS+yqWwg+gAkvi4zBHEnPV1zulHX/qR0geje2nemFMowgtouHbn5BWqrR98Zq05MPXgPRg4MdbTAB/6OtDSbWBupw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 47JLoBjv3033752
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 21:50:12 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>, "'Patrick Steinhardt'" <ps@pks.im>
Cc: <git@vger.kernel.org>, "=?UTF-8?Q?'Ren=C3=A9_Scharfe'?=" <l.s.r@web.de>,
        "'Kyle Lippincott'" <spectral@google.com>,
        "'Phillip Wood'" <phillip.wood@dunelm.org.uk>,
        "'Josh Steadmon'" <steadmon@google.com>,
        "'Edward Thomson'" <ethomson@edwardthomson.com>
References: <cover.1722415748.git.ps@pks.im> <cover.1723791831.git.ps@pks.im>	<369060793306daab1796ae3063b4eaacc287f12d.1723791831.git.ps@pks.im> <xmqqr0akcion.fsf@gitster.g>
In-Reply-To: <xmqqr0akcion.fsf@gitster.g>
Subject: RE: [PATCH v5 2/9] t: import the clar unit testing framework
Date: Mon, 19 Aug 2024 17:50:06 -0400
Organization: Nexbridge Inc.
Message-ID: <01ed01daf281$c5dba4a0$5192ede0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQE2Q9x0fuag13GoRDOLG7kBaq5wcQNmbeWFAk1tFCACHM9gHrM59j+g

On Monday, August 19, 2024 5:22 PM, Junio C Hamano wrote:
>Patrick Steinhardt <ps@pks.im> writes:
>
>> diff --git a/t/unit-tests/clar/clar.c b/t/unit-tests/clar/clar.c new
>> file mode 100644 index 0000000000..3fc2c76815
>> --- /dev/null
>> +++ b/t/unit-tests/clar/clar.c
>> @@ -0,0 +1,842 @@
>> ...
>> +
>> +#ifdef _WIN32
>> +#	include <windows.h>
>> +#	include <io.h>
>> +#	include <shellapi.h>
>> +#	include <direct.h>
>
>This seems to break Windows build
>
>  In file included from t/unit-tests/clar/clar.c:22:
>  D:/git-sdk-64-minimal/mingw64/include/windows.h:89:10: fatal error: =
shellapi.h:
>No such file or directory
>     89 | #include <shellapi.h>
>        |          ^~~~~~~~~~~~
>  compilation terminated.
>
>https://github.com/git/git/actions/runs/10459342252/job/28963152995
>
>As we have other topics that I do want to do well in 'seen' before =
merging them to
>'next', I'd temporarily drop this topic from 'seen'
>and push out the rest of the topics.

shellapi.h is not portable. This breaks the NonStop build also.

