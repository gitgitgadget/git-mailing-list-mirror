Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A5E1E51A
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 17:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710104; cv=none; b=d9UENYK4ysCpz2zZ6ub7whcdydFTBwN18763y1BDrwIGqznMFYnrDnmy1kDD6JXdIvrG5jjT9PIO9ABQDXmFlrXH9xHF2vwsUCzRuUrQbPfeVT63V78syxE75Zk2Bm9CcxT0b/NlCjq0qPys0Ksd+folrmby8u7qEcBznfpl8M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710104; c=relaxed/simple;
	bh=KtMmEJR9ru57Cxv4baHQ6Y50GZ6vj1tRWEJSen6FIqg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gNaFcND9DoAOXBsDZWqbjjKKjDRvGjI0lmxYgX8YPoV/ewJGGp79fwr/R+sxPltUo0iMRkVrHvvw/AcI8ZKsIK5Z2zI0leH6//tIaE8wRwqRygjP7o3Laf/sph67ygQWCnQ+LkKwqwnDmwl2PO1Z+xNMiWtxInjFpvYBzlRhgpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MS8TlbC8; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MS8TlbC8"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A1F22228E2;
	Fri, 23 Feb 2024 12:41:42 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=KtMmEJR9ru57Cxv4baHQ6Y50GZ6vj1tRWEJSen
	6FIqg=; b=MS8TlbC8MApNranAC8oYdV6V+f97JRPlZo24QGZT5AyIqFrUS2DKwO
	Yp5Qwi0qgfkr3j/+MQgiA9CDl7TcpRvzs+j5DM/oPeLx1Py6REijb0kpKg7WEO3o
	F2D41TM6fe+Yh27sq3tHNo1eV+LxqRoMYg30cBCZZH5kjFFsmqVTM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9AEEE228E1;
	Fri, 23 Feb 2024 12:41:42 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B8F41228E0;
	Fri, 23 Feb 2024 12:41:38 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Brian Lyles" <brianmlyles@gmail.com>
Cc: <phillip.wood@dunelm.org.uk>,  <git@vger.kernel.org>,
  <newren@gmail.com>,  <me@ttaylorr.com>
Subject: Re: [PATCH v2 7/8] cherry-pick: enforce `--keep-redundant-commits`
 incompatibility
In-Reply-To: <17b669c4bfe6602f.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
	(Brian Lyles's message of "Fri, 23 Feb 2024 06:23:22 +0000")
References: <17b669c4bfe6602f.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Fri, 23 Feb 2024 09:41:37 -0800
Message-ID: <xmqqjzmvulgu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CC1EC3F8-D272-11EE-9913-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Brian Lyles" <brianmlyles@gmail.com> writes:

>> Well spotted, do we really need a new test file just for this though? I 
>> wonder if the new test would be better off living in 
>> t3505-cherry-pick-empty.sh or t3507-cherry-pick-conflict.sh
>
> I was modelling this off of 't3422-rebase-incompatible-options.sh'.
> Additionally, I do feel like these tests are only tangentially related
> to the tests that actually exercise the features themselves. Notably,
> the setup requirements are drastically different (simpler) since the
> test should fail long before any setup actually matters.

It is exactly the reason why we do not want to waste a scarce
resource, the test file number, when we do not have to.

Sanity checking the command line options and failing when they do
not make sense is a small part of what a command needs to do; you
are exactly right to say "they do not really exercise the main
feature".

As these "we expect this to fail" tests do not depend on and do not
have to modify the state of the test repository, we do not even have
to do any extra set-up over what the existing test script already
establishes, no?  No additional set-up is even better than a simpler
but non-zero set-up we need to newly do, right?
