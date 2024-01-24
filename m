Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3814B132C34
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 20:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706127076; cv=none; b=b5VasP0Dpectg7UgJeBMYJRbf3XcXkklpmoFWB0dW7YVouPge66JNAKyL7JL2SewELcr2JMnYnhW/0daLd3nHCOPk57iWhoMaP/wBb4wdrp5BZznlC58C8OCFIIC9bu+Wu9ms1c+FJMWo3ZtxkDVlglcO2OwwuzeiM3qyqWqJhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706127076; c=relaxed/simple;
	bh=o8+oZP4DNhrcRDcCAokQfv7sWeweMFVyiwTjF2ZoW/A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pIMiklGuPoTyMUXIV/dnC0zxVQ9MCDcvaXsRo2A7R//ZlLSAbkbRsiaPrtGG0K1dzNiwMbZWbe6sXyR1Xti/07rdGHusbu8LIANpFNz32NmtIbhjbFvTLgAVSF+EllYIplh+RQ1eAZdX25Gc1ZH1dlCRPEJH9NrxgrhRtnXfUXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=av5qRsor; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="av5qRsor"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AC6311E58CB;
	Wed, 24 Jan 2024 15:11:12 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=o8+oZP4DNhrcRDcCAokQfv7sWeweMFVyiwTjF2
	ZoW/A=; b=av5qRsorS3TUfjHi4P+9pTLry+E3E7ZcHgcWzke4mTOKJH6I4QLWMW
	5xWCmrDfq0bJE3VjGnmySw/IQS784Dd+d7f0kYuCJHX9fLPUyIeexbjLFEXf0zzt
	WEyWhF0TBBi1jgcOa7MCUlKtD8+6HwiL3doTIovrAc/uJ2ivZnkHs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A42C91E58CA;
	Wed, 24 Jan 2024 15:11:12 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 17FB81E58C9;
	Wed, 24 Jan 2024 15:11:12 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Md Isfarul Haque via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Md Isfarul Haque <isfarul.876@gmail.com>
Subject: Re: [PATCH 2/2] FIX memory leak in one branch
In-Reply-To: <a7c81f7e114fc8854436e2ca1fccb4c968653317.1706105064.git.gitgitgadget@gmail.com>
	(Md Isfarul Haque via GitGitGadget's message of "Wed, 24 Jan 2024
	14:04:24 +0000")
References: <pull.1653.git.git.1706105064.gitgitgadget@gmail.com>
	<a7c81f7e114fc8854436e2ca1fccb4c968653317.1706105064.git.gitgitgadget@gmail.com>
Date: Wed, 24 Jan 2024 12:11:11 -0800
Message-ID: <xmqqil3icx0g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B8415C96-BAF4-11EE-AD40-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Md Isfarul Haque via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Md Isfarul Haque <isfarul.876@gmail.com>
>
> Signed-off-by: Md Isfarul Haque <isfarul.876@gmail.com>
> ---
>  diff.c | 1 +
>  1 file changed, 1 insertion(+)

We do not need to see that you are just as human as other developers
and are prone to make mistakes that you need to fix it in a
follow-up.  In other words, please do not introduce a bug in [1/2]
only to be fixed in [2/2].  By squashing these two patches into one,
you can pretend as if you are a perfect developer and never leaked
memory ;-).

> diff --git a/diff.c b/diff.c
> index e3223b8ce5b..9fa00103a6b 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2309,6 +2309,7 @@ const struct strbuf *diff_line_prefix_buf(struct diff_options *opt)
>  		msgbuf->alloc = 1;
>  	}
>  	else {
> +		free(msgbuf);
>  		msgbuf = opt->output_prefix(opt, opt->output_prefix_data);
>  	}
>  	return msgbuf;

But as I said, I do not see a need for this helper function in the
first place, so...
