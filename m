Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE77183084
	for <git@vger.kernel.org>; Mon, 29 Jul 2024 18:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722279362; cv=none; b=daMJg4N4sQrJVGF3GU8etkhMVBNKDAWFUzxI4VEwsCEsMqqnaS2bOtVSmimfoqKkQhx4HpisFbZZQ08hpxZa0CsnoCSLOfRUceI83fqj67I5DhUcWBpj909+Kf5YSSiST1u5A9ng7Ob0AXE1XFkbX8Ft4m0Xn6L+c4lusGFsO2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722279362; c=relaxed/simple;
	bh=NXyvv/Oaerd+XAI4DlW4M44Q8zLh3goTd9ELfY02DGc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ukLPpo4QJn1ZDpM96Lw4bRACtXi9xENyqN7gr4AUg+jNWb37TCxlk/yFof1G+NOWll9ACnsrooP6jl/bnS0+XNFVvNXQB64HW54l7BHjd1wKIosNGaZpqSjh4sPb4T2DtZ0+YsKCHnl1gtH+slxb1FS7mST24YVxHFdyo8SbCqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kx8sUGml; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kx8sUGml"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A702E299B7;
	Mon, 29 Jul 2024 14:55:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=NXyvv/Oaerd+XAI4DlW4M44Q8zLh3goTd9ELfY
	02DGc=; b=kx8sUGmlO3fx4Amo4Rzw4fDDoCY6UIBdYHTml+ZiKbxSGkuahZKpAJ
	uEuBLx+WQ2bixlZoed3PvhpvxMLnjWWvrBYnk3USOMEJWqAWmXwpUJhWLAGDXKE8
	zmcyTX2qBL0c/1YJOpx1mvUFdEdizlkDWOJZ8TZbjLK0pXjRBUCQ8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E9C2299B6;
	Mon, 29 Jul 2024 14:55:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1202F299B5;
	Mon, 29 Jul 2024 14:55:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Kyle Lippincott <spectral@google.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe
 <l.s.r@web.de>,
  Git List <git@vger.kernel.org>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v3 3/7] unit-tests: add for_test
In-Reply-To: <ZqdldZE2MV-Pkuu-@tanuki> (Patrick Steinhardt's message of "Mon,
	29 Jul 2024 11:48:37 +0200")
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
	<73465c3d-1be0-456b-9471-f875e819c566@web.de>
	<c51025cc-26e5-41e2-be56-94e141a64f5d@web.de>
	<CAO_smVi2rJd5SDMsbbxzFUj28a_1KTgdHMz4DTKMsii+Wt5H_Q@mail.gmail.com>
	<xmqqfrrxjw8f.fsf@gitster.g>
	<CAO_smVhq=MkQV3a6qJtDiFykvR4im7AX4hMfKMNcL5SegnOSLA@mail.gmail.com>
	<xmqqv80szxgw.fsf@gitster.g> <ZqOc9vxdD4qttkFs@tanuki>
	<xmqqed7gxhyz.fsf@gitster.g> <ZqdldZE2MV-Pkuu-@tanuki>
Date: Mon, 29 Jul 2024 11:55:52 -0700
Message-ID: <xmqq8qxkhvt3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2E8DACFE-4DDC-11EF-A263-34EEED2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> is standalone nowadays and called "clar" [1]. The biggest downside of it
> is that it depends on Python to auto-generate the test "main" function,
> which is not really a good fit for the Git project.

Is that because Python is optional (like, we only use it for
optional Perforce thing and import-zip in contrib), or are there
other concerns?

Unlike these components, unit tests are not even for the end-user
consumers, so if it is Python that you find it a blocker, I do not
see a reason to reject it.  The thing looked like a simple script
that does not use any tricky language construct or modules.
