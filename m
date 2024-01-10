Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8854B5BB
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 17:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TTHZBfNh"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F2CEB1C701B;
	Wed, 10 Jan 2024 12:25:10 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=P0+ESN0j0BpE5kVbc2lpyzsBB8bDF6nGalnfPo
	WxLbA=; b=TTHZBfNh62gS5aEYNBdTu70f6ALqGIccCDdwZmX54zb/IIZWKa7Bs5
	D9be2e6d7ZHLXcENCPN8veRCFt6MgiYxTLQbDNsLBG8qbBbybb2NAjTMSfuj29U7
	a5dL9jWE88szGDV90g/MKgqbT1WffYYWY9aKO0E/fD4NrzD6VRTV8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E92751C7019;
	Wed, 10 Jan 2024 12:25:10 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2E5E51C7018;
	Wed, 10 Jan 2024 12:25:10 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Chandra Pratap <chandrapratap376@gmail.com>,
  Chandra Pratap <chandrapratap3519@gmail.com>
Subject: Re: [PATCH] t4129: prevent loss of exit code due to the use of pipes
In-Reply-To: <pull.1636.git.1704891257544.gitgitgadget@gmail.com> (Chandra
	Pratap via GitGitGadget's message of "Wed, 10 Jan 2024 12:54:17
	+0000")
References: <pull.1636.git.1704891257544.gitgitgadget@gmail.com>
Date: Wed, 10 Jan 2024 09:25:08 -0800
Message-ID: <xmqqwmshcd8r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 34B87994-AFDD-11EE-9B08-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  t/t4129-apply-samemode.sh | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Looks good.  Will queue with two instances of a minor style fix (see
below).

> diff --git a/t/t4129-apply-samemode.sh b/t/t4129-apply-samemode.sh
> index e7a7295f1b6..ffabeafa213 100755
> --- a/t/t4129-apply-samemode.sh
> +++ b/t/t4129-apply-samemode.sh
> @@ -41,7 +41,8 @@ test_expect_success FILEMODE 'same mode (index only)' '
>  	chmod +x file &&
>  	git add file &&
>  	git apply --cached patch-0.txt &&
> -	git ls-files -s file | grep "^100755"
> +	git ls-files -s file > ls-files-output &&

Redirection operator ">" and "<" sticks to the file in question
(look for "> " and "< " in this file and you'd find none), i.e.

	git ls-files -s file >ls-files-output &&

Thanks.
