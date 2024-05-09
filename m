Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E91F85C41
	for <git@vger.kernel.org>; Thu,  9 May 2024 20:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285681; cv=none; b=ABqD1KFquuocmQjYvwSvAQFsISl7oHRbKtl2v/NSO6l42z30ZofJaQMOnxyDMQXaWSifQ+7cMhJ2vzQ9axW6cxHQ72SpV1ULi/HS3MFA3LILLmAoCGHNK64YYNHnxOCXH36sv2oz1ajPwJnyBmxSgzQPYjXLIgW/b3prK6Nu71Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285681; c=relaxed/simple;
	bh=nTqNaEzV4pju3L3v6eNKAQrQn5heSQl3J5xKe3wHvLg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RCr6zt/0JgQ8QeRn05owoQg5Ny7BT39f8x2pmUAU0NCNXelyO01T9SZsxFkApkxncqRz9nBHeijojMYxHn/e+slc993pHCWtmVHqCsl/VoPOBQQ8Wb1xTvYI53qHpzh3jnBHmEu5kiwL3pnmbhhW50UaY+KocJDqwxw40kwAWTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CI6ZP12f; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CI6ZP12f"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EC63F2EA1F;
	Thu,  9 May 2024 16:14:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=nTqNaEzV4pju3L3v6eNKAQrQn5heSQl3J5xKe3
	wHvLg=; b=CI6ZP12f+wgi5RgI2AUstEI5ASE4Q3WN8mdU6gOLMfk0bFDEYPZqYC
	52+z+WRNWgnzBW2hiT5ZzB9KXT7+zqQlWCgKlDVUoztZeUl1uKfpaV0AcVqOkqKx
	TwVOwrxAkwZC6IRa8ri1DN1qPTLc3nMNIW2tuhcPNGPMNSbChZMDw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E3EAE2EA16;
	Thu,  9 May 2024 16:14:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 789B92EA11;
	Thu,  9 May 2024 16:14:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kyle Lippincott <spectral@google.com>
Cc: Calvin Wan <calvinwan@google.com>,  Git Mailing List
 <git@vger.kernel.org>,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  rsbecker@nexbridge.com,  phillip.wood@dunelm.org.uk,  Josh Steadmon
 <steadmon@google.com>,  Emily Shaffer <nasamuffin@google.com>,  Enrico
 Mrass <emrass@google.com>
Subject: Re: [RFD] Libification proposal: separate internal and external
 interfaces
In-Reply-To: <CAO_smVhjtvHeDR6KYNJL+hzc5uheWjshaayQPN1PkBhRaFTqOQ@mail.gmail.com>
	(Kyle Lippincott's message of "Thu, 9 May 2024 12:45:51 -0700")
References: <CAFySSZAB09QB7U6UxntK2jRJF0df5R7YGnnLSsYc9MYhHsBhWA@mail.gmail.com>
	<20240422162617.308366-1-calvinwan@google.com>
	<CAO_smVhjtvHeDR6KYNJL+hzc5uheWjshaayQPN1PkBhRaFTqOQ@mail.gmail.com>
Date: Thu, 09 May 2024 13:14:27 -0700
Message-ID: <xmqqttj6spy4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BDB3A414-0E40-11EF-9197-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Kyle Lippincott <spectral@google.com> writes:

> I don't expect there's many cases where we want to create a wrapper
> that maintains the existing interface and error handling, because that
> wrapper can _only_ by used by the git project binaries, not any of the
> code that's in a library.

In other words, such a code belongs to the "glue" layer that updates
the internal implementation detail of "git" so that we no longer use
the original set of helper functions and instead make use of the
"library".  They are not part of "library" proper, as among users of
the same "library", the "glue" is needed only by "git" itself.

So, yes, you may have to create such wrappers if the library wants
to be used by "git" itself, but the wrappers should be kept outside
the library.

