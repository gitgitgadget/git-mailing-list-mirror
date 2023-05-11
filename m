Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9335BC7EE22
	for <git@archiver.kernel.org>; Thu, 11 May 2023 17:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238563AbjEKRYW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 13:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238904AbjEKRYU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 13:24:20 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733E71BCC
        for <git@vger.kernel.org>; Thu, 11 May 2023 10:24:13 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-645538f6101so28630554b3a.1
        for <git@vger.kernel.org>; Thu, 11 May 2023 10:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683825853; x=1686417853;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1YdYEcMlxvgoJknGL5UG/GsBGoGYr5KGlJbIJhJiQNo=;
        b=0i7rvK15stu6EYlJv/kEEWip8Ot9cpXgyo0gu9O5llN29xCygZHsXKvvMrLls/6820
         +7TVcMQpuqI0diIMu+KfWNcQ7O7jY64EblP1zhB5mUMcMDT7eGYyX0AKOazAo+aSyXun
         /BbOPxZ+pnEWX3LmaeHyqnhQgm3blWZjNhw7OsavBx8/d7/tKyqHCgKRcESNa7XZCr73
         Hz+LGU7/Dj9RO4ukrKMwiY7tuqOnVMcC0NpDJP4AdT7/r8M3xInkjpZ53nzssNnjAda/
         MaXcUiUue6gK/iMehtY57LdgGxYCOZC05Ap8Sjwmy1vBSTaqG9RQYsW9aefleX8WrN4n
         ySag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683825853; x=1686417853;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1YdYEcMlxvgoJknGL5UG/GsBGoGYr5KGlJbIJhJiQNo=;
        b=keNzAQKLCo970mmC9JjOSctr3Kr3ER60jcAhN3QolKp4Sp2/BS1/Kpw02wzstBdZpS
         3u7VcHcPef2P2UULs1RnHjB4WbnbRFoFHuroEkGjk7kd+ZRaTQcX+R64xGTjE7OulRYu
         Zu1KvfbbkUYBFb5u1OBD1Lnl+IaGVXtvKvPCxHr5rpOiCXB86rqkxuBqA2E2VFsaTJWD
         38p/lkuE0gMnsYTIjHTqIUp1NUt0PAD8AFaF9AyiheO/52tpBDX9l8/bzkbfP6HE9gAf
         clY1qtQ/8AS6uWX0zbZfGcwBDRha9YNAz8zdLgvSZ4QfDYeoo8j2FW9TL92agPYRhk4+
         FzQg==
X-Gm-Message-State: AC+VfDyzykYku/f0a3GLtZgATV6AeTCsO65zH6vB2CVcTEM3IXZ+N7Wl
        pqRIuvKS1L48v9xi8DzT2bhBbnwhLcpqA7Y=
X-Google-Smtp-Source: ACHHUZ7ojHgfpQV8tih9W7FfgPie4vT4BbyK472ejKminlfm7Mvf+Qu8Jqflwb1YVBup/Y7XKyFhW2G9yi1LCmw=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90b:4a52:b0:247:b82f:b42 with SMTP
 id lb18-20020a17090b4a5200b00247b82f0b42mr7297374pjb.4.1683825852957; Thu, 11
 May 2023 10:24:12 -0700 (PDT)
Date:   Thu, 11 May 2023 17:24:01 +0000
In-Reply-To: <44a4027b240289605f4c40b9121ee6615e9759f7.1683431153.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230511172401.934633-1-calvinwan@google.com>
Subject: Re: [PATCH 23/24] hash-ll, hashmap: move oidhash() to hash-ll
From:   Calvin Wan <calvinwan@google.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Note that there's a small but
> important change to khash.h in this patch as well to allow this move,
> which is easy to overlook.

Can you go into a bit more detail as to how this change allows the move?
(An example of the concatenation would probably be sufficient)
