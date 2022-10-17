Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E7DC433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 17:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiJQRCu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 13:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJQRCs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 13:02:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834136E88B
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 10:02:47 -0700 (PDT)
Received: (qmail 26993 invoked by uid 109); 17 Oct 2022 17:02:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 Oct 2022 17:02:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8475 invoked by uid 111); 17 Oct 2022 17:02:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Oct 2022 13:02:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Oct 2022 13:02:46 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonas Bernoulli <jonas@bernoul.li>, git@vger.kernel.org
Subject: Re: "submodule foreach" much slower than removed "submodule--helper
 --list"
Message-ID: <Y02KtjAUGSPqffvB@coredump.intra.peff.net>
References: <Y0r4US7AKxT/BLiY@coredump.intra.peff.net>
 <xmqqwn904sof.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwn904sof.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 15, 2022 at 03:40:16PM -0700, Junio C Hamano wrote:

> If one likes the output from "submodule--helper list" so much, I
> think your "ls-files" above should be the closest.  There seems to
> have existed some logic to squash unmerged entries down to a single
> one, too (git-submodule.sh in Git 2.0.0 era has a module_list shell
> function that shows what "helper list" should be doing), though.

Ah, good digging. I briefly looked at the patch removing the
submodule--helper version, saw the word "active", and assumed it was
checking that. On closer inspection, it is just the global "active_nr"
for iterating over the index. ;)

So yeah, using "ls-files" is a suitable replacement for Jonas's original
complaint. I'll leave it up to folks more interested and knowledgeable
on submodules to discuss whether there ought to be a listing command
that's more aware of gitmodules, populated fields, active flags, etc.

-Peff
