Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763AB74BE1
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 22:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723500132; cv=none; b=sUhxhLCRAnzR82vUsbshDDi6mi3W7dqWJV7SYoHaxVjwUkj7mr0x3rxLqugRoq95Xi/uXWrI6vNVCeFzZL8RWSbpijL/wqmm23+ZSFZPERa5QO+o13JqsxHDwXa/BEmGI+daHcMSuKcVFKGcy1kkKUGxLj+B3dbwNP1k42yu98U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723500132; c=relaxed/simple;
	bh=LlDns7mwqzrACuWzkWuvc7us9FwOUCg8EzbNJarWBT0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eBgyTinfqXAXg7MHUIcU9zU+zb/OQq5W8LI5XJIK+3/phWQB2e9fn7X5VvRMKw/IMK8BIBPKJFWxGFxvflUQqbhHBTaGEBXsxMa9yyGPjI5Tx1ziVbLf5lVZiPRRM2Fl98/hd04QIAB1mlnOr+NlSvlPHr2mpwMwk//06rv4tYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=XvckJVD9; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XvckJVD9"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E7BDF3F23C;
	Mon, 12 Aug 2024 18:02:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=LlDns7mwqzrACuWzkWuvc7us9FwOUCg8EzbNJa
	rWBT0=; b=XvckJVD9pzq6mfl7RUrSd4zRFoqyoepTpRwGL6gXOsTGjt6yuQ5jWm
	Ey+NR3JaVYqvT3KYF6EfRr3KTLJh2CCfqp1rA67u6cJQnrSBhM4o/88LUjH0siqn
	q/tFZ4WUBrXPJXlG+Rgz7oYRLc0pgFOEtXjU/QaJfIz24FgsNeqis=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DF42A3F23B;
	Mon, 12 Aug 2024 18:02:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 52D3B3F23A;
	Mon, 12 Aug 2024 18:02:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  Dragan Simic
 <dsimic@manjaro.org>,  "Jason A. Donenfeld" <Jason@zx2c4.com>,
  git@vger.kernel.org,  calvinwan@google.com,  spectral@google.com,
  emilyshaffer@google.com,  emrass@google.com,  rsbecker@nexbridge.com,
  mh@glandium.org,  sandals@crustytoothpaste.net
Subject: Re: [PATCH v2 0/5] Introduce cgit-rs, a Rust wrapper around libgit.a
In-Reply-To: <rt4ruismrzhtkbry4kuube5fwf2zprajjen7wagl5nyyjivhvz@xuxq6paidcmr>
	(Josh Steadmon's message of "Mon, 12 Aug 2024 14:24:03 -0700")
References: <cover.1723054623.git.steadmon@google.com>
	<cover.1723242556.git.steadmon@google.com>
	<Zrdn6QcnfmZhyEqJ@zx2c4.com>
	<6398d60387a6607398e4b8731363572e@manjaro.org>
	<CAPig+cSotr8CNZLy4xnm4qyJsuQsxjzsYMVU5sf3eeoEiE8aXg@mail.gmail.com>
	<xmqq5xs688cz.fsf@gitster.g>
	<rt4ruismrzhtkbry4kuube5fwf2zprajjen7wagl5nyyjivhvz@xuxq6paidcmr>
Date: Mon, 12 Aug 2024 15:02:05 -0700
Message-ID: <xmqqy1519z8i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 841ED682-58F6-11EF-893A-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Josh Steadmon <steadmon@google.com> writes:

>> But just a dismissing "Bikeshed on the name", as if they do not care
>> to be mistaken as saying "those who complain about the name are only
>> bikeshedding and not worth listening to"?
>> 
>> We should do better than that.
>
> I am quite surprised that people felt this was dismissive. So to be
> clear: yes, we need a new name before this lands in next. I thought that
> leaving that as a known needs-work item was sufficient to call that out,
> but I guess I was wrong.

Yes, I had a similar initial reaction, but I guess that comes
primarily from the fact that we both misjudged how "cgit" is already
deeply established name that refers to something other than this
project.
