Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB1818FDB2
	for <git@vger.kernel.org>; Mon, 23 Dec 2024 11:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734954740; cv=none; b=air6O4kweMaWxa4cEpUDzUxxOLT9D61IurTEAjN4ESUzmzIiEpp9Drk29pnsvmRWjXIxVJaOumwuCdQp1Qoh978vDOg4ffzyZg5JK8BtFgkDQuqqC2hitB5HT1Na9TcVw3yPwY1RnQ2awxKcWbL5MhT1C9pZPgCHl/XKLtrdiNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734954740; c=relaxed/simple;
	bh=jozRuGA614WoqJ1ZRy44YzFWc4zgf7p0r/BFPAvH5jk=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V6iYQNDWCmtU/rChBzBd7MR2t8bUwG2KSQ4F6QsBPPoKBoiaovxE1W8umIbHEUWR6sHlYZKKX5bUVSV5uHxwl7iiiEmfOiXpQbd5KSufdWDd0Hqke5eeWfejP7PEKIMI24rGseJ5wJirW4jMNUmdIPIPAvlGv7ISBKQn5jD8EOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=0bwJrHM5; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="0bwJrHM5"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1734954731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hAZ4YeH2xereOG44+AF8Ea9Ni//2fMAuEQbaqD4qBGM=;
	b=0bwJrHM5US2X67MI0hph/hsSY4ls78W7Yi5f5n1dsRuNchBr8F4QQfRXeBQmGJ00Z9sZBn
	lImeouRD0xpfnJcbCPaLLULyRIbplWXUdSQnGWT6wHMSv39DRTSj2bYzqF4EQ3wF9gI0yh
	UWRIANseiFDLa9wekC1lLIZ0Pas87NQ=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 00/10] meson: wire up missing HTML documentation
In-Reply-To: <20241213-b4-pks-meson-docs-v1-0-0c7895952cd3@pks.im>
References: <20241213-b4-pks-meson-docs-v1-0-0c7895952cd3@pks.im>
Date: Mon, 23 Dec 2024 12:51:54 +0100
Message-ID: <87wmfqfwh1.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series wires up missing HTML-based documentation with Meson.
> This includes a couple of missing manpages, the user manual as well as
> the random set of articles that we have. It also starts to generate the
> indices for API docs and howtos so that the result is a complete set of
> HTML docs, same as with our Makefile. It also fixes a couple of smaller
> issues I found while working on the series.
>
> Notably missing yet is an integration with CI as well as sanity checks
> for any kind of missing docs in Meson. I'll work on this in a separate
> patch series once the initial CI integration as well as this patch
> series here have landed.
>
> Further missing is the generation of both info pages and a user manual
> PDF. I couldn't find any users of these anywhere in downstream distros,
> so I decided to not care for now until somebody complains.
>
> The series is built on top of caacdb5dfd (The fifteenth batch,
> 2024-12-10) with ps/build at 904339edbd (Introduce support for the Meson
> build system, 2024-12-06) merged into it.

Hi Patrick,

I've been reading through the patches, and as far as I understand it
makes sense. But to be honest, I don't know how to use this. I have
almost no experience with Meson and I only know `meson setup` and `meson
compile`. But the `meson.build` from Documentation/ is marked as a
subdir() if option "docs" is given. But I don't understand how this
should be used. For `meson test` there are some instructions in the
root-level meson.build, but not for the docs. Should we add this as
well?

And a bit related to this, I saw you use `env: script_environment` in a
few places, how does this get injected from the root-level meson.build
file? Due to this, I assume it's intended to only use the root-level
meson.build directly, and not run `meson setup` in the Documentation/
folder?

-- 
Toon
