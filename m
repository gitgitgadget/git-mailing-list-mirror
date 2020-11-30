Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC949C64E8A
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 18:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90DFC20825
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 18:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aUkJj33h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbgK3Smb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 13:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgK3Sma (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 13:42:30 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A00DC0613D3
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 10:41:50 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id z28so9681759pfr.12
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 10:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=BhBwwlCriSY1cJ7IQzo5m2K/lkvtvBIwtvH3s+77tZI=;
        b=aUkJj33hoHfRFstwRi4v7Z2DlPj6HFqScrd9d/XmU+sXAHEo3BIuy1logIi8FfBrPX
         15l2WtRc6BBqe4VIggsRFE8DRc5oigesxELqgjs4zyzYySOsYfhJNmhXsxPuW5Xp0sgX
         UmQl6Bm1cROHe3M9LmFoZuNQXRATTvf6esU3m5jlYBlw3Gb7Ts0AgyJ23T/8HmdKEXoj
         d8mQWTjLnLkttEndzPt29t110aLxl55PJxPDyJljiyTcBHPBNmMHxOSf7Ratg11RO//I
         rvyFvqIeFdB9zoanzg2CQP8vJURcFni3H4TzYlE7/B9xy9TnE8FLVKiK0JMhUvcZDsQ5
         amkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BhBwwlCriSY1cJ7IQzo5m2K/lkvtvBIwtvH3s+77tZI=;
        b=bZ9Vh3lU2FSEooTjyXwRop4HzzQdNJCRRL300nPeXzJyBY/uZ5FoqBsKdepD0+QLbh
         6Nwquvn/dBc3A23QXKhbWcChP2BlhASWo6Z219Mnwh+1zg8TIEhDoOCQ6gDzQl+eXsCl
         pbJzWZ1E9pZchFHuXPFPTkiuJU9THxwjmpfFbXTsbr3Utnw8MxP5McNIQRE6Yc5tAVCG
         x6PNpn5Ch3O4A9RK+u1B2+A+gx4gXuG3DDR1gwNOeSwaQdUkljCHww4U9updj/LIvdV3
         ekvw6+j3B56C+h09AFi54l2se0FoZBQh5vyaRb0+bbtaipBE1rGAasfARuhKUOwajfj7
         XjIg==
X-Gm-Message-State: AOAM532MkjEHQr5amv4qtQSKO8oJzX0lNUdx7UFYs8gX/uPHNKryVWgT
        Ikd0FYzc4CKNIdxS9i8tGPRb4+SrIeNwvopjYwlB
X-Google-Smtp-Source: ABdhPJyaRYv7sAa/gnVMB6kr2ufvKkzgUy4KBv6Vpz2XsecCIvfgVE8mnerSpiH2WJ9QCASU0IdBj/0EZQOUuo5aHz7j
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:e903:b029:da:7259:1bd1 with
 SMTP id k3-20020a170902e903b02900da72591bd1mr8039435pld.35.1606761709840;
 Mon, 30 Nov 2020 10:41:49 -0800 (PST)
Date:   Mon, 30 Nov 2020 10:41:47 -0800
In-Reply-To: <CABPp-BEfqrT7B=Mu=LWpi3GYkP0SRLFFjPVkca8krairry3iew@mail.gmail.com>
Message-Id: <20201130184147.3086836-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CABPp-BEfqrT7B=Mu=LWpi3GYkP0SRLFFjPVkca8krairry3iew@mail.gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: Re: [PATCH v2 15/20] merge-ort: step 3 of tree writing -- handling
 subdirectories as we go
From:   Jonathan Tan <jonathantanmy@google.com>
To:     newren@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Tue, Nov 24, 2020 at 6:07 PM Jonathan Tan <jonathantanmy@google.com> wrote:
> >
> > > For now, I'll keep the code as-is, but add more comments to both the
> > > data structure and the code.  If I've missed something about how I
> > > could make use of your BEGIN_TREE idea, let me know and I'll look at
> > > it again.
> >
> > In collect_merge_info_callback(), you call setup_path_info() to add to
> > opt->priv->paths, then call traverse_trees() (which recursively calls
> > collect_merge_info_callback()). I was thinking that in addition to doing
> > that, you could call setup_path_info() a second time, but teach it to
> > add a synthetic path (maybe have a special bit in struct conflict_info
> > or something like that) that indicates "this is the end of the tree".
> > Subsequent code can notice that bit and not do the normal processing,
> > but instead do end-of-tree processing.
> 
> So, I realized that I already had end-of-tree markers -- the
> directories themselves.  But due to some other weirdness in how I had
> built up the processing, the existence of those markers was both
> obscured, and deliberately side-stepped.  So, I did a little
> restructuring so we can use these as actual end-of-tree markers more
> directly.

Ah sorry...what I meant was to have both begin-of-tree and end-of-tree
elements in the path list, so one of them is real and the other
synthetic. Right now you have an end-of-tree real path in the list of
paths, yes.

> > Having said that, maybe it will turn out that your additional comments
> > in v3 will be clearer, and we wouldn't need the synthetic entry.
> 
> Hopefully it's clearer now, but the entries aren't synthetic.  My big
> opt->priv->paths strmap with all full relative paths contained all
> files _and_ directories already, and now I just use the directory
> markers more directly.  Hopefully the extra comments help too.

OK - I see that you have a new version [1] and hopefully I'll be able to
take a look soon.

[1] https://lore.kernel.org/git/pull.923.git.git.1606635803.gitgitgadget@gmail.com/
