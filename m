Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AF6C432C3
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96B7A2242A
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbhAMWRP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 17:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729280AbhAMWM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 17:12:57 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A29FC061575
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:12:15 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id s2so3852691oij.2
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tSbjddZt6HAXXQf0DbscVa52Ekm5xCsCzs1IAsRq9xE=;
        b=Q8aFWNZ+ma//E6Q3JE5pNEWgBcImcaQOKkR+iWmiW5JbkEsEC+k+WIYSLPiY994wGJ
         ezlVwy9Mp4srLXobPkzeRtPmiy5UpmiL3EVSbsQP/Ein7jF0QNTdJOdft5xhpaee7Eu5
         hX5mZm3tjM/spD2R4Mictgcyc6shquDozDlKufcab/JHesvdQmVRjEBUvdujwlDN2mRL
         9gL/Skm3Yjz7FsB9OFLZMdUYW+qmaGDtW40K91cP3EGBAT78V1SHS/hrf6DNmzmReDK4
         Nnay6SoVpA+Syl6BaiW/CWXxKPZgTMHiuMZ4Eh5sSdSkxdMxokwGiwgWfd9tb+jGUJLB
         yFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tSbjddZt6HAXXQf0DbscVa52Ekm5xCsCzs1IAsRq9xE=;
        b=BbRQv8WyXtXPJiI50onTEcQ6kICBPFrE0AtRfsXBYZyg6IAF1RsJyv/43R2bYWuX9P
         gnlK/h6fvRN14A8XRUKxj5PfE9sYlcIsp+UNdrrAvXQ4fSn/z87e/I97h3dBgffAXpmw
         b4c1PB/RHubRYaGE9c/gBC2MTNC8bJTmWzTbORyXiMm409Jcc5DfUAMIxkfTsB33PMoe
         JEIH6tEU6gi2pi9mAjJtV05IWBO/zC/VkgzNWrve+pNlEkuWKIIslFfz/Y08qkJ8twOu
         FQbX6xiER/Xr5rDrcK7WxCJB/5OZ5rY1OWrse4xQS/Lw2/CyeXjCb571LlncOgZer8s3
         baTg==
X-Gm-Message-State: AOAM533MQkDui+vj3tcSKTpaYv5F8KZl3WYtOI5MyM0/nXQL7RMMuDJW
        3ACRQkKN5PE9bbfnZ1yfrwbeTuI05tAdHg==
X-Google-Smtp-Source: ABdhPJyX8iJYisVGtkLs5zLMXno1LyKuiRbbeUUghEsT7kxA34PgrI3jMADT2GsmsfnwxJfzHFuz/Q==
X-Received: by 2002:a54:4785:: with SMTP id o5mr827542oic.139.1610575934499;
        Wed, 13 Jan 2021 14:12:14 -0800 (PST)
Received: from tiger.attlocal.net ([2600:1700:bae0:2de0::26])
        by smtp.gmail.com with ESMTPSA id t24sm692633oou.4.2021.01.13.14.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:12:13 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 0/1] And so it begins...merge/rename performance work
Date:   Wed, 13 Jan 2021 14:11:57 -0800
Message-Id: <20210113221158.2869128-1-newren@gmail.com>
X-Mailer: git-send-email 2.29.2.544.gecb49aa127.dirty
In-Reply-To: <20210108205111.2197944-1-newren@gmail.com>
References: <20210108205111.2197944-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This depends on a merge of en/ort-conflict-handling, en/diffcore-rename,
and en/ort-directory-rename.

Changes since v1:
  * Add a step I forgot in my testcase setup -- increasing
    merge.renameLimit
  * Add Acked-by from Taylor

Elijah Newren (1):
  merge-ort: begin performance work; instrument with trace2_region_*
    calls

 diffcore-rename.c |  8 +++++++
 merge-ort.c       | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

Range-diff:
1:  9542932eee ! 1:  8783f209ef merge-ort: begin performance work; instrument with trace2_region_* calls
    @@ Commit message
           $ git switch -c 5.4-renames v5.4
           $ git mv drivers pilots  # Introduce over 26,000 renames
           $ git commit -m "Rename drivers/ to pilots/"
    +      $ git config merge.renameLimit 30000
     
         === Testcases ===
     
    @@ Commit message
           is noticeably faster with merge-ort than with apply-based rebase.
     
         Signed-off-by: Elijah Newren <newren@gmail.com>
    +    Acked-by: Taylor Blau <ttaylorr@github.com>
     
      ## diffcore-rename.c ##
     @@ diffcore-rename.c: void diffcore_rename(struct diff_options *options)
-- 
2.29.2.544.gecb49aa127.dirty

