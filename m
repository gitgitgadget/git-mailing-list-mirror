Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD14C05027
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 23:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjBAXzw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 18:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjBAXzu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 18:55:50 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC3466FA0
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 15:55:49 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id 12-20020a62160c000000b005808c2cd0b6so20397pfw.12
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 15:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+57CRUHYWXOHC96rwF56tI6Xf0sKMiXH5qF/r+4Mqg8=;
        b=kblAUXgFJzoC6ky+huORfdRTKlMvIlb1xcctMd/l6IA7yzbGpLPWg8xfQ5KKuBNKkq
         2USnlYs4GF+HYxVblNkqjYuZwY8kCdYr5cCLWQdH79xJPEkuiJYTBrKzjwqRN3ZEY6vl
         UCfz4KHAAZmdpInJ4zCUQ4tVhxA5j4NzqWHmZeUNkQAYorNy5Q0tlE+uBvMR2zPiC3th
         vWgFh8vtbyvZa1ohh8cZ5ZcipdPyyP0lgwXweQ0DPduc3JS1K5lbcfHUCm4TwwCWIrs3
         N4dHhn+AFk6eK+rE5/GHPlUf4etzXsVOqFjEXGNamjvodDoDnLOCzH6Erjz2jo8H8l5B
         PjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+57CRUHYWXOHC96rwF56tI6Xf0sKMiXH5qF/r+4Mqg8=;
        b=6EcHbxd5Fmw76TBLW1Ug7rbL2m3ls4StWVgYt1YT9JjcN7KbAX9qdT7FCxgoOyX4RF
         H4COcXtrVW1f3X1bFRuAwODe6ia4WjCwN8qpAEj3Roe5Dj+63BVAtw8xHxJFsBGArG5D
         8Lk9UUtfSWHnGMam0RelM+4Ui81JHm9cQx5D/qWDYEWqu3r0kA8tyx6c6p5+4p0BJpAb
         Xttkv05pM3SPDtTY242um8j/5c+mHxTf6kjLs9NBa7cEBIasXz7w3L2Gw8tuZ6TaNlkA
         689Tbj3XuNLbCDfY0EVfm/zOaP57RN1wkBMUWYpjTUGoioxIIoGN5TLJKFQ2zcUcIRx6
         +CXg==
X-Gm-Message-State: AO0yUKXJsv7MBh+ChANMvvJbhfJ2Ob3ge2t6JJz7Scvstj7fzAOWCyN1
        hwZ9AG/8kf8yYt9ckDqsFcTg4EYWLAF1zLM=
X-Google-Smtp-Source: AK7set89uNEnUopIIYkax0ry9/caUu3X+k0jnaOvg2V6OhhwJ8BZuDtBTUGS6jdsQ6MiDVvDfXefZ3u9CR9g1J8=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:902:e792:b0:192:63c3:7b5f with SMTP
 id cp18-20020a170902e79200b0019263c37b5fmr1047603plb.28.1675295749173; Wed,
 01 Feb 2023 15:55:49 -0800 (PST)
Date:   Wed,  1 Feb 2023 23:52:53 +0000
In-Reply-To: <20230119223858.29262-6-zev@bewilderbeest.net>
Mime-Version: 1.0
References: <20230201235253.1891546-1-calvinwan@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230201235253.1891546-5-calvinwan@google.com>
Subject: Re: [PATCH 5/5] format-patch: Add support for --{to,cc}-cmd flags
From:   Calvin Wan <calvinwan@google.com>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Zev Weiss <zev@bewilderbeest.net> writes:
> Having these flags available for format-patch instead of only on
> send-email makes it much easier to use an automated command to do the
> bulk of the recipient-selection work but still manually adjust it if
> desired.

Commit message could use some more explanation to make blame diving
easier later on. In particular, why is creating temp files necessary? 

Missing update to Documentation/git-format-patch.txt

This patch also needs many more tests
 - tests for --cc-cmd
 - tests for commands that run on the patches
 - similar tests in t9001-send-email.sh

Will wait for reroll to dive deeper into the implementation here, but
overall a well-intentioned v1!
