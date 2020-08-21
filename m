Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E90C433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 20:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 158102076E
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 20:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgHUUB3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 16:01:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:37556 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbgHUUBY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 16:01:24 -0400
Received: (qmail 20338 invoked by uid 109); 21 Aug 2020 20:01:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Aug 2020 20:01:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31779 invoked by uid 111); 21 Aug 2020 20:01:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Aug 2020 16:01:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Aug 2020 16:01:21 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 4/5] strmap: add strdup_strings option
Message-ID: <20200821200121.GF1165@coredump.intra.peff.net>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <b3095d97d8ee9d6576292731cc100492e7c64f13.1598035949.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b3095d97d8ee9d6576292731cc100492e7c64f13.1598035949.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 21, 2020 at 06:52:28PM +0000, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
> 
> Just as it is sometimes useful for string_list to duplicate and take
> ownership of memory management of the strings it contains, the same is
> sometimes true for strmaps as well.  Add the same flag from string_list
> to strmap.

This is actually one of the ugliest parts of string_list, IMHO, and I'd
prefer if we can avoid duplicating it. Yes, sometimes we can manage to
avoid an extra copy of a string. But the resulting ownership and
lifetime questions are often very error-prone. In other data structures
we've moved towards just having the structure own its data (e.g.,
strvec does so, and things like oidmap store their own oids). I've been
happy with the simplicity of it.

It also works if you use a flex-array for the key storage in the
strmap_entry. :)

-Peff
