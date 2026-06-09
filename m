Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBFA2F6188
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 01:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780968160; cv=none; b=CGffbwn4mFhgB0Sb7J1zythJugnPzYP/tZ5cL/Q9upgMIq9Ln/F00R0ZWwI1EtoUKSj/IzwBAPe+ineD2BCtpUuZSHZzzjblXkic8XNHKETqvKULb4w736hjhd1ku5dpLBlOlQ0sidsvlkRPy46Szczs4gsYMuF4S9jBzA0rfLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780968160; c=relaxed/simple;
	bh=paVAgSLnRaFtypCPScfnKekmhCt5cXzRK9lzK3wAW9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXrbvFHtuwvj6VcB7SewV2UxHhuG5ceeNVrX1KicpBgV1nYcFDSDCtSRmsV17VEZKPR98jVMaZMRKWCC2FIjI8N1UB7bJdLXRY6VR8VI8qOjYQSc6cW6tvnESh/pBycnrz7wbmFq8wxo2PdxITm3djHPjUL/dU2xF1AybVTHbH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=emXz732r; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="emXz732r"
Received: (qmail 84317 invoked by uid 106); 9 Jun 2026 01:22:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=paVAgSLnRaFtypCPScfnKekmhCt5cXzRK9lzK3wAW9c=; b=emXz732rQKny9UQBGl92Jk94951b8OEUiHblxQ7wnHTitpdwcM8VZ4J/i6bgzbMukxXwW140YyEa8xVYGxozhhVqTb3cMDHZjpVen9RBvfRc2VMlPGVKMskEffdvsXDm/m644TWcxAwLtEhCZUz4RJmCgF5VJUxkX/DCDA6x4RGF17eAzA0AKnTRfu2A/oBHf/2/Y0lreXTGXWx0Oof5X+0GHuvIR6GnV2vYxOhdY2qoBFswXAob4sp750wiCLvC62LMJlIabpU0+bSeA16+aYzhWA2vGA51jh45/2b7D4Ky2N8IU2ISrF25pBCaXPrVdVGN4tQYeRcnPS10bFvzhg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 09 Jun 2026 01:22:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 248010 invoked by uid 111); 9 Jun 2026 01:22:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Jun 2026 21:22:40 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Jun 2026 21:22:36 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 5/8] t7810: turn MB_REGEX check into a lazy prereq
Message-ID: <20260609012236.GA1502349@coredump.intra.peff.net>
References: <20260604-pks-t7527-fix-tap-output-v3-0-7d766ed481e4@pks.im>
 <20260604-pks-t7527-fix-tap-output-v3-5-7d766ed481e4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260604-pks-t7527-fix-tap-output-v3-5-7d766ed481e4@pks.im>

On Thu, Jun 04, 2026 at 12:07:35PM +0200, Patrick Steinhardt wrote:

> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index 1b195bee59..d61c4a4d73 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> @@ -18,8 +18,9 @@ test_invalid_grep_expression() {
>  	'
>  }
>  
> -LC_ALL=en_US.UTF-8 test-tool regex '^.$' '¿' &&
> -  test_set_prereq MB_REGEX
> +test_lazy_prereq MB_REGEX '
> +	LC_ALL=en_US.UTF-8 test-tool regex "^.$" "¿"
> +'

Oh good. Since the error was coming from the shell, I was worried that
the use of LC_ALL inside the test snippets was somehow causing output to
leak to stderr. But it was just (yet another) case where we ran a tool
outside of a snippet, which is easy to fix.

This also allays my fears that the tests might have been misbehaving on
those other platforms. They are (and were) caught by this prereq and not
run at all, which is the right thing.

Thanks for fixing.

-Peff
