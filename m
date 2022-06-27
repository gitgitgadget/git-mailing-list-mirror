Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D30C433EF
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 18:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240432AbiF0Ssv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 14:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbiF0Ssu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 14:48:50 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F840EAA
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:48:50 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 37-20020a630a25000000b003fdcbe1ffc8so5527416pgk.11
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=XendMsnVeitbfKg8qWPINyBR5Yd1nWPcbyXORqgPjH4=;
        b=BDimUaQyz1ruO/aisy8glVDM2daEGmAAZjULaWzVRPbyivtE404uvJURGKDV9FExlX
         +EGdi6PjajF/VjQ8JSZe/JvDiG5C5hCUOrzwOuk2TIWkRyz1TwCHorQkqyi1zV7vjYcJ
         ldGSMgI3wSRtV/wwM8qO8wL+NVv48oI7+/EN1TBvewgIk9n6C0MoJmfxr3gEnzAwWSpR
         6UlwILB2AyB9l8a0uMlaNkpO7qg2yVsNAtz2SqXvxFEM/WuWQttV/lVw/8EtNLzQfQwQ
         i6ABGTOOGQBAD2LoM5/8t6pgHb3zjyqdEZmg7nqpoGaZwlJJAAZpPNsgNdHDdWvFxrcu
         R1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=XendMsnVeitbfKg8qWPINyBR5Yd1nWPcbyXORqgPjH4=;
        b=2j8QB8xwVKbUE1pRdpKHl6Xdx7K6JkIGBNPfwEAvzfMTU+5mI6VkateanSuaQylDh0
         Z8jL70vEEfelvbNv1Py1CFgHjURJqSZaBIGCqXOpkBfpxNQAtuAUXIp8T9jQd7heqoS1
         Lgrdguu7AwP6r93MI12Qg2iEPBlOutfxzud6M51mC3QGFhRBm27WH/2L+pBICJ98JSvE
         ta8aeh8ZVAExLYnXs2hUraVYGwCmOH6UcFHk0/3Z4l3tpOEFCXyeTPj40RoH0v9vnByu
         Yc4cqvpqLlCdh8zQfvHIM6/oH0IyRGJmr73P29zyYGKPSBmCBUrzzoPOwvjIZUapqbAN
         FZLg==
X-Gm-Message-State: AJIora884t+C64rPtVRzIzcjoXnB7n7uehz0ozjH43bjFJb5lcEN7dS5
        0ZhX1Qgs0cbFFalxCOQwuBqqdmXDuHWiemGJZX39
X-Google-Smtp-Source: AGRyM1ubvDWvD5MuEdtWdldBbErO5Q9SxjBZ9jYVOsy6nIqgDwWKV6IiE86mXjaJo5JwxES6Cyod4u3mzxFbIf2wvtrm
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:92d2:0:b0:51b:4d60:6475 with
 SMTP id k18-20020aa792d2000000b0051b4d606475mr15961998pfa.73.1656355729853;
 Mon, 27 Jun 2022 11:48:49 -0700 (PDT)
Date:   Mon, 27 Jun 2022 11:48:47 -0700
In-Reply-To: <d8c13e56209ebb6d1d3c521b6522a1bc64909108.1655871652.git.gitgitgadget@gmail.com>
Message-Id: <20220627184847.1361980-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: Re: [PATCH 2/3] merge-ort: shuffle the computation and cleanup of
 potential collisions
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> @@ -2314,7 +2335,8 @@ static char *check_for_directory_rename(struct merge_options *opt,
>  	}
>  
>  	new_path = handle_path_level_conflicts(opt, path, side_index,
> -					       rename_info, collisions);
> +					       rename_info,
> +					       &collisions[side_index]);

Is this a fix of a latent bug? handle_path_level_conflicts() is not
changed in this patch.
