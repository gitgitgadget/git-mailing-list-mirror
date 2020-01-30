Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B345C33CB2
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 01:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA69220716
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 01:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i80+iks6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbgA3BjG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 20:39:06 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:37857 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgA3BjF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 20:39:05 -0500
Received: by mail-pj1-f74.google.com with SMTP id dw15so1175549pjb.2
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 17:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3R26ANVrRiKLypdsGuTEBVDP8lnGT6+ab4CKkDsIPfI=;
        b=i80+iks69BPuAYyyYzElQJREiOit1Ma2NRirEce/wZqoedIyexfLFKSLDmYD7NAmL3
         HtkK90n+0y/kTFFF1+H44BFoJWpfcUYVy2lrPH3T3rwFrLs6n1162bdtmsuae03IDrSe
         AEjkXU7r0KcEmve2iVjhtcByB8UJ9Od2ahFTMdsdPQUDFfksHbpIrtCUTIJG+TwHAvk3
         I1VwGaiUabJoZqsK9AugUOe3DH8pedmFGnD6mDhxRgVFGYRIBT2KpzinY1rTkX0IjRyH
         iNg9gWw5tOozld5slbUZx5cS/Jtss8uZz+ezmaN/slAxRe8IbK8a1vbKfcvNOfsBDS2N
         r0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3R26ANVrRiKLypdsGuTEBVDP8lnGT6+ab4CKkDsIPfI=;
        b=E75Cy/OCtXZlticNtTsRm0ssTLLWX7kTg2K/W1/F4l8+/V4DNSlbn7u13uix/Greke
         CqCrfk2Hf1xKnhQvCzZzK1FzRIj47OnTbKiblFcEw8RFn7lz/nrKYbKiPesS6Jf/7fUI
         AJ71bx/9AawRGBcbOEGwCAq5xa1FMfn8b5ElfOGZuJ6apotMwRWa2zpF0by3aAqkiMIA
         S0yWNw5lr9xUmLtKEOqPDaLtT5CddlZ+pM1XwIftiStKrCdzVOV4m4We4/UMeADzQs1k
         bhZTlmgD0Ka9Rd/u/ilM3WBJqcLJc49MB6tK/jKqjZTn1yffPtfWfbFCeDjM6MjK9iOn
         xGsQ==
X-Gm-Message-State: APjAAAXw1jD13jHqFEi0VWuGxkMmc5rZwp36lQTq3cGmxJa/Y6hzkD2N
        4CljUoQV90SniWJUx41gHjyXAcoicvuc5f3CI4V+
X-Google-Smtp-Source: APXvYqxL778G1ceCR3qeAMLXlmsHp6uWV0HR4a2fOhub10lRIK66B1YJFB8WYjjxsiXTWWmvUsGcFmaDLwxXoZ1rOiZL
X-Received: by 2002:a63:114a:: with SMTP id 10mr2085654pgr.250.1580348343613;
 Wed, 29 Jan 2020 17:39:03 -0800 (PST)
Date:   Wed, 29 Jan 2020 17:39:00 -0800
In-Reply-To: <20200129050935.GA601903@coredump.intra.peff.net>
Message-Id: <20200130013900.181477-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200129050935.GA601903@coredump.intra.peff.net>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: Re: [RFC PATCH] diff: only prefetch for certain output formats
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Sometimes "status" does need the actual blobs, if it's going to do
> inexact rename detection. Likewise if break-detection is turned on,
> though I don't think anything does it by default, and there's (I don't
> think) any config option to enable it.
> 
> So something like "git log --name-status -B -M" would probably regress
> from this (though only in speed, of course; I do think we can play a
> little loose with heuristics since we'd generate the correct answer
> either way).
> 
> You could get pretty specific by putting logic inside diffcore_rename(),
> which would know if anything is left over after exact rename detection,
> but I suspect just checking:
> 
>   (options->break_opt != -1 || options->detect_rename)
> 
> in diffcore_std() would be OK in practice.

Thanks for taking a look at this patch and for the pointers, especially
to rename detection. I investigated and found that in practice, with
respect to rename detection, options->detect_rename is insufficient to
determine exactly when we need to fetch; we need to fetch when
(for example) a file is deleted and another added, but not when a file
is merely changed, and these rules are not reflected in
options->detect_rename. These rules indeed are in diffcore_rename(), as
you mentioned, but putting logic inside diffcore_rename() (or copying
the same logic over to diffcore_std()) complicates things for too little
benefit, I think.

To add to this, rename detection is turned on by default, so it wouldn't
even fix the original issue with "status".

So I'll abandon this patch, at least until someone finds a use case for
diffing with no rename detection on a partial clone and would rather not
have a prefetch.

> >  - Is the whitelist of output_format constants the best?
> 
> I think it could be pared down a bit. For example, --raw doesn't
> need the blobs (aside from renames, etc, above). I think the same is
> true of --summary. You've already omitted --name-status and --name-only,
> which makes sense.
> 
> I think --dirstat, even though it is only showing per-file info, still
> relies on the line-level stat info. So it should stay.

Thanks for taking a look at this.
