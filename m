Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3F74C97
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 18:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFDCB7
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 11:47:25 -0700 (PDT)
Received: (qmail 22575 invoked by uid 109); 23 Oct 2023 18:47:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Oct 2023 18:47:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14679 invoked by uid 111); 23 Oct 2023 18:47:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Oct 2023 14:47:26 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 23 Oct 2023 14:47:24 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Michael Strawbridge <michael.strawbridge@amd.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] Revert "send-email: extract email-parsing code into
 a subroutine"
Message-ID: <20231023184724.GB1537181@coredump.intra.peff.net>
References: <20231020100343.GA2194322@coredump.intra.peff.net>
 <20231020101310.GB2673716@coredump.intra.peff.net>
 <xmqqedhpotmt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqedhpotmt.fsf@gitster.g>

On Fri, Oct 20, 2023 at 02:45:30PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   - the handling for to/cc/bcc is totally broken.
> 
> It is good to see another evidence that "--compose" is probably not
> as often as used as we thought.  With enough bugs discovered,
> perhaps someday we can declare "it cannot be that the feature is
> used in the wild, without anybody getting hit by these bugs---let's
> deprecate and eventually remove it" ;-)

I'm not sure if that is evidence or not. The to/cc/bcc feature was just
never implemented. The commit from 2017 made it more broken than saying
"not yet implemented", but that may only be an indication that nobody
wants it or tried to use it.

I dunno. As I noted, the same feature exists when reading the
cover-letter from a set of format-patch files. And of course it is
implemented using totally separate code (in pre_process_file). One
possible cleanup would be to unify those two, but I'm sure there would
be behavior changes. Some of them perhaps good (e.g., it looks like
pre_process_file is more careful about rfc2047 handling) and some of
them I'm not so sure of (e.g., support for --header-cmd in the --compose
letter).

I think an interested person could champion such changes, but I am not
that interested in send-email (I don't use it, and some of its code is
pretty ancient and gross). My goal was to fix the bug I saw with minimal
regression (I waffled even on my patch 2).

-Peff
