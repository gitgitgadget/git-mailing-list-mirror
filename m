Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3163281AD9
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032006; cv=none; b=P/UvmbhoWLs9MK0BTaLX7z+J0etslGyHKWPnurSesEGlA4poUWIr0aSczJGxrW6XxnrvPvkN+Akvo/pIY4VR9A3YMaYIhSwVSR/fDCfJPW9BtuPSmYn7Mmr2w7IzP+EsFA6jrTKmIPGwueIt0dt+ioBoVjkwNij+9s3irQZZxJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032006; c=relaxed/simple;
	bh=afuRY+i7kQFTKl1iftV2sQzYPtytYsvU3hkilEFrTIA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ORoM30BEXz8/CsXdLBXvrGQwF5YvrID2CKjbdty3nOipIUTxdID87QecoSMIBjHPcWLLNpZJO2V7McYgqv2j9JsVre5E3JQwoskHJDQYLZ/axd0M13kiDvb1hgG2ZhCDil7WWoy6dpw4c2hHdDJvdCnVBUGi4JuNgjVSdJbOHwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=qS3V2r7/; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qS3V2r7/"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BA79A1DB62F;
	Tue, 23 Jan 2024 12:46:43 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=afuRY+i7kQFTKl1iftV2sQzYPtytYsvU3hkilE
	FrTIA=; b=qS3V2r7/HXMaHFp5NJS0qdPHFJp7xDCroBvMcO7Dx9MnOaWBKfEFbG
	TZUmXWl9+8ZtLEzWDziWVlVqOaqBzEeMTcK4MM4GCYdQ+KpTN+9gXw2zmx+5BepB
	JnHWRrK08jNHGsiNpOjUwBaggpMWvS4IeazVKAOSK/zf8ITw5NU74=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B310E1DB62E;
	Tue, 23 Jan 2024 12:46:43 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 25A881DB62D;
	Tue, 23 Jan 2024 12:46:43 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  git@vger.kernel.org
Subject: Re: [PATCH 2/5] refs: make `is_pseudoref_syntax()` stricter
In-Reply-To: <CAOLa=ZQOcqGBJOSehok4BYGUE8RKtnE9eiJYogeT8E6NWZ25xw@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 23 Jan 2024 04:49:27 -0800")
References: <20240119142705.139374-1-karthik.188@gmail.com>
	<20240119142705.139374-3-karthik.188@gmail.com>
	<ee977173-bc6d-48f6-9bc8-e1d84fe3d95d@gmail.com>
	<xmqqplxtrucm.fsf@gitster.g>
	<ba721840-7b67-4822-8046-c0da4d3b9bde@gmail.com>
	<CAOLa=ZQOcqGBJOSehok4BYGUE8RKtnE9eiJYogeT8E6NWZ25xw@mail.gmail.com>
Date: Tue, 23 Jan 2024 09:46:42 -0800
Message-ID: <xmqqsf2ondrx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5EBFA200-BA17-11EE-B3B6-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> Given this, I think for the next version, I'll do the following changes:
> 1. keep `is_pseudoref_syntax()` as is.
> 2. introduce `is_pseudoref()` which calls `is_pseudoref_syntax()` and
> also checks the content of the file.
> 3. replace use of `is_pseudoref_syntax()` with `is_pseudoref()` in this
> patch series.

The content check in 2. was something that was mentioned in an
earlier discussion, lack of which I completely missed during the
review of this current round.  Sounds very good to add that.

Thanks.

