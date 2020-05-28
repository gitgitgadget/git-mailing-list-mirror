Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB77BC433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 19:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3761208A7
	for <git@archiver.kernel.org>; Thu, 28 May 2020 19:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlVEpk75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406373AbgE1T0b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 15:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406258AbgE1T01 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 15:26:27 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7808C08C5C6
        for <git@vger.kernel.org>; Thu, 28 May 2020 12:26:27 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y11so3721893plt.12
        for <git@vger.kernel.org>; Thu, 28 May 2020 12:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GdvK6asCK7V8igfBz5Gp8p/WHEeKfzvjgp4gOzm7C/o=;
        b=JlVEpk75rFXnGbM/AQ5nF2hzhVv8RYaye4VmGsi7OL2BECKP+PoH0HVt8EbrYBejd6
         u6OhgFWMQO8q5OdJm8lEq5WSJJJyya40JwWnzwUTQiobjKDR7D/tORU6RJPkr9lvSwda
         Vks6A4EV3fDSNsAUSlYKr4mjLydJxXi8wxpAkBO+KXHheJit7XNgv5PE6mseJaB6gvQA
         +w74/HpT4zBSvtJIin5HJwN54hErk7136SIzvSq4IS2KzAC+anR8O7j5j34TU1mabx0U
         akDYgQFjAPrtyktXO430kEmFkej3Khzbf0jGvKff8Z0aPw7jTwMCZG2FgCYmFQ8LQcgM
         nWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GdvK6asCK7V8igfBz5Gp8p/WHEeKfzvjgp4gOzm7C/o=;
        b=Gt1LZSupIUDZmTwEcJxxl+FYQK15/oolv+T9oJ8XYje7O3ClLoo5k32zyd7A1pruLm
         s5YARGkKNMszhqzp4SEh1LupTD3goR+FXrROb2/AHJSzwkRF03tWi4SslnNi99cBOnJl
         5jHAQ5OKyLSQHHNAtK6xJGTRlBhNYO+B2qkNdvKiF+U8OSNeuUa4zAS+yedAhP2JJJI3
         ZbQxAQcYWnSZFvClTs93a4fs/XTxT9WQT6ThdqqNJJ50rVP1yUPmhG62JHuu11MEVUxr
         qB84JJBffJpZHiWL7SI4xv9BthRgKWkAsZWWmBSk/9ZY4IcFD4189M1o7ratfAx3IbuX
         Tkzg==
X-Gm-Message-State: AOAM531EVMhDHp9Vh0AcSsjw/xbf2IpXay1DnCa3eIGzqvoDyaB68gmR
        pkilmoU6DQlZYdaZW3hVkyk=
X-Google-Smtp-Source: ABdhPJz8+WJn8xRfkza+vCZRl2oIcUQFfDDiZLeFL+2ShtXOa82HJRRF1lj5fwd1HW5nWZHS9Lbj0g==
X-Received: by 2002:a17:90a:36aa:: with SMTP id t39mr454268pjb.185.1590693987178;
        Thu, 28 May 2020 12:26:27 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id c123sm5297201pfb.102.2020.05.28.12.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 12:26:26 -0700 (PDT)
Date:   Thu, 28 May 2020 12:26:24 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] fast-import: accept invalid timezones so we can import
 existing repos
Message-ID: <20200528192624.GB114915@google.com>
References: <pull.795.git.git.1590693313099.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.795.git.git.1590693313099.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Elijah Newren wrote:

>                  Relax the parsing to allow these timezones when using
> raw import format; when using --date-format=rfc2822 (which is not the
> default), we can continue being more strict about timezones.

There are two different use cases here that we may want to distinguish.

The original motivation for fast-import was for importing a repository
from some non-Git storage system (another VCS, a collection of patches
and tarballs, or whatever).  Such an importer might use
--date-format=raw just because that's simple, to avoid overhead.  In
that case, the strict parsing seems useful for catching bugs in the
importer.

"git filter-repo" is for taking an existing repository and modifying
it.  In this case, it would be *possible* to take an invalid timezone
and normalize it to "whatever 'git log' would show", but that's
overreaching relative to the caller's intent: the caller has a specific
set of history modifications they meant to make, and fixing the time
zone wasn't necessarily one of them.

To that end, would it make sense for this to be a new date-format
(e.g., --date-format=raw-permissive) to avoid regressing behavior in
the original case?

Thanks and hope that helps,
Jonathan
