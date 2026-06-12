Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F414D3624C9
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 08:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781251351; cv=none; b=BkWfBWQF7HpzzC9FbI4LW3B6oNQ4LDILlWUhGyBQD3tP9A2isQZEVy0fzdhnijh8GZ+IikNtD/xrisfFXO/XHJtCavcBXfvNrvFGSIl/W0GeDfJOzJZiEQ4gvbblei99TT/s3RStQvHMk6f2A6pHakkR1boKXDnti8C9pbVSLy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781251351; c=relaxed/simple;
	bh=6uCZtdowP+DHWGb+BOFFPrgr7/ISBlbqGT0gXQqLbPY=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=niapu/cZ1WlGajJnpCPXyEcqCNNemWIJ8JHMjrflP58lm52UcSbaaiDjvZmIDnILscXfDOApwErASXjgeAENwHGIJI9mEn58rUFeurzYw5cH5KR7xUuaynFbc8aoP7vkbrklFhcymN6oiJI3v05Y4eVbWUi5cqBjZ8Gv5w1s5mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=jLpoZ8Hy; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="jLpoZ8Hy"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1781251347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0zqqcDQIa3Bh9LcKAzN45WUMEM+feBQlWjxGX8yfNN0=;
	b=jLpoZ8Hy9w/CDlI+dCU4GvrO9Llp9Xi2Ww+y6NjTXhlwzgKApaa9PfZ/X7VtDFgjWp947K
	7dIq8uZRkDokhFkB/uqGUwXmGSp4XMQl3op3N9V3UQE7WY2IZfP8a+tjWNxlij0hoyjxI8
	ctL7PqKXRDURnvXi7E+B/x0nRWoeglo=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 7/7] treewide: drop USE_THE_REPOSITORY_VARIABLE
In-Reply-To: <20260610-b4-pks-setup-drop-global-state-v1-7-5dff3eec8f06@pks.im>
References: <20260610-b4-pks-setup-drop-global-state-v1-0-5dff3eec8f06@pks.im>
 <20260610-b4-pks-setup-drop-global-state-v1-7-5dff3eec8f06@pks.im>
Date: Fri, 12 Jun 2026 10:02:12 +0200
Message-ID: <87tsr8yynv.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Adapt a couple of trivial callers of `is_bare_repository()` to instead
> use a repository available via the caller's context so that we can drop
> the `USE_THE_REPOSITORY_VARIABLE` macro.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/repack.c        | 3 +--
>  mailmap.c               | 6 ++----
>  refs/reftable-backend.c | 4 +---
>  setup.c                 | 3 +--
>  4 files changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index bbc6f51639..d0465fb4f5 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -1,4 +1,3 @@
> -#define USE_THE_REPOSITORY_VARIABLE

This makes it all worthwhile. Great work on untangling this!

-- 
Cheers,
Toon
