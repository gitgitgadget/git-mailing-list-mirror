Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91A9C433E0
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 22:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A361964DED
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 22:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhA1W7S (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 17:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhA1W7C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 17:59:02 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B998C061573
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 14:58:22 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id 19so7087406qkh.3
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 14:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MWDK5QhiuKPAx7OSf7bV4EEkkYQ/UYuGRBrHEkED3bs=;
        b=BnZGVp2GFszr3vJMutg2eT/Fo5N5JjfWCqL+d3XVCFwBlppFannD85261xu4mu8MmQ
         WuVsRl+NdHSO552iBB0qxWTjvbWLMCOomeFOE2BNY5FwSIL+Ivj+NlJ8EQEXgAPJx6vG
         bwXIMguhBI41f5O7s3S2TBYu1WlakfQuj6ROm7qHdaZced9ynMWqkLCWJnC54ZjILiD3
         9zhUsbXB2t0/oPDBNIFS+62Pw46mSmJHif+sVHxhHpXHhrChYifaYUw+vImep1MxPXHy
         saiEdSWPP6e5EzxbPQOBksFxHs8r0/mcDy1sbBaaEho3Cb3TqeEa066+Ubx8PcB0mMBJ
         jD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MWDK5QhiuKPAx7OSf7bV4EEkkYQ/UYuGRBrHEkED3bs=;
        b=OM9n+LDgo1YBD/HnBxJ+IasNiD96R7p7uNUNi0N0lnUvb4KTSfYzezoLInpoxMOk19
         gkwXjvQar3VKbQqrhx9o9F/OGlI7bOI2dE3AptxhCfUKQsKuaMO14zfSLOFKVd1g9Y4J
         6WAgNr9w0/XI1LREkwG2zRmhiZhIl8MVr+JBsAX6T1sDa0Lqkf9mQ2fKvRkSRG19emiZ
         xqoOox/ea9FaahLeY+EAwM7rg1pA+wVUgx5OZUW7M5yXbyYOVUYgPu5G8I6mc+GM0cbV
         dLduGmWPWw9p8LNI399Xp7AY6pmJ599Ja9DDGCEsvYIJ6YCF/0cOe5g6y+tSP7XHom2O
         GJQA==
X-Gm-Message-State: AOAM532mxD7wIzs6ZOJznVVKSscfLNNhQXOzh3WZlPzNpgz7WesUdsBt
        Gww3eMad2xjDTcjDJ0zikak3ELci9BnChg==
X-Google-Smtp-Source: ABdhPJwZM2d/RwJVlx+uiGEOSVoe0lPW17nPU5OXp/NhJvloJfGilX5+hRYoQRzRWHYFqiMdoz4ngA==
X-Received: by 2002:a37:f510:: with SMTP id l16mr1708900qkk.90.1611874701220;
        Thu, 28 Jan 2021 14:58:21 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:5d6b:9c45:5e60:e7b4])
        by smtp.gmail.com with ESMTPSA id a129sm4540840qkf.95.2021.01.28.14.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 14:58:20 -0800 (PST)
From:   Taylor Blau <ttaylorr@github.com>
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>
Date:   Thu, 28 Jan 2021 17:58:18 -0500
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] pretty: lazy-load commit data when expanding user-format
Message-ID: <YBNBbgZ/FLW8YVOe@nand.local>
References: <YBMXM83xCZvC5WyA@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBMXM83xCZvC5WyA@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 28, 2021 at 02:57:39PM -0500, Jeff King wrote:
> Reported-by: Michael Haggerty <mhagger@alum.mit.edu>
> Signed-off-by: Jeff King <peff@peff.net>

This is delightful.

As I was reading the discussion you and Michael had off-list, I was
worried that this would be more complicated than it ended up being. But,
it's terrific to see that this change appeared to be relatively easy,
and the performance speaks for itself.

Thanks for such a pleasant read!

Thanks,
Taylor
