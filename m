Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1130C05027
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 22:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjBAWKI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 17:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjBAWKC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 17:10:02 -0500
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E498873760
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 14:10:00 -0800 (PST)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id E989F1F5A0;
        Wed,  1 Feb 2023 22:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1675289401;
        bh=mMBAtm1OX24LwVYXMczdSByAVpeG3caxGL2qv9Xpzaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iUfN8gGZlp8EhDP/cNmKGir2R/oMDIueifs0bLTgoMGxq9DRZl7KvQv2cipOedCG3
         tZBCiYFnkLAkOqCYlAhQXY39UXWxxCkU+HJ5ZXzxj+eQQbnus4dPY3PdzUwBDe/JRZ
         lYwa4lzyfC/BjvJH7QqdiR40TEnbUYM/JScUfnPI=
Date:   Wed, 1 Feb 2023 22:09:29 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: pack-objects memory use observations [was: [PATCH]
 delta-islands: free island-related data after use]
Message-ID: <20230201220929.M549554@dcvr>
References: <20221116105013.1777440-1-e@80x24.org>
 <Y3UvhsRC9uCXJJ8P@coredump.intra.peff.net>
 <20230201092027.M96461@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230201092027.M96461@dcvr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> wrote:
> [1] WIP oidtree map, but I feel like I forgot C, again :<

Well, it hasn't crashed.  It's just much slower compared to khash.

I'm thinking `struct object_id' should be pooled+deduplicated
like hash keys in the Perl/Ruby interpreters and we'd pass
4/8-byte pointers instead of 36-byte structs.
