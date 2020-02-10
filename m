Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49EFC352A4
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 22:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F3B20733
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 22:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbgBJWYo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 17:24:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:56906 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727254AbgBJWYo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 17:24:44 -0500
Received: (qmail 2997 invoked by uid 109); 10 Feb 2020 22:24:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Feb 2020 22:24:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26752 invoked by uid 111); 10 Feb 2020 22:33:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Feb 2020 17:33:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 Feb 2020 17:24:43 -0500
From:   Jeff King <peff@peff.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
Subject: Re: git-patch-id and syntactically significant whitespace
Message-ID: <20200210222443.GA623231@coredump.intra.peff.net>
References: <20200210164115.x4gciujyjisivfgi@chatter.i7.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200210164115.x4gciujyjisivfgi@chatter.i7.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 10, 2020 at 11:41:15AM -0500, Konstantin Ryabitsev wrote:

> This mostly becomes a problem if we try to build any kind of patch 
> indexing/retrieval systems that rely on patch-id to identify patches.  
> While this is not a high-impact problem by any means, it's not a 
> theoretical concern: git-format-patch includes functionality to provide 
> patch dependencies via prerequisite-patch-id trailers [1]. An automated 
> system attempting to auto-fetch dependencies can potentially retrieve 
> and apply the malicious version of the patch.
> 
> I'm not sure what the solution here is, since changing git-patch-id to 
> not discard whitespace is obviously going to defeat its entire purpose 
> of "not ever changing". I mostly wanted to share my findings in case 
> someone has thoughts on how to best approach this.

Can't you already have malicious patch-id collisions without the
whitespace thing? The patch-id also throws away line numbers, so a patch
adding "return 0" in an innocent location could have the same patch-id
as one adding it somewhere more dangerous. It's just a question of the
context, but there's often enough boilerplate for two functions to look
similar.

This is occasionally a problem for actual accidental collisions (in
patch-ids, but also when merging). I can imagine it's probably not that
hard for a determined attacker to make such a case intentionally.

-Peff
