Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525D7168C20
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723566345; cv=none; b=Ji6dCNb9LZ0CzPezP29zoMFKB13L5aAl6ZWvJsQqdH/fjv4k+pgivcyKdF82umnPmQ4NSIGSy7wOlvsPLzB7Hf2n8vj/AWmwBfoKCeFRSZ2zdtzCTdK0L/+z1GdMXnfW3ILxgGRTG+2iydNmbLDi/k8ld08U18bjK1GIRJxLqog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723566345; c=relaxed/simple;
	bh=LCOVLdKOeM0spFFXd4tFT9GmtUAR9zC4FtC22aB13xs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mpvqLDPa32RyydKI+vBXR3DcKkipJ0HuVVA8DOeA2lkFB81rYqCGDLOXDbJIH+FyxwGS9g4Oy1ujOlppEmEUu6FSoydZdkeNysIdhpKPw6vXeqjCVscCZdLfbKv3zGt3G+NfvUfnddmD94lqLlj+rgbLXIOwr6aGWk3HsmwU7e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rgtmTKXf; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rgtmTKXf"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 182EF27B3D;
	Tue, 13 Aug 2024 12:25:43 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=LCOVLdKOeM0spFFXd4tFT9GmtUAR9zC4FtC22a
	B13xs=; b=rgtmTKXfnpQpDoRBcto5WVarwQ/ScZ38poijiNNwIcolvMzj8w7JJt
	hMLEHp1jz6f7+zCifMn3H8k5YAqbwIfxtn00BDxbH7kiIyayv1vJB9SXxcc9JcPm
	xVvVV9+ohK2A9XB4Fyhe+q2Adi/k+V0cS0syjK/issm8M5ZL0gza0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0EEA627B3B;
	Tue, 13 Aug 2024 12:25:43 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6ACF627B3A;
	Tue, 13 Aug 2024 12:25:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  James Liu <james@jamesliu.io>,  karthik nayak
 <karthik.188@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,
  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 22/22] builtin/diff: free symmetric diff members
In-Reply-To: <31e38ba4e150c9bc9e3aa1073869881ccba9035e.1723540931.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 13 Aug 2024 11:32:16 +0200")
References: <cover.1722933642.git.ps@pks.im> <cover.1723540931.git.ps@pks.im>
	<31e38ba4e150c9bc9e3aa1073869881ccba9035e.1723540931.git.ps@pks.im>
Date: Tue, 13 Aug 2024 09:25:41 -0700
Message-ID: <xmqq1q2s8k56.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AF64E7D8-5990-11EF-A0C0-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> We populate a `struct symdiff` in case the user has requested a
> symmetric diff. Part of this is to populate a `skip` bitmap that
> indicates which commits shall be ignored in the diff. But while this
> bitmap is dynamically allocated, we never free it.
>
> Fix this by introducing and calling a new `symdiff_release()` function
> that does this for us.

OK.

> +static void symdiff_release(struct symdiff *sdiff)
> +{
> +	if (!sdiff)
> +		return;
> +	bitmap_free(sdiff->skip);
> +}

Hmph, wouldn't it be a BUG if any caller feeds a NULL pointer to it,
though?  When symdiff was prepared but not used, sdiff->skip will be
NULL but sdiff is never NULL even in such a case.

> @@ -398,7 +405,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>  	struct object_array_entry *blob[2];
>  	int nongit = 0, no_index = 0;
>  	int result;
> -	struct symdiff sdiff;
> +	struct symdiff sdiff = {0};

And symdiff_prepare() at least clears its .skip member to NULL, so
this pre-initialization is probably not needed.  If we are preparing
ourselves for future changes of the flow in this function (e.g.
goto's that jump to the clean-up label from which symdiff_release()
is always called, even when we did not call symdiff_prepare() on
this thing), this is probably not sufficient to convey that
intention (instead I'd use an explicit ".skip = NULL" to say "we
might not even call _prepare() but this one is prepared to be passed
to _release() even in such a case").

Given that there is no such goto exists, and that _prepare() always
sets up the .skip member appropriately, I wonder if we are much
better off leaving sdiff uninitialized at the declaration site here.
If we add such a goto that bypasses _prepare() in the future, the
compiler will notice that we are passing an uninitialized sdiff to
_release(), no?

> @@ -619,6 +626,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>  		refresh_index_quietly();
>  	release_revisions(&rev);
>  	object_array_clear(&ent);
> +	symdiff_release(&sdiff);
>  	UNLEAK(blob);
>  	return result;
>  }

Other than that, this looks cleanly done.  Thanks.
