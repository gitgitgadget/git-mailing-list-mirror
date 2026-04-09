Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E9D395D90
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 22:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775774418; cv=none; b=ZYpGA9EVpEjy8V1+ly11STcOwcX56iIWuQ4rSCRL3JFA/K2TC8l/srxaXgDXiZ7gJ9TZy+Rc1tGyRv4xIZOzM1nJb24D4HLlLq83+IusiwKkSHx5vheyn6BKMycmrZWauXjVeeA3rFY/vJE2HG87mnue63avF5oKIxEk85ajkz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775774418; c=relaxed/simple;
	bh=SRPScfCdz13YjvFxpqZd5tb4IDcnb46GzW9HscJ5dT8=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=m6Pz2wOvkWPhTvYt4AzAac5RMahFT08XGpWGZ6aKVuMqQN00Iamdj9Nb1qKYO/Vr9wHzOrrK1aKY/bXubH+TBHfiVXt0dv0gz6RV+Renh2sX7wIInzdWgZ1p3tFQa8cMfZm1bX6XZiq8ln0UmPgnpotxk1RBqrCIBlZU47kOtaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 639Me68u3685207
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Apr 2026 22:40:06 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Jeff King'" <peff@peff.net>
Cc: "'Patrick Steinhardt'" <ps@pks.im>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <20260408173949.GB2850002@coredump.intra.peff.net> <xmqq4illz5g9.fsf@gitster.g> <014e01dcc793$8a9bab90$9fd302b0$@nexbridge.com> <xmqqqzopxkxa.fsf@gitster.g> <016b01dcc79e$87472860$95d57920$@nexbridge.com> <xmqqcy09xh53.fsf@gitster.g> <20260408223233.GB2873736@coredump.intra.peff.net> <adbwyvQ-R2Ag1vox@fruit.crustytoothpaste.net> <addgkjiB80pgKw69@pks.im> <021a01dcc827$4e6342c0$eb29c840$@nexbridge.com> <20260409203338.GB3076846@coredump.intra.peff.net>
In-Reply-To: <20260409203338.GB3076846@coredump.intra.peff.net>
Subject: RE: Git 2.54.0-rc1, subtests of t5310, t5326, t5327
Date: Thu, 9 Apr 2026 18:40:00 -0400
Organization: Nexbridge Inc.
Message-ID: <029701dcc871$d055dd20$71019760$@nexbridge.com>
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
Thread-Index: AQGZ2yzlJ5LQ3kUIWQ8+cGJhwabWtwJRg8x3AZcngtMCID0I1gLLYlI0AdyluJACPWVi3wKcPq6QAdR2JykCoJtYTAHub7o+ta24N9A=
X-Antivirus: Norton (VPS 260409-8, 4/9/2026), Outbound message
X-Antivirus-Status: Clean

On April 9, 2026 4:34 PM, Jeff King wrote:
>On Thu, Apr 09, 2026 at 09:46:39AM -0400, rsbecker@nexbridge.com wrote:
>
>> >--- a/git-compat-util.h
>> >+++ b/git-compat-util.h
>> >@@ -690,14 +690,8 @@ static inline uint64_t u64_add(uint64_t a,
>> >uint64_t b)
>> >  * to override this, if the definition of SSIZE_MAX given by the
>> >platform
>> >  * is broken.
>> >  */
>> >-#ifndef MAX_IO_SIZE
>> >-# define MAX_IO_SIZE_DEFAULT (8*1024*1024) -# if defined(SSIZE_MAX)
>> >&& (SSIZE_MAX < MAX_IO_SIZE_DEFAULT) -#  define MAX_IO_SIZE =
SSIZE_MAX
>> >-# else
>> -
>> >#  define MAX_IO_SIZE MAX_IO_SIZE_DEFAULT -# endif -#endif
>> >+#undef MAX_IO_SIZE
>> >+#define MAX_IO_SIZE 128
>> [...]
>> Please do not make the change in git-compat-util. This will break =
xwrite().
>> We already have MAX_IO_SIZE working and verified from years ago.
>> Changing that will remove our platform from being supportable.
>
>I think that was just there to demonstrate that the patch works =
regardless of the
>size, and would not be included in the final.
>Building with:
>
>  make CFLAGS=3D-DMAX_IO_SIZE=3D128
>
>is probably a nicer way of doing that, though. ;)

We had that set properly in git-compat-util.h for years. MAX_IO_SIZE =
should be set to SSIZE_MAX if SSIZE_MAX is defined.
#ifndef MAX_IO_SIZE
# define MAX_IO_SIZE_DEFAULT (8*1024*1024)
# if defined(SSIZE_MAX) && (SSIZE_MAX < MAX_IO_SIZE_DEFAULT)
#  define MAX_IO_SIZE SSIZE_MAX
# else
#  define MAX_IO_SIZE MAX_IO_SIZE_DEFAULT

