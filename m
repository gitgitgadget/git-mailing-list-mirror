Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45894C433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 288DC61A7D
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353611AbhJAKjx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 06:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353615AbhJAKjp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 06:39:45 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC452C06177B
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 03:37:58 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id j27so6905236wms.0
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 03:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uZUy7r/89cvpRYs0dIEWrGPsVFIXq07QSSGpSLmfwYw=;
        b=LmaLfArW9Aswby8p9mxNItTo6XyObxN24pU3+L4812ZHbJOakNWYGUGEzD2cXVSasO
         wokU7dmh379addmLbS+unuWZH+dBTCkVS9YGgG3dKk4rJDY5/qUeGIQUi7tqOCz6H8tl
         6u+xfv/AaFcOHj5eVLdjNo+g8gH3pf1PeKj+0RafVGv9/cVmOJ7uaha9Lqqwwud7sGvE
         xcg1crMI1ySHKzRF+3XfodskSZviw9g+V2OXyZzHrgJ2uY5s/NtGSW0YLHhRHdDXMsZ9
         HufibJZPCSxAULEs6iGuqfvBxrP75QJ9Kw4qGRgaqTg1TV3H844TO9mxjyEceVFJ10EL
         D44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uZUy7r/89cvpRYs0dIEWrGPsVFIXq07QSSGpSLmfwYw=;
        b=ZpQN9m4Am143jHXpsLvLz9xnCWWDS/faj4FFBUTlv/s+kcPfqy85Eg13myhEyeI7Vu
         8M0eA6UKe32anTCsH1mR9CawU4ccIyzdgvAuXAZsvA9NyB7lslO6MgHb2ChQf/b7WVSy
         R6xhXZx+Wyt5c8mEmV2WCfKyWpZ+vtvRtc2uA2Z4ptOcho64xhaVZp4WIq52DISoF+65
         O4XtHsBfstTbvGnPiaStMRyKu9c7wBdVr6soVJsOKzBkbgAfEO33euuLKjyXPsxLRg0R
         YBAtWAwqPUHyC4uhiKFpsAgh04uIL9cIkEWn7TqRrSOLkQlZ3b4vtDBhSJQ//gwo9jGB
         Y1wQ==
X-Gm-Message-State: AOAM533vwz3NK415URUdaetw3bLwBTa4Pr89yaqEB7uzVeHEpu0UME+K
        +53HFgxgvq1GEGIQqR+A1/U4M7zDmHs+HA==
X-Google-Smtp-Source: ABdhPJzLOOuceVg8keCkJ9vyUkeWzxkmZ0sGdi+8TrLvhCvQM5QlHeqWdIx/eMZyOFD636bHoaVb6w==
X-Received: by 2002:a1c:4e16:: with SMTP id g22mr3497286wmh.171.1633084677050;
        Fri, 01 Oct 2021 03:37:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k10sm7235586wmr.32.2021.10.01.03.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 03:37:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/4] config.h: remove unused git_config_get_untracked_cache() declaration
Date:   Fri,  1 Oct 2021 12:37:43 +0200
Message-Id: <patch-4.4-01d53ae63b6-20210928T125228Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1375.gbbd823cc90f
In-Reply-To: <cover-0.4-00000000000-20210928T125228Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20210928T125228Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function was removed in ad0fb659993 (repo-settings: parse
core.untrackedCache, 2019-08-13), but not its corresponding *.h entry.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 config.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.h b/config.h
index 147f5e0490e..7378fc165fb 100644
--- a/config.h
+++ b/config.h
@@ -609,7 +609,6 @@ int git_config_get_maybe_bool(const char *key, int *dest);
 int git_config_get_pathname(const char *key, const char **dest);
 
 int git_config_get_index_threads(int *dest);
-int git_config_get_untracked_cache(void);
 int git_config_get_split_index(void);
 int git_config_get_max_percent_split_change(void);
 int git_config_get_fsmonitor(void);
-- 
2.33.0.1340.ge9f77250f2b

