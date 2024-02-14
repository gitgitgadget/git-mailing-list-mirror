Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE2E60DD0
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 16:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929395; cv=none; b=Xr4A0Iy6Ut8+ygK1Xk4Kn0VcT6xsox7+yzjNpKXPt/5Cj0jtHthlyVtNWL1YXt8RNT5M7pCxH9nkCp5djsLzt7ysDkKvmyd6OmHEtOqBSluob4to3orNKnHZjtkBkG7OsJTAaBZLL6aJRTUg8E5JUrH0FDIJ2UElxG9yecWkl7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929395; c=relaxed/simple;
	bh=x6CBMxxnly3ReCwUuOLRetOqjj9zaZwle76W0kdSOkU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JvtCuPrNj9ujgJ88E/x4QEXXBmQ1UwwCTwhztKElWdR1yo+ychXELyT5aOcEFp0nb6N8EV+SjU8FLdEbK7n1fwqP7uR8f4DdXmGrbK9T4o0ABDrYbJzxvt0yXLj3Fxc/yXiQ3Wvpdl+L5BJDcqf86CxbU/WDa88N/lC+7sEgJx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gS38rChX; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gS38rChX"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6907B222DB;
	Wed, 14 Feb 2024 11:49:53 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=x6CBMxxnly3ReCwUuOLRetOqjj9zaZwle76W0k
	dSOkU=; b=gS38rChXU52M7OrtLoDhcPyLoQYsQJf6JzpRVKt28AgMHapQ3D+rXK
	tNb5vJi9Q7mD2uTEa+q2HQ0iQqxiFF3+0WmpUtfT8wU95sFDxcMck4b1mfLVrB3V
	+twDIw7JiphHa8MIYd6r+NSOYfzpaadKKq10kytdjhOS/cxIyj0Jc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 610DD222DA;
	Wed, 14 Feb 2024 11:49:53 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F3228222D8;
	Wed, 14 Feb 2024 11:49:49 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Linus Arver <linusa@google.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>,  John Cai <johncai86@gmail.com>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 4/4] rev-list: allow missing tips with
 --missing=[print|allow*]
In-Reply-To: <CAP8UFD25urs1ud16c4BhMLFxHQHuDde+KV71BN6M3vDQqJ-YwA@mail.gmail.com>
	(Christian Couder's message of "Wed, 14 Feb 2024 15:34:14 +0100")
References: <20240208135055.2705260-1-christian.couder@gmail.com>
	<20240208135055.2705260-5-christian.couder@gmail.com>
	<xmqqeddmonq0.fsf@gitster.g> <owlyfrxw9ei3.fsf@fine.c.googlers.com>
	<CAP8UFD25urs1ud16c4BhMLFxHQHuDde+KV71BN6M3vDQqJ-YwA@mail.gmail.com>
Date: Wed, 14 Feb 2024 08:49:48 -0800
Message-ID: <xmqqjzn7xa6r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 116F876A-CB59-11EE-900D-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

>> >> +            /* Already add missing tips */
>> >> +            oidset_insert_from_set(&missing_objects, &revs.missing_commits);
>> >> +            oidset_clear(&revs.missing_commits);
>> >> +    }
>> >
>> > It is unclear what "already" here refers to, at least to me.
>
> I wanted to hint that we already have some missing objects that we can
> add to the set. But it's not an important detail and I agree it can be
> confusing.

I was confused primarily because "already" was not sitting next to
"missing".  I would have understood "Add already-missing tips" just
fine ;-)
