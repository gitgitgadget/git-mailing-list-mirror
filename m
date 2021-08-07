Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBB2C4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 05:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0C6561184
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 05:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhHGFKw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 01:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhHGFKv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 01:10:51 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC65C0613CF
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 22:10:34 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id f42so22161156lfv.7
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 22:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=aL+Y4hOOXLmlH6gxOdh6M1U7WjIaX1Pfd6d7U/+aSk8=;
        b=qiRSKTpfMmNLPRP7nalorPfj63Ml/IEMVcEH+gLgAfFP7qrpzPac8Tfoq3dMD8jJMz
         WiLMTUcsZrZv70wTlUx3dEv+rSq9igEsSFWVBaX48NCs9/Z/OpFOt+0CXddIrL8ClkKe
         ldMRt4dqgCzwxBSJjELokSk+VEdfAavJRy/N3s75O1Nf9JcoubYjHXx5L5Hjm7Jyddgz
         yV52CDpzdGeQdGH1H/Iyd5+qMsp2e72pGm5SU7LpfPLDmwQvRKBRkapFjVqaGoJKn9wN
         nu+HuM3uevgSzY6sIyvCPNtxFvjebXY4Lb42X1GW0bXdc6bTd8xjMmRzf7vkUusXKQHk
         xIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=aL+Y4hOOXLmlH6gxOdh6M1U7WjIaX1Pfd6d7U/+aSk8=;
        b=Lmj8khTAV2z258zC6o+5xQ/UN2AJndZqAP2ktXrMvaezFBS+wWSv95UwV0VAaMv7W4
         4Vks/fxCnhY9DGvgQ7chcW0k1RYJxOD/TTRiGPSAdwlDKVrFUR3TGhhy75nZHzll6Vle
         OTmJ4ZnZvvQvPHuheDf/+CMwNP7PizMrMHpYe2HNhSeGr6/0+y8iB0/+KK8BXyXQzHOM
         VZoPX9cWIhD6TRfhgjF1sSMHtF/li9AA8SoR3+6d4Ef4bCk1lxwHoFlyBUzMQO2vg6bX
         q919pqVcMCuS+eX7zzdpC5N6FFF1qt7b3KidBtgLd1qJsHtjtIBlnXfBqh/+FWqGHW8N
         C/Aw==
X-Gm-Message-State: AOAM532yWXu0LwkbmwWeuNAroxGXHaDLmAFLQv2c32JIpyE1jRrFxiQx
        0be1EgcYoVIXxDTjsJDSu/gKfToOfqQaP6oJz8n5/UTFr7bkVw==
X-Google-Smtp-Source: ABdhPJxXfTg72eMh1lBjvRR6UDp4mQIuA64IMTpK5tyoEORLjbCZ86D2trXd18JrSh1Vi7qxMpdtzPwVrjw5Btba3iw=
X-Received: by 2002:a05:6512:20d2:: with SMTP id u18mr926536lfr.167.1628313032619;
 Fri, 06 Aug 2021 22:10:32 -0700 (PDT)
MIME-Version: 1.0
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Fri, 6 Aug 2021 23:10:20 -0600
Message-ID: <CAMMLpeR8C_gjZ0CE8-nEo7syt=t0MwMGVKw8BL0k_BTpsk2D5Q@mail.gmail.com>
Subject: Problems with Git's Spanish translation
To:     Git mailing list <git@vger.kernel.org>, git-l10n@googlegroups.com,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

There are a large number of mistakes in Git's Spanish translation.
Most of the mistakes are just typos, but in some cases the
translations are incorrect to the point of incomprehensibility. I sent
a pull request to the Spanish translation's maintainer in June,[1] but
received no reply on GitHub. When I emailed the maintainer directly,
he replied that he had little time for reviewing changes.

May I send these changes to Jiang Xin directly?

-Alex

[1] https://github.com/ChrisADR/git-po/pull/22
