Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC0FAD55
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720459172; cv=none; b=EB+AudNSZh12Xf+sX1qfrnFhT5yB+6JzdVQZVDlcBXJFjWerZTIdt0IPdIi5GiCXYH30x0F7yW10K8y36wuia1dImE7KvqaYlCYuWNExF2VhfXzvwwK/Uac9ww7+UkFtjXTZLDZdHk8YgTiIhWNJ2g6M+II1LZ0gP/FCn5o4LJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720459172; c=relaxed/simple;
	bh=FAidXsWlEt1SNZcWF8Jd7o68eFzVYtRVt9cCjdErRwM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GDhPMKPNieQlojeLNy0YgBDYwiEhn0BLeYxdMT21ULLP7oa3PcXjdICbnP4+R/mnfuJW+KSHRe4YS+anCEBW33Kf6jXnpZIEbNb7yIxFvpSxPZ+y10uDfT7tyMUPX4T8vof9VIyC2ZtnP6zmLVV0iPXJfoH4U8lxDRWdhiJdEj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BiK//ObB; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BiK//ObB"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 245CC2219A;
	Mon,  8 Jul 2024 13:19:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FAidXsWlEt1S
	NZcWF8Jd7o68eFzVYtRVt9cCjdErRwM=; b=BiK//ObB7givCq9CxJ6jk7RrgEAA
	s4kVbvv9AGQyDKnAlu2ChsgM2GWAt2FMzDMcWWlWbDUAV3CUkTsW/kR4R8IQFq7g
	J7DogxdWcJnku2SwMKzzSf3BPisJNvU5MV4A+6KtObxdL+A8kWc5hATw9SYhKRme
	EXlWSLbjc01aKKs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1BA6922191;
	Mon,  8 Jul 2024 13:19:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 817AD22190;
	Mon,  8 Jul 2024 13:19:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Chris Torek <chris.torek@gmail.com>
Cc: Georg Pfuetzenreuter <georg@syscid.com>,  Karthik Nayak
 <karthik.188@gmail.com>,  git@vger.kernel.org,  jltobler@gmail.com,
  chriscool@tuxfamily.org
Subject: Re: [PATCH 8/8] check-whitespace: detect if no base_commit is provided
In-Reply-To: <CAPx1GvcunqYvZtkSJ0wDd4802VPEyRzDJnZmfoGh6L1rFof2vQ@mail.gmail.com>
	(Chris Torek's message of "Mon, 8 Jul 2024 03:42:10 -0700")
References: <20240708092317.267915-1-karthik.188@gmail.com>
	<20240708092317.267915-9-karthik.188@gmail.com>
	<CAPx1GvfkC0rv_8_q5_HfduhuKX4csO+sBZiZqV+Sh+Q0dV8+4w@mail.gmail.com>
	<d3921679-eeb8-4cca-bc0d-967e9e567fd4@syscid.com>
	<CAPx1GvcunqYvZtkSJ0wDd4802VPEyRzDJnZmfoGh6L1rFof2vQ@mail.gmail.com>
Date: Mon, 08 Jul 2024 10:19:27 -0700
Message-ID: <xmqqikxfhkdc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 3B6C271E-3D4E-11EF-A7DA-965B910A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Chris Torek <chris.torek@gmail.com> writes:

> On Mon, Jul 8, 2024 at 3:35=E2=80=AFAM Georg Pfuetzenreuter <georg@sysc=
id.com> wrote:
>> https://pubs.opengroup.org/onlinepubs/9699919799/utilities/test.html s=
tates
>>
>> "The XSI extensions specifying the -a and -o binary primaries and the
>> '(' and ')' operators have been marked obsolescent."
>>
>> suggesting "&&" being preferred over "-a".
>
> That's annoying, I wonder why they did that.

Consult Documentation/CodingGuidelines?

 - We do not write our "test" command with "-a" and "-o" and use "&&"
   or "||" to concatenate multiple "test" commands instead, because
   the use of "-a/-o" is often error-prone.  E.g.

     test -n "$x" -a "$a" =3D "$b"

   is buggy and breaks when $x is "=3D", but

     test -n "$x" && test "$a" =3D "$b"

   does not have such a problem.

