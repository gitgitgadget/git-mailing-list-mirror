Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA99C433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 06:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiGLGhP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 02:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiGLGhN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 02:37:13 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918EE2612B
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 23:37:11 -0700 (PDT)
Received: (qmail 10266 invoked by uid 109); 12 Jul 2022 06:37:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Jul 2022 06:37:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27476 invoked by uid 111); 12 Jul 2022 06:37:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Jul 2022 02:37:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Jul 2022 02:37:09 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han Xin <hanxin.hx@bytedance.com>,
        Michael J Gruber <git@grubix.eu>, chiyutianyi@gmail.com,
        derrickstolee@github.com, git@vger.kernel.org,
        haiyangtand@gmail.com, jonathantanmy@google.com, me@ttaylorr.com,
        ps@pks.im
Subject: Re: [External] Re: [PATCH v4 1/1] commit-graph.c: no lazy fetch in
 lookup_commit_in_graph()
Message-ID: <Ys0WlWFIuhP8b2hb@coredump.intra.peff.net>
References: <cover.1656381667.git.hanxin.hx@bytedance.com>
 <cover.1656593279.git.hanxin.hx@bytedance.com>
 <96d4bb71505d87ed501c058bbd89bfc13d08b24a.1656593279.git.hanxin.hx@bytedance.com>
 <165736941632.704481.18414237954289110814.git@grubix.eu>
 <Ysw9LmBFGbRy9L7c@coredump.intra.peff.net>
 <xmqqk08jo147.fsf@gitster.g>
 <CAKgqsWVD2108f0PyJGp6mVKp2cGd_V_MiiQO3SAPm+LEHcb2mA@mail.gmail.com>
 <xmqq1quqkiq2.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1quqkiq2.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 11, 2022 at 10:23:01PM -0700, Junio C Hamano wrote:

> > The tricky thing about using ulimit is that it's tied to the entire development
> > station. I have tried to run the test without any limit [1], it did finally be
> > canceled after 6 hours.
> 
> I am not worried so much about developer workstation, which people
> are sitting in front of.  They can ^C any runaway test way before 6
> hours just fine.
> 
> I am assuming that we do not have to be worried about CI settings
> too much, either, as they should already be prepared to catch
> run-away processes.

Agreed. Also, I think that although it's natural to worry about a bug we
know about causing an infinite loop, it's much more likely that a _new_
bug will cause one. I.e., every test we already carry is a candidate to
accidentally loop forever in this way. This is just the one we happen to
have seen. Once fixed, I don't know that it's at any more risk of
reocurring than any other problem.

-Peff
