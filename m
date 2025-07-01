Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7452580FE
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 13:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751376994; cv=none; b=U+Gr8tcHCNIPDBrjaFR2v50OsS5wkcQ1OAPuOz4ZS4DLCHCCFysUT9GwdlV+wmUAQIGIDD8xgXZXaJWY7SB1voT3lQ+P8Az3Jofoz+gSLBx/nD7v9Pe2uLBkIsECo2SB2zig3AqxzZzrP17QF+m4Iet4zf7AqGtDaOPI94yuBUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751376994; c=relaxed/simple;
	bh=tzaV9BuYpx0TxQIjYwZHV/35pAnHKBaGKW83NwuQMXc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=asAfuE1fjnS5/qEqD/eVhg/veY3DNVXmzP1flcbRrwLHmXBAi2/RaYWCwxYpYt/odFtX5WAN3z4YVCYAPa0pHL1gJq01C4wTn+FNqRxr8E/yRnEBvPMYHYznlCuPn/hf9Eixf0dYLDmKM76wPUP8HAuPyvC4HhVZQx2gzBaa7xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=ks8hG4TX; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="ks8hG4TX"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1751376989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e5G4YlN76CIM2nQWZcdGG5/ad6Pb58uxYNfO58gAJAU=;
	b=ks8hG4TXbzyJ6e4n+U/zAQUS2RlB6+ol4T4ewbYhPnM5kOh0dvNh98kCibT09i/VGDu9Es
	nP5i9m73uTgSHookHu3BzanNoEqgUjU82e8j6oWy7SY5tGWpmoULiQoQBPwkJiI7Rxm8bj
	/4b6qJgkRPlblpA3s08dRtuG4a7+aZk=
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: chriscool@tuxfamily.org, jltobler@gmail.com, gitster@pobox.com, Karthik
 Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 0/3] clang-format: modify rules to reduce
 false-positives
In-Reply-To: <20250630-525-make-clang-format-more-robust-v2-0-05cbcdbf7817@gmail.com>
References: <20250625-525-make-clang-format-more-robust-v1-0-67a49ecc2fd5@gmail.com>
 <20250630-525-make-clang-format-more-robust-v2-0-05cbcdbf7817@gmail.com>
Date: Tue, 01 Jul 2025 15:36:18 +0200
Message-ID: <878ql8qbhp.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Karthik Nayak <karthik.188@gmail.com> writes:

> This series is in response to an email thread [1] around the usage of
> '.clang-format' and its effectiveness.
>
> The goal of the series is to improve the usage of 'clang-format' in the
> repository. To do this we:
> 1. Reduce the number of false positives. Majority of which is due to
>    line-wrapping. We remove the 'ColumnLimit' from 'clang-format'. This
>    removes the responsibility of line-wrapping from 'clang-format' and puts
>    it into the hands of the user.
> 2. Add a rule to 'meson' to run 'git clang-format' by running 'meson
>    compile style'.
> 3. Make the 'RemoveBracesLLVM' permanent by moving it to
>    '.clang-format'.

Thanks for working on this. While the changes are not huge, I appreciate
them.

> With this, running `git clang-format` for the last 25 commits in master,
> seems to produce much less false positives.
>
> [snip]
>
>   diff --git a/pathspec.h b/pathspec.h
>   index 5e3a6f1fe7..601b9ca201 100644
>   --- a/pathspec.h
>   +++ b/pathspec.h
>   @@ -80,7 +80,7 @@ struct pathspec {
>     * For git diff --no-index, indicate that we are operating without
>     * a repository or index.
>     */
>   -#define PATHSPEC_NO_REPOSITORY (1<<7)
>   +#define PATHSPEC_NO_REPOSITORY (1 << 7)

I'm surprised, but I couldn't find a setting to change this...


-- 
Cheers,
Toon
