Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64F3134C5
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 18:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5135D127
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 11:51:54 -0700 (PDT)
Received: (qmail 22624 invoked by uid 109); 23 Oct 2023 18:51:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Oct 2023 18:51:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14775 invoked by uid 111); 23 Oct 2023 18:51:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Oct 2023 14:51:55 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 23 Oct 2023 14:51:52 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Michael Strawbridge <michael.strawbridge@amd.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/3] some send-email --compose fixes
Message-ID: <20231023185152.GC1537181@coredump.intra.peff.net>
References: <7e2c92ff-b42c-4b3f-a509-9d0785448262@amd.com>
 <xmqq1qe0lui2.fsf@gitster.g>
 <20231011221844.GB518221@coredump.intra.peff.net>
 <xmqqzg0oiy4s.fsf@gitster.g>
 <20231011224753.GE518221@coredump.intra.peff.net>
 <b4385543-bee0-473b-ab2d-df0d7847ddf3@amd.com>
 <20231020064525.GB1642714@coredump.intra.peff.net>
 <20231020071402.GC1642714@coredump.intra.peff.net>
 <20231020100343.GA2194322@coredump.intra.peff.net>
 <xmqqil71otsa.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqil71otsa.fsf@gitster.g>

On Fri, Oct 20, 2023 at 02:42:13PM -0700, Junio C Hamano wrote:

> > So here's the fix in a cleaned up form, guided by my own comments from
> > earlier. ;) I think this is actually all orthogonal to the patch you are
> > working on, so yours could either go on top or just be applied
> > separately.
> >
> >   [1/3]: doc/send-email: mention handling of "reply-to" with --compose
> >   [2/3]: Revert "send-email: extract email-parsing code into a subroutine"
> >   [3/3]: send-email: handle to/cc/bcc from --compose message
> 
> Nice.
> 
> With the approach suggested to move the validation down to where the
> necessary addresses are already all defined, Michael observed "whoa,
> why am I getting stringified array ref?".  If that is the only issue
> in the approach, queuing these three patches first and then have
> Michael's fix on top of them sounds like the cleanest thing to do.

I don't think it is even an issue in Michael's approach. I'd have to see
his patch and how he tested it to be sure, but I suspect he was simply
being extra careful to test nearby behavior and stumbled upon the
ARRAY() bug. But the bug was there long before either of his patches.

> Will queue on top of v2.42.0 to help those who may want to backport
> these to the maintenance track.

So I think you could take my series on top of master (or 2.42.0), and
eventually target 'master'. The bug it fixes is from 2017, so not
urgent. The reading of "to" headers is a new feature.

But the fix to move the validation around should probably go directly
onto a8022c5f7b (send-email: expose header information to
git-send-email's sendemail-validate hook, 2023-04-19) for use on maint.
I guess maybe it is not that urgent anymore, as that regression is in
v2.41, and we would not release anything along that maint track anymore,
though.

-Peff
