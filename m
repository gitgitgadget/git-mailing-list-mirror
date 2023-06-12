Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8033C77B7A
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 03:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbjFLDUp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jun 2023 23:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbjFLDUS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2023 23:20:18 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A2130CB
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 20:18:18 -0700 (PDT)
Received: (qmail 21927 invoked by uid 109); 12 Jun 2023 03:17:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 Jun 2023 03:17:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11616 invoked by uid 111); 12 Jun 2023 03:17:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 11 Jun 2023 23:17:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 11 Jun 2023 23:17:32 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 03/11] remote: fix a leak in
 query_matches_negative_refspec
Message-ID: <20230612031732.GC306352@coredump.intra.peff.net>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
 <a9b27053-ff2b-7b67-f2ba-5691f4bda961@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9b27053-ff2b-7b67-f2ba-5691f4bda961@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 11, 2023 at 08:49:35PM +0200, Rubén Justo wrote:

> An interesting point to note is that while string_list_append() is used
> in the first two cases described, string_list_append_nodup() is used in
> the third.  This seems to indicate an intention to delegate the
> responsibility for freeing the string, to the string_list.  As if the
> string_list had been initialized with STRING_LIST_INIT_DUP, i.e.  the
> strings are strdup()'d when added (except if the "_nodup" API is used)
> and freed when cleared.
> 
> Switching to STRING_LIST_INIT_DUP fixes the leak and probably is what we
> wanted to do originally.  Let's do it.

Ah, clearing a NODUP string-list strikes again. :) I concur with your
reasoning here; switching it to DUP is the best fix.

-Peff
