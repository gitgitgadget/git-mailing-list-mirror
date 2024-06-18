Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567A23B79C
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726285; cv=none; b=FjdhMip8DJb0Fnj7DU/Rtz19N6Y1uUNmccJyfXkt7/v79Whe/CmpCt9FAQNkDUz/hUXigoiH9EbTzGhl/WKmybaqRDpzWc5Yn1lLy95Sp7jNMDPj4VnA/NhiNN1skDZQ/k4Q1+tM+K/5uNWHcba8hiE2POYpdvA36sOo9Uoflfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726285; c=relaxed/simple;
	bh=VoDVPO3sSSkDZjpSvOoJ5Q2LoWZ7MWTnppYSLwgIqJ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KQbYcHO0vzk5DLEODj7CRKgKyGlaorGyvVa0BVNjPOBUeA9SzLcQftTiXRxg7nkfKsQHnRauWf1dS782l801RGrMOfKzJrU3P4J/URxOG5s1jkwfVWSw8x/HnVxH3dNVZNawVF/sX3hEQuQs813SYywpitB3X/xc2MXkwFGGUtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ogB5MVEf; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ogB5MVEf"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2603D2636A;
	Tue, 18 Jun 2024 11:58:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=VoDVPO3sSSkDZjpSvOoJ5Q2LoWZ7MWTnppYSLw
	gIqJ0=; b=ogB5MVEfud85H13qvkpcmc5T2+SfBpLfYbCwB63sE3HFiJfoRaDOqU
	lhC09zVJJiZ9IdqEhEXJMKlz5N4niClp4lqfMrT3khJ1ajTBtrCcYH3vW+hHkioM
	QjxU9wtLzKNA6cv15+6E8q0fvg6CwpYXxQ4sGNrMcudoY+vjvEP2w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1D5FA26369;
	Tue, 18 Jun 2024 11:58:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 810BB26368;
	Tue, 18 Jun 2024 11:58:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Ghanshyam Thakkar
 <shyamthakkar001@gmail.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 09/20] global: introduce
 `USE_THE_REPOSITORY_VARIABLE` macro
In-Reply-To: <CAOLa=ZRA6QDojbvP6btOGX5q1Pa0DivBZA_J1gojF1gJu9aENw@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 18 Jun 2024 05:25:33 -0400")
References: <cover.1718106284.git.ps@pks.im> <cover.1718347699.git.ps@pks.im>
	<7e023a335f500658b09a0037aee48eff06c668f8.1718347699.git.ps@pks.im>
	<CAOLa=ZTq+sQAtSiQm9xmdLyn=T=u8Ck0oXEBFLnJvH+54O+AHA@mail.gmail.com>
	<ZnEYNzLue3OIK-Ul@framework>
	<CAOLa=ZRA6QDojbvP6btOGX5q1Pa0DivBZA_J1gojF1gJu9aENw@mail.gmail.com>
Date: Tue, 18 Jun 2024 08:58:01 -0700
Message-ID: <xmqqwmmm1bw6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8AE04F6E-2D8B-11EF-8349-965B910A682E-77302942!pb-smtp2.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

>>> s/# define/#define/
>>
>> This is in fact intentional. We aren't strictly following this in our
>> codebase, but when nesting preprocessor macros into ifdefs then we often
>> indent the inner macros with spaces.
>>
>> Patrick
>
> That's something I didn't know. Thanks.

Unlike borrowed sources in compat/, in our codebase, such
indentation is minority.  IOW "often indent" -> "sometimes indent".

A quick look at an early part of git-compat-util.h would show that
even within a single file we are not consistent at all.

#if __STDC_VERSION__ - 0 < 199901L
#error "Required C99 support is in a test phase.  Please see git-compat-util.h for more details."
#endif

#ifdef USE_MSVC_CRTDBG
#include <stdlib.h>
#include <crtdbg.h>
#endif

#define _FILE_OFFSET_BITS 64

#if defined(__GNUC__) && defined(__GNUC_MINOR__)
# define GIT_GNUC_PREREQ(maj, min) \
	((__GNUC__ << 16) + __GNUC_MINOR__ >= ((maj) << 16) + (min))
#else
 #define GIT_GNUC_PREREQ(maj, min) 0
#endif

#ifndef FLEX_ARRAY
#if defined(__SUNPRO_C) && (__SUNPRO_C <= 0x580)
#elif defined(__GNUC__)
# if (__GNUC__ >= 3)
#  define FLEX_ARRAY /* empty */
# else
#  define FLEX_ARRAY 0 /* older GNU extension */
# endif
#elif defined(__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L)
# define FLEX_ARRAY /* empty */
#endif
...


We may want to eventually fix this, but we need to decide what the
desirable layout is.  I am not sure if the indented version is
easier to read and maintain, but one thing that is sure is that a
mixed mess is harder than either.  In the above excerpt, you cannot
tell if I quoted everything related to FLEX_ARRAY (in other words,
if "#ifndef FLEX_ARRAY" is already closed in the excerpt) without
carefully looking.

