Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CCD36B17
	for <git@vger.kernel.org>; Thu, 23 May 2024 18:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716487737; cv=none; b=fJAgrotdni+KzA8pQjx0y9tx3d+HEJcR2q7PrtJz4klj82hY98p129O/4KEvoKNGEaz7ytRHmKCqQEbDw/QSsCfVtOBrwzqoRLOubBq59W7WvJ5nxaG39K/gyS9zOKu5iEnQwSJ+X6dpoiTRBAGr8ae2DrJKVJCfQxzeHtMmwEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716487737; c=relaxed/simple;
	bh=MxAajmmtst8uZIWT6IrNgV5Oj2uRA0f9+CVWRW/Dncc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SFh4i+Nl7knI+8z6EdmDKsO0r2jWhQmROC8wcICZtVXjWOjvflOVJLLUOIz2P4+0IIGA9RztAHX85rWTSx+YvhU6UGWTPo25rkNUXI+UtW110yFCquMd6glWUyOiqNJw4ulNocxtzPcCPSnYVanhxepdSt08SykgAw0/cRnCL20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Th7bV4em; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Th7bV4em"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8A4B121A88;
	Thu, 23 May 2024 14:08:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=MxAajmmtst8u
	ZIWT6IrNgV5Oj2uRA0f9+CVWRW/Dncc=; b=Th7bV4em2i6A7A9W2ntfTEWIjZXR
	Ja55H0XAYtr3FaxJ5WtkmjXARHf8y46+Z1+aPN68YSZo1gWaqdT7bpIuNqiETrvt
	oL86qHpDXEtNGMNuxPjv7mJOLvrk2hAN7oxNGbC6OjvEylOgJYYikmjft1UWJgzL
	PMHJm/zRNaiofPE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 82CED21A87;
	Thu, 23 May 2024 14:08:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7A4BD21A86;
	Thu, 23 May 2024 14:08:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2 0/6] update-ref: add symref support for --stdin
In-Reply-To: <CAPig+cT6_j80vh_HEjg6HWKXpkv-huggudShh_RgzLSKvV_bOA@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 23 May 2024 13:59:43 -0400")
References: <20240514124411.1037019-1-knayak@gitlab.com>
	<20240522090326.1268326-1-knayak@gitlab.com>
	<xmqqbk4wy3ji.fsf@gitster.g>
	<CAOLa=ZS31CuL8kDODNfM5L8gXN6RUOG5uEP5Q9JzEuaxtLEZ8g@mail.gmail.com>
	<xmqqr0dsv6e8.fsf@gitster.g>
	<CAPig+cT6_j80vh_HEjg6HWKXpkv-huggudShh_RgzLSKvV_bOA@mail.gmail.com>
Date: Thu, 23 May 2024 11:08:49 -0700
Message-ID: <xmqqo78wtn7y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 81E446F6-192F-11EF-9888-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, May 23, 2024 at 12:29=E2=80=AFPM Junio C Hamano <gitster@pobox.=
com> wrote:
>> We may want to teach "format-patch --range-diff" to place the output
>> of range-diff _below_ the list of commits and the overall diffstat
>> in the cover letter
>
> Placing the range-diff below the list of commits and the overall
> diffstat in the cover letter is how `format-patch --range-diff`
> already works.

Heh, so what Karthik was manually doing made the cover letter harder
to read?

In any case, that is a great news.

>> (and at the end of the patch for a single patch topic).
>
> This could indeed lead to less visual clutter for the single-patch topi=
c.
