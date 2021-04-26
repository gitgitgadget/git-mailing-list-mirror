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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A4AC433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B8F361164
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbhDZQQF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbhDZQQE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:16:04 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8A4C061756
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:15:22 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id u21-20020a0568301195b02902a2119f7613so5690212otq.10
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JAVw9eVU+ydJZBoZop+F0mxI4d9bqq+1T45uqXAJK+Y=;
        b=CdTM/9/iBDwwFbLIZfQKT3EvInRCsGB8g1/DMuCSPdmxy7nGxbq3lsQWP7e9bObRJy
         AJ+oudrsRqYkPhqolxUOpum4DEA1IvFRiNcHxE8wal/aKalumDxs7L1W4BYMIGb7W+CO
         B/qYTzOtnlqd+EprT8NYXkKUQFk6QFP3NdNI9S7z5ykZiaLOzXZXdJ9TeByXq40upEEd
         LWGwRbnO8dHOenXKGCn7cUw3wd7+r3JjnzvRb2MFRexLdRpa20PP6U+8kBQsSZkELBgX
         5Vjk2KNfwyW6/Xu5fCfh8ofeeZKPOt9YrcAc4q7Uz26p8iTOwEEoXT9oxugzBzfst96f
         Ysrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JAVw9eVU+ydJZBoZop+F0mxI4d9bqq+1T45uqXAJK+Y=;
        b=DDwFkAZepN5BXce5DaEFBctOgmf/ITbowUT4sK3n3D1yleOUX7JK8gfGefQqHuISBp
         of1D0VPM2Ls9BqkYKFV9oqrhUL19PQ7YF8CG+qgqjHj9Y3XEqWlPzHtdC6PGN+4oOLkT
         kc+nY8TPbuq29t5CVMa9Si8YR0KiIaayMmU/Mr1+4OrDSlzh24WQ34OAsELjKYkBBYhx
         U2gVID0UlFKQmUTP8nEXCxaKXA4n9xCqOuvvjtZ38w+JxiFFspVSUSV35GZcjotJUxbF
         mFodVQLNzfprFIbESzZ6iuesY9vlHFAOozfz/DEyBbnaZx8Gof+38ixy/TXfjjy5jGa/
         iTUQ==
X-Gm-Message-State: AOAM531Pk9gUV6ZEz/9A2fpV2r+jQvikDqSNYS9dgPXi0TgJU+FZNlaJ
        BR7583mLiSN7wxmK/ihqqTks/zc2AzrDOg==
X-Google-Smtp-Source: ABdhPJzYoFFKGoyuV0+VQLnOY/Ie8zUr1jjuHurVb7p4uFFV0rYDP5Gh2R1sUAqvIq3ayDIMNiMDbw==
X-Received: by 2002:a9d:5c87:: with SMTP id a7mr15596151oti.292.1619453722055;
        Mon, 26 Apr 2021 09:15:22 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id v128sm222236oia.44.2021.04.26.09.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:15:21 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 04/43] completion: bash: add correct suffix in variables
Date:   Mon, 26 Apr 2021 11:14:19 -0500
Message-Id: <20210426161458.49860-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
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

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index bc19792a51..0706f1e304 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2647,7 +2647,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
-		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "$sfx"
+		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "${sfx- }"
 		return
 		;;
 	guitool.*.*)
@@ -2681,7 +2681,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__git_compute_all_commands
-		__gitcomp_nl "$__git_all_commands" "$pfx" "$cur_" "$sfx"
+		__gitcomp_nl "$__git_all_commands" "$pfx" "$cur_" "${sfx- }"
 		return
 		;;
 	remote.*.*)
@@ -2697,7 +2697,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
-		__gitcomp_nl_append "pushDefault" "$pfx" "$cur_" "$sfx"
+		__gitcomp_nl_append "pushDefault" "$pfx" "$cur_" "${sfx- }"
 		return
 		;;
 	url.*.*)
-- 
2.31.0

