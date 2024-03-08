Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A1E567A
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 15:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709912690; cv=none; b=Uv+Tq3PJy1uhTNjmDm/eek/MtJfg68lJ0mg/lT8ew6Z/GUJ/ajx8NTFP0zOu/QXXwPSEsMHOgPY0f+RWzogfgGFuppZCZMBU4ygbFyP8MwS9mm3lc3lQWZVG6MxYrrlbbLTmexXwRwqffPzpcexWUm4DI3fA9pdCZn+iZNG44lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709912690; c=relaxed/simple;
	bh=F+U3pyjcFDTTLH6JPg7uXLJUU9AztVPqEsrn5HGCfaE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rb8AEGKdYkGDF8kg6zI0SCq7n/rb8emkyeqxD8OkJHt3tnGwpsjmmxPnK4EQsIbQD4bSwTw32SgTBSiuZPUfJ0+DC5y3J7pNEB1VYtmukZjrR5yKQe2beZTd5WM6QWtGvTZ1nr1+0O3spaSOxn1p2W3ABFtMknw8fXwoICDTdsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GaYEHPMY; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GaYEHPMY"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6354C38C99;
	Fri,  8 Mar 2024 10:44:48 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=F+U3pyjcFDTTLH6JPg7uXLJUU9AztVPqEsrn5H
	GCfaE=; b=GaYEHPMYOisE88ios2yk2yap0ioM7RvalH9DKRQE9cmKE4oH1jS55g
	k1djCbTjnhYdXZ3J6/rKCgdN1HxVh5QgvPyjgGb0aFrWD8N5uCDFxizbW/emp3m7
	zicl0TvenkIL69vYdX6LzBE2VvIJzSvnGnqze66UJhYrfltdCKUdA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5B9B938C98;
	Fri,  8 Mar 2024 10:44:48 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D26D538C97;
	Fri,  8 Mar 2024 10:44:43 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 0/4] checkout: cleanup --conflict=
In-Reply-To: <pull.1684.git.1709907270.gitgitgadget@gmail.com> (Phillip Wood
	via GitGitGadget's message of "Fri, 08 Mar 2024 14:14:26 +0000")
References: <pull.1684.git.1709907270.gitgitgadget@gmail.com>
Date: Fri, 08 Mar 2024 07:44:41 -0800
Message-ID: <xmqqplw4hgnq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C8B2E1E0-DD62-11EE-BF0F-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

Here is a place to say why this series exists.  Saying things like
"'checkout --conflict=bad' gives a wrong error message, as if the
inalid conflict style were given by a configuration variable, and
this is to fix that bug".

> Phillip Wood (4):
>   xdiff-interface: refactor parsing of merge.conflictstyle
>   merge-ll: introduce LL_MERGE_OPTIONS_INIT
>   merge options: add a conflict style member
>   checkout: cleanup --conflict=<style> parsing
>
>  builtin/checkout.c | 40 +++++++++++++++++++++-------------------
>  merge-ll.c         |  6 ++++--
>  merge-ll.h         |  5 +++++
>  merge-ort.c        |  3 ++-
>  merge-recursive.c  |  5 ++++-
>  merge-recursive.h  |  1 +
>  t/t7201-co.sh      |  6 ++++++
>  xdiff-interface.c  | 29 ++++++++++++++++++-----------
>  xdiff-interface.h  |  1 +
>  9 files changed, 62 insertions(+), 34 deletions(-)
>
>
> base-commit: b387623c12f3f4a376e4d35a610fd3e55d7ea907
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1684%2Fphillipwood%2Frefactor-conflict-style-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1684/phillipwood/refactor-conflict-style-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1684
