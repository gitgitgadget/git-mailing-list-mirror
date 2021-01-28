Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0CEC433DB
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 22:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F34DA64DDE
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 22:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhA1WuK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 17:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbhA1WtH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 17:49:07 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DF4C061574
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 14:48:27 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id v126so7023827qkd.11
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 14:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cjjGu1xV5mT+KkRMemGY1wIsW0gYu/hoPmOHh8KJEjc=;
        b=g6SyxBu5VvlHDEGAf1Vvst0N/1hPwe3fWJyeY/8sMj+1+y+PFr9JZTnhokyspnBsDp
         EiukeRE9cq6U4H13ZdtVKBULFaVrWwvKhCKXfEVHKw803DDrK5No02dajmRwrZ3svNnh
         8yR8+prXNUo4imH6THD6jLbXpaj2hoAHRy114bWMWSuEj7CN6TGVZ5X3SenDOl50JNvz
         H1hfGEvllSHFdko1ui3U1mKQs8ucN2w61c6FWZwwVAujcB+MurfbxKyV0pr9RZ8j36MZ
         VJkOqgtXUZvf15fsmPVJElJp57cjPTpaGEZF2C8W1hquq5kqB4NneNcO2x59Wg3O2GKO
         Momg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cjjGu1xV5mT+KkRMemGY1wIsW0gYu/hoPmOHh8KJEjc=;
        b=aIpagsWt9eJuxU9bAxBBE6SS02XpMIkJnne5/UkwalSYfc5YKRARw2RNiyan4ZysOH
         bVidIWmwERoeYtMvLld/3hd9QagEeO6MgacQA2ckhjmIa5LPX12cIZ13BSku2hPpWJ6+
         A4b0ba/0g6PRr6IUEQNoQP5OhvXZKXz2N0inYtVQXFGIXjkyxg3i48k1FXrkVRlGr9hJ
         plI0L7VUp3ScT5R228bE8dsL3QQC/BPr8ihIs1LBGdaHrx1e73pVB6ID01zckQipQaiH
         uANK01mpDoa4gFUhMx1572XwRIihXq97RWo7cIhnYGzWerrEPXqHf7c/tYYrGt9x17VF
         Xz0w==
X-Gm-Message-State: AOAM531LeprAt7HTJr1TMeDkrg9tC+hC8p/tQGMicvEAySh2LRILj6i8
        5b4oSdA9pdMJHoUZEut/i7Wqee75IhyH7w==
X-Google-Smtp-Source: ABdhPJxMmMc5KGUvsTDyKIeqZ353RdxqOa96F+rEFlyCKNMCN136UgwLfrj6Jk75ev8haNVsqRwI9w==
X-Received: by 2002:a37:2f85:: with SMTP id v127mr1638547qkh.18.1611874106341;
        Thu, 28 Jan 2021 14:48:26 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:5d6b:9c45:5e60:e7b4])
        by smtp.gmail.com with ESMTPSA id d9sm4478410qko.84.2021.01.28.14.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 14:48:25 -0800 (PST)
Date:   Thu, 28 Jan 2021 17:48:22 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/6] hash_pos(): convert to oid_pos()
Message-ID: <YBM/NpLeS0uFzVb3@nand.local>
References: <YBJVuckmbGriVa//@coredump.intra.peff.net>
 <YBJXfl86Juv5kn16@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBJXfl86Juv5kn16@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 28, 2021 at 01:19:42AM -0500, Jeff King wrote:
> All of our callers are actually looking up an object_id, not a bare
> hash. Likewise, the arrays they are looking in are actual arrays of
> object_id (not just raw bytes of hashes, as we might find in a pack
> .idx; those are handled by bsearch_hash()).
>
> Using an object_id gives us more type safety, and makes the callers
> slightly shorter. It also gets rid of the word "sha1" from several
> access functions, though we could obviously also rename those with
> s/sha1/hash/.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> If we don't want to make this change, I think it's still worth sweeping
> through the callers and changing the names of their access functions.
>
>  builtin/name-rev.c  |  8 ++++----
>  commit-graph.c      | 28 ++++++++++++++--------------
>  commit.c            | 10 +++++-----
>  hash-lookup.c       | 18 +++++++++---------
>  hash-lookup.h       | 10 +++++-----

I wondered briefly if we should rename this to oid-lookup.{c,h}, but I
think the answer is "no", since we still have bsearch_hash() in this
header.

Probably a single header with "hash" in the name is better than two
headers each containing a single function (and one containing an
additional typedef).

So, I think that what you did here is good.

Thanks,
Taylor
