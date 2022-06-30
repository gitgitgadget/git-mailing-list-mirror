Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B90C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 22:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiF3Wc7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 18:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiF3Wc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 18:32:57 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC9857226
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 15:32:52 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id cp20-20020a17090afb9400b001ec75748019so348388pjb.6
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 15:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=7PjTjkMgcE4PxXZK1NiVyRKkIsibrSvH6r2sTxvOGiI=;
        b=WdIxvsSlrprZ1VaKLN+7dj3gYTrCfeJ48Log+odQzma/fTaZoLucf/jpCxs9PIVu0k
         17ypbIFldEfT1hqaJKpkKjuAYgA1QjO4FIHngbZ3H/cWYV1kFW1iyOBmdg0sMqtlvwTu
         gzw9cr8jwUE78eQk5yckgKDRUJXq48K9c5IC41Q8D19atbxgKCSSgaGnh7DlePCIf8T1
         2YAk6x0S87fcy3mQgjKHuX1b7AA/z9miio4vGzbpDKvfewds5PVWpqqFLvDhfrQjfawm
         ua3OUsoCFmGBQOsQ5pNSJOJhQeQo/Ej3SFSp2GOaIk24GnLDdhQIoDg/8kfLr7S/+8Nw
         1duQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=7PjTjkMgcE4PxXZK1NiVyRKkIsibrSvH6r2sTxvOGiI=;
        b=zU33O3jnBpA9hccHHX4Cf/ml7G5JBOxqPSQqFFl48CV9UjbFlpMRiy0xPYi6edGpaW
         QBYAfyBCDgRblbnvlmU6Rymy/82+shZkTWlVwFJb+2GgyJ6LwGY8KiAUckrZ4oaWoR9X
         xeEa9Jix7NWAnOi9PanUm06/K554Na89pDAD+vfRbR3httJb02h88LDiMKSMa4rABL/K
         PXGcVAlU6B0KA4AEn6XMj/oXH7YmrJWMJSa3Rjil4cr0Icy7RceYEcnVqIxUK67TJ2LA
         LHfNGlxwqNG/44/2eyZSWpgXkRVqX0M0WRpfgg+Cg8IZ3K5weOPIeeadz1hslZar6ecR
         +fMQ==
X-Gm-Message-State: AJIora9n9sPGGnMeIBPgWIcUvdl16ucpd2gSz7ZUmi3MSQeXtsE3ft/d
        ojvZzcUab/ZXS7w0zI9XI9zxPkDG6zsSN7P0XEvO
X-Google-Smtp-Source: AGRyM1vHSd3yqTD5nCw5tdD7jhBvNOy8BHm8RqkXiiO2wZSZHfyIOJRNaccg8g0l3PTQ3dSfgX4iBoTtoE9Mhh5aMxm6
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:1c90:b0:1ee:d804:d2c1 with
 SMTP id oo16-20020a17090b1c9000b001eed804d2c1mr14561129pjb.92.1656628372602;
 Thu, 30 Jun 2022 15:32:52 -0700 (PDT)
Date:   Thu, 30 Jun 2022 15:32:49 -0700
In-Reply-To: <CABPp-BGtKQVgaf9ttwRMAE6AvH1QC3TqFcFwiAOpnm-SqKnNCQ@mail.gmail.com>
Message-Id: <20220630223250.2843332-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: Re: [PATCH 1/3] t6423: add tests of dual directory rename plus
 add/add conflict
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:
> Ah, I can see you've looked at this very closely.  Thanks for digging
> in!   I know it's counter-intuitive at first, but the file is
> necessary in order to get the sub1/ -> sub3/ rename.  The reasoning is
> as follows: We don't need to detect a directory rename for a directory
> where the other side added no new files into that directory...because
> the whole point of directory renames is to move new files in a
> directory to the new location.  Therefore, no new files in the
> directory on one side, means no need to detect a directory rename for
> it on the other side.  For a deeper discussion of this, see commit
> c64432aacd (t6423: more involved rules for renaming directories into
> each other, 2020-10-15).

Thanks! This makes sense. Might be worth including as a comment
(explaining why "newfile" is there) in the test.
