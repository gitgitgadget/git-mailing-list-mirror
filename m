Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D7026E6FA
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 08:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772266371; cv=none; b=gqapSz+wdSGmCvlokQ2SEUGcXZf92LrCdlRkc5rPtVuJ6Jb+qwckka9HgaPXazKXQLWm7oItbAp0BzxD9SGCMyFSF569cxPIvb80VqUH/Sq1t1tcnKx7CrgNT0Ib2F+oat8H3dwE32srGIDFfllNk/wKwPKPDrsOCssK8tLAR08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772266371; c=relaxed/simple;
	bh=OTkuXB6CIOrbdZycvzvPLYs5fnH1IDaEpPkmRGLG1pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CI0BxrT/o48wgoHOx9dUwUGUDBuOKP3yPx3OxnZJNz90rSQLKPQHuT6xUhj3DqDgxXKqmtSCqdR6Jzh83pZpo3HaM95qJpnPncvYcaUkvWUhooSls0ii4cypfSmuNkSyOh2xLfuxRGGkPdCT+4EsCEo7Nyw/lUfUspQfQDXKND4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4fNHxV5nMRzRnlS;
	Sat, 28 Feb 2026 09:12:46 +0100 (CET)
Message-ID: <3c854150-2efc-4f5b-8a75-bb40808babd0@kdbg.org>
Date: Sat, 28 Feb 2026 09:12:46 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] t3700: avoid suppressing git's exit code
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: peff@peff.net, git@vger.kernel.org
References: <20260227165143.70188-1-r.siddharth.shrimali@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20260227165143.70188-1-r.siddharth.shrimali@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 27.02.26 um 17:51 schrieb Siddharth Shrimali:
> @@ -536,9 +544,9 @@ test_expect_success 'all statuses changed in folder if . is given' '
>  		touch x y z sub/a sub/dir/b &&
>  		git add -A &&
>  		git add --chmod=+x . &&
> -		test $(git ls-files --stage | grep ^100644 | wc -l) -eq 0 &&
> +		test $(git ls-files --stage >actual && grep ^100644 actual | wc -l) -eq 0 &&
>  		git add --chmod=-x . &&
> -		test $(git ls-files --stage | grep ^100755 | wc -l) -eq 0
> +		test $(git ls-files --stage >actual && grep ^100755 actual | wc -l) -eq 0

This doesn't help. The exit code of $( ) that is substituted into a
command is ignored, too. You must move the git invocation out of the
subshell.

>  	)
>  '
>  
> @@ -574,4 +582,4 @@ test_expect_success CASE_INSENSITIVE_FS 'path is case-insensitive' '
>  	git add "$downcased"
>  '
>  
> -test_done
> +test_done
> \ No newline at end of file

Please keep the newline at the end of file.

-- Hannes

