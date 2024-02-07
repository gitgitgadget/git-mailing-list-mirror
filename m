Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824DB81ABF
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 16:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324378; cv=none; b=r/GwR6vCT/IG/kEPmerettM/ltUuClceS9oirfCjEQVLagrwB7FdMZGTo1wrnMb5DDSS61zgyXN1t0TUHbMjkmdq6HozS/bVC/Hm/rbcMH30Rjnw+i1ZqBLxgdp5I7iLkfJQFddPmqGqW/x4UOGBP0KjXqVeRyQF/LDqqSL4sWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324378; c=relaxed/simple;
	bh=ovRePaDMJynQC92Jf0oZFpu6o+7E/Y5vMXbnv9/XThA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ky2E8NCtTblv7qS9l/S2b2Sj6iw1KRSXZBFqH6YHx6UoWwIQb5zg1bMgaeYh9fqVu9OSH98fpGFS7T89Qx/1GzLWpEmw18jmqcwxst2I/EdAHw66C7GXfcYlF5MsvW2ZADBlPNFOYkFXKgpnFhsPYYtpUf6/LPoSq3VHRFjNt9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=niWb+V0a; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="niWb+V0a"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ECD801D73B8;
	Wed,  7 Feb 2024 11:46:14 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ovRePaDMJynQC92Jf0oZFpu6o+7E/Y5vMXbnv9
	/XThA=; b=niWb+V0agYrSXrSgu/4uKdaHibnmBkB+P+kzb1SzJvSJT6VHdco9IM
	O727kSPB0LTi1+gOA64e+1lcDdNIXlA+EcAbFYnTVqyRcvTvgv4W6r+gi9EsvsDx
	MIdYRLLNwdtSv+MLQOn9yUjNQxoFSNRTScwjdigyAdiSeoT3A0OeM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E3BEC1D73B7;
	Wed,  7 Feb 2024 11:46:14 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4A55B1D73B5;
	Wed,  7 Feb 2024 11:46:14 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  phillip.wood@dunelm.org.uk,
  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v3 4/4] for-each-ref: avoid filtering on empty pattern
In-Reply-To: <CAOLa=ZQzz7_L_9cBmK+pgFwd_DFqfWDVRiaZMAxU+54kBq6Pcw@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 7 Feb 2024 17:18:56 +0100")
References: <20240119142705.139374-1-karthik.188@gmail.com>
	<20240129113527.607022-1-karthik.188@gmail.com>
	<20240129113527.607022-5-karthik.188@gmail.com>
	<98d79d33-0d7e-4a9c-a6a3-ed9b58cd7445@gmail.com>
	<CAOLa=ZR=_tt=ppphGMkxqj_YB5G+YkTMWGzRzcHTbrZz4ysb5w@mail.gmail.com>
	<92ba680d-0b48-49f0-aafc-f503e5a5e0ea@gmail.com>
	<xmqqle7xjzic.fsf@gitster.g> <xmqqr0hph1ku.fsf@gitster.g>
	<CAOLa=ZSZJ=_VCppHXcJeE=Z61go4_040xyc1NBTu-o=xysLrdg@mail.gmail.com>
	<xmqqcyt9fdc7.fsf@gitster.g>
	<CAOLa=ZRcWYmEYnxh_=ykOerahZ61xaanLCj_JHHLvtrvN=Xs-w@mail.gmail.com>
	<xmqq1q9oe029.fsf@gitster.g>
	<CAOLa=ZQzz7_L_9cBmK+pgFwd_DFqfWDVRiaZMAxU+54kBq6Pcw@mail.gmail.com>
Date: Wed, 07 Feb 2024 08:46:12 -0800
Message-ID: <xmqq1q9ocje3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 67FBE2C6-C5D8-11EE-AEF0-25B3960A682E-77302942!pb-smtp2.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> This is a bit of a grey area, what I mean is that we do allow users to create
> non "refs/" prefixed refs:
>
>     $ git update-ref foo @~1
>
>     $ cat .git/foo
>     2b52187cd2930931c6d34436371f470bb26eef4f
>
> What I mean to say is that, by saying "--include-root-refs" it seems to imply
> that any such refs should be included too, but this simply is not the case.

But isn't that a quality of implementation issue?  I'd consider it a
bug once we have and enforce the definition of what pseudorefs are.
