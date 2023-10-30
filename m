Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAC9D52E
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 09:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D3AB6
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 02:29:05 -0700 (PDT)
Received: (qmail 1653 invoked by uid 109); 30 Oct 2023 09:29:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 30 Oct 2023 09:29:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9517 invoked by uid 111); 30 Oct 2023 09:29:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Oct 2023 05:29:09 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 30 Oct 2023 05:29:03 -0400
From: Jeff King <peff@peff.net>
To: Todd Zullinger <tmz@pobox.com>
Cc: Michael Strawbridge <michael.strawbridge@amd.com>,
	Junio C Hamano <gitster@pobox.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Luben Tuikov <luben.tuikov@amd.com>, git@vger.kernel.org,
	entwicklung@pengutronix.de
Subject: Re: Regression: git send-email fails with "Use of uninitialized
 value $address" + "unable to extract a valid address"
Message-ID: <20231030092903.GD84866@coredump.intra.peff.net>
References: <20231013141437.ywrhw65xdapmev7d@pengutronix.de>
 <20231020100442.an47wwsti2d4zeyx@pengutronix.de>
 <68d7e5c3-6b4a-4d0d-9885-f3d4e2199f26@amd.com>
 <20231024130037.sbevzk2x7oclj7d7@pengutronix.de>
 <89712aea-04fc-4775-afd4-afd3ca24ad01@amd.com>
 <20231024204318.gi6b4ygqbilm2yke@pengutronix.de>
 <20231025072104.GA2145145@coredump.intra.peff.net>
 <xmqqsf5xr1xk.fsf@gitster.g>
 <a71f2f1f-b5f0-4628-a4f3-6fd1319062a3@amd.com>
 <ZTp7xvXDw1GF-NUB@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZTp7xvXDw1GF-NUB@pobox.com>

On Thu, Oct 26, 2023 at 10:46:30AM -0400, Todd Zullinger wrote:

> I'd lean toward dropping the dependency entirely and leave
> the more basic validation of git-send-email in place.  That
> may not catch every type of address error, but I would argue
> that what we do without Email::Valid is perfectly reasonable
> for checking basic email address syntax sanity.

I am somewhat tempted to say the same, but in this case didn't it help
us find a real bug? True, the bug was that we were feeding garbage to
Email::Valid because we were calling it to early, and I _think_ the
ultimate emails we sent would have been OK. But I think we were possibly
feeding that garbage to the user-visible validation hook.

That might just mean we need to beef up our homegrown validation a bit
(though as you indicate here, I am generally of the opinion that the
best validation is trying to actually send things).

-Peff
