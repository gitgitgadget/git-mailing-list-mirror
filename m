Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1329C432C3
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 06:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9DE2068F
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 06:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfKVGym (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:54:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:57740 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726865AbfKVGym (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 01:54:42 -0500
Received: (qmail 18499 invoked by uid 109); 22 Nov 2019 06:54:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Nov 2019 06:54:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20186 invoked by uid 111); 22 Nov 2019 06:58:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 22 Nov 2019 01:58:32 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 22 Nov 2019 01:54:41 -0500
From:   Jeff King <peff@peff.net>
To:     M Lewis <picevio@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: GitAttributes feature export-ignore works, but -export-ignore
 (with dash) should also work
Message-ID: <20191122065441.GA23225@sigill.intra.peff.net>
References: <01e0a4ab-d809-d968-5671-b731438c2bc4@gmail.com>
 <20191121075837.GA30966@sigill.intra.peff.net>
 <1e9e3272-f97b-9944-817f-778deec2e65c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1e9e3272-f97b-9944-817f-778deec2e65c@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 21, 2019 at 07:45:44AM -0800, M Lewis wrote:

> Thank you for taking this on. I tried your suggestion copied below. The
> 'needed_a' (and _b) directories appear in the archive but unfortunately they
> are empty. We need the contents of the directories in the archive.

Ah, I assumed they were files. You should be able to handle that by
setting and clearing the attributes using the "**" syntax. Something
like:

  /subdir/** export-ignore
  /subdir/keep/ -export-ignore
  /subdir/keep/** -export-ignore

would work to re-enable "one" and all of its contents. Or if everything
you want to toggle is at the top-level of the subdirectory, you can use
"*" to avoid assigning export-ignore to all of the recursive paths in
the first place, like:

  /subdir/* export-ignore
  /subdir/keep/ -export-ignore

-Peff
