Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975A31ABEBB
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 21:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722635246; cv=none; b=RosSMVdFkvGU7jj5Jj9d1ZkTC7odSaYcxYo1KB/7VN3Bhd3QErgjcZFGI8DZvP9LGogYWAiAS+eSKeSeSPtcFgBazCCeX/bmKqrLOBMSFPmc303yxcsXr1V649KvERSqBcx8AD/zZnwRBhPXkdQZIFp0dDZXsmZJFlL3d8P7upg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722635246; c=relaxed/simple;
	bh=KNhPeknrjaSZUZHHuQWjNcCx1sW9p8IA0fyLSln9hes=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RvFKLoPIn1MjoEt7LL4iY5hTPzAv3Pfwx0kz8QrF21XXPMWVQkZf9UKMg0Disx5n9m30fvOSA0HTxYEk7foqrPKFGLR0ui06BrJHWuzQxVQfhIP7/BtMLuIBJ/5wvqhjqibrb9VXuHDHmgy2vI5/uOFf7hbOVO+f6Wluwp1QnMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=M6jLf6Hq; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="M6jLf6Hq"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 44E0D1CD6A;
	Fri,  2 Aug 2024 17:47:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=KNhPeknrjaSZUZHHuQWjNcCx1sW9p8IA0fyLSl
	n9hes=; b=M6jLf6HqHFAG+2YvuL8Q/shD+Xx7kWkB7ftaB9Taz2flngjCuDe1Gu
	+nJhxxY5vGjclAOdwHJ1gAT9g1qwdzXmax9QAovXbtn/MGjajOrk0DousLEHgccA
	L9FkNyzHc8+sGIMtdaXnvRln2JSMoDlHyUbZRIEcUIgs0lBKhL0SQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3DDB71CD67;
	Fri,  2 Aug 2024 17:47:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 24E251CD64;
	Fri,  2 Aug 2024 17:47:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v5] http: do not ignore proxy path
In-Reply-To: <c7b3383b-ebbf-6ec4-00b8-41c9430a99f4@alum.mit.edu> (Ryan
	Hendrickson's message of "Fri, 2 Aug 2024 17:26:32 -0400 (EDT)")
References: <pull.1767.v4.git.1722489776279.gitgitgadget@gmail.com>
	<pull.1767.v5.git.1722576007398.gitgitgadget@gmail.com>
	<xmqq7ccygbx6.fsf@gitster.g>
	<2ba77de5-f103-c2f0-c009-71700c8a020d@alum.mit.edu>
	<xmqqv80idf52.fsf@gitster.g>
	<a0b916a4-8941-4c06-263d-0ae92dcaf29e@alum.mit.edu>
	<xmqqh6c2d8qt.fsf@gitster.g>
	<30733887-33d8-4049-7dc9-8bc9d0b106da@alum.mit.edu>
	<xmqqfrrmbpbv.fsf@gitster.g>
	<c7b3383b-ebbf-6ec4-00b8-41c9430a99f4@alum.mit.edu>
Date: Fri, 02 Aug 2024 14:47:19 -0700
Message-ID: <xmqqikwia97c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CBC71F0C-5118-11EF-A748-9625FCCAB05B-77302942!pb-smtp21.pobox.com

Ryan Hendrickson <ryan.hendrickson@alum.mit.edu> writes:

> what the test matches against. Matching against hypothetical future
> errors is speculative overengineering if it is not obvious how the
> errors will vary and what it may mean if they do.

The easiest you can imagine is that it turns out the cut-off version
of cURL for the feature turned out to be not 7.84, or versions of
cURL shipped by some distros have backports of the feature to an
older version that explicitly naming 7.84 causes more confusion than
naming the exact feature we rely on, and we end up rephrasing the
error message.  We have done such changes in the past, so it is not
really speculating "hypothetical future errors", but applying common
sense gained over years working on this project.
