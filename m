Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8E5C43465
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 02:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B510323600
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 02:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnYKEJnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgIRCRR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 22:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729522AbgIRCRK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 22:17:10 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60F3C06174A
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 19:17:09 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id b79so3944486wmb.4
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 19:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=QXS0/4e7LdUNyM63vhWE3MBoJaqVI20h1RDvIFC9KGs=;
        b=MnYKEJnDLjm6kTi6x1bw3O6wm8lLgwXnxvw450QsElnPKefxRtG1zZS2AhzUai5XQ+
         wk/LCGyCy42SDYzhQypsPMogLs68UVuFuDnQRI4Mpt3wjznhEfrSTQDtGbXUxj2cd3/c
         ea4Ozfc0sbA2PPFYTvhRwKiZd62LwpkmAYKiWCS2ovCPlKH2Mx2vhGN/WoChmXRQl7K5
         /s4m0zkQOvUQGbKFH7ABipie/u9/45B1pK3u7BXPfAkQfdghl2Qm69cEXTlrDuClaxoB
         m+wbEs//wNih0hUddAnucpjxmizxUul7pV3PUmJ+B3LC/OYAMSt1lVg+FaYFuYpCtlHV
         MTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QXS0/4e7LdUNyM63vhWE3MBoJaqVI20h1RDvIFC9KGs=;
        b=mcwElzD3E9GWmbsfDGgBYVuEanKggehOgjhESqirb+N3mxjsymc182FTVCi4MbXha+
         OYlaGh+VjwxUMg5N1/opZ1M8pmOKDn2O5gPWtUfrRKaie+qhuT/Wqo0FLX3LCUcrEjTH
         5S0tnMPFExNRrJ8KxplY0RLcjZ6SKeUEHeYZBI+sos2ntWcwAR8GESzvFJ/ua8luZC/o
         9rdcBMsEPWsMV+L9K3FhcOJ0HhO5j2SaDBLSeFSuytzXU2NUahdvWwgFdfuM+GYvv5Z8
         QsqGtvGVrWzolkEprvJ8eQijJiQN9wJl9+9xMWlzdW3uMsI1HP9YXyvcIsZjsU/EIuV/
         dfcw==
X-Gm-Message-State: AOAM5327ceDC/vxtXcjVl3dEKALhl2yVjLRgqv1IlaR61RYF0lSQdRdP
        WpDPO9ycQwWo8qpxG8WXa98HQdejL2o=
X-Google-Smtp-Source: ABdhPJyGUT4QdQ68Zqzo7l/KfmM3+b0RipzEW1aQbcfHnxrcIUC087sjZwpB4PaDqbdySWaDv9Scug==
X-Received: by 2002:a1c:39c4:: with SMTP id g187mr12491188wma.126.1600395428470;
        Thu, 17 Sep 2020 19:17:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v17sm2511024wrc.23.2020.09.17.19.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 19:17:08 -0700 (PDT)
Message-Id: <pull.841.git.git.1600395427.gitgitgadget@gmail.com>
From:   "Andrew Klotz via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 18 Sep 2020 02:17:05 +0000
Subject: [PATCH 0/2] config: improve error message for boolean config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Andrew Klotz <agc.klotz@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently invalid boolean config values return messages about 'bad numeric',
which I found misleading when the error was due to a boolean string value.
This change makes the error message reflect the boolean value.

The current approach relies on GIT_TEST_GETTEXT_POISON being a boolean
value, moving its special case out fromdie_bad_number() and into 
git_config_bool_or_int(). An alternative could be for die_bad_number() to
handle boolean values when erroring, although the function name might need
to change if it is handling non-numeric values.

Signed-off-by: Andrew Klotz agc.klotz@gmail.com [agc.klotz@gmail.com]

Andrew Klotz (2):
  config: improve error message for boolean config
  formatting for error messages

 config.c                  | 26 ++++++++++++++------------
 t/t0205-gettext-poison.sh |  2 +-
 2 files changed, 15 insertions(+), 13 deletions(-)


base-commit: 3a238e539bcdfe3f9eb5010fd218640c1b499f7a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-841%2FKlotzAndrew%2Fbetter_bool_errors-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-841/KlotzAndrew/better_bool_errors-v1
Pull-Request: https://github.com/git/git/pull/841
-- 
gitgitgadget
