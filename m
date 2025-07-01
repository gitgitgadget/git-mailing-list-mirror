Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E80278E6A
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 13:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751376433; cv=none; b=cwoTpLds51GC7Qd4ynzweIhYjUlesiFv8yLHzYmpFuhDM5qNm9Tz441PoFv6DFxMBbBCOfZTkGpZiBNd+pHHKzTS8uMb9pBqejHkWxQhE49YHwunATleFnudggBSg2s6PUVqI6K24D+eKnviocWdVt9eyh+sL56rZRxAr929wSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751376433; c=relaxed/simple;
	bh=JDXk2hWjxwxVQZhLs0cjhtlNtdbW0JDMSLgdMtqHlg0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FBg5Q4i7kBUiUjLGO3sjVEr9LDik+UlW2xKuxVRzocWiuP1kko/20xSiLgWpOz09dmbSFwS/2aS0iWvJ2f35FvWtgjUavAj05RHG4kHY6f8xAaP7LIA9Sj20u/fgUqqEw9KTnNhIQhwq/ENPTiRPJvtpTFKCusDdlv7SZEBP5Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=5pWWLNCZ; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="5pWWLNCZ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1751376423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lh05l+j+HKAEA1yCkETUpDedNhgzfsW3pNGJ/w475ec=;
	b=5pWWLNCZ07XNNA9RuJcIBdQpkJDe3xmgn/a34YBGKprlh1n1BBdAx8iHGVnIOXxfyArREJ
	oGMguE8aziYyqcvyCrdiHcwuLLmsz8xjaT5OpmaXhgPl0r/ars5BUwm5v/f5ZM5W0/H2q1
	/CrA7nQZ37LFpwscXFt7dst4lgVigII=
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: chriscool@tuxfamily.org, jltobler@gmail.com, gitster@pobox.com, Karthik
 Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 3/3] meson: add rule to run 'git clang-format'
In-Reply-To: <20250630-525-make-clang-format-more-robust-v2-3-05cbcdbf7817@gmail.com>
References: <20250630-525-make-clang-format-more-robust-v2-0-05cbcdbf7817@gmail.com>
 <20250630-525-make-clang-format-more-robust-v2-3-05cbcdbf7817@gmail.com>
Date: Tue, 01 Jul 2025 15:26:49 +0200
Message-ID: <87bjq4qbxi.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Karthik Nayak <karthik.188@gmail.com> writes:

> The Makefile has a 'style' rule to run 'git clang-format'. While Meson
> intrinsically supports a 'clang-format' target, which can be run when
> using the ninja backend by running 'ninja clang-format', this runs the
> formatting on all existing files.
>
> Our Meson build doesn't yet support a way to run 'git clang-format',
> which runs the formatter between the working directory and commit
> provided. Add a new 'style' target to Meson to mimic the target in the
> Makefile.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  meson.build | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/meson.build b/meson.build
> index 7fea4a34d6..20ce0525a1 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2144,6 +2144,18 @@ if headers_to_check.length() != 0 and compiler.get_argument_syntax() == 'gcc'
>    alias_target('check-headers', hdr_check)
>  endif
>  
> +git_clang_format = find_program('git-clang-format', required: false)

I think we should include `native: true` as well.

> +if git_clang_format.found()
> +  run_target('style',
> +    command: [
> +      'git', 'clang-format',

We should be using the `git_clang_format` variable here to ensure we
call the tool we've found.

> +      '--style', 'file',
> +      '--diff',
> +      '--extensions', 'c,h'
> +    ]
> +  )
> +endif
> +
>  foreach key, value : {
>    'DIFF': diff.full_path(),
>    'GIT_SOURCE_DIR': meson.project_source_root(),
>
> -- 
> 2.49.0
>
>

-- 
Cheers,
Toon
