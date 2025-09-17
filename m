Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609DA225A29
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758119277; cv=none; b=SjhST/y8iTBxXthvt3heoT+eqIzFcMkmIG6v0hX+hW/bSDkfm37yhq0Hf40iny/o+YIM1rLydL7VzxCI27TSyH+7StpEdPS9VR3EZPVwJLrfUfkar82tqTdFpxs7h/+QydfzHc/x2P/5ptFhysSMMlvLnCf4lwNvfkbU0nTTKu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758119277; c=relaxed/simple;
	bh=jxkQCfvfXrt7dCIlxO4ecEdO1EgSPxyPPNKfaQ+xXms=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HurEGZR3E3wHkGXBYibuS+2cs7dUx3zRv4cppK7w9xlWdpXI5V78Cj74FfiSK1dCslKF0RlAWatGVPTTcsgbWD60uWt2eWK6r10db2qbPuqHzytal8DVve3H+Z0N2Vfx1A/ZB7qGZRs7gOQh262kXOAYfqxwBcT1Wm1dcmqi3o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=KvTZKd1t; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="KvTZKd1t"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1758119268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jxkQCfvfXrt7dCIlxO4ecEdO1EgSPxyPPNKfaQ+xXms=;
	b=KvTZKd1tN17JyTfVY8QSKQ3/EbsVTUUAIRCb4B8N3ef1GHj1IKEKeSIiOg457cAcWo3aG8
	wjdtd0tl5wVDNmowDFvMlqYREMRy8PYUv9ET7dD+kOLtcVPzpaA1eTr5UuA23LFvOFXLbh
	EYIA59nBtI+dWyKB9Ji42xGqLlbelRY=
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, joe.drew@indexexchange.com, peff@peff.net, ps@pks.im
Subject: Re: [PATCH v3 0/4] refs/files: fix issues with git-fetch on
 case-insensitive FS
In-Reply-To: <CAOLa=ZRvAMq7MNm6=dBneAXdDe6OjQ=NqYA9-Vd7E+nvDWGH0w@mail.gmail.com>
References: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com>
 <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-0-195569740b57@gmail.com>
 <xmqqh5x2m5d3.fsf@gitster.g>
 <CAOLa=ZRvAMq7MNm6=dBneAXdDe6OjQ=NqYA9-Vd7E+nvDWGH0w@mail.gmail.com>
Date: Wed, 17 Sep 2025 16:27:37 +0200
Message-ID: <874it1noh2.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Karthik Nayak <karthik.188@gmail.com> writes:

> I did respond to Justin, I think there were a few small nits around
> grammar in the commit messages and a question around error reporting.
>
> I have applied the grammar fixes locally and don't think they warrant a
> re-roll. Regarding the error reporting. I think it is good the way it
> is.
>
> So I would say this is good as is and I will refrain for sending in
> a new version, unless there is some other concern.

I also gave it a round of review, and I agree it's good to go.

I've noticed another issue though, at the moment it's possible to create
a ref like `refs/heads/foo.Lock`. I can image this gives issue when the
remote has `refs/heads/foo` and `refs/heads/foo.Lock` and you pull those
in on a case-insensitive FS. Unfortunately I wasn't able to verify this.
But anyhow, I don't think that any reason to hold back on this current
patch series. I approve.

-- Toon
