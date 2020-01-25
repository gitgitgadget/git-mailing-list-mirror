Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A928EC2D0DB
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 19:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77DCE2071E
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 19:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgAYTxV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 14:53:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:44698 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726448AbgAYTxV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jan 2020 14:53:21 -0500
Received: (qmail 19272 invoked by uid 109); 25 Jan 2020 19:53:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 25 Jan 2020 19:53:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20154 invoked by uid 111); 25 Jan 2020 20:00:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 25 Jan 2020 15:00:36 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 25 Jan 2020 14:53:19 -0500
From:   Jeff King <peff@peff.net>
To:     "Crabtree, Andrew" <andrew.crabtree@hpe.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Inconsistent results from git rev-parse --show-toplevel
Message-ID: <20200125195319.GA5519@coredump.intra.peff.net>
References: <TU4PR8401MB111758B9513DD7D8B96CBFAAF90E0@TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM>
 <xmqqftg4zkvo.fsf@gitster-ct.c.googlers.com>
 <TU4PR8401MB1117B81EB9240905AA36B1E9F9090@TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <TU4PR8401MB1117B81EB9240905AA36B1E9F9090@TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 25, 2020 at 07:31:20PM +0000, Crabtree, Andrew wrote:

> > From: Junio C Hamano [mailto:gitster@pobox.com] 
> > Because you do not know where the top level is (otherwise you would not be asking "rev-parse --show-toplevel" about it), either is an option for you, 
> > but you can "unset GIT_DIR" to stop telling Git that it should not
> > perform the repository discovery.
> 
> Gotcha, thanks.  Would it make sense to have 'git rev-parse
> --show-toplevel' error out if GIT_DIR is set?  Or update the rev-parse
> documentation with a warning about GIT_DIR? 

No, it shouldn't be an error; setting GIT_DIR means that your current
directory is the worktree. That _is_ confusing in some situations, but
at this point it's a historical thing that I don't think we want to
change. Discussing it in the documentation might be good (it's probably
in there somewhere already, but a pointer from --show-toplevel doesn't
seem unreasonable).

But the bigger thing, I think, is: who is setting GIT_DIR but not
setting GIT_WORK_TREE to match? Because IMHO that's the situation that
is causing the confusion.

-Peff
