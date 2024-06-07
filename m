Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EFB7347D
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 18:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717785765; cv=none; b=M/0/gc9/c/pmVn7+CEK+YQLDwRMuKevgOk5HmMy59j4D1czPwRsqFZJsL5pCeA8jW9seoUYF56rsHFQrj76z1hbNZklKDvvFE9yFdA7V8vuW6fgbAAYHTCV0uRmZek4h6VDwvTv5/ijRQTwQtc6pRW9X+3ZCw6k/4y1ram7toWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717785765; c=relaxed/simple;
	bh=ReWo6KoW0DWd1SOlNq1hIrOkoW9iR8sR/KUZYd9UyLo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nahfVyhvAv8pFU4nzyoZ5UGNXSZZdl9o3Co3S4I9Lnzx/wu/IgiO4TGO8vobS1tplUE6tttObuEaCuYsbzAplgmPmwy1Uqk+VnqBTJ2N6z6NY6FYbTTLBAuUrOnJ7eDrWnzKEXxIFbP8XX8Y3Qc10ks5l2/Vsx9e190hP3oljMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bVhK5lhX; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bVhK5lhX"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E524C3050E;
	Fri,  7 Jun 2024 14:42:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ReWo6KoW0DWd1SOlNq1hIrOkoW9iR8sR/KUZYd
	9UyLo=; b=bVhK5lhXpWYDM1ZUe7RTYyvSBDc6LyDktBdCJDLK9ldm+hPsaXuLJ7
	pIwEOKe4uXxFOcwjN+hKty/ZoxyDeuH5u7icXIhjaA6C6b3i1aZAGOGDik/moHPJ
	f+VMFnWnGAjb/DuFeaHOUOJRpTnAi1S01micun1g74Aj8K7j/d/zc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DC30A3050D;
	Fri,  7 Jun 2024 14:42:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4C92B3050C;
	Fri,  7 Jun 2024 14:42:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] ci: let pedantic job compile with -Og
In-Reply-To: <ZmKWLV29TQ71DQ7u@tanuki> (Patrick Steinhardt's message of "Fri,
	7 Jun 2024 07:10:05 +0200")
References: <cover.1717655210.git.ps@pks.im>
	<351dec4a4d5a5619e7627e11a8e674e32125125e.1717655210.git.ps@pks.im>
	<20240606065236.GA646308@coredump.intra.peff.net>
	<xmqq4ja6niba.fsf@gitster.g> <ZmKWLV29TQ71DQ7u@tanuki>
Date: Fri, 07 Jun 2024 11:42:41 -0700
Message-ID: <xmqqmsnwd272.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B924F776-24FD-11EF-B77D-6488940A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> Speaking of variants, is there any interest in migrating one or some
>> of the existing x86-64 CI jobs to arm64 CI jobs GitHub introduced
>> recently?  I suspect that we won't find any endianness bugs (I
>> expect they are configured to do little endian just like everybody
>> else) and there may no longer be lurking unaligned read bugs (but
>> "git log --grep=unaligned" finds surprising number of them we have
>> seen and fixed), so the returns may be very small.
>
> Note that we already run arm64 via GitLab's macOS runners. That's not
> Linux of course, but I guess that any architectural issues should still
> be caught by that.

The more the merrier and it is nice to know we have extra variety
over there.

> Not to say that we shouldn't adapt GitHub.

;-)
