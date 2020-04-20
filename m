Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464B8C54FCB
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 23:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F0D620722
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 23:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="hIqNURxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgDTXjL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 19:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725988AbgDTXjK (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 19:39:10 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4C6C061A0E
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 16:39:10 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id x26so5873079pgc.10
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 16:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bmQMb6pRvtOHqvi6fmaTz0Q0kBLarnMK2St0UC/KgTE=;
        b=hIqNURxv3m9F5GVvp3HKRgCbRhJPP1Zmfyu8DuLGOXpL/LBi8fdSztiQv+PC88Wmt2
         FfqAaV5bY0GCV0Yzu4ITbd67cIVKoMI124kUaiT8jVVCji4MheLhqEj3o+rQmJvPkZIZ
         Xc3g7vodDNyJMPjJqOjDGF7QMDpYv2wVuCLlPzWbP87KuUvRExheayGC1KuP5wyi8CWI
         1uCcV5Wx4gvI8I9qyE+HD3h0kjK+E1DGIwj0Zuj0Og9Q3aMNpJ2o3WTWn9BNARb+MIJf
         6DzSNz+rj6W0c8ie0R/VFAnaOZQIamPWLS9SmF3+ZTg/MuYLm1s/75xNwg3+MdNNeCML
         Qubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bmQMb6pRvtOHqvi6fmaTz0Q0kBLarnMK2St0UC/KgTE=;
        b=fWw7KRxoEYyKPLj6I5Z3jLM/eDMWgkKRXjRLRFl8Pk2TrUnTBWuWqH4Amrt4nSO9Ke
         3xn9YDLmXgzRzk/tfFmp8KvfjhWRn/uY1OgqfPMrelovkn3q9T577TvgfTT7w23bmSjo
         GZEcfLEy1+LC4C1tLqTmjVVY/NSPfCV8GkuG60psipBEFkqNel4ZTJ8VH1YW7Vx08Ors
         thcXTt/5ZeEVG5cOEctYeR25nZXody5QLUs4jGglwFulBbFAU8Cb6GaRnKAYaRYtLAII
         TOrzfsaS46X43iDQAeTXyEKKLIE+jyt5spaOtAz5tQGFY2fVtD+Bgp/kTJAjj3UZg1dV
         G4xg==
X-Gm-Message-State: AGi0PuY0Kkd+z8PS7JOnOspNrZRWUBS9JUIxkvxPvidMmaKyJxFnzlYJ
        N6YIvz1yInvzm1FYwHr7R8tYv8jv+dORIw==
X-Google-Smtp-Source: APiQypKR0nQ3xHbakVafdoCUVVS4To0pm6O3l0gtvaw/k5kQ4cFGyC5HzjcKJmK42tEJg80jHKPLFQ==
X-Received: by 2002:a62:e304:: with SMTP id g4mr19877869pfh.286.1587425950119;
        Mon, 20 Apr 2020 16:39:10 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id ml24sm486320pjb.48.2020.04.20.16.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 16:39:09 -0700 (PDT)
Date:   Mon, 20 Apr 2020 17:39:07 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, mhagger@alum.mit.edu, peff@peff.net
Subject: Re: [PATCH 0/3] commit-graph: write non-split graphs as read-only
Message-ID: <20200420233907.GA97996@syl.local>
References: <cover.1587422630.git.me@ttaylorr.com>
 <xmqq5zdtrbby.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5zdtrbby.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 20, 2020 at 04:23:13PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > The first two patches set this up, and the third patch uses it in
> > commit-graph.c, and corrects some test fallout. Eventually, we may want
> > to take another look at all of this and always create lockfiles with
> > permission 0444, but that change is much larger than this one and could
> > instead be done over time.
>
> So,... is the problem that this did not follow the common pattern of
> creating (while honoring umask) and then call adjust_shared_perm(),
> which I thought was the common pattern for files in $GIT_DIR/?

We do call adjust_shared_perm() from (based on what's currently in
master) 'write_commit_graph_file' -> 'hold_lockfile_for_update' ->
'lock_file_timeout' -> 'lock_file' -> 'create_tempfile'.

But do we want commit-graphs to be respecting 'core.sharedRepository'
here? Either we:

  * do want to respect core.sharedRepository, in which case the
    current behavior of always setting split-graph permissions to '0444'
    is wrong, or

  * we do not want to respect core.sharedRepository, in which case these
    patches are doing what we want by setting all commit-graph files to
    have read-only permissions.

My hunch is that we do not want to abide by core.sharedRepository here
for the same reason that, say, loose objects are read-only. What do you
think?


Thanks,
Taylor
