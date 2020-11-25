Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF09C2D0E4
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 02:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D07D421734
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 02:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PnWwgPcZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgKYCHF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 21:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbgKYCHE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 21:07:04 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735D4C0613D4
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 18:07:04 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id y21so880798qve.7
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 18:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=xp9Qq/6e+Ktxt1Jxt2olgPuJMhRzmdt1Tc5mAfXRNt4=;
        b=PnWwgPcZh32XerHG0JbC59Qwm6gt8WtY5aIno4nLw6WzeGjSxzetu5X/iXaXwj3BQ5
         E1MDU2qn9lP/HyZxEUCx4Pnz/Myhj/0VMNA0y/fjpZkpqohkzqyxhB23gLhzfmWF9Bze
         1efTSIS8JFne9bGXy+uE15a4ieNJL0KLRQR9vnzGkmZ911uRgd0+Za35RhJyiLlrDB9P
         VL+wcz/XYYg9Eb1+bNbqOOm9gSRVt9W9DfxhpsKtsp5aS0BgGkUxrh4zGwtCkfvRTFQS
         LW4//7vI2b4ATqjKFbHuk+A8xg77yOwK9/Fmxqnv09c+aNMJ838NWSzFb6ritg6pKRlV
         p3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xp9Qq/6e+Ktxt1Jxt2olgPuJMhRzmdt1Tc5mAfXRNt4=;
        b=bEJvGhBhta0wJciXgFvkLG1Y6Br3PZwZOqeEH7yaQMYKFLTDuLo8w5xGX0Xgw9jaHI
         hsj/7fZzil5ty8Wj3VgTkJHM5v/5g9vavf787rEFMpRC5iJxlBDx1EaBdUmo+Fc7Bz5g
         2EnuPBrl3FpL4sYh4fCJlsnvTIt+VXdh0gv1KKutbE0Tzh2WNc020EXEjCd/mZFEkZJX
         RqnjZVrd6m5X28ND6q2e4LbFI3VymmjjUGKT+R96c0+tdlkYypvxmmee8CxgZw3bqHO0
         MPRNAVRczgzHUFXE9Fvp7VoQTd2zzBuBVVZeug/H9XCeM606re1b4FgsldKFHR9/WKb3
         ybSA==
X-Gm-Message-State: AOAM532YO/CArfwSeKtj+SWGUt1X1nDurgjh7V4ZNKuphG4Mm5IWRGuU
        hRmGxcMaRarShHmvIVZFKrPeNSEFJHPEdsu/6V5e
X-Google-Smtp-Source: ABdhPJy72zR8qRqRtsvb70bSVzsg/mfHAudQ+prBVRr8e/CJwa9X/zqw1hvuab8vgz44wEC8a2xWS6kjYYgtOfHMGAAH
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:83a2:: with SMTP id
 k31mr1163710qva.57.1606270023537; Tue, 24 Nov 2020 18:07:03 -0800 (PST)
Date:   Tue, 24 Nov 2020 18:07:01 -0800
In-Reply-To: <CABPp-BHa21aeXwzykyQAtGd3rzOiE++Gozu7umOSYihc_145iA@mail.gmail.com>
Message-Id: <20201125020701.956393-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CABPp-BHa21aeXwzykyQAtGd3rzOiE++Gozu7umOSYihc_145iA@mail.gmail.com>
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

> For now, I'll keep the code as-is, but add more comments to both the
> data structure and the code.  If I've missed something about how I
> could make use of your BEGIN_TREE idea, let me know and I'll look at
> it again.

In collect_merge_info_callback(), you call setup_path_info() to add to
opt->priv->paths, then call traverse_trees() (which recursively calls
collect_merge_info_callback()). I was thinking that in addition to doing
that, you could call setup_path_info() a second time, but teach it to
add a synthetic path (maybe have a special bit in struct conflict_info
or something like that) that indicates "this is the end of the tree".
Subsequent code can notice that bit and not do the normal processing,
but instead do end-of-tree processing.

Having said that, maybe it will turn out that your additional comments
in v3 will be clearer, and we wouldn't need the synthetic entry.
