Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B9B3451BA
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 15:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771601837; cv=none; b=iDVy4FUnfMUhklKHMbsd/HFv9Emoi9+M1QpjjYmvIW1lYBr36SJD+ElIuAAzY32afHPxEp/ix3SmeKLGpqfHdwy2kNRpprfxaRDSdNPFvUjFdMmNwPosLu4yutzVDjedlHFyTVdLJruIYjFsJ9VC5GBsrBuRECNB2qBaO+siBpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771601837; c=relaxed/simple;
	bh=tKQRNXT0QIGeAvOJpreGuudzbY0J7A9rZ4jR1XSisKY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ikXzUm2HWJEBmvHDOyljQn2f0riWse+vi+qybL/hTxT47YEVjXnein1ioGnPIdub7CARBWPPfgJuT4rUdN8wl/nH0+yt5tOCSXIOj53PbG7+0H/S5hwSZmiuiRSU1Ku7C20o9muvWBQ0prwhPMIieALPEsGhcsIlz2mRvwHjQEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=SaUvOAUX; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="SaUvOAUX"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1771601833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0+sDKWdsghPINpVnvq2aXLmcpIgZCfV2ItgdeUd7XKc=;
	b=SaUvOAUXhJOZLEQ5LjGdUPX39MDzWS5fXr1drLbIZNsN4JXeU5+N3JcuYNesvjtBLpAgjY
	3KzDH2hmKKDFukYPEMMmGR+Kl0rU3ftz/IAdBfFb/EjixuVzgqpcHS4UbzUb2hfIR3CwG3
	MRFl7LNWwjxgDiF6eT/yhN/DIY00caY=
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im
Subject: Re: [PATCH v7 5/6] refs: allow reference location in refstorage config
In-Reply-To: <20260219-kn-alternate-ref-dir-v7-5-16f27860dbdf@gmail.com>
References: <20260219-kn-alternate-ref-dir-v7-0-16f27860dbdf@gmail.com>
 <20260219-kn-alternate-ref-dir-v7-5-16f27860dbdf@gmail.com>
Date: Fri, 20 Feb 2026 16:36:58 +0100
Message-ID: <87342vfmud.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Karthik Nayak <karthik.188@gmail.com> writes:

> diff --git a/setup.c b/setup.c
> index 1fc9ae3872..d407f3347b 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -632,6 +632,21 @@ static enum extension_result handle_extension_v0(const char *var,
>  		return EXTENSION_UNKNOWN;
>  }
>  
> +static void parse_reference_uri(const char *value, char **format,
> +				char **payload)
> +{
> +	const char *schema_end;
> +
> +	schema_end = strstr(value, "://");
> +	if (!schema_end) {
> +		*format = xstrdup(value);
> +		*payload = NULL;
> +	} else {
> +		*format = xstrndup(value, schema_end - value);
> +		*payload = xstrdup_or_null(schema_end + 3);

Also here, why did you put the negated condition in the if clause?

> +	}
> +}
> +

-- 
Cheers,
Toon
