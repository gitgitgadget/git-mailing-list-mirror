Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244C637896
	for <git@vger.kernel.org>; Mon, 18 Dec 2023 18:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nA6PhyFJ"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B92451ECF1;
	Mon, 18 Dec 2023 13:11:02 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=kFZ1ReKVugroHvvEs4zVcuto44L4CuQ4P2Tx9O
	3zs7g=; b=nA6PhyFJ8pIsflPeX8grr+nLgUNc71szOUGGwWBjnnhwkrEWp6s1F6
	wdMnMb07eN4J6N1E/VtSiRuDk13zluDozdnlMRFNT9s57pXvSt1vSQbc0jZw1og2
	o+G106cFTadsOYbJoClodXup0TPKfq8kiSr61JBcce1hEJCpkaGxk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id AFEB41ECF0;
	Mon, 18 Dec 2023 13:11:02 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E3C701ECEC;
	Mon, 18 Dec 2023 13:10:58 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Chandra Pratap <chandrapratap376@gmail.com>,
  Chandra Pratap <chandrapratap3519@gmail.com>
Subject: Re: [PATCH] Teach git apply to respect core.fileMode settings
In-Reply-To: <xmqqle9rfkvd.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	18 Dec 2023 10:04:06 -0800")
References: <pull.1620.git.1702908568890.gitgitgadget@gmail.com>
	<xmqqle9rfkvd.fsf@gitster.g>
Date: Mon, 18 Dec 2023 10:10:57 -0800
Message-ID: <xmqqbkanfkjy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CB9712D6-9DD0-11EE-8961-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

>> +test_expect_success FILEMODE 'ensure git apply respects core.fileMode' '

Forgot to point out the most important thing.

The code change in this patch is primarily about making the code
work better for folks without trustworthy filemode support.
Emulating what happens by setting core.fileMode to false on a
platform with capable filesystems may be a way to test the code, but
we should have a test specific to folks without FILEMODE
prerequisites and make sure it works well, no?

IOW, shouldn't we drom FILEMODE prerequisite from this test?  How
does it break on say Windows if this test is added without FILEMODE
prerequisite?

