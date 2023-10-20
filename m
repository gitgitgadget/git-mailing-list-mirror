Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F12D2EF
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 07:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DC691
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 00:35:02 -0700 (PDT)
Received: (qmail 13623 invoked by uid 109); 20 Oct 2023 07:35:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Oct 2023 07:35:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11863 invoked by uid 111); 20 Oct 2023 07:35:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Oct 2023 03:35:05 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 20 Oct 2023 03:35:00 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 1/7] bulk-checkin: extract abstract
 `bulk_checkin_source`
Message-ID: <20231020073500.GE1642714@coredump.intra.peff.net>
References: <cover.1697736516.git.me@ttaylorr.com>
 <97bb6e9f59e5092f0519c7d1141d0673313fdc33.1697736516.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <97bb6e9f59e5092f0519c7d1141d0673313fdc33.1697736516.git.me@ttaylorr.com>

On Thu, Oct 19, 2023 at 01:28:42PM -0400, Taylor Blau wrote:

> +struct bulk_checkin_source {
> +	enum { SOURCE_FILE } type;
> +
> +	/* SOURCE_FILE fields */
> +	int fd;
> +
> +	/* common fields */
> +	size_t size;
> +	const char *path;
> +};

This is a pretty minor nit, but we may find that "SOURCE_FILE" is not
sufficiently name-spaced. Enum tags are in the global namespace, so
the compiler will barf if there are any conflicts.

It might be OK here, since this is local to a single C file (so we at
least are not hurting other code), but we may be in trouble if code in a
header file is less careful. There is already a near-miss here with
GREP_SOURCE_FILE, but fortunately grep.h is indeed careful. :)

(I notice that ref-filter.c similarly uses SOURCE_* for an internal
enum).

-Peff
