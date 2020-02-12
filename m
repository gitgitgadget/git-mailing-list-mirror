Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACEAC3F68F
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 02:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C01920842
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 02:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbgBLCYn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 21:24:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:58136 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727600AbgBLCYm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 21:24:42 -0500
Received: (qmail 11181 invoked by uid 109); 12 Feb 2020 02:24:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 12 Feb 2020 02:24:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3896 invoked by uid 111); 12 Feb 2020 02:33:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Feb 2020 21:33:35 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 Feb 2020 21:24:41 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, git@vger.kernel.org
Subject: Re: bug? illegal text in commit log
Message-ID: <20200212022441.GA2963695@coredump.intra.peff.net>
References: <20200204010524-mutt-send-email-mst@kernel.org>
 <b005193f-24b7-7b6f-f3dc-c7a98db14ed7@web.de>
 <xmqqd0arfyw8.fsf@gitster-ct.c.googlers.com>
 <e271bb17-376d-426f-61b2-86971f1cb02b@web.de>
 <xmqqlfpf3qh3.fsf@gitster-ct.c.googlers.com>
 <3cd137fa-b879-9850-0b81-5f907623ee6d@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3cd137fa-b879-9850-0b81-5f907623ee6d@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 07, 2020 at 09:30:59PM +0100, René Scharfe wrote:

> My problem with the situation is that innocent-looking commits that
> can be diffed, pushed and pulled suddenly fall apart when used in a
> mail-based workflow or with rebase am.

Maybe we could automatically write ">diff" in such mails? :)

Speaking of which, try this:

  git init
  echo base >file
  git add file
  git commit -m base

  echo change >file
  {
    echo subject
    echo
    echo "From fc4ee3386d6db204b00b45889ef42400b9e18eed Mon Sep 17 00:00:00 2001"
  } | git commit -a -F -

  git format-patch --stdout -1 >patch
  git reset --hard HEAD^
  git am patch

mboxrd fixes this, but it's not the default.

-Peff
