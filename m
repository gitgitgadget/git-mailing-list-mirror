Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E049C55ABD
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E312E20781
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIay9Vyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731735AbgKJVVq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 16:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgKJVVp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 16:21:45 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA58C0613D1
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:21:45 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id l36so129360ota.4
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=udwQE863MDU6iSYqiBMkmiS+h620h7PqpG/YqrVBlnM=;
        b=PIay9VyfVnDgLwdzry2HrGgyp/GXVqkfbfbv5TKxIcl2SCCZvPm8646I1RGFi2mA/v
         XSrC+h+VACwT/VU5un092aGG/Jwzk6S4JlW+E3i7vCmKFeu/KZZmHoR7KDZxyx/GT+H4
         Dim9GND89BYm4pjfa/hfIDxuaxmkNQExU2Q2FwrT/KWcEDanJa/G4+WfjsegaTor0cme
         2PgEJOIFTKsaqKenjpbSfQ6PuUUY424tUgLz8TKiLiKMD7XO6nELcM81u4M9Hzm1qNCR
         v9KfsYbC3iZWggjvEYbDLWM6ruk6BsN1eneSmaE00KZlalpeCRjAnwMyCT2FVnlRBVg9
         7eRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=udwQE863MDU6iSYqiBMkmiS+h620h7PqpG/YqrVBlnM=;
        b=YBf1O63kRrWJL0IjbnTyBeY9ZWMTwA20N+B9w0RHSLzYldzC0aCNcisGQuBvh6WgXr
         VmwgFCKxXcpKdX91vRXhe/HMZnMVCh8LXoAk/yDGwWPHO3l/0rxNyR5cbQOUPl+8XLOz
         IZWhGADhqh4MKlDWBln300xZNFL+m0SyE0gOkHzApRH0txX8BQNLw0ADgqU+brp7Vve3
         +5kx7HxGaDtFGc8ED57yGeo3iwfasGyo2Bk9zzTApcwd+WoQJQqkP5KCFRpNpR6Lk7X6
         FbTfNHbjrmdgtThhidUNDVhzdQgth2opxL0LNR8Wruopvcmmdhr8HjcKa1P7qmzpqkPX
         GQXA==
X-Gm-Message-State: AOAM5314NnXN65q663QOxkn8eTuH2ADiASMYQUyoUNNxDcFMmpoUExYv
        BdXKZsF+PFiS0UMb08xgg6xhEIqHGAlF9g==
X-Google-Smtp-Source: ABdhPJxnc2ZliqIDt3yX1tExq64tcpCCZKPYhF9I+D2ne6hZLx79zR22ZwPzLjiE5y0+Ba6Nh/F+eQ==
X-Received: by 2002:a05:6830:441:: with SMTP id d1mr5807984otc.337.1605043304509;
        Tue, 10 Nov 2020 13:21:44 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id g8sm3391850oia.16.2020.11.10.13.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:21:44 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 02/26] completion: bash: add correct suffix in variables
Date:   Tue, 10 Nov 2020 15:21:12 -0600
Message-Id: <20201110212136.870769-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201110212136.870769-1-felipe.contreras@gmail.com>
References: <20201110212136.870769-1-felipe.contreras@gmail.com>
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

