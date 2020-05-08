Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C48C38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 18:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 133CE218AC
	for <git@archiver.kernel.org>; Fri,  8 May 2020 18:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgEHSAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 14:00:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:41932 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726746AbgEHSAs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 14:00:48 -0400
Received: (qmail 10866 invoked by uid 109); 8 May 2020 18:00:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 May 2020 18:00:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31062 invoked by uid 111); 8 May 2020 18:00:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 08 May 2020 14:00:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 8 May 2020 14:00:47 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] ci: allow per-branch config for GitHub Actions
Message-ID: <20200508180047.GD637136@coredump.intra.peff.net>
References: <20200504233634.GB39798@coredump.intra.peff.net>
 <20200505002055.GC64230@syl.local>
 <20200505164326.GA64077@coredump.intra.peff.net>
 <xmqqo8r2b6y4.fsf@gitster.c.googlers.com>
 <20200505182418.GA66702@coredump.intra.peff.net>
 <20200505210451.GA645290@coredump.intra.peff.net>
 <20200507162011.GA3638906@coredump.intra.peff.net>
 <xmqqwo5n34ka.fsf@gitster.c.googlers.com>
 <20200507204626.GG29683@coredump.intra.peff.net>
 <xmqqo8qz2yrr.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo8qz2yrr.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 07, 2020 at 02:58:16PM -0700, Junio C Hamano wrote:

> In any case, I'll queue it on 'pu'.  Thanks.

I just noticed this needs a small fix to the sample script, which I gave
the wrong name:

diff --git a/ci/config/allow-refs.sample b/ci/config/allow-ref.sample
similarity index 93%
rename from ci/config/allow-refs.sample
rename to ci/config/allow-ref.sample
index f157f1945a..c9c9aea9ff 100755
--- a/ci/config/allow-refs.sample
+++ b/ci/config/allow-ref.sample
@@ -7,8 +7,8 @@
 # your repository:
 #
 #   git checkout -b ci-config
-#   cp allow-refs.sample allow-refs
-#   $EDITOR allow-refs
+#   cp allow-refs.sample allow-ref
+#   $EDITOR allow-ref
 #   git commit -am "implement my ci preferences"
 #   git push
 #

> Perhaps we can experiment with "echo >&2 we are getting called" in
> the allow-ref script itself ;-).

That definitely ends up in the log. But doing:

  echo     "::error file=foo.sh,line=1,col=2::this is the stdout msg"
  echo >&2 "::error file=foo.sh,line=1,col=2::this is the stderr msg"

shows both versions formatted in red, which implies to me that stdout
and stderr are treated the same.

-Peff
