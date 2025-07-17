Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33612A94F
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 22:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752790585; cv=none; b=QO3PkEixLSixW1uPCc9GXxQEL5Nu0mFrIdMZgRYgv/hVmwTHgwZ2NUlYLEPiYXvPvHLlNHqc2Ma+y+3SMEklUg04+l/Ia6VpvPu04y050QrNIVb5ArYfgrmUaG0uqlSOaCYo3sDxZTwYWXZ0CiB3NE4fUf9Po8UktRbL0Ep++ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752790585; c=relaxed/simple;
	bh=6s3DGEq35BWAgYu7v52fKCDPkN89Szh2hvUJD0w0Dic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q91ERErvK1cGCMZt/3zBREujICBVppqzIC8zSl1tQSr5YvbAX+WI5yQkfad6xzMfVwMhDNq3HrFVnBwJAd6O1eXaoMOt47PGThKkz/RVvzWyICyPSsQQQmlcwTMeFtb0RfTbZ1wE3DD1jaT4u4xYKrZtg5UcpMTv3WTjNbLcc24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=GpMlscVr; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="GpMlscVr"
Received: (qmail 15099 invoked by uid 109); 17 Jul 2025 22:16:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6s3DGEq35BWAgYu7v52fKCDPkN89Szh2hvUJD0w0Dic=; b=GpMlscVr2rbXX6gy023nGsZ3iDcLFFWJYugAUQwK3YfhpXscI5LjfMVGr1h/dg+9b2xzXgv70t1axNyKSq3uZTygsMWx3/UOEISuu59wZBfdNCtnhPLf0WO0dy+lDHkgXjkep7pfkZ/nIOBvs5fmAF2KSiChyvMXn6epPTBrBTANFzxnL4Kc1pX8v53b49mIIZXBz6W8b1R8LBrPR5vrEHastVfM6Vf3+5v3fhMtHhrqi2qQlUBNPV49WvrziC3CXpr8sQ6QStevPwzLdlD9EzaF+BsVNn/hj/6QvLeLyMGqRULivHD7MFUxEoAL5Yd/n2o5fomNDzt/yLuecJmcKQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Jul 2025 22:16:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12029 invoked by uid 111); 17 Jul 2025 22:16:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Jul 2025 18:16:22 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 17 Jul 2025 18:16:20 -0400
From: Jeff King <peff@peff.net>
To: Kyle Lippincott <spectral@google.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	schwab@linux-m68k.org, phillip.wood123@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 0/5] for-each-ref: introduce seeking functionality via
 '--start-after'
Message-ID: <20250717221620.GA2782307@coredump.intra.peff.net>
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
 <20250715-306-git-for-each-ref-pagination-v5-0-852d5a2f56e1@gmail.com>
 <xmqqple1gtyg.fsf@gitster.g>
 <CAO_smVg9TDakUnubepjPGmLyOzW6n8Z=MDbnZKvkwN2=kN2RRw@mail.gmail.com>
 <20250717015402.GA2127425@coredump.intra.peff.net>
 <CAO_smVgdaOxiD_494qA+VxkmxNd6c=XqJDcCE2weCTknWfmkkA@mail.gmail.com>
 <CAOLa=ZQPOP0DkK9L5XLmA_uzH7jWwX-ti8AgaEcAF2Mon=w0BA@mail.gmail.com>
 <CAO_smVj4e0XOQyQr5sDyMZ8WPvqcBe2Y33DFHrED7C=VJnm4eg@mail.gmail.com>
 <20250717220929.GB2244266@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250717220929.GB2244266@coredump.intra.peff.net>

On Thu, Jul 17, 2025 at 06:09:29PM -0400, Jeff King wrote:

