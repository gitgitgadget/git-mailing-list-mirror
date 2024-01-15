Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4F5182A0
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 17:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qjSKZjER"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C10C91D2D0;
	Mon, 15 Jan 2024 12:19:35 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dBwW1mAF7n8Bl1ohzOqYXsYD5Q5bK5U+zw21M6
	6TxzE=; b=qjSKZjER7fGHpZ0knKbqmDGi2aH0BQKDkghCBiPoef1oQ3F2XgWM55
	MRNytkCAOrPJKmrO3AjIDePFC8bpVhyGWz5oGf07Scv7U7cMFrnNvnloZ5ig5DOz
	Ebk9wIMOjUCR2+6fci/6w4LvG3yps1NUEJ2a/uFtUyOB5bk8PjD+0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B994A1D2CF;
	Mon, 15 Jan 2024 12:19:35 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6B83F1D2CE;
	Mon, 15 Jan 2024 12:19:32 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Michael Lohmann <mi.al.lohmann@gmail.com>,  git@vger.kernel.org,
  newren@gmail.com,  phillip.wood123@gmail.com
Subject: Re: [PATCH v2 1/2] revision: ensure MERGE_HEAD is a ref in
 prepare_show_merge
In-Reply-To: <ZaUYyEAdr4oTImL-@tanuki> (Patrick Steinhardt's message of "Mon,
	15 Jan 2024 12:36:40 +0100")
References: <xmqqy1cvcsp3.fsf@gitster.g>
	<20240112155033.77204-1-mi.al.lohmann@gmail.com>
	<xmqqzfxa9usx.fsf@gitster.g> <ZaUYyEAdr4oTImL-@tanuki>
Date: Mon, 15 Jan 2024 09:19:30 -0800
Message-ID: <xmqq4jfe5xb1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3F76CBBA-B3CA-11EE-A6C1-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> Which would mean that we do not need a separate "other_head"
>> variable, and instead can use "MERGE_HEAD".
>
> There is no need for this, is there? We have already resolved the ref to
> an object ID, so why not use that via `add_pending_oid()`?

add_pending_oid() and its callees use the name only for human
consumption (e.g., in error messages), as they all already have the
object name.
