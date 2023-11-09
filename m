Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3135374F9
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 22:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="rGBq2nii"
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11445386A
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 14:15:08 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-778927f2dd3so84131785a.2
        for <git@vger.kernel.org>; Thu, 09 Nov 2023 14:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1699568107; x=1700172907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hf+MHf5qnsDfMaZVIqqMQ+WShpaYOknfK3njl5bff4o=;
        b=rGBq2niiV3LBWL8SsKBAWM0HV9bNAUip8e/kMtAyDVZVaBQKGqtAIawTrtlwaMSo1O
         j6BeSYlNY/BFzn4hhfyrQex5cg8hgE37y0xm30kg+K7b+kEpkX7ekjLGV+EJlYtldW+c
         lBsiuiMxCYxO8S59oW5OXnU5NQ4qL6WPLQ//KXIoWvxtYSwfGrgpk+amOFxnhhG23fMu
         mH4oEwLCDvboK0oTvKTdNiNWfiNNE1sjA6rLSH0V1gEdPVdbsUlDJ9pzwjuYg0i4Z7nV
         05F0F3JPUPbbAeZUusr2Sb2G30sI6eVh9IZxcatOZDd6irUG5ZtfcWn2DVu/BJtiqWq+
         3cHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699568107; x=1700172907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hf+MHf5qnsDfMaZVIqqMQ+WShpaYOknfK3njl5bff4o=;
        b=MBOAxrjurVR0xf8d4LPEc49UxVReJgSSe0eIkdXyEShKv2A5lt+uJP19dG3m+ciN4n
         4g/L4sxDN7UPRRtVBxE0Er/3JL2dr/5julNGa4+tvGaLxgiuK7Mik1dKoX8ti/kCXCZo
         hFSTsGmQ6gsjiwMe9guZ8ik6JWrhI9/RK4Mi9JWVjiYg8+Y/CByjuJVh6+qQb7khrFVy
         gnN3mo0a/42zPPiOKGdbyqGpNwh4rEA+sU9xsn4jKKwEiMf9isPNEGJccl52M4mVUYql
         TPXeQf8T/KPyi0hWXa9pyzmZdK/K6C7TiPn7EFcen0cL5iz8vqREtC0RvFyhzUE2e9QL
         /5Kg==
X-Gm-Message-State: AOJu0YwhSRIzV7DpKOLYQr2wZLAYDB1egrHOka6roEp/4AeJShq99a3M
	y5Qbv1lfiGHDsb3hrLewLZN6OgGSFqq3Q9lFl0RkmQ==
X-Google-Smtp-Source: AGHT+IF5634SrIAFSjtb7Klsgz3bzIX8x7pIvTZSXutQwvX1xhvQvw5MLxJRL2VY8/Gs0wuAlWXgVg==
X-Received: by 2002:a05:620a:2a07:b0:772:4be1:b41e with SMTP id o7-20020a05620a2a0700b007724be1b41emr6679079qkp.10.1699568107167;
        Thu, 09 Nov 2023 14:15:07 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g20-20020a05620a40d400b00767dcf6f4adsm237813qko.51.2023.11.09.14.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 14:15:06 -0800 (PST)
Date: Thu, 9 Nov 2023 17:15:05 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/9] commit-graph: use fanout value for graph size
Message-ID: <ZU1Z6WUrEhcxLBTO@nand.local>
References: <20231109070310.GA2697602@coredump.intra.peff.net>
 <20231109072435.GF2698043@coredump.intra.peff.net>
 <ZU1NNcP/ARxK6D89@nand.local>
 <20231109213813.GB2728242@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109213813.GB2728242@coredump.intra.peff.net>

On Thu, Nov 09, 2023 at 04:38:13PM -0500, Jeff King wrote:
> Or by "duplicate" did you mean the two-line:
>
>   > > +   error: commit-graph OID lookup chunk is the wrong size
>   > > +   error: commit-graph required OID lookup chunk missing or corrupted
>
> output. That's because our chunk of the return value from read_chunk()
> is a bit lazy, and does not distinguish "missing chunk" (where we should
> write a string saying so) from errors produced by the callback (where a
> more specific error message has already been written). That's true of
> all of the read_chunk() callers, including the midx ones.

Yeah, I meant duplicate in the sense above.

> This is one of the ways that pair_chunk_expect() could do better without
> adding a lot of code, because it can check the return value from
> read_chunk(). It doesn't help the other cases (like OIDF) that still
> have to call read_chunk() themselves, though. Possibly read_chunk()
> should just take a flag to indicate that it should complain when the
> chunk is missing. And then callers could just do:
>
>   if (read_chunk(cf, id, our_callback, CHUNK_REQUIRED)
> 	return -1; /* no need to complain; either our_callback() did, or
> 	              read_chunk() itself */

We do return CHUNK_NOT_FOUND when we have a missing chunk, which we
could check for individually. But TBH, I don't find the first error all
that useful. In this instance, there's really only one way for the OIDL
chunk to be corrupt, which is that it has the wrong size.

And short of making the error much more robust, e.g.:

    error: commit-graph OID lookup chunk is the wrong size (got: $X, wanted: $Y)

and dropping the generic "missing or corrupt" error, I think that just
the generic error is fine here.

> -Peff

Thanks,
Taylor
