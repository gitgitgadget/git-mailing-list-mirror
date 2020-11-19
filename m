Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C538EC63697
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 01:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61DA5246CA
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 01:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5GmMFnf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbgKSBwR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 20:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgKSBwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 20:52:16 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C05C0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 17:52:16 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id 79so3827347otc.7
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 17:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=udwQE863MDU6iSYqiBMkmiS+h620h7PqpG/YqrVBlnM=;
        b=G5GmMFnfo3ckjKjuE1JvytRWr3pPSMYLSi7AxyPcqtb0X1Lrn9m1fq+/HWw4KT9NxN
         oQCYCV1274E7kiJFFCO9Jgikz+u1V1xEu/tD/qIHsXzF0FSFOGph58iM/KQlvNaTySGb
         yH6zbwi/0+ZMoypFF+oDtFFi+8qtFpGce/ixacLjIK3Nu7P39u2gpnaDd2EaF+VE0a8F
         fgO9VQ1LyyuvPL1pzu0y61zOXMMSjiLO70DvlYsSNEVgwWjCWh2//QL2LdE4GCIirj1M
         ovMERjq11ByG0NOXbvM+9RUA3nfGru2jp9KS+WcHBabAofxgjKvYb3vjYy9EVdCE+T4Q
         jzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=udwQE863MDU6iSYqiBMkmiS+h620h7PqpG/YqrVBlnM=;
        b=q/dw6wWSrcznL4vWNoHCbE54EIaFz5Z7DwbzbBc1fMoV0FFU4QW2dSzBFzPXFP5xc7
         0OjOj+PS/wkXWPWGpD6paKNZw2GgLm5ZFWwNDBU/bdDE0Hqw26eUfXrOfgo4Q3upGzol
         4065yLqWPvCsfck5kxacz62Nef99rEj0vkeM45X75zBsEXrlbBa2vg0Dhe5ftCMsH/lH
         /MSYw7tV9PGW6AmBiFwSy1fjf+LJj52ZREqthGW+Fyh/tWnY9t/V7vuRQ5eHiEy27TdI
         LKf3SpEZHzsJbZ6eD9rWG5lOlzEpUBg7aAj/AF4SFST/kFYsKOf1X00zH1FpZdE1dAYO
         4p2A==
X-Gm-Message-State: AOAM531FIPdo8H+WHMPYJqIPwygZHWwfvvP0mqv7QrPLH4ZWL/9VyOJ5
        FIhYrT9MkpPv7dt8CjCeVCa9OfCOehepAw==
X-Google-Smtp-Source: ABdhPJyh6d71S/xkRmGWPKH/SH4oeixkU9oaySoGhiHTC+gX+MQ2JEtwYrD4WkeSRF6aK+7hSl6pbw==
X-Received: by 2002:a9d:5549:: with SMTP id h9mr8846475oti.230.1605750735387;
        Wed, 18 Nov 2020 17:52:15 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id t199sm8634706oif.25.2020.11.18.17.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 17:52:14 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/4] completion: bash: add correct suffix in variables
Date:   Wed, 18 Nov 2020 19:52:07 -0600
Message-Id: <20201119015209.1155170-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201119015209.1155170-1-felipe.contreras@gmail.com>
References: <20201119015209.1155170-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

__gitcomp automatically adds a suffix, but __gitcomp_nl and others
don't, we need to specify a space by default.

Can be tested with:

  git config branch.autoSetupMe<tab>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 6 +++---
 t/t9902-completion.sh                  | 7 +++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b866b68b3c..bbdb46d87e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2618,7 +2618,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
-		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "$sfx"
+		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "${sfx- }"
 		return
 		;;
 	guitool.*.*)
@@ -2652,7 +2652,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__git_compute_all_commands
-		__gitcomp_nl "$__git_all_commands" "$pfx" "$cur_" "$sfx"
+		__gitcomp_nl "$__git_all_commands" "$pfx" "$cur_" "${sfx- }"
 		return
 		;;
 	remote.*.*)
@@ -2668,7 +2668,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
-		__gitcomp_nl_append "pushDefault" "$pfx" "$cur_" "$sfx"
+		__gitcomp_nl_append "pushDefault" "$pfx" "$cur_" "${sfx- }"
 		return
 		;;
 	url.*.*)
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 2be9190425..4a3d3d1597 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2293,6 +2293,13 @@ test_expect_success 'git config - value' '
 	EOF
 '
 
+test_expect_success 'git config - direct completions' '
+	test_completion "git config branch.autoSetup" <<-\EOF
+	branch.autoSetupMerge Z
+	branch.autoSetupRebase Z
+	EOF
+'
+
 test_expect_success 'git -c - section' '
 	test_completion "git -c br" <<-\EOF
 	branch.Z
-- 
2.29.2

