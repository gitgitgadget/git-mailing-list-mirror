Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEC8CE7A89
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 08:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjIYIA0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 04:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbjIYIAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 04:00:25 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D764CB3
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 01:00:18 -0700 (PDT)
Received: (qmail 3400 invoked by uid 109); 25 Sep 2023 08:00:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 25 Sep 2023 08:00:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10547 invoked by uid 111); 25 Sep 2023 08:00:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Sep 2023 04:00:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 25 Sep 2023 04:00:10 -0400
From:   Jeff King <peff@peff.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Michael Strawbridge <michael.strawbridge@amd.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [REGRESSION] uninitialized value $address in git send-email when
 given multiple recipients separated by commas
Message-ID: <20230925080010.GA1534025@coredump.intra.peff.net>
References: <ZQ1eGzqfyoeeTBUq@debian.me>
 <20230924033625.GA1492190@coredump.intra.peff.net>
 <ZRE6q8dHPFRIQezX@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZRE6q8dHPFRIQezX@debian.me>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2023 at 02:45:47PM +0700, Bagas Sanjaya wrote:

> On Sat, Sep 23, 2023 at 11:36:25PM -0400, Jeff King wrote:
> > Your report also mentions a validation hook, so I tried installing one
> > like:
> > 
> > 	cat >.git/hooks/sendemail-validate <<-\EOF
> > 	#!/bin/sh
> > 	echo >&2 running validate hook
> > 	exit 0
> > 	EOF
> > 	chmod +x .git/hooks/sendemail-validate
> > 
> > and confirmed that the hook runs (three times, as expected). But still
> > no error. I'm using v2.41.0 to test against.
> > 
> 
> Hi Jeff,
> 
> I think you missed perl version. As stated earlier, I'm on Debian testing
> with perl v5.36.0. On there, `perl -V` outputs:

Mine is the same (I'm on Debian unstable, but the version is currently
the same as the one on testing).

> For the sendemail-validate hook itself, I managed to trigger this regression
> with simple helloworld script:
> 
> ```
> #!/bin/bash
> 
> echo "patching..." && exit 0
> ```

I think that's equivalent to what I was using (and certainly using yours
verbatim does not change anything on my end).

Do you have any other send-email related config? Can you show us the
output of "git config --list"?

-Peff
