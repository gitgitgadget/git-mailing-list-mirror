Return-Path: <SRS0=mvrS=AI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AE2C433E0
	for <git@archiver.kernel.org>; Sat, 27 Jun 2020 03:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E77720675
	for <git@archiver.kernel.org>; Sat, 27 Jun 2020 03:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgF0DLM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 23:11:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:44488 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgF0DLM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 23:11:12 -0400
Received: (qmail 13936 invoked by uid 109); 27 Jun 2020 03:11:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 27 Jun 2020 03:11:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1261 invoked by uid 111); 27 Jun 2020 03:11:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Jun 2020 23:11:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Jun 2020 23:11:11 -0400
From:   Jeff King <peff@peff.net>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Chris Torek <chris.torek@gmail.com>,
        Craig H Maynard <chmaynard@me.com>, git@vger.kernel.org
Subject: Re: Regarding Git and Branch Naming
Message-ID: <20200627031111.GB1187031@coredump.intra.peff.net>
References: <B4814F42-7AF8-4D80-93D4-FAF752C72F21@me.com>
 <CAPx1GvcZk2o7f8-27xokwxUayWwO+t5qdsMjLrjBymc+WHznmw@mail.gmail.com>
 <20200626203539.GA1173768@coredump.intra.peff.net>
 <6b9d76e4-68dd-8e57-f96a-318579dea6f3@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b9d76e4-68dd-8e57-f96a-318579dea6f3@iee.email>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 26, 2020 at 10:33:14PM +0100, Philip Oakley wrote:

> A wild bikeshed question: Is HEAD itself protected as a branch name e.g.
> that HEAD could contain `ref: HEAD` or `ref: refs/heads/HEAD`? (or maybe
> the null  oid

The first is not legal; we insist that symrefs start with "refs/".  The
second one _is_ legal, but isn't any kind of loop. The HEAD symref is
.git/HEAD, which is distinct from a ref of the same name inside
refs/heads/.

It's confusing, of course, because the lookup rules make it hard to
refer to refs/heads/HEAD. For that reason we do disallow it from the
branch-creation porcelains like git-branch and git-checkout.

-Peff
