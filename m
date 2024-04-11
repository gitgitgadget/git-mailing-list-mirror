Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D3D3A1C5
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 21:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712871578; cv=none; b=SaiKDOQTpp0R0XqjdkNVfvCWukdRE6yrM86ZWvx3KKFJ7UWovGnQfCZ8w7ko3cx0uyJndi+WPAXkfTMzSLriqcUVWv+oHdSyFOxBQSZa9AupWT2m7TfpW87iz/EVraOgVVv5rSLNjQ+P5p79113jVEUWdQrHi7yqxctu1U1h9tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712871578; c=relaxed/simple;
	bh=QrOTliiLJ8KbaewfSD+OkObzhbBiBlZGum+/CRZJgY4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DryQkeTjvkJpCO1uhYByhKK/sYp+hDTRxHrRX4YDSyx9B9Gr8yvaPBg97afXRBT2Q5DEJjRaT2/09OYJIyTcBcGfCu+GhFSxRmX4cmRxKR/4TtNdG4jcPkOeeGkYV3Kf0VSLKuDyBuE0j6LwBGLtK+oAU7N/snkKt+HnK7NBL4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=q4E2t/Bm; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="q4E2t/Bm"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6D3EF3A711;
	Thu, 11 Apr 2024 17:39:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=QrOTliiLJ8KbaewfSD+OkObzhbBiBlZGum+/CR
	ZJgY4=; b=q4E2t/Bm6sw2bKkES5TzPJFatifBW/wcQ0vs8T4yKgZhQZjPJUIbaf
	fQDFBQHcqlSfqfGSJgnYXfoxVEQYPngSCnUEY2UVY2/lfRMp/1D392PgSJX+49bU
	zzZVxtO6veXxd40qtbflOlpKJgwamN5682IsoOEjNitfPJfZeUkFE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6661D3A710;
	Thu, 11 Apr 2024 17:39:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F35003A70C;
	Thu, 11 Apr 2024 17:39:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  peff@peff.net
Subject: Re: [PATCH v2 2/2] fuzz: link fuzz programs with `make all` on Linux
In-Reply-To: <8846a7766a1e14373272f7115d37a3b774f51a71.1712858920.git.steadmon@google.com>
	(Josh Steadmon's message of "Thu, 11 Apr 2024 11:14:25 -0700")
References: <cover.1709673020.git.steadmon@google.com>
	<cover.1712858920.git.steadmon@google.com>
	<8846a7766a1e14373272f7115d37a3b774f51a71.1712858920.git.steadmon@google.com>
Date: Thu, 11 Apr 2024 14:39:30 -0700
Message-ID: <xmqq1q7br33h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FB764CF8-F84B-11EE-A0DC-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> @@ -752,23 +755,6 @@ SCRIPTS = $(SCRIPT_SH_GEN) \
>  
> - ...
> -# Always build fuzz objects even if not testing, to prevent bit-rot.
> -all:: $(FUZZ_OBJS)
> -...
> -FUZZ_PROGRAMS += $(patsubst %.o,%,$(filter-out %dummy-cmd-main.o,$(FUZZ_OBJS)))
> -
>  # Empty...
>  EXTRA_PROGRAMS =

As Peff said earlier, I suspect there is no need to move things for
dependencies (make rules are somewhat declarative), but grouping all
the things related to fuzzing is a good idea, so I am OK with the
new location.

> +# Always build fuzz objects even if not testing, to prevent bit-rot.
> +all:: $(FUZZ_OBJS)
> +
> +FUZZ_PROGRAMS += $(patsubst %.o,%,$(filter-out %dummy-cmd-main.o,$(FUZZ_OBJS)))
> +
> +# Build fuzz programs when possible, even without the necessary fuzzing support,
> +# to prevent bit-rot.
> +ifdef LINK_FUZZ_PROGRAMS
> +all:: $(FUZZ_PROGRAMS)
> +endif

OK.

Will queue.  Thanks.
