Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA016C433DF
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 02:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79CBC20708
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 02:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iK+byDTD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgGICfg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 22:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgGICfg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 22:35:36 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E28EC061A0B
        for <git@vger.kernel.org>; Wed,  8 Jul 2020 19:35:36 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id q89so512585pjk.5
        for <git@vger.kernel.org>; Wed, 08 Jul 2020 19:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TR7ohNLU4FCR+2U5LNqxZpe5X1LCuigA2KX0CmEXExA=;
        b=iK+byDTDZZWJGd5ruTvGoFym1OMOlOSUMIAKFG9uz1O4/IXMhZf7LQGc4LAhRe8p2P
         LpKYq51qTU5GXf6GXPPIXCfJqxLZVLDZp2nV8IXcn3xVGR/gVmQv3cgnCRV6QkoWDxxf
         Ye+ZDFLu+5y4FAVAxjwjKXBxx9Fz3bAv71irVOpOhfmU/QYFr3S7xGkeyr1gSPtIEkz4
         uMibxBOO1NEX0YTgSI4CB4Igv9Q1onQ96NSZEkO4IDplMoWS3hXG/j//+GWTHiuinA80
         W6UuwbdPLIZcYbGTyq+AKgxFm0BsP8kTSOc5xDTSiqr38U4c68lYv0WJmplA0YdiLt/V
         8kKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TR7ohNLU4FCR+2U5LNqxZpe5X1LCuigA2KX0CmEXExA=;
        b=KUNy65Lq2qWM8vBJKrjP3ci4iV9I97kGnzBNa4I2pm3aJTcKFyeb9AKt8D40wkwQAp
         uZz4Oo2Ms9oDjooQKQ5PsQhIjOA3xirhZDZ1p3GMSyZWLGFKRpY5up4CbM793LTqUlXW
         B6OwjzLe/uhqui+H2D8HEl8bUoHsXBdWskvBM+cqTNje6ieEDavuUGmyb6P/jvBbMcV0
         MUaozWivicqWRZNkGrDqYkmkC/vWdOIab/SvCanZ44/c++kL8Lmr1Ati1xBp9pYHdW1s
         OFVRvLW88vp/1YnpmahC/H8ccLtt3PpNFVXefOn1Mz34/YYsXniWWJlcXDWsyPv7Xj2i
         dgHg==
X-Gm-Message-State: AOAM531EiseltKIofUJbRIlNYPOt5HupuxRncbUv3Oz0KJ3nhsduI4Qr
        +SWJ9zTKe8gNFq9WgjNNiV9+8GdDPH3pWg0MxIKZ
X-Google-Smtp-Source: ABdhPJwUoaOJvBLg/b41ljOQb1JHP3kTRxNBBq+L/yzqt6kNTuKctB7iCmp/vUUHStMo6k55yzSgD2lVuRlU+Sg0WHo9
X-Received: by 2002:a17:902:6bc5:: with SMTP id m5mr53133170plt.101.1594262133361;
 Wed, 08 Jul 2020 19:35:33 -0700 (PDT)
Date:   Wed,  8 Jul 2020 19:35:31 -0700
In-Reply-To: <cbaa5ecc4f23eed0823fbbb53ffef28c9f7d6913.1594131695.git.gitgitgadget@gmail.com>
Message-Id: <20200709023531.41660-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <cbaa5ecc4f23eed0823fbbb53ffef28c9f7d6913.1594131695.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: Re: [PATCH 12/21] maintenance: add fetch task
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, derrickstolee@github.com,
        dstolee@microsoft.com, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> 3. By adding a new refspec "+refs/heads/*:refs/hidden/<remote>/*"
>    we can ensure that we actually load the new values somewhere in
>    our refspace while not updating refs/heads or refs/remotes. By
>    storing these refs here, the commit-graph job will update the
>    commit-graph with the commits from these hidden refs.
> 
> 4. --prune will delete the refs/hidden/<remote> refs that no
>    longer appear on the remote.

Having a ref path where Git can place commit IDs that it needs persisted
is useful, not only in this case but in other cases (e.g. when fetching
a submodule commit by hash, we might not have a ref name for that commit
but want to persist it anyway), so I look forward to having something
like this.

The name of this special ref path and its specific nature could be
discussed further, but maybe it is sufficient for now to just say that
the refs under this special ref path are controlled by Git, and their
layout is experimental and subject to change (e.g. future versions of
Git could just erase the entire path and rewrite the refs its own way).
