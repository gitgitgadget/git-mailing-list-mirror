Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEDBC433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 356DC61361
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353616AbhJAKjw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 06:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353612AbhJAKjm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 06:39:42 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0038C061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 03:37:57 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x20so14723748wrg.10
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 03:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j8gNe7+dtknCoNdZnvFbSWdqy9JPZ0VjH8SyZpKlHZM=;
        b=Zl2czFIaRWByAjSlTjoBrXKctdzJYa4dncwViCsYp3uAOHSassw1U7gYBdFbSJ2e91
         8OaQ/nPeGwCORX2hFn/97+EcvSET93U/wWTQQoq+hGFUO0qif+k04u/vs/TprGsIL1u4
         MCGLCPVgXJuYgXSjPbDCNMZYYHa4hcDZl/+bQ7mjU4D0RZgrow0j26HzVIemQWa7exTN
         T2vkP1UI8wOsKJzz7d3YOZXo+y0yWv5e8CVXbOZ+KDsfomPISiqZ0zGgTbuwSCqBq/cA
         8e2u7KO2dGRv3rQc4I4/w5QWFvLlR7G9MLTSCSu4sbcIz1IeGOQIbevDC+5yWwSZvBLZ
         6bqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j8gNe7+dtknCoNdZnvFbSWdqy9JPZ0VjH8SyZpKlHZM=;
        b=nehsnH7vz7yJk79+qyLNv6KWwj8mxNT/oi/D/9IIYzBY5x+HbWNETYV44ayf8439iC
         idpN5CUzKw60SzxisccWMe4i8E5Zyhpewgow1WZPw+Bux26FfyjP+GWaQmrofwlWtLL3
         zyj8v8WDTjnPYnIYRVcImbjesVVq2O3cVHsaAQ4iSlwnZ0uz/R6/+sY0fY7mDeLmBAd4
         2B1xUi6YRDKiJE4mjBmF7KTGiqhu7M0YuaaK9+DiUkqULuKb+wYATXjmzxDMrkeQPz/5
         /Avd5yzG1eb9Wi29OOxqKveG4KBiuyx+mMQWA6sH6ym6ZVRXjXLJDFzbIelsRCG+DxxW
         1tlQ==
X-Gm-Message-State: AOAM532tEwB2kYx+Q9FcF8AH8TC5z5Pm7tPdV8jjyhGeoHU+qNo+qHXv
        xg1xC9nEXnlLwLpBW+/3EQol/URZV54RZQ==
X-Google-Smtp-Source: ABdhPJyTMZAQiC49THTZ+bLBoV1RjIhJmHCkYXzTQw9ChQ/YyzmMe7/Iri1f8fY0ccxuU+T+k2mwLQ==
X-Received: by 2002:adf:fd45:: with SMTP id h5mr11424767wrs.175.1633084676193;
        Fri, 01 Oct 2021 03:37:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k10sm7235586wmr.32.2021.10.01.03.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 03:37:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/4] log-tree.h: remove unused function declarations
Date:   Fri,  1 Oct 2021 12:37:42 +0200
Message-Id: <patch-3.4-899d5d1c5e4-20210928T125228Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1375.gbbd823cc90f
In-Reply-To: <cover-0.4-00000000000-20210928T125228Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20210928T125228Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The init_log_tree_opt() and log_tree_opt_parse() functions were
removed in cd2bdc53094 (Common option parsing for "git log --diff" and
friends, 2006-04-14), but not their corresponding *.h declaration.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 log-tree.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/log-tree.h b/log-tree.h
index 1e8c91dbf21..e7e4641cf83 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -14,10 +14,8 @@ struct decoration_filter {
 };
 
 int parse_decorate_color_config(const char *var, const char *slot_name, const char *value);
-void init_log_tree_opt(struct rev_info *);
 int log_tree_diff_flush(struct rev_info *);
 int log_tree_commit(struct rev_info *, struct commit *);
-int log_tree_opt_parse(struct rev_info *, const char **, int);
 void show_log(struct rev_info *opt);
 void format_decorations_extended(struct strbuf *sb, const struct commit *commit,
 			     int use_color,
-- 
2.33.0.1340.ge9f77250f2b

