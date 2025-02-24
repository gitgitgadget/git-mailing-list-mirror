Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F031F20C002
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 23:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740440844; cv=none; b=f25t/PhHaM+3g21OPqEjE9VNUEeU5GYWxcliwETfprO7xn0K7eHy9cXFPCIi162WVc83qG01LLdHLqLYCSEYXmfCY5oSff4of9VQQQfZ0eML/sLCd7qwKiqc4HVU22iLhL4hsp4wIQroEX+vZ6JD+mSLGP6Z9eWEha7HsX36yJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740440844; c=relaxed/simple;
	bh=kk3yYOPmyJBbb6MXDTo39yZ8HG8BY8BlzTU8ZK5m38g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXJN/YpUY4/4r3XMccZ4r+ZsGrpFkpVFXOpJ7f8mnZvAqep9VZg3tf2v33sq7uEwH7eWNhxmqzt0xd0/2CMHwFz+HJ0waFSyir264M/7qh79lEQaIzn8FVIQGlOLdb/zBFzhJcelbFEj5NmrunJCumgPTE8nUjB6+Kb/v6PrwjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=f9qN+xRz; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="f9qN+xRz"
Received: (qmail 21360 invoked by uid 109); 24 Feb 2025 23:47:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=kk3yYOPmyJBbb6MXDTo39yZ8HG8BY8BlzTU8ZK5m38g=; b=f9qN+xRzLVcyRyLd36BAIXpV/fedy9to69lnocOkAiSKtgr7SCQ4PEm0gqjG0N6W2oMfVC21qZgw0wPdKKPfu9TGgmx3t/87R5nhe1BYaCbdrXe7LIZo1zBuhKBAJPp/Z2PZS8gD9YieTJnPVIJ7DLYn+ndp5DWsVxZ+UKFmYCmC3cPGiJzbehn+9dtGf+ZrZZ62n4E+R8YtwYYxMiuziy6RGsDHzFn3Fp+GGxX3loRnV96L2+MOofWjVUJacbeA6/Kk8FFoS4NfGe75y8EgNRmJM76ybvnTmAKI/PvQ15sBV6hgT45BBgFlTzDueK/lKSngjycgbALXiI45HW9Pug==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Feb 2025 23:47:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30596 invoked by uid 111); 24 Feb 2025 23:47:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Feb 2025 18:47:20 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 24 Feb 2025 18:47:20 -0500
From: Jeff King <peff@peff.net>
To: Eric Ju <eric.peijian@gmail.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com,
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com,
	jltobler@gmail.com
Subject: Re: [PATCH v11 8/8] cat-file: add remote-object-info to batch-command
Message-ID: <20250224234720.GC729825@coredump.intra.peff.net>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250221190451.12536-1-eric.peijian@gmail.com>
 <20250221190451.12536-9-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250221190451.12536-9-eric.peijian@gmail.com>

On Fri, Feb 21, 2025 at 02:04:49PM -0500, Eric Ju wrote:

> +static int get_remote_info(struct batch_options *opt, int argc, const char **argv)
> [...]
> +	if (gtransport->smart_options) {
> +		CALLOC_ARRAY(remote_object_info, object_info_oids.nr);
> +		gtransport->smart_options->object_info = 1;
> +		gtransport->smart_options->object_info_oids = &object_info_oids;
> +
> +		/* 'objectsize' is the only option currently supported */
> +		if (!strstr(opt->format, "%(objectsize)"))
> +			die(_("%s is currently not supported with remote-object-info"), opt->format);

BTW, this strstr() isn't quite sufficient to prevent problems, as it
would not find placeholders which _do_ exist but which aren't handled.
One of the first things I tried was:

  git cat-file --batch-command='%(objecttype) %(objectsize)'

and feeding it "remote-object-info /path/to/repo some-oid". And it
segfaulted.

-Peff
