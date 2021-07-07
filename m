Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C966C11F66
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 02:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5800E61CA2
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 02:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhGGCej (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 22:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhGGCeg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 22:34:36 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FFAC061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 19:31:55 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id h9so1714155oih.4
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 19:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p27hd21DJnwP13hTjgQmrNWzILLH6vxTLByRzwYj+g4=;
        b=fP4N1nx3t8lkg5w14IeTdccMmIqyH4nv3BMIrhwMAgdUbV+ZIjCkvmhW5DcbVmhCdi
         o2ac9UkzG05zDtskHveiPIV0Ss0a62X+7cWY/a77BHFavkxjxERdqB/Ytsh8vHUobv4g
         kzsFittJ0WQnukl3/k51+i9sP3Exn2PO+kVTCqgEHVv7FFr2Z8vJlIhr5GxPFAWv2P3W
         AEoDQwcXtbXQde2edjVdzq/1fiDoJ53bXSKml9z7Z5mrZIrDbGrvKJputNhffxyxZJXJ
         DotxrZKMxqX2ezoNliL/YpUzMQmaLAlB7QQjqSGeW/k24qIc8UgZem/0VUzMNrEOhpho
         ESYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p27hd21DJnwP13hTjgQmrNWzILLH6vxTLByRzwYj+g4=;
        b=Tc0boeygqwsyFh6X7hgVb+O77HfrFzZMFjfat9g+KV9kBI+3z1sX3+uq2gHJu9J/ag
         YuFtqiriwfvGKPGO/vk9Vn3v8BCr+U6DeeUD93SfnFst+F+9fW7E9P+zvoFUiMWowS+a
         4ti9YwZ6joLCz9/cpt4Dj/gjZaFQ1II+vNIaaApa7/Ev+gwUHoGwjXiOZiFWvZPCHKuz
         D9ObqHZmqN01/Ij0l+Ew/gRbs2nU7NanYiHdmeVMgGyA/mLK0NFJRpMjOpU0WtvGFMvx
         tSsvUTDaNeGYQ1QZmqlEu60McMDFgxwMJjMlUfl8O05EyDn9VgFp6uVUyXlqaABSdAqV
         3+vw==
X-Gm-Message-State: AOAM53118FftBmsyroxTGX6u1dlJLijSaW0oH/lWCXhsqImsdRCyrtrA
        ZDH1aF0F01DFytb/lAt7LH+KMG0mhFk=
X-Google-Smtp-Source: ABdhPJxV8s+n1JBmz8AHp9BsAwFwWybwuNCSZGuPRibMeoxW6N3ob73UDQxRBFgoM7IhhMelbHuw1A==
X-Received: by 2002:a05:6808:1312:: with SMTP id y18mr17012198oiv.82.1625625114895;
        Tue, 06 Jul 2021 19:31:54 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id n26sm3231623oos.14.2021.07.06.19.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 19:31:54 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 4/4] completion: bash: add correct suffix in variables
Date:   Tue,  6 Jul 2021 21:31:46 -0500
Message-Id: <20210707023146.3132162-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210707023146.3132162-1-felipe.contreras@gmail.com>
References: <20210707023146.3132162-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

__gitcomp automatically adds a suffix, but __gitcomp_nl and others
don't, we need to specify a space by default.

Can be tested with:

  git config branch.autoSetupMe<tab>

This fix only works for versions of bash greater than 4.0, before that
"local sfx" creates an empty string, therefore the unset expansion
doesn't work. The same happens in zsh.

Therefore we don't add the test for that for now.

The correct fix for all shells requires semantic changes in __gitcomp,
but that can be done later.

Cc: SZEDER Gábor <szeder.dev@gmail.com>
Tested-by: David Aguilar <davvid@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1feb2ee108..c72b5465f9 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2652,7 +2652,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
-		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "$sfx"
+		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "${sfx- }"
 		return
 		;;
 	guitool.*.*)
@@ -2686,7 +2686,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__git_compute_all_commands
-		__gitcomp_nl "$__git_all_commands" "$pfx" "$cur_" "$sfx"
+		__gitcomp_nl "$__git_all_commands" "$pfx" "$cur_" "${sfx- }"
 		return
 		;;
 	remote.*.*)
@@ -2702,7 +2702,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
-		__gitcomp_nl_append "pushDefault" "$pfx" "$cur_" "$sfx"
+		__gitcomp_nl_append "pushDefault" "$pfx" "$cur_" "${sfx- }"
 		return
 		;;
 	url.*.*)
-- 
2.32.0.36.g70aac2b1aa

