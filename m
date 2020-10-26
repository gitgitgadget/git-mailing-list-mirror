Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED32CC4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 21:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A642E21655
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 21:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PaqlQSyU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391265AbgJZV43 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 17:56:29 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:52006 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390914AbgJZV43 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 17:56:29 -0400
Received: by mail-yb1-f201.google.com with SMTP id q8so1576833ybk.18
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 14:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Csi9FSGvYIO2sf75QXncqLfhMaEI08cA6QGh92fj+uw=;
        b=PaqlQSyUz0gP0XDC8gofOFwjiG50zQGYPAkT28X+cyjqCNczCawuKpZlgF9Z7+KKHX
         17ffTkCIfUyd5L11dfiEBdSuEiT702nypEjygvL2fyMAYL53Bhh3BOLGRtvsGFPuqD2o
         VJjpgDHyKjPdm/ObEx35/gy3O00kiNpG/gz3L9EQ44ukXoyad5oTpD4q41YPto+jwebN
         6PGxSB35k9A+zd/AXuXEVI9+yIhDUqrA1+l9Lu07amlerBjfOp8hP9fEL9fy/EBREqIl
         M9BCqJrKUN222PKcEbO1nytWgZBxp/xEfSBQLxHgscWBOymT76AUTWEjOo7Af/voKTAo
         unsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Csi9FSGvYIO2sf75QXncqLfhMaEI08cA6QGh92fj+uw=;
        b=rlwUl7/qqf3Ji2pK4tSUy9Btkf4CY/8S79PZnPnVyoDEOgjnx+bIFjDl5unSZ7w8ih
         dnZGxOW+ru9yibZzhdvcJAcl9bT12g3SDvwRAXg27dHdEURmxhZnbOniI+6LmpX/VZM+
         7PN5ecJ+vg+JZN+lWyEBeNuxhB9xYOah6i+wvHfjxDmktuqfbn9nXAS+RWKcddGVBEeL
         1n2cUZeBMaImvjfrtqBBg5TZ1ZUmX8I854hN2cc1E3o+vwlREtp/tBshCzq5Emvz/TBL
         y+9cylf+Dz21zJHanSYNSSzM7Fh/j3GwtdvteB/c1K8EiS7LG30abP+d1YmHk38ei/Hz
         1C8g==
X-Gm-Message-State: AOAM530ePZ90Q4l8BOk6/KcX0bFRFUKgaBD1MYAnVqj3Vw8pXP1ds1A6
        7hNgjSp7TebRan0oR5MVvXKLz4mL8gAkdIy+FJE5
X-Google-Smtp-Source: ABdhPJy2I7G0A+KwiiIzumvr+OfQPL6+bScK+3a8Bj856frvUZfBKebSqXG1QgXJQAP+OfISsqmwIv+vli5fYxqPjC59
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:d0cb:: with SMTP id
 h194mr22302293ybg.52.1603749388229; Mon, 26 Oct 2020 14:56:28 -0700 (PDT)
Date:   Mon, 26 Oct 2020 14:56:22 -0700
In-Reply-To: <CABPp-BEGo8qfaoz6vUs+ktvmNUZdiHjwda468Qkh5uaD-wAd4w@mail.gmail.com>
Message-Id: <20201026215622.2138981-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CABPp-BEGo8qfaoz6vUs+ktvmNUZdiHjwda468Qkh5uaD-wAd4w@mail.gmail.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: Re: [PATCH 0/4] Beginning of new merge strategy: New API, empty implementation
From:   Jonathan Tan <jonathantanmy@google.com>
To:     newren@gmail.com
Cc:     gitgitgadget@gmail.com, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Hi,
> 
> On Wed, Oct 21, 2020 at 6:22 AM Elijah Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > In this series, I try to show the new merge API I have developed in
> > merge-ort and show how it differs from that provided by merge-recursive. I
> > do this in four steps, each corresponding to a patch:
> 
> I should probably call out that even if folks don't have time to
> review patches, I'm particularly interested in opinions on the
> following two questions:
>   * Are the "pull.twohead" and "GIT_TEST_MERGE_ALGORITHM" names in
> patch 4 good/bad/ugly?  (especially the mapping from "pull" to revert,
> cherry-pick, rebase, and merge?)

I think GIT_TEST_MERGE_ALGORITHM is fine. I think extending
"pull.twohead" is ugly - perhaps we could get away with not doing
anything about it for now, and once this feature is ready, we could add
a new config parameter specially for this.

>   * Is it too weird to have a temporary/hidden builtin, in patch 3?
> If so, what is a good alternative?

An alternative is to implement it as part of test-tool - see t/helper/
for more information.

I'm not very familiar with the merge code, but overall this looks like a
good, clear design. Thanks especially for showing how this code can be
used (in patch 3) and a comparison to the old API (in patch 2).
