Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3250B5C91D
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 07:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 9859 invoked by uid 109); 12 Jan 2024 07:41:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 12 Jan 2024 07:41:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15223 invoked by uid 111); 12 Jan 2024 07:41:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 12 Jan 2024 02:41:41 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 12 Jan 2024 02:41:38 -0500
From: Jeff King <peff@peff.net>
To: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Linus Arver <linusa@google.com>
Subject: Re: [PATCH] strvec: use correct member name in comments
Message-ID: <20240112074138.GH618729@coredump.intra.peff.net>
References: <pull.1640.git.1705043195997.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1640.git.1705043195997.gitgitgadget@gmail.com>

On Fri, Jan 12, 2024 at 07:06:35AM +0000, Linus Arver via GitGitGadget wrote:

> From: Linus Arver <linusa@google.com>
> 
> In d70a9eb611 (strvec: rename struct fields, 2020-07-28), we renamed the
> "argv" member to "v". In the same patch we also did the following rename
> in strvec.c:
> 
>     -void strvec_pushv(struct strvec *array, const char **argv)
>     +void strvec_pushv(struct strvec *array, const char **items)
> 
> and it appears that this s/argv/items operation was erroneously applied
> to strvec.h.
> 
> Rename "items" to "v".

Good catch. The source of the problem is that the patch originally used
"items" in the struct, too, but after review we settled on the more
concise "v". I'd almost certainly have then flipped the name in the
struct definition and relied on the compiler to help find the fallout.
But of course it doesn't look in comments. :)

As you note, we still call use "items" for the vector passed in to
pushv. I think that is OK, and there is no real need to use the terse
"v" there (it is also purely internal; the declaration in strvec.h does
not name it at all).

So this patch looks great to me. Thanks!

-Peff
