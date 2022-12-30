Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3EBC4332F
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 02:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbiL3CTX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 21:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234319AbiL3CS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 21:18:56 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBCC1704D
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:52 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id c17so28840114edj.13
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SvFYXt9ZKBMVGx//NwLoFy5ZCj83eS9eIuWeWGABmc=;
        b=YBpGv7x1iH4urbmUxwM2oUW0PkxrHYpUyWXNbf49cuIvB/tfAWB4ZEPQLf5fYvy1ZM
         hdEeBlpZyVzCEQLL5uSKHZbFzPod6PoHG2MEr5TOLUCrzHBwOKP/BQtCDG5V2anDpRn+
         L2MEM1bRNF/YEoLBT/J3ECdyBmzQMNpfI4RL8E5sycjkypT8TrS1OctaeiZr94YNtQvc
         yVsRYRjQ9wvlQE4YZ2uNWiLgnWmnrma/QSD2frt+99RZY3b66CpnCa2y95RfJqeb6F4/
         AemDd8g04io+CU/5WcyX6hKTYmqs+ZG4JgSayN1yS7LvWsZOqSMIfWX/DVD+aQz3BMaa
         MfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1SvFYXt9ZKBMVGx//NwLoFy5ZCj83eS9eIuWeWGABmc=;
        b=alQYqhG7QrdyOdiRnnDvLTGb8Aiwi7GDwiEHpEtwLnENR+9/cPQjvWUER/prYpqoo1
         PCFLMi5gqulu/pfsYZcIXLni8uS1MvOBXJTbib4ZQqSWR0jIWypySHfrSr6DNTR0/Emh
         LpVNb/sCrBlvbWcmQj/gRbucfpmgfBzeYJVEUBRCT6vZPrmwfk1T3l/Zx77oPFiQkCIu
         Fx77cNhqHdN5qagWf+icgDZFO5baEKSCWlt3Bnkp/B3J19ZXMgb7Kbs3OIP9W1RRwBNj
         GNqCKz1F6aWSsES8eEit8cWRNW3RwB8JImWTeI+y2WImepUYE+HxwI1iT0aYVuTlUWI8
         GqjA==
X-Gm-Message-State: AFqh2kpwPc4CfmnNUKV4jf69L8PSxutA+IWx4ImyEbg6u+e5p4YdCfo4
        sOxgsdgG2GUSgL6NbONi8WZ2Qgd5225DgA==
X-Google-Smtp-Source: AMrXdXsgcUNBHvD6lGouWOth2Wslr2DUOlYJyZTTAsMDapidFfkAsdowsvtEotAX6Tbz82wk6B7lfA==
X-Received: by 2002:a05:6402:1149:b0:482:d62c:cde with SMTP id g9-20020a056402114900b00482d62c0cdemr18171316edw.13.1672366730533;
        Thu, 29 Dec 2022 18:18:50 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay15-20020a056402202f00b0046dd0c2a08esm8861991edb.36.2022.12.29.18.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 18:18:49 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 12/20] show-branch: free() allocated "head" before return
Date:   Fri, 30 Dec 2022 03:18:27 +0100
Message-Id: <patch-v2-12.20-bf0e9bc5fa6-20221230T020341Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.g589e4efe9dc
In-Reply-To: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com> <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stop leaking the "head" variable, which we've been leaking since it
was originally added in [1], and in its current form since [2]

1. ed378ec7e85 (Make ref resolution saner, 2006-09-11)
2. d9e557a320b (show-branch: store resolved head in heap buffer,
   2017-02-14).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/show-branch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index c013abaf942..358ac3e519a 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -956,5 +956,6 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		if (shown_merge_point && --extra < 0)
 			break;
 	}
+	free(head);
 	return 0;
 }
-- 
2.39.0.1153.g589e4efe9dc

