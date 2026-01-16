Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58473126C02
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 12:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768566642; cv=none; b=Im770UVnP1ySfBq/hlW3jSBFsHObkACHbkEXwJSyHvgdIRy8kz4TeE+E8FX9OeUk4QUhJc7DbVrfgjs1JivGaIGfx6oXAEYHgl393LfVe+lnwN62097egwjBT6B0pWSzT+3pMocxHUcg8J5e0r2g1Ier8brCuXNvWixSKwcL9tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768566642; c=relaxed/simple;
	bh=5PqmgLEUK3QVCTtQe58u4nHWSUwtuz6RsMw7BgP02io=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fzWYkYAVe6V0305Za637panPPsdGIv95PzyC5M2MDe43cEtREwUyrmAmwI58aAppU9TZZKP7PjG0fryeN+ZevijU2teUUWix3aTrqMd4v+GHGMi+ETZN6aNWol52NNozQPWX9ipOhnoruGp8CzkKeIqAI39opq9JGYWD5uGLQ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=ec6cO2DI; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="ec6cO2DI"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1768566638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5PqmgLEUK3QVCTtQe58u4nHWSUwtuz6RsMw7BgP02io=;
	b=ec6cO2DInUQLNuV2TQlZlE0dJs/rwLUdWm6e85Hn8uWrccDKvnzefXfNoT/m7fy1h2DOxW
	LgjDfxLcULPA8ctqyTZL0HsHQSsrFRKYxg0Kx4jqik/MPjXWbEf0WZGP3crfZFgDwIX84e
	J6Oq8u4zRP10xIpoYL9mJwXNQa0Tc1A=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] last-modified: rewrite error message when more
 than one revision given
In-Reply-To: <aWnkJ_GpgbXBPwFp@pks.im>
References: <20260114-toon-last-modified-tree-v2-0-ba3b1860898f@iotcl.com>
 <20260114-toon-last-modified-tree-v2-1-ba3b1860898f@iotcl.com>
 <aWd2SLrBQRBC1e2S@pks.im> <87jyxjjejz.fsf@iotcl.com>
 <aWjVWC71rFeTsHLP@pks.im>
 <ca6cfd7a-3392-46ce-99ab-3d93c9ce90dd@app.fastmail.com>
 <aWnkJ_GpgbXBPwFp@pks.im>
Date: Fri, 16 Jan 2026 13:30:28 +0100
Message-ID: <87cy39kae3.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

>> Surprised that =E2=80=9Crevision=E2=80=9D is a synonym for commit? Why i=
s that?

I must admit, I was surprised too.

> Because in my mind a revision can resolve to any object type.
> "<rev>^{<type>}" for example is a revision, but it can resolve for
> example to a tree if you say "HEAD^{tree}". Still a revision, but
> definitely does not resolve to a commit.

Besides the discussion if "HEAD^{tree}" is a revision or not. Passing in
two revisions to git-last-modified(1) is not allowed. So I think the
error message I proposed makes sense.

> Also, it's confusing to conflate the way to name a commit with a commit
> itself. "HEAD~10" is a revision, but taken by itself it's not a commit.
> It's not even clear whether it resolves, so it feels sensible to me to
> keep these two concepts separate from one another.

--=20
Cheers,
Toon
