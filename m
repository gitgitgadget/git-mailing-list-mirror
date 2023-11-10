Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996533C07F
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 21:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A280131
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 13:49:01 -0800 (PST)
Received: (qmail 15010 invoked by uid 109); 10 Nov 2023 21:49:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Nov 2023 21:49:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 853 invoked by uid 111); 10 Nov 2023 21:49:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Nov 2023 16:49:02 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 10 Nov 2023 16:48:59 -0500
From: Jeff King <peff@peff.net>
To: Simon Ser <contact@emersion.fr>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: fix ignored encode_email_headers for cover
 letter
Message-ID: <20231110214859.GE2758295@coredump.intra.peff.net>
References: <20231109111950.387219-1-contact@emersion.fr>
 <20231109183506.GB2711684@coredump.intra.peff.net>
 <VTz8XT3MCqWUh1HFQon62NxmGJiYFfNmBeWTtR8MwmeuaSkovfBJ02P-S79GsD94XwlxlrL6W80YZ8OwfpDd1BqA0E4GwFQlDKN5DWq0Qtg=@emersion.fr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VTz8XT3MCqWUh1HFQon62NxmGJiYFfNmBeWTtR8MwmeuaSkovfBJ02P-S79GsD94XwlxlrL6W80YZ8OwfpDd1BqA0E4GwFQlDKN5DWq0Qtg=@emersion.fr>

On Fri, Nov 10, 2023 at 10:36:22AM +0000, Simon Ser wrote:

> > I don't think that answering those questions needs to hold up your
> > patch. We can take it as a quick fix for a real bug, and then anybody
> > interested can dig further as a separate topic on top.
> 
> These are good questions indeed. Unfortunately I don't hink I'll have time to
> work on this though.

That's OK. I think it's fine to stop here for now.

> > Some of these long lines (and the in-string newlines!) make this ugly
> > and hard to read. But it is also just copying the already-ugly style of
> > nearby tests. So I'm OK with that. But a prettier version might be:
> > 
> >   test_expect_success 'cover letter respects --encode-email-headers' '
> >         test_config branch.rebuild-1.description "Café?" &&
> >         git checkout rebuild-1 &&
> >         git format-patch --stdout --encode-email-headers \
> >                 --cover-letter --cover-from-description=subject \
> >                 main >actual &&
> >         ...
> >   '
> 
> Yeah, that sounds better indeed. Let me know if you want me to resend a cleaner
> version of the test.

I don't have a strong opinion, so I'd leave it up to you.

> > I also wondered if we could be just be testing this much more easily
> > with another header like "--to". But I guess that would be found in both
> > the cover letter and the actual patches (we also don't seem to encode
> > it even in the regular patches; is that a bug?).
> 
> That sounds like another bug indeed… But maybe that'll be harder to fix. To
> Q-encode this field one needs to split off the full name and actual mail
> address ("André <andre@example.org>" would be split into "André" and
> "andre@example.org"), then Q-encode the full name, then join the strings
> together again. In particular, it's incorrect to Q-encode the full string.

Yeah, without even looking at the code, I had a suspicion that this
would be an issue. I doubt that format-patch is doing much parsing at
all of what we feed it via --to.

-Peff
