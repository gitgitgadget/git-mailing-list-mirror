From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] replace sha1 with another algorithm
Date: Wed, 26 Oct 2011 11:59:22 +0200
Message-ID: <4EA7D9FA.6070505@drmicha.warpmail.net>
References: <20111026001237.GA22195@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 26 11:59:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJ0Gi-00070A-1w
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 11:59:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644Ab1JZJ70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Oct 2011 05:59:26 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:57406 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932616Ab1JZJ70 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Oct 2011 05:59:26 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 0B8E120B20;
	Wed, 26 Oct 2011 05:59:25 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 26 Oct 2011 05:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=8qyPVsKigSnLl7LoZM1pBJ
	q7hhk=; b=SQWCq73+2hL/jK3ENWTPfRdcWWdw07sm7zdCkH1P8d11aKQzJUFqSm
	alSmnGjdX/9QxpIwpRtGzdxdY1hBMIzzCbA8RZFvKf+JU8pp9CjXCM+w6bmu6M/2
	0AMDm22A271ijAPoikrqWRdcn/hBlTm3CQS5YQ/SSl+LDmZp0dCz4=
X-Sasl-enc: NrjXTGpUSYaRwHlOm+YK4/vNcfKYYbTitDSueiaDAFm2 1319623164
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 649FC40CE04;
	Wed, 26 Oct 2011 05:59:24 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
In-Reply-To: <20111026001237.GA22195@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184254>

Jeff King venit, vidit, dixit 26.10.2011 02:12:
> SHA-1 is due to be cryptographically broken sometime in the
> next decade, with collision attacks becoming possible. But
> we don't have to wait! We can act now and replace it,
> treating us to all of the pain of a flag day without any
> delay!
> 
> We could of course use the SHA-2 family, or wait for the
> upcoming SHA-3. But any good cryptographer knows that you
> should _never_ use a standard algorithm. It's always better
> to roll your own. After all, if _you_ can't break it, how
> could anyone else?
> 
> Signed-off-by: Jeff King <peff@peff.net>
> Reviewed-by: Brandon Casey <drafnel@gmail.com>
> Mocked-by: Rick Balocca <richard.balocca@ericsson.com>
> Enjoyed-by: Elijah Newren <newren@gmail.com>
Awaited-by: Michael J Gruber <git@drmicha.warpmail.net>

Still remembering an earlier GitTogether's l33t l10n....
> ---
>  block-sha1/sha1.h |    2 +-
>  cache.h           |    4 +++-
>  sha1_file.c       |   32 ++++++++++++++++++++++++++++++++
>  3 files changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/block-sha1/sha1.h b/block-sha1/sha1.h
> index b864df6..49331e3 100644
> --- a/block-sha1/sha1.h
> +++ b/block-sha1/sha1.h
> @@ -19,4 +19,4 @@
>  #define git_SHA_CTX	blk_SHA_CTX
>  #define git_SHA1_Init	blk_SHA1_Init
>  #define git_SHA1_Update	blk_SHA1_Update
> -#define git_SHA1_Final	blk_SHA1_Final
> +#define real_git_SHA1_Final	blk_SHA1_Final
> diff --git a/cache.h b/cache.h
> index 2e6ad36..068062b 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -13,9 +13,11 @@
>  #define git_SHA_CTX	SHA_CTX
>  #define git_SHA1_Init	SHA1_Init
>  #define git_SHA1_Update	SHA1_Update
> -#define git_SHA1_Final	SHA1_Final
> +#define real_git_SHA1_Final	SHA1_Final
>  #endif
>  
> +void git_SHA1_Final(unsigned char out[20], git_SHA_CTX *ctx);
> +
>  #include <zlib.h>
>  typedef struct git_zstream {
>  	z_stream z;
> diff --git a/sha1_file.c b/sha1_file.c
> index 27f3b9b..23e0107 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2833,3 +2833,35 @@ void assert_sha1_type(const unsigned char *sha1, enum object_type expect)
>  		die("%s is not a valid '%s' object", sha1_to_hex(sha1),
>  		    typename(expect));
>  }
> +
> +static void xor_bytes(unsigned char *out, unsigned char *a, unsigned char *b,
> +		      unsigned n)
> +{
> +	unsigned i;
> +	for (i = 0; i < n; i++)
> +		out[i] = a[i] ^ b[i];
> +}
> +
> +static void mix_hash(unsigned char *h, unsigned n)
> +{
> +	unsigned char out[20];

unsigned char out[n];

;)

> +	unsigned mid = n / 2;
> +
> +	if (2*mid < n)
> +		return;
> +
> +	xor_bytes(out, h, h + mid, mid);
> +	xor_bytes(out + mid, h + mid, h, mid);
> +	memcpy(h, out, n);
> +
> +	/* If a little bit of mixing is good, then a lot must be GREAT! */
> +	mix_hash(h, mid);
> +	mix_hash(h + mid, mid);

n a power of 2 anyone...

> +}
> +
> +void git_SHA1_Final(unsigned char out[20], git_SHA_CTX *ctx)
> +{
> +	/* We build on top of the regular SHA1, but then "enhance" it. */
> +	real_git_SHA1_Final(out, ctx);
> +	mix_hash(out, 20);
> +}
>--
>1.7.7.troll

;)
