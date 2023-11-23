Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="a2YBLwas"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25741BE
	for <git@vger.kernel.org>; Wed, 22 Nov 2023 22:10:09 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D0C0D3B366;
	Thu, 23 Nov 2023 01:10:06 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=tFLy4XWWenJdaTZVtqp4gxPcCfG0aLa8ncCUym
	qud58=; b=a2YBLwasynBN1icUapkThfSmSyKplT8SaJdfdLMQb4zKU+vL408WCX
	3C06xz54w+BgYZxTx7uGddkzhzsmxYPweSz2GVb2Erq/U82JsCKuk5RhPc54fiwC
	dNnVLcMi8UVIdbyoxi42Yb1eQWzmevPaS/Pu9BOPQDtf+T+QshWHs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BB5253B365;
	Thu, 23 Nov 2023 01:10:06 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 001823B362;
	Thu, 23 Nov 2023 01:10:01 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>,
  Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH 1/4] trace2: fix signature of trace2_def_param() macro
In-Reply-To: <97d17c22ff310c26c3ec391c7bf870e7e5bab4f8.1700680717.git.gitgitgadget@gmail.com>
	(Jeff Hostetler via GitGitGadget's message of "Wed, 22 Nov 2023
	19:18:34 +0000")
References: <pull.1616.git.1700680717.gitgitgadget@gmail.com>
	<97d17c22ff310c26c3ec391c7bf870e7e5bab4f8.1700680717.git.gitgitgadget@gmail.com>
Date: Thu, 23 Nov 2023 15:10:00 +0900
Message-ID: <xmqqil5tatl3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F01F1C98-89C6-11EE-B645-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhostetler@github.com>
>
> Add `struct key_value_info` argument to `trace2_def_param()`.
>
> In dc90208497 (trace2: plumb config kvi, 2023-06-28) a `kvi`
> argument was added to `trace2_def_param_fl()` but the macro
> was not up updated. Let's fix that.
>
> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
> ---
>  trace2.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/trace2.h b/trace2.h
> index 40d8c2e02a5..1f0669bbd2d 100644
> --- a/trace2.h
> +++ b/trace2.h
> @@ -337,8 +337,8 @@ struct key_value_info;
>  void trace2_def_param_fl(const char *file, int line, const char *param,
>  			 const char *value, const struct key_value_info *kvi);
>  
> -#define trace2_def_param(param, value) \
> -	trace2_def_param_fl(__FILE__, __LINE__, (param), (value))
> +#define trace2_def_param(param, value, kvi) \
> +	trace2_def_param_fl(__FILE__, __LINE__, (param), (value), (kvi))

IOW, this macro was not used back when it was updated, and nobody
used it since then?  

I briefly wondered if we are better off removing it but that does
not make sense because you are adding a new (and only) user to it.

Will queue.  Thanks.

>  
>  /*
>   * Tell trace2 about a newly instantiated repo object and assign
