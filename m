Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E96F433DC
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721314835; cv=none; b=TBClr2AHSrlkAD7Kwgvi7UJWHDBMbvHLxOkNOByESVyLl5GeZZrTnx7A280n7Szf2RIKzPIjeY1WujSr5RzBYDQV3SZiqr7zYgX2ZXFfJz8m6EIUqokNZJK2mwi77klTRCDbd1D3pKku8RdwhKL+0071NW5rHt15VeyNqjT4boA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721314835; c=relaxed/simple;
	bh=9bjbbM2fsh8OS5M1fTnWfwmcZfsFnSfG99wC+rhSe2A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Czt76Ez/s4m4WsbzwHDpeupkYVmtQpfnt50oafHkaVZXA7DqWnRJBL2jsmwYGcV2ugiwPs/JzRRAs7NOMKHS9IY2S4K9rlG5+uaN250QLRu/YPxbS0Xt+tYDBW7AkDa/PX32CQaTiDNIsKCTIEYBJiI0gLLwFHSTX4mHVQ63TF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QE9USHsG; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QE9USHsG"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1AA9A3C92F;
	Thu, 18 Jul 2024 11:00:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=9bjbbM2fsh8OS5M1fTnWfwmcZfsFnSfG99wC+r
	hSe2A=; b=QE9USHsGOllGosJmJCtgvMp/QXXqGk947QQOyIc9glKQfWFmmkGIW+
	Ejk5qg+wRLHh5GT8/+FfnKtTM1NBCFslSljwmxA+hHFEXUk6jLtLG4MWvsg1MIBK
	yWs+Vns+//sTW8XY14kwLKJxbXJpCTOAfMm1dO2lYcxiwtbLCXMiY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 133043C92E;
	Thu, 18 Jul 2024 11:00:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 83B723C92B;
	Thu, 18 Jul 2024 11:00:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chriscool@tuxfamily.org,  git@vger.kernel.org,  jltobler@gmail.com,
  phillip.wood123@gmail.com
Subject: Re: [PATCH v5 5/6] check-whitespace: detect if no base_commit is
 provided
In-Reply-To: <20240718081605.452366-6-karthik.188@gmail.com> (Karthik Nayak's
	message of "Thu, 18 Jul 2024 10:16:04 +0200")
References: <20240715093047.49321-1-karthik.188@gmail.com>
	<20240718081605.452366-1-karthik.188@gmail.com>
	<20240718081605.452366-6-karthik.188@gmail.com>
Date: Thu, 18 Jul 2024 08:00:28 -0700
Message-ID: <xmqqfrs6ycc3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 79B94CC0-4516-11EF-B368-9625FCCAB05B-77302942!pb-smtp21.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> +    - |
> +      R=${CI_MERGE_REQUEST_TARGET_BRANCH_SHA-${CI_MERGE_REQUEST_DIFF_BASE_SHA?}}
> +
> +      if test -z "$R"
> +      then
> +        echo "CI_MERGE_REQUEST_DIFF_BASE_SHA should always exist!"
> +        exit 1
> +      fi

The same comment applies as the previous step.

	R=${A-${B:?}} || exit

should be sufficient.

A demonstration.

        $ unset A; unset B; C=${A-${B:?}} && echo "C=$C"
        bash: B: parameter null or not set
        $ A=a; unset B; C=${A-${B:?}} && echo "C=$C"
        C=a
        $ unset A; B=; C=${A-${B:?}} && echo "C=$C"
        bash: B: parameter null or not set
        $ unset A; B=b; C=${A-${B:?}} && echo "C=$C"
        C=b
        $ A=a; B=b; C=${A-${B:?}} && echo "C=$C"
        C=a

Note that the broken case we do not see C=<value> becaues the
assignment fails with non-zero status.

Thanks.
