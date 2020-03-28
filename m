Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650A3C43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 14:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415D320723
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 14:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgC1OSQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 10:18:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:54448 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726325AbgC1OSP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 10:18:15 -0400
Received: (qmail 24211 invoked by uid 109); 28 Mar 2020 14:18:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 28 Mar 2020 14:18:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1520 invoked by uid 111); 28 Mar 2020 14:28:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 28 Mar 2020 10:28:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 28 Mar 2020 10:18:14 -0400
From:   Jeff King <peff@peff.net>
To:     Bastian Buchholz <buchholz.bastian@googlemail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git 2.26 rebase.backend change issue
Message-ID: <20200328141814.GA1198080@coredump.intra.peff.net>
References: <CAJTX9qSjnPGKEBDB_ma5QqWOwop5s15kskKQ7EU2ne7VFEBnfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJTX9qSjnPGKEBDB_ma5QqWOwop5s15kskKQ7EU2ne7VFEBnfA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 28, 2020 at 09:21:08AM +0100, Bastian Buchholz wrote:

> Just wanted to report that I am running into issues with the git 2.26
> `rebase.backend` change.
> I am a maintainer on https://github.com/FredrikNoren/ungit which is a
> UI for git using a http server / browser architecture.
> We are using `git rebase` in non interactive mode (e.g. not specifying
> `-i` or `--interactive`) on the server and with git 2.26 this fails
> because it seems that it now runs in interactive mode by default. It
> tries to an editor on `git rebase --continue`.
> Specifying `-c rebase.backend=apply` fixes our issue see
> https://github.com/FredrikNoren/ungit/issues/1301

I don't think --interactive is relevant here; the features triggered by
that option (i.e., the ability to tweak the instruction list) are
different from the notion that rebase would never interact with the user
at all.

There's more discussion of this change in the thread at:

  https://lore.kernel.org/git/20200310174017.GA549010@coredump.intra.peff.net/

The simplest fix is likely to set GIT_EDITOR=: in your environment when
you don't want the user to ever be presented with an editor.

-Peff
