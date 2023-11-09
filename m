Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD7BDDB8
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 07:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF4AA4
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 23:35:19 -0800 (PST)
Received: (qmail 25731 invoked by uid 109); 9 Nov 2023 07:35:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Nov 2023 07:35:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21133 invoked by uid 111); 9 Nov 2023 07:35:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Nov 2023 02:35:22 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Nov 2023 02:35:17 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/3] t9164: fix inability to find basename(1) in
 Subversion hooks
Message-ID: <20231109073517.GB2698227@coredump.intra.peff.net>
References: <cover.1699428122.git.ps@pks.im>
 <cover.1699513524.git.ps@pks.im>
 <6891e2541552073c6827d81d2b761252f253bea2.1699513524.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6891e2541552073c6827d81d2b761252f253bea2.1699513524.git.ps@pks.im>

On Thu, Nov 09, 2023 at 08:10:01AM +0100, Patrick Steinhardt wrote:

> +	# Subversion hooks run with an empty environment by default. We thus
> +	# need to propagate PATH so that we can find executables.
> +	cat >"$rawsvnrepo/conf/hooks-env" <<-EOF
> +	[default]
> +	PATH = ${PATH}
> +	EOF

This is so much less ugly than the shell shenanigans discussed in the
earlier round. Thanks for finding it. :)

The ${PATH} here is interpolated by the here-doc. I guess it's possible
somebody's exotic PATH could break the svn conf syntax, but it's
probably not worth worrying about.

-Peff
