Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A5B811E4
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 21:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706130151; cv=none; b=LpIqPfOqbx/Rv9g6JIJJfD+mcZCT0aUJvabpH6NlYsSOcbNssO/Bp0i+asfqJizRzvcKHIv0w+kEnjwDYg0R/vRYRhvIcdb7SCCpYwfeNLv34hjkNfC6oJ9suYo/dFstSXRVmsbAbiZm5CMa97ago2ui+rFEXA/9Toqa+Yx9wdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706130151; c=relaxed/simple;
	bh=x//ZzMMzwXBljOogb1dnfqknRGWDmi5VH3/LCLnkg/0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TxKhInuUdEJGiCLk3j0slyibgYdz5uvxIwkz45PIJSUcUdLyWXvC62dwuWOdozR1NextWjLEsjrmP1bBDVcaK1PuF6CxDgx5+YDs6IfjXmhRTbVEOUtT7HW2ZueLub1LngcGyoITkdx0pepyj3RVI5yE2Q2pPQtBtWYH5fcA6dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BG+UByz9; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BG+UByz9"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C99EC2558E;
	Wed, 24 Jan 2024 16:02:28 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=x//ZzMMzwXBljOogb1dnfqknRGWDmi5VH3/LCL
	nkg/0=; b=BG+UByz94Lv7yWQpKuPST2VBsOUryq0WS72LXTZwhJSjI/3Xbnh/wr
	z/X8GkRHVdZbn9vFsoyQMxCBBeHgLz1t8u1/G2YZqlt2f6XmLjM3Sj+sio47JvD/
	Yo9ozwF8t7NqLfO0RPlBXNRAAvtbU49W+NTlDfK6wSUP0eLLth92s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C20EA2558D;
	Wed, 24 Jan 2024 16:02:28 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3E5882558C;
	Wed, 24 Jan 2024 16:02:25 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Mohit Marathe <mohitmarathe@proton.me>,  Mohit
 Marathe <mohitmarathe23@gmail.com>
Subject: Re: [PATCH v4 2/2] patch-id: replace `atoi()` with
 `strtol_i_updated()`
In-Reply-To: <17f2dda4907ec03b0783160c53c4896fd76cb053.1706079304.git.gitgitgadget@gmail.com>
	(Mohit Marathe via GitGitGadget's message of "Wed, 24 Jan 2024
	06:55:04 +0000")
References: <pull.1646.v3.git.1706078885.gitgitgadget@gmail.com>
	<pull.1646.v4.git.1706079304.gitgitgadget@gmail.com>
	<17f2dda4907ec03b0783160c53c4896fd76cb053.1706079304.git.gitgitgadget@gmail.com>
Date: Wed, 24 Jan 2024 13:02:23 -0800
Message-ID: <xmqqttn2bg2o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DFFF84D6-BAFB-11EE-9DCD-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  	q = p + 4;
>  	n = strspn(q, digits);
>  	if (q[n] == ',') {
>  		q += n + 1;

So, we saw "@@ -" and skipped over these four bytes, skipped the
digits from there, and found a comma.  

For "@@ -29,14 +30,18 @@", for example, our q is now "14 +30,18 @@"
as we have skipped over that comma after 29.

> -		*p_before = atoi(q);
> +		if (strtol_i_updated(q, 10, p_before, &endp) != 0)
> +			return 0;

We parse out 14 and store it to *p_before.  endp points at " +30..."
now.

>  		n = strspn(q, digits);
> +		if (endp != q + n)
> +			return 0;

Is this necessary?  By asking strtol_i_updated() where the number ended,
we already know endp without skipping the digits in q with strspn().
Shouldn't these three lines become more like

		n = endp - q;

instead?  

After all, we are not trying to find a bug in strtol_i_updated(),
which would be the only reason how this "return 0" would trigger.

>  	} else {
>  		*p_before = 1;
>  	}
> @@ -48,8 +53,11 @@ static int scan_hunk_header(const char *p, int *p_before, int *p_after)
>  	n = strspn(r, digits);
>  	if (r[n] == ',') {
>  		r += n + 1;
> -		*p_after = atoi(r);
> +		if (strtol_i_updated(r, 10, p_after, &endp) != 0)
> +			return 0;
>  		n = strspn(r, digits);
> +		if (endp != r + n)
> +			return 0;

Likewise.

>  	} else {
>  		*p_after = 1;
>  	}

