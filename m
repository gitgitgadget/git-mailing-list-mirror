Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02E71758D
	for <git@vger.kernel.org>; Fri, 10 May 2024 17:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715361456; cv=none; b=qx1Wr1wc0yAb5cV5dcEy7qvU3zMl/ZJakDVbZuPBX+q0VDcw1JR/9FqJerO2qe4t2EzOdIMa+z7zndSmrHQlTyJGtGvdE/eAgcIGAAX/PbY9n0jf5smrH+C0vvaSfFkoaCpWgfX0l+o6NGg4hcJ1Lx3NjUoVmSoytkDAx8ewyiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715361456; c=relaxed/simple;
	bh=AtaNLmoslQC4TJQoacLIDllywaFF1a9ojetDdChN1hI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VIEb1LUS0gCx/k6h+mlbPtMwQnrbOyYN/ur/CM8iw8GJwQlzveHnVrKxk22bmzOpjkvVlNS2mI96gc9H+tnEs/Z7JdcD4naIXy2hqa59FH835iXL2LGcnPbU/oniBkkHOReivYp/VCfXJshuaIVflqBvjxn5L05HFtoX4Zg2028=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GosU6iVT; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GosU6iVT"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9CA92253F3;
	Fri, 10 May 2024 13:17:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=AtaNLmoslQC4TJQoacLIDllywaFF1a9ojetDdC
	hN1hI=; b=GosU6iVTYozE6/infEb63L19kG4B4Y5S0JaigQj+a2RDZdIqTmcGyU
	xQ1WxfguDE5+IBmvseET/9KKKDTXI9fhMhqTTg8tF70TR1eni9MqhWlMPd+Wy8AD
	B1zseMvD63G06zgxmBokXYQVXD2NYyVJh61Q9e+n7ni1LDrDRA5og=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 92D42253F2;
	Fri, 10 May 2024 13:17:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 05EE6253F1;
	Fri, 10 May 2024 13:17:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/13] reftable: prepare for re-seekable iterators
In-Reply-To: <Zj5HvF-Uq0uWranj@framework> (Patrick Steinhardt's message of
	"Fri, 10 May 2024 18:13:48 +0200")
References: <cover.1715166175.git.ps@pks.im> <xmqqwmo3x44s.fsf@gitster.g>
	<Zj3RR-I1v1XwSuJ-@tanuki> <xmqq1q697jzr.fsf@gitster.g>
	<Zj5HvF-Uq0uWranj@framework>
Date: Fri, 10 May 2024 10:17:31 -0700
Message-ID: <xmqq8r0h60yc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 30350A2C-0EF1-11EF-A16F-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> It's needed in the sense that your version leaks memory -- the `ti`
> pointer is never free'd. Other than that they are equivalent indeed.

Ah, OK, I somehow misread that _close() will free the resource, but
it only frees the resources held by the shell and not the shell
itself.

Thanks.
