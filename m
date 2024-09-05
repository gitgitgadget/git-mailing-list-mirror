Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04CF10A1F
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548485; cv=none; b=akE6ZM2r/F8AluYCTwQIfhQ0sb8Ah4xr5p+ujP59KOPEi/pV8e0clokzFGCZa+qulqT5344GwVS5HM/1k93FXVBgDNAbYnNQdl4dbjBpJgD/mY9Mcwc/yFAAi9ak/DieqEVKHvjrgswCp90ah1/lvohJdl7hwrepjKAFc3TEd7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548485; c=relaxed/simple;
	bh=w/bmcXlUFJjfG9WQqSk9oHsXn8xtf1WLfhF5Is3T9HY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jT3LZ4RKJgQrqyFELo9P0+BMyXzFNC/cY/a0U3ChmLrivhvCz/ONNL4Cfjrxsyu0snBsSojD6OAQxXSgIbotU+CTJ0UjyooabGDTSsFy1yNFG8wQNWrYj5b5wpyH1Wr3JPaZ7NdKYA9ZTGY36QrWFR0WMN0p5RiYY9O4bedKX6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gnxyKSF8; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gnxyKSF8"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E045F2B683;
	Thu,  5 Sep 2024 11:01:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=w/bmcXlUFJjfG9WQqSk9oHsXn8xtf1WLfhF5Is
	3T9HY=; b=gnxyKSF8Kkd0du66CslFQhoEbIaxAYkqntr8guQKeDbQT5bbZivh0F
	crSaqDQhYQvEkHh51jhQscXjrvmX6JPhVKSkeAHcO94mhGtgBfQJUAJXmtBl0Go9
	EPH/O3QbXNSWIIBNXsNk2ZxBW7vmO0X3qj9ugnoCmfVemcXhZMksE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D42E92B682;
	Thu,  5 Sep 2024 11:01:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C4F622B681;
	Thu,  5 Sep 2024 11:01:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Han Jiang <jhcarl0814@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: `git log FETCH_HEAD` only logs whatever happens to be the first
 among the fetched refs (instead of all the fetched refs)
In-Reply-To: <CANrWfmSMbR+8oGsCzOygBA0sFSmMwUmCy=qQEsa16RWcztYaQA@mail.gmail.com>
	(Han Jiang's message of "Thu, 5 Sep 2024 16:25:50 +1200")
References: <CANrWfmSMbR+8oGsCzOygBA0sFSmMwUmCy=qQEsa16RWcztYaQA@mail.gmail.com>
Date: Thu, 05 Sep 2024 08:01:20 -0700
Message-ID: <xmqqplpi5em7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B68649E4-6B97-11EF-BA78-9B0F950A682E-77302942!pb-smtp2.pobox.com

This is totally expected.  FETCH_HEAD is only special to "git
merge".  When FETCH_HEAD is used as if it were a ref, everybody else
uses only the first entry.

