Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9374EC4708C
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 01:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbiLFBj3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 20:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbiLFBjI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 20:39:08 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFB72F3
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 17:38:39 -0800 (PST)
Received: (qmail 11309 invoked by uid 109); 6 Dec 2022 01:38:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Dec 2022 01:38:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16045 invoked by uid 111); 6 Dec 2022 01:38:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Dec 2022 20:38:39 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 5 Dec 2022 20:38:37 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Christian =?utf-8?B?R8O2dHRzY2hl?= <cgzones@googlemail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] setup: avoid unconditional open with write flags
Message-ID: <Y46dHWVaU00WFL+f@coredump.intra.peff.net>
References: <20221205190019.52829-1-cgzones@googlemail.com>
 <Y45tGLaJwg3Lt5uJ@tapette.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y45tGLaJwg3Lt5uJ@tapette.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 05, 2022 at 10:13:44PM +0000, brian m. carlson wrote:

> _However_, I will say that `git status` is not a read-only command
> because it can write the index, and we aren't, in general, going to be
> able to promise that any portion of Git will work with only O_RDONLY
> file descriptors.  I suspect such a sandbox is going to result in a
> highly broken Git in general, and so it wouldn't be a good idea.

I wonder if "git status" might work OK in a sandbox, because it should
quietly skip the on-disk index refresh if something fails. That is, it's
supposed to work in a read-only repository. As long as the sandbox just
returns an error when opening the lockfile (and not, say, killing the
process), it would look the same to Git.

-Peff
