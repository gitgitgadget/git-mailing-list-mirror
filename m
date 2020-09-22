Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8CEC2D0E2
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 21:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FF512371F
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 21:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgIVVYG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 17:24:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:37330 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgIVVYG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 17:24:06 -0400
Received: (qmail 20262 invoked by uid 109); 22 Sep 2020 21:24:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Sep 2020 21:24:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3768 invoked by uid 111); 22 Sep 2020 21:24:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Sep 2020 17:24:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 22 Sep 2020 17:24:04 -0400
From:   Jeff King <peff@peff.net>
To:     Ilan Biala <ilanbiala@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git diff --name-only --submodule=diff combination does not work
Message-ID: <20200922212404.GA547416@coredump.intra.peff.net>
References: <20200922193407.23931C0613CF@lindbergh.monkeyblade.net>
 <CAD2jYq_-yOgVDd8280+T1E1hT1r0DfN1xFN6V0Hz_v7wnsENpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD2jYq_-yOgVDd8280+T1E1hT1r0DfN1xFN6V0Hz_v7wnsENpQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 22, 2020 at 04:56:45PM -0400, Ilan Biala wrote:

> I've been running into issues with using the --name-only and
> --submodule=diff flags together in Git 2.27.0. Is this a known bug?

What did you expect it to do, and what did it do instead?

I'm not very familiar with the --submodule flag, but it looks like it
only impacts "--patch" output. E.g., in git.git (with the submodule
actually populated):

  $ git log --oneline --submodule=diff -p sha1collisiondetection
  4125f78222 sha1dc: update from upstream
  Submodule sha1collisiondetection 16033998da..855827c583:
    > Detect endianess on HP-UX
  07a20f569b Makefile: fix unaligned loads in sha1dc with UBSan
  Submodule sha1collisiondetection 232357eb2e..16033998da:
    > Shorter version of force aligned access.
    > Add compiler option to force aligned access even for Intel CPUs.
  23e37f8e9d sha1dc: update from upstream
  Submodule sha1collisiondetection 19d97bf5af..232357eb2e:
    > Merge pull request #45 from avar/aix-big-endian-detection
    > sha1c: fix a trivial spelling error
  86cfd61e6b sha1dc: optionally use sha1collisiondetection as a submodule
  Submodule sha1collisiondetection 0000000000...19d97bf5af (new submodule)

  $ git log --oneline --submodule=log --raw sha1collisiondetection
  4125f78222 sha1dc: update from upstream
  :160000 160000 16033998da 855827c583 M  sha1collisiondetection
  07a20f569b Makefile: fix unaligned loads in sha1dc with UBSan
  :160000 160000 232357eb2e 16033998da M  sha1collisiondetection
  23e37f8e9d sha1dc: update from upstream
  :160000 160000 19d97bf5af 232357eb2e M  sha1collisiondetection
  86cfd61e6b sha1dc: optionally use sha1collisiondetection as a submodule
  :000000 160000 0000000000 19d97bf5af A  sha1collisiondetection

-Peff
