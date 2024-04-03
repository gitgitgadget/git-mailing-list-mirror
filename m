Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF8415219F
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 16:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712163383; cv=none; b=P5wpczcWiLkTg63/eJEYhiiBcSQ6Kl7dVPWy+XE+fVSzFkqIeCURRDmreuVSnmweeKDxJigryeCgJ4hmMjLspcv3WhZC9FVWSCWslaborTAF3Rx2tX6YwpR18J3dI+Q7I2P6lr1xWYWl7TKkyysD1gBGHEKs/BfxcZLtjvfdzNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712163383; c=relaxed/simple;
	bh=LRjONO//jhBG9YeeY3itIHxscIYYWNAB/YbXEr1uBek=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WQaVMc3mUqXavbXrjgOF7v5ukQiLkzhe+D+DoIqmtIFFBOdoyUUuSF4w86yTobCSp3E63yUXmnIPDFWpslJLiEqBGaVnV3RdJSKU9zvCtnZjskMKoQdgYbcgwbP3GngmM/HjpfHyuT7+783zA5PJb41ZOY2opD3boy4ll6i2TxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CRLSNaYd; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CRLSNaYd"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 83EBC1DB538;
	Wed,  3 Apr 2024 12:56:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=LRjONO//jhBG9YeeY3itIHxscIYYWNAB/YbXEr
	1uBek=; b=CRLSNaYdo4iBbPtt9UWaICZezUlkrstDbSM7BuZ9VeFPQ/FaI5oMow
	dt+eBynoMgzzqPHW/sEbgcNSEGTWkjif7rXdoXp4Ts6m1XDzWbsu2cRS5Ab77OIs
	QFchhTDDqIC/k3i5ielndRJL++NmFpAS+4RI8Nq/0/VFC1PWF9jmU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7CB3D1DB537;
	Wed,  3 Apr 2024 12:56:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E15FB1DB536;
	Wed,  3 Apr 2024 12:56:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Justin Tobler
 <jltobler@gmail.com>
Subject: Re: [PATCH v4 0/2] reftable/stack: use geometric table compaction
In-Reply-To: <CAOLa=ZR0odWdoVBDTN+0j5d4f=s1z5zGcTNK+2tBgDX7RjXX2Q@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 3 Apr 2024 04:12:14 -0700")
References: <pull.1683.v3.git.1711685809.gitgitgadget@gmail.com>
	<pull.1683.v4.git.1712103636.gitgitgadget@gmail.com>
	<CAOLa=ZR0odWdoVBDTN+0j5d4f=s1z5zGcTNK+2tBgDX7RjXX2Q@mail.gmail.com>
Date: Wed, 03 Apr 2024 09:56:18 -0700
Message-ID: <xmqqfrw28jwt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1818225E-F1DB-11EE-BA08-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> Just a note that this doesn't merge nicely with nice because of
> conflicts with a2f711ade0c4816a59155d72559cbc4759cd4699.

True.  I've been resolving the conflict already, so there is not
much new to see here ;-)

It seems that the plan is to update the section that conflicts even
further to avoid the access to the environment variable, so I'll
have to update my rerere database yet another time.

Thanks.