> Probably:
> 
> diff --git a/wrapper.c b/wrapper.c
> index 2f00d2ac87..6a4c1c1c29 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -482,6 +482,8 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
>  		if (csprng_bytes(&v, sizeof(v), 0) < 0)
>  			return error_errno("unable to get random bytes for temporary file");
>  
> +		msan_unpoison(&v, sizeof(v));
> +
>  		/* Fill in the random bits. */
>  		for (i = 0; i < num_x; i++) {
>  			filename_template[i] = letters[v % num_letters];
> 
> 
> on top of that would fix the problem you guys are seeing. I don't know
> if that path leads to insanity, though. Using MSan-enabled libraries is
> probably a better direction (should increase accuracy, and we don't have
> to carry these manual annotations around).

Hmm, probably insanity. Just for fun I tried to run the whole suite, but
got this doozy:

  Uninitialized bytes in fopen64 at offset 0 inside [0x7020000109c0, 25)
  ==2568195==WARNING: MemorySanitizer: use-of-uninitialized-value
      #0 0x7f90fe14fa46 in BIO_new_file (/lib/x86_64-linux-gnu/libcrypto.so.3+0x14fa46) (BuildId: 07a8321bad67632b52b47ad026125c79b7ebaab4)
      #1 0x7f90fe1a659c  (/lib/x86_64-linux-gnu/libcrypto.so.3+0x1a659c) (BuildId: 07a8321bad67632b52b47ad026125c79b7ebaab4)
      #2 0x7f90fe1a8453 in CONF_modules_load_file_ex (/lib/x86_64-linux-gnu/libcrypto.so.3+0x1a8453) (BuildId: 07a8321bad67632b52b47ad026125c79b7ebaab4)
      #3 0x7f90fe1a8807  (/lib/x86_64-linux-gnu/libcrypto.so.3+0x1a8807) (BuildId: 07a8321bad67632b52b47ad026125c79b7ebaab4)
      #4 0x7f90fe27274e  (/lib/x86_64-linux-gnu/libcrypto.so.3+0x27274e) (BuildId: 07a8321bad67632b52b47ad026125c79b7ebaab4)
      #5 0x7f90fea01bc6 in __pthread_once_slow nptl/pthread_once.c:116:7
      #6 0x7f90fea01c38 in __pthread_once nptl/pthread_once.c:143:12
      #7 0x7f90fe287f3c in CRYPTO_THREAD_run_once (/lib/x86_64-linux-gnu/libcrypto.so.3+0x287f3c) (BuildId: 07a8321bad67632b52b47ad026125c79b7ebaab4)
      #8 0x7f90fe272fd9 in OPENSSL_init_crypto (/lib/x86_64-linux-gnu/libcrypto.so.3+0x272fd9) (BuildId: 07a8321bad67632b52b47ad026125c79b7ebaab4)
      #9 0x7f90fe78a6d7 in OPENSSL_init_ssl (/lib/x86_64-linux-gnu/libssl.so.3+0x396d7) (BuildId: a0d77cb273378dec1d74a115ac1c9e40306e675d)
      #10 0x7f90fee2a503  (/lib/x86_64-linux-gnu/libcurl.so.4+0x9e503) (BuildId: 61ee7a8d1799c0e6c38a99b4d739e0c90391a05f)
      #11 0x7f90fedc2e42  (/lib/x86_64-linux-gnu/libcurl.so.4+0x36e42) (BuildId: 61ee7a8d1799c0e6c38a99b4d739e0c90391a05f)
      #12 0x7f90fedc33c9 in curl_global_init (/lib/x86_64-linux-gnu/libcurl.so.4+0x373c9) (BuildId: 61ee7a8d1799c0e6c38a99b4d739e0c90391a05f)
      #13 0x55fbbe211623 in http_init http.c:1347:6
      #14 0x55fbbe1f5b98 in cmd_main remote-curl.c:1583:2
      #15 0x55fbbe244571 in main common-main.c:9:11
      #16 0x7f90fe993ca7 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
      #17 0x7f90fe993d64 in __libc_start_main csu/../csu/libc-start.c:360:3
      #18 0x55fbbe15bb60 in _start (git-remote-http+0x43b60) (BuildId: dfc63b9261f6d575776d30b4e048b235389a7b20)
  
  SUMMARY: MemorySanitizer: use-of-uninitialized-value (/lib/x86_64-linux-gnu/libcrypto.so.3+0x14fa46) (BuildId: 07a8321bad67632b52b47ad026125c79b7ebaab4) in BIO_new_file


So MSan complaining about stuff deep within curl/openssl, and AFAICT not
something we could influence or annotate as OK.

-Peff
