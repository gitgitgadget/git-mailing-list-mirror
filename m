Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3252A16E86F
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 18:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729104782; cv=none; b=quHQf+TRgvd1mzC8DN5ykL9O4SCK2qVAGfTzb4XhfusebVeAypu517WIccA7GY/MD7t3ghz7qAjiZeoUzWB3YHbQBLk9fV6tkMvwKk+X6nF6U62r4A8qzMb9Gg/qJ7eSxBoZ1Spp4HhA+ci4MaFh6uQGiO/TLt971R0kflcDzQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729104782; c=relaxed/simple;
	bh=/LjYx/lp+VQxDGoNyPymOoD4dN+nLLT2gCr8e8e3Ktk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPNMue0+uR3s3oY+LEaqkNy9w25ikR3+XINf+a7dHgKSaUMtVd+N4OnjLYW9rQtdIHioTM/QPrWTK8Apo6UZozFkfN+/M2w/qlFCARgzuvnAJEa/kXBV2neDEfJomIWfKghazUHxDeOH9ZcmnuJ4fi3ypuTaM4r4ZGfb79/+/Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=RLROq9HB; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="RLROq9HB"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6cc03b649f2so1008166d6.3
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 11:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729104780; x=1729709580; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LjYx/lp+VQxDGoNyPymOoD4dN+nLLT2gCr8e8e3Ktk=;
        b=RLROq9HBZ4jx+QRnZRnRksn2xgJkOVEWbNJk3EW57eJekuwO+74rmHmRFUPjbXQE+x
         xOn5Rd9V1L4oMcz3jnapSbYI7vuRa2P/KhXseYSsPeyf3Ho9TTRTm5hC296YAKtlb2if
         48NYW8ALHSDeYrvvxC0mFmHaD2fEduXI7w3Bex1z/tnWrciZu0h2dOybgZkNBNiM7C18
         QcqKY3FYcvoLIQMEkBKP4LSd8fCuxcQC5XpxAgOVgXb5d5BqX84W6k3zLa8jvdYzONjC
         h3ZvVIgz8gp/EtNVc4VmiCkz4/DSBSWAK9QzQP39V9++VkI7Q6O8aRFxnzQCYZLxaBfe
         FT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729104780; x=1729709580;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/LjYx/lp+VQxDGoNyPymOoD4dN+nLLT2gCr8e8e3Ktk=;
        b=jUjQTfTBr8sYXTWt7K4ZmTQ856RiJyjV4qHsZcz9bOCb3sx/5eWyqDuqYiKgGUf/BO
         1m5N+QNqz+pwZFncyj6uEQ4iEKJ2oBd+qiWRINqT3UtC97NRj62raqMaI6hs5dIUCJ+c
         2f1s/TGxAM8uSGnKHOXK25YX/2YNRdsL5945q9jIohItqr20wpdbN9bWRDz6Z/Vr7bP6
         7JANr/bjmBKJzqXZlirIRza7xwT6AGeG1RpgnMvX2XGki/BKN4YQn/RTFkz1P4u46Lzw
         PvFxiK2AhXTgJukZG+Im0athLMCIMVpIrAFvDuQWu/lNp1PmAi3DXNchuSMn0KTcUMSf
         n+ww==
X-Forwarded-Encrypted: i=1; AJvYcCUb27dj1hgI9pRseAd+R1RvV/8yVIcd8wxa2gHrxiJ5zzkhOthrjAPgA+dFtYXNFGdJ4eA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdhgrywTEJPG+ksLsm5eXqQkWnkPOJvYvTjwpSwYvEts5Lz36m
	q/j3+9zMjytyr5RwmoapmtFRbqGHvlH3YJf2+3k+8Tibyg+c2bpxdWnKJESkOIyOS6CAcYQCIWg
	M
X-Google-Smtp-Source: AGHT+IGH3oju7/tZvwCMHXM9EKCtum4JAwXbJv5WekewwE35t8p1IubvHiBg3NMLaAPfrTa8Z8bKfg==
X-Received: by 2002:a05:6214:4804:b0:6cb:ce15:dc4e with SMTP id 6a1803df08f44-6cbeff74b98mr336411226d6.8.1729104779993;
        Wed, 16 Oct 2024 11:52:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc2291d9f4sm20783736d6.43.2024.10.16.11.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 11:52:59 -0700 (PDT)
Date: Wed, 16 Oct 2024 14:52:56 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [RFC PATCH v2] builtin/shortlog: explicitly set hash algo when
 there is no repo
Message-ID: <ZxALiDHkkq4yIP8R@nand.local>
References: <20241011183445.229228-1-wolf@oriole.systems>
 <20241015114826.715158-1-wolf@oriole.systems>
 <Zw9P90_QtiAAH3yz@pks.im>
 <gtdjnvonjodr435wuv2pofnww2pdcd33s22xxz5ypwkpvdythc@vrajz5ttkjbz>
 <Zw9_46fbvbGhjmYw@pks.im>
 <yxfpbmwy5bhtjwmffzrfoagugs4rsxw7wn2cvve5ygzcnlolpu@lhjgpz4riogd>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yxfpbmwy5bhtjwmffzrfoagugs4rsxw7wn2cvve5ygzcnlolpu@lhjgpz4riogd>

On Wed, Oct 16, 2024 at 11:07:02AM +0200, Wolfgang Müller wrote:
> On 2024-10-16 10:57, Patrick Steinhardt wrote:
> > Given that we do set `log.abbrev` I think we should be hitting code
> > paths in git-shortlog(1) that use it. `git shortlog --format=%h` for
> > example would use `log.abbrev`, wouldn't it? It would be nice to figure
> > out whether this can be made to misbehave based on which object hash we
> > have in the input.
>
> I did try this, but like I said, --format seems not supported when
> git-shortlog(1) is reading from stdin. It always outputs the same
> summary format, either grouped on authors or committers. This is not
> explicitly documented anywhere - the manual only says that "git shortlog
> will output a summary of the log read from standard input" and then goes
> on to document all the options with no mention of a difference in
> behaviour when reading from stdin. So I'm still not entirely convinced
> that this is impossible to trigger (also given the complexity of the
> argument parsing machinery), but I have not been able to find a way.

Yeah, I think this is correct. For the purposes of this series, I think
that what Woflgang has done is sufficient on the testing front.

As a nice piece of #leftoverbits, it would be appreciated to have a
patch that amends git-shortlog(1) to indicate that '--format' is ignored
when reading input from stdin.

Thanks,
Taylor
