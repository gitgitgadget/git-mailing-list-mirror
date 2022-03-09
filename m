Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0987C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 13:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbiCINTd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbiCINTW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 08:19:22 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C52179260
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 05:17:58 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id r9-20020a1c4409000000b00389d0a5c511so309900wma.5
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 05:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wiiWAv+I10fNYVvilUo6mIoqTGFBIvQCkCEdKqwlSjI=;
        b=fLDJNlLhhChz1UWcwBA927wo6s21TVqJ8igog/8RWI1nq8aJMqRqy4I2GTYZvAAQ/+
         wftmASmt0ORX+YjZfwzoJweHxpRFE1H/IMl+hBcnzK/hOjk1mul8QecW1LVvLGoMugSP
         tpLw01kD8fpQ/4AIRThmOxix6O2ouXqO5WR5t6ol2/TI1yDRG+8ZWs/RE5iL0K6UFJ0n
         MhnZ8T80BH5aipW8aKwO5cJ570fmjupbMrMEQpGPPL3fdB/EDf7DvQqCfmcZk8Yu2vkB
         RREMztA4UhyEgJl0ObrGKDmhZppKXxmhVoarMxv0Ont5TTitv8yCLHNFnnv4xF1ph51O
         0OYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wiiWAv+I10fNYVvilUo6mIoqTGFBIvQCkCEdKqwlSjI=;
        b=U5nwWeKjNFTVd45b4w31XaziXeqhEuMfFO1vBGhneZAdnzIdMLFnGeHobIsyxRK1Mm
         NnJWxk6X9PE7BnEWYbkJiVFnzNHFYI7FDbh3iCPjCkXdUY67xwjEHM1BKXOYKEfBeYEB
         iqqc6NTziKtZCLJSUG+SKcqbAzFN1udGgBzc2VO2Jj/KbpZ6aa68FSegtA/Ie/PaxnV/
         uLlZX11iEdVZ8x6QYfBAVk4nMdh9/WPwJcK25rWO66JSEYreMCQY5aheAFO2oXZg2WGY
         hAn9ZJGU1g/ctOxbT05lOZWzkKn4OgXChh8QNxFD/vAlf9n1hTIf3Fh7ScjOe3J+/qLb
         zEvQ==
X-Gm-Message-State: AOAM530H8Yzg8PlahTsXtUGezBDu9BDVZ7mwMWpEYZis/XfueaGknWCB
        CfbHOU/zWB16ybMX6gLwuqOVxCn2MbrseA==
X-Google-Smtp-Source: ABdhPJwNnYKM84wd79FLJ9EyfNO8CqXS7TAwQqTiSS/t3jgqZuo9t5QnBuZomvxpqz6+vF8OPke7xw==
X-Received: by 2002:a05:600c:3011:b0:387:a08f:44d8 with SMTP id j17-20020a05600c301100b00387a08f44d8mr7597492wmh.59.1646831877125;
        Wed, 09 Mar 2022 05:17:57 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm2599988wri.0.2022.03.09.05.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 05:17:56 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 15/24] revisions API: have release_revisions() release "commits"
Date:   Wed,  9 Mar 2022 14:16:45 +0100
Message-Id: <patch-15.24-4a0adf6fd00-20220309T123321Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1295.g6b025d3e231
In-Reply-To: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the the release_revisions() function so that it frees the
"commits" in the "struct ref_info".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 revision.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/revision.c b/revision.c
index 831f2cf977b..475901d77e3 100644
--- a/revision.c
+++ b/revision.c
@@ -2930,6 +2930,7 @@ void release_revisions(struct rev_info *revs)
 {
 	if (!revs)
 		return;
+	release_revisions_commit_list(revs);
 	object_array_clear(&revs->pending);
 }
 
-- 
2.35.1.1295.g6b025d3e231

