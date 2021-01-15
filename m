Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C47CC433E9
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 19:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7E2B23A9C
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 19:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388563AbhAOTau (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 14:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbhAOTau (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 14:30:50 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD167C061757
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 11:30:09 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id m6so6119639pfk.1
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 11:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nMIvUaXJ5t+dx3aBVIr9yKIhiMDudr1kJ+KV8u/tMSM=;
        b=JwzGcjf1ZCaQ6IjZe5NThhXt6OeJxvG5FdWvJ/wSTNF4F/289R8bP/1lVErx39mCvp
         f4HOd9uiyzwTaGBLR2hWR3veq/GRozt1ZaKeVn7Gx2mHNnxqmExJufw+xfdGkQN6G3t+
         yzLtJf+F0UkdrOovwtTyero0loJYKjczJ7uxnbQ7k4kDngDD+01vfUEHlF4vcmIWy+4P
         J2k+tigVJymfcfqrd4zf4ArIm/L5KLvSSdHmol5fpZH8JdJymhdKydeY9pyGz7XFjQIO
         WA9DVnOPYEY61Rc3GO04VLCvUOoz5QW40AXCUpZSplCxZO0I0WOhZLc6xF1P8w3vzJNG
         46xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nMIvUaXJ5t+dx3aBVIr9yKIhiMDudr1kJ+KV8u/tMSM=;
        b=famfl7Pq6/EdXzSue/pUHTxLYFxnMLZ/JcC/DYfu3bwxqakD1UBuCTScwMaIOTjoNJ
         kmXkFcpqmsyY7007Lv5eswBSfUiMZffLNQ6S5De98fA/eUyotqrASnrDPp2e3fppU+qq
         FoUW9Hs4l6/5EBzydXZUyfBZjxS19BmPY+xbxHLCakGf6Bx1UEpEyjN8GYcnzJYJygkd
         klItRtExYGPS3zgiVZHw4tuAFYapNXjQbjSbtxegUfjiDAt9PBqkalf4aJfdO8517tgM
         3hYTVlU+floRkVKO3JuoWMYUCAdaT+KuTQT8s/bgs4tul22FnD2N0C/Oty+9ltawdpJN
         OK8A==
X-Gm-Message-State: AOAM531YAE2BvzYPwKkAx2lyaWQSVQgwZWCpbIioMlEy0ea7GbNFqqdg
        Kv7gvOjRQXWkLPVm20+bsQwKV678h4o=
X-Google-Smtp-Source: ABdhPJxQnWOsFjH7HEo8CUCmS1ZnpNci10jUubQD0kN6xYHF+WLXDbs4UU2z+O/3I7aCqwmRhWqMkA==
X-Received: by 2002:a65:460d:: with SMTP id v13mr14021134pgq.414.1610739009202;
        Fri, 15 Jan 2021 11:30:09 -0800 (PST)
Received: from tiger.hsd1.ca.comcast.net ([2601:646:8d80:9ab0:f634:2e28:1242:da6])
        by smtp.gmail.com with ESMTPSA id fh7sm8625657pjb.43.2021.01.15.11.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 11:30:08 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, gitster@pobox.com,
        Sangeeta <sangunb09@gmail.com>, Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 0/1] And so it begins...merge/rename performance work
Date:   Fri, 15 Jan 2021 11:29:57 -0800
Message-Id: <20210115192958.3336755-1-newren@gmail.com>
X-Mailer: git-send-email 2.29.2.551.g3e6b12e63d.dirty
In-Reply-To: <20210113221158.2869128-1-newren@gmail.com>
References: <20210113221158.2869128-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This depends on a merge of en/ort-conflict-handling, en/diffcore-rename,
and en/ort-directory-rename.

Changes since v2:
  * Add another step I forgot in my testcase setup -- setting
    merge.directoryRenames (noticed by Sangeeta); I've double checked
    that I didn't forget any other settings.

Elijah Newren (1):
  merge-ort: begin performance work; instrument with trace2_region_*
    calls

 diffcore-rename.c |  8 +++++++
 merge-ort.c       | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

Range-diff:
1:  8783f209ef ! 1:  644f458c01 merge-ort: begin performance work; instrument with trace2_region_* calls
    @@ Commit message
           $ git mv drivers pilots  # Introduce over 26,000 renames
           $ git commit -m "Rename drivers/ to pilots/"
           $ git config merge.renameLimit 30000
    +      $ git config merge.directoryRenames true
     
         === Testcases ===
     
-- 
2.29.2.506.ga68ba46ed0.dirty

