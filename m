Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDBAC433ED
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 08:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85B9B61074
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 08:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhDOIwD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 04:52:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:53090 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231251AbhDOIwC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 04:52:02 -0400
Received: (qmail 9625 invoked by uid 109); 15 Apr 2021 08:51:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Apr 2021 08:51:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14221 invoked by uid 111); 15 Apr 2021 08:51:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Apr 2021 04:51:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Apr 2021 04:51:39 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jason Gore <Jason.Gore@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>
Subject: Re: Git clean enumerates ignored directories (since 2.27)
Message-ID: <YHf+m7vOQumdJXwX@coredump.intra.peff.net>
References: <DM6PR00MB06829EC5B85E0C5AC595004E894E9@DM6PR00MB0682.namprd00.prod.outlook.com>
 <YHdzDlAfsuZ21HR7@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YHdzDlAfsuZ21HR7@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 14, 2021 at 10:56:14PM +0000, brian m. carlson wrote:

> ----
> #!/bin/sh
> 
> git init test-repo
> cd test-repo
> longname="directory"
> touch "$longname.txt"
> last=400
> for x in $(seq 1 $last); do
>   mkdir "x$longname$x"
>   mv directory* "x$longname$x"
>   mv "x$longname$x" "$longname$x"
> done
> git clean -ffdxn -e directory$last
> ----
> 
> When it fails, it will complain that it wasn't able to open the
> directory.  It still exits zero, however.
> 
> I haven't bisected this, so I don't know if those patches are related to
> the problem or not.  I'm a little short on time today to investigate
> further, but hopefully this can get someone on the right path with a
> modified version and git bisect run if nothing else.

It bisects to 8d92fb2927 (dir: replace exponential algorithm with a
linear one, 2020-04-01). I won't pretend to understand everything going
on in that commit, though.

-Peff
