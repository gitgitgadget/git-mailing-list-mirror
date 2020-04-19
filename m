Return-Path: <SRS0=ylBF=6D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53518C2BA2B
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 03:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DEF921744
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 03:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCL/UQKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgDSDyl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Apr 2020 23:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725819AbgDSDyk (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Apr 2020 23:54:40 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A3EC061A0C
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 20:54:40 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id nv1so4999807ejb.0
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 20:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=3hE7VwwCsd9dlJhNyaL+cAYdwZSV99eDxBU4xjx6hUQ=;
        b=gCL/UQKoFd6wLgDYYLzbjmWiHNDglzYg6ur/v3edI4hIPlFQAzzgSKpHISYyOg0m5h
         YHs7jTEuY/mqqEFi7Um5/EhEodmlvS9QLbWxsrocrwx3CZkX8tul4hwnuclfpgiAfges
         wvx6LzApz1shiCsY5clRNh1weVXHW5FBOl0h88KEcdc9EkL4qEw39sboDzNs0F+ox7TX
         vaaoTJ6hFaa9IS2s0A4dEhUYrl/M8cVQh9pmfbjleOs+prUWbiZ0sEKIcyTH0+fiE67N
         ylqSgKqW2Y9z1LcPv/tYRKtKrQZap8a8McLAWq9IKNQS9UprTc7wEyAG+vRNxsxejyB2
         CYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3hE7VwwCsd9dlJhNyaL+cAYdwZSV99eDxBU4xjx6hUQ=;
        b=Y2LjCD6Wq+7issZ52tVsbmuoRES4vmIX++3ZFKx7ykgBW8Oo/zGlh8FgzHfVklGRiw
         8uT3Y8+eKcLPFN86eTA1j4i+S5eAWL7jf1d9CoyZW8YdqYyy7TyWbnwdna92l/WhjjYL
         ESnSi8RppvuQKrY5G4mbcuaqRSqJ1xjV6ZZKFJeXPCsyCaAxu5GAZb6E1rB0322UMyJp
         cjzpCZAlL55mlKwigYg+dDdEbBq/Qjfjl0WSwz32fOxSZZ+FPVLm2J5sZyi7EaLDPxuN
         ijVqdfWdm0e6CkMokMQBm5UpRVhvgcdudgSwhWq9r+WUnYZELZ0jqV2wkbe/Hoa7+Plr
         qTHQ==
X-Gm-Message-State: AGi0PubFrjIrQsejW4K9zRCt/GIf2vFnd6K/eKLYprdkBdNL998QqGFT
        4i6E+Ci+tWcv6EDmlKvWgO2n1Rh15NiTchXeceuas/HM/S0=
X-Google-Smtp-Source: APiQypKxHn+FFyhAEskYdyGbmhtqqqyTUYGiC3bum5slbPIZKtnRV3R/Notk80VvpdLcD39NICLufQcmlBH4J1HciYc=
X-Received: by 2002:a17:906:4a94:: with SMTP id x20mr10324563eju.306.1587268479120;
 Sat, 18 Apr 2020 20:54:39 -0700 (PDT)
MIME-Version: 1.0
From:   Kelvin Wu <kelvin.wu@gmail.com>
Date:   Sun, 19 Apr 2020 11:54:28 +0800
Message-ID: <CAAxGxjXv+VvN6PqOK8WbxO6_eFrcBhiaj2xRWcUhCtO321JmOg@mail.gmail.com>
Subject: Why the stand-alone installer for macOS hasn't been updated for 8 months?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As title says.

For some reasons I don't use homebrew too...

Thanks

- k
