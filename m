Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360E1C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 13:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03C5C2073A
	for <git@archiver.kernel.org>; Wed,  6 May 2020 13:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=eficode.com header.i=@eficode.com header.b="a92rRywK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgEFNMx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 09:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727916AbgEFNMw (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 May 2020 09:12:52 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC7AC061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 06:12:51 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id s9so1291259eju.1
        for <git@vger.kernel.org>; Wed, 06 May 2020 06:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eficode.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=O4ScBbrreYVKAGqk/KsKhC/CS++d1fyrcUQSOCGUcI8=;
        b=a92rRywK2ObFBSq1/Qvkmj7z0frXAq3J8HEVhGed7eYsZtJx2i/PzM9cWhI06vWGML
         gNWoqabZOf7rK2aKnHc8PUGHUDqj2DtcrZ+yD9pe3wxEvtbfn9icNUqUE79Iez6dwUrF
         UmbHx1wt/P2s+fJzAzaGXIvY4TNfuXaVU+QG+ipQIYFH45fH4PgxKcRIAYEavLfHPJfG
         SlJNDelbPF9YNTSVgQnnyoQZc3tEUQa13M7HzyhfTUjYSlZvF/ni4R1uGLYukRE/FtE2
         TR8p8Ul5cIaJ6B238c7MsgUBEGkSbMdDcode0JFPPZPxhxqCHOxUM6ZM+vd77DO3i5H6
         4bHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=O4ScBbrreYVKAGqk/KsKhC/CS++d1fyrcUQSOCGUcI8=;
        b=p8+jQprCbowZF1UDlOkEmzlg10knj2vbHWxRJ1VgZaF60WJvBy/4BPE9ONDfZYqJgQ
         92WM0JT087VM5YsVOtyf1wNj6D67GRbN1DyfNESG+m8YUadYJ9FSHYPzxnH4iFtnvD0t
         jLmcceo6iw3Nr5J9ys3AdO6wFRNhLn10Mt0zurDDULBCqOmw+V+XljfLNp1SJhadZ1vl
         NuxF+B9Qr/X5MK4vTB4Ubza1Y6xPiUQhIV48SDAy9DOL6x4bs9KR/LQzqa4aWxz253uK
         NS3WYR3KvJajwAHcnvrtqwA6KRJBOoJJfrNE4p9fp0fTUWN4JJ/u8V5Wk0YubqSUMQKx
         xiGQ==
X-Gm-Message-State: AGi0PuaXJ8reYEWd7qXSaog8Q+hKjUH3P0AmEocuRm6jX9AeOe14rDpG
        95plQG23XfyU1WffXdlYwsAJZ5m61wsVMC/JfFlFTIyExg==
X-Google-Smtp-Source: APiQypL72r+nbLHTkmyLyy+3hHTsPpawacWTV6o9drrkQ0wvv7gmLj1ZotT99dZzzATzN4d3YZXUyOrEI4nw7NegwjE=
X-Received: by 2002:a17:906:bb07:: with SMTP id jz7mr6955160ejb.317.1588770769684;
 Wed, 06 May 2020 06:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <CA+GP4bozGEP_kJ1V5df_UEh46kDhPV48h_OqkPWfNJLQ2V4yCg@mail.gmail.com>
 <CA+GP4bpUs8ZArrf6sZDHDPHEJYu5Z_jrq4c5Bz4Sm6M24LuRMw@mail.gmail.com>
In-Reply-To: <CA+GP4bpUs8ZArrf6sZDHDPHEJYu5Z_jrq4c5Bz4Sm6M24LuRMw@mail.gmail.com>
From:   Claus Schneider <claus.schneider@eficode.com>
Date:   Wed, 6 May 2020 15:12:40 +0200
Message-ID: <CA+GP4brP8rtTxtKCPaq0q8VisOa9=fRJWU86SE61zB7S6CaGzw@mail.gmail.com>
Subject: [RFC] subtree: say last line of progress when all commits has been processed
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi..

Currently the progress-bar when running split echo's with a single
line which is great, but when it is done it disappears again and the
outcome is gone.

Suggest to record the last line and then "say" it after all commits
have been processed. It is then more informative to run from the
command line.

Patches can be found here:
https://github.com/git/git/commit/5f0924bb2953b9ee084dbf72312bac6e7e556d83

Best regards
Claus Schneider
