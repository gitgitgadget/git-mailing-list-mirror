Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895C43C695
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 21:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCB04205
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 13:44:25 -0800 (PST)
Received: (qmail 14944 invoked by uid 109); 10 Nov 2023 21:44:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Nov 2023 21:44:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 800 invoked by uid 111); 10 Nov 2023 21:44:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Nov 2023 16:44:26 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 10 Nov 2023 16:44:23 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] global: convert trivial usages of `test <expr>
 -a/-o <expr>`
Message-ID: <20231110214423.GC2758295@coredump.intra.peff.net>
References: <cover.1699526999.git.ps@pks.im>
 <cover.1699609940.git.ps@pks.im>
 <2967c8ebb460934eb4aaaaebe5941bff643d4a94.1699609940.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2967c8ebb460934eb4aaaaebe5941bff643d4a94.1699609940.git.ps@pks.im>

On Fri, Nov 10, 2023 at 11:01:15AM +0100, Patrick Steinhardt wrote:

> diff --git a/t/valgrind/valgrind.sh b/t/valgrind/valgrind.sh
> index 669ebaf68be..9fbf90cee7c 100755
> --- a/t/valgrind/valgrind.sh
> +++ b/t/valgrind/valgrind.sh
> @@ -23,7 +23,7 @@ memcheck)
>  	VALGRIND_MAJOR=$(expr "$VALGRIND_VERSION" : '[^0-9]*\([0-9]*\)')
>  	VALGRIND_MINOR=$(expr "$VALGRIND_VERSION" : '[^0-9]*[0-9]*\.\([0-9]*\)')
>  	test 3 -gt "$VALGRIND_MAJOR" ||
> -	test 3 -eq "$VALGRIND_MAJOR" -a 4 -gt "$VALGRIND_MINOR" ||
> +	( test 3 -eq "$VALGRIND_MAJOR" && test 4 -gt "$VALGRIND_MINOR" ) ||
>  	TOOL_OPTIONS="$TOOL_OPTIONS --track-origins=yes"

I was surprised to see this one as a subshell after you adjusted the
other. It probably isn't that big a deal either way, though (as a style
thing I generally try to use braces unless I am relying on the separate
environment provided by the subshell, but it's certainly not wrong in
this case).

-Peff
