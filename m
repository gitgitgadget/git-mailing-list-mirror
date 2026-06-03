Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBB83A1695
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 19:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780516714; cv=none; b=sK3jySUFrO+mT9vDTqEPSIGiX6UQoH8yf3w3t3sbSspqm2cult2/mxbafmxD9sGvWHTbicktSwFnEqPdeVVIY0ZhR4x7hXlbdZwoOwHiF1Es5Nji8yEmkTAxlp6kEaswY3oWHimqFPzepLTJzmSH910+MXgNhL4X/Y39SXMPonw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780516714; c=relaxed/simple;
	bh=kmkJlpyR11Hz6M9y6+eE/PPRbSaP/3APYAkcImApYDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VXwONrRthiJ/C4YjW4bvqk/9n54BJw/JmHYZbC1jyKPdtno3AxxafgfLiRVA+DhXKnKSiKq4fUtENRIS6CagMJTjQmQF+0gPMtoAkUfbvAvACY1tnI3bL325splU3GMDhEbJLH6AD3hrAUAIJ2iSeSB8KyUx97zZkLj2Nf2ua8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=TS7sKM1F; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="TS7sKM1F"
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 426C2DF8D38
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 21:49:08 +0200 (CEST)
Received: from piment-oiseau.localnet (unknown [IPv6:2a01:e0a:d1:f360:18a3:5f4f:fb38:4634])
	(Authenticated sender: jn.avila@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id 063535FFAF;
	Wed,  3 Jun 2026 21:48:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1780516139;
	bh=kmkJlpyR11Hz6M9y6+eE/PPRbSaP/3APYAkcImApYDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TS7sKM1FgPu7z86UdOXDdZrISdHrX3YhPFg07b2Y3M41cg7bcpALX+DS8eqiKN16D
	 6GChC6tiov/rKFBcLKEpuxzsDo8WNYJFy5iUYafeg9ZLyCHT8+VZucgE5bYZVRFvmh
	 USG8OFkVdgji8cOQh9nkiQmI8QwjN4qM/XZjB8aWANEzTsvO5n4e+lxAtNIE7Rvm8g
	 kw6L8cr5WOH36xExk2nmgkFKsoPVJVzswF6KTNmtcnkwv7fERsD1EWRp3DNFPdiroO
	 uIUqI6OP4BekIAkx22MTxhEyTtteJ1+q3i00F61KPytPgn8i5QOfbWdxnYxJCQ06MT
	 +pJun8dSizdBg==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org, Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: gitster@pobox.com, christian.couder@gmail.com, toon@iotcl.com,
 r.siddharth.shrimali@gmail.com
Subject: Re: [PATCH 1/2] parse-options: introduce die_for_required_opt()
Date: Wed, 03 Jun 2026 21:48:53 +0200
Message-ID: <2412618.ElGaqSPkdT@piment-oiseau>
In-Reply-To: <20260603111044.39116-2-r.siddharth.shrimali@gmail.com>
References:
 <20260603111044.39116-1-r.siddharth.shrimali@gmail.com>
 <20260603111044.39116-2-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Wednesday, 3 June 2026 13:10:43 CEST Siddharth Shrimali wrote:
> Introduce a new helper function die_for_required_opt() to check if a
> given option is present without its required prerequisite option.
> 
> This provides a centralized API for handling simple option dependencies
> (i.e., X requires Y), matching the style of the existing mutual-exclusion
> helpers like die_for_incompatible_opt{2,3,4}().
> 
> Suggested-by: Christian Couder <christian.couder@gmail.com>
> Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
> ---
>  parse-options.c | 7 +++++++
>  parse-options.h | 3 +++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/parse-options.c b/parse-options.c
> index a676da86f5..e100f9a0c1 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -1558,3 +1558,10 @@ void die_for_incompatible_opt4(int opt1, const char
> *opt1_name, break;
>  	}
>  }
> +
> +void die_for_required_opt(int opt1, const char *opt1_name,
> +			  int opt2, const char *opt2_name)

Hello,

First thanks for trying to uniformize/simplify option checking. The 
translators will be happy.

To me, "die_for_required_opt" is a misnomer as the function does not die for 
an existing "required" condition, unlike the other functions such as 
die_for_incompatible_opt<n>.

The names of the parameters do not indicate that the test is not symmetrical 
(not failing on XOR).

Maybe something like "die_for_missing_opt(int tested_opt, const char 
*tested_opt_name, int required_opt, const char *required_opt_name)

would make it more understandable.



