Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A11224EA
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 20:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723236856; cv=none; b=JsHgxfYmTsY/h6Z8HBnii/GW7SSGLht2GH/h61MoA1lq3I4dQG1tdtnOqnNoeI4JzRTKKEKDIsiM9QtMM1bID+IFMUC/9jX9+G2DqctIMTQVoTfUos2SDdcvxOTtTs5yd0HnYhFIzVAwaNZjnCq1wOxWGLskX8TUbVU26EKvzCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723236856; c=relaxed/simple;
	bh=0+brzM7ZMUW5Tni3RgZ6Ttrn3INet+mAITNUPSNUOOI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H7dZm5GFYZpyWN6oG3Qro5B8Kr4/qvfjXhK79JFdI+BpK7N+EJ3Q6kXE7IDzQfx78zOaB7wyTAUsOtEd74l7OATBBBZ9/un4IGCh3xcQenNMUNOkv7GnkdzJqou6ecCgXGTdJ5wxxP5y5QAOICOwFVHTDVK1aO7APJ3/TF4a4qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=txLRpQGm; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="txLRpQGm"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6F1A320210;
	Fri,  9 Aug 2024 16:54:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0+brzM7ZMUW5Tni3RgZ6Ttrn3INet+mAITNUPS
	NUOOI=; b=txLRpQGmOAFsdBOD8j4pIFe56aBRjketjAK3nQ9YUKJg8FS2HP7gRx
	yo8/iHlASmr74+dv0Vb8i6Q3lv8XZ3QZq+t9VoUa++PX1z2s4A0MslHrNRQyzFu+
	Gxf9zAxj67FkSZdwEhbwuWPH2Al2bbNIwiYq9XyFL5ovcYea5TMao=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 669152020F;
	Fri,  9 Aug 2024 16:54:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6F12D2020E;
	Fri,  9 Aug 2024 16:54:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  calvinwan@google.com,  spectral@google.com,
  emilyshaffer@google.com,  emrass@google.com,  rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 0/6] [RFC] Introduce cgit-rs, a Rust wrapper around
 libgit.a
In-Reply-To: <xmqqbk21cxhn.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	09 Aug 2024 12:22:28 -0700")
References: <cover.1723054623.git.steadmon@google.com>
	<xmqqbk21cxhn.fsf@gitster.g>
Date: Fri, 09 Aug 2024 13:54:09 -0700
Message-ID: <xmqqv809beoe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 877677FC-5691-11EF-A740-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Josh Steadmon <steadmon@google.com> writes:
>
>> We're sending this series as RFC because there is remaining work
>> we'd like to do, but we'd like to get early feedback on this approach,
>> and particularly to ask for advice on a few topics:
>
> I am not sure how much this is reusable, after seeing comments that
> "cgit-rs" may not be the best name for this thing and pathnames may
> have to change, but I needed the following merge-fix to get this
> into "seen" and have the result pass "make", due to interactions
> with the ps/config-wo-the-repository topic.
>
>  contrib/cgit-rs/public_symbol_export.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

There is another thing.

Listing this file in $(OBJECTS) means that you should be able to
pass "make sparse" to build contrib/cgit-rs/public_symbol_export.sp
but it seems to fail rather miserably.  I am tempted to suggest in
the meantime to futz with $(SP_OBJ) to filter it out in the top
level Makefile.

