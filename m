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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E58C433DB
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 14:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D894D2255F
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 14:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgLWOt3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 09:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgLWOt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 09:49:28 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC9AC0613D3
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 06:48:48 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id n42so9254789ota.12
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 06:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yzgVh8q72e5lcVm++2IIzif8zM7VA/v9GcMX12EZvI4=;
        b=qTGe4qx+osG+RhdivIR/Z27aHJDF05dHjWB697D7obg4u4GZSveThPNc8cob/jtl0A
         6uh01ruVNv5NbDNATk3GDtxwE9cd1cjLDorwxCYiSI/Cv9EglOkqz/ym04BiBPRlBbIO
         2/hUYO/nfH31cW6YZfDu+VM8JrwvEiBGJMsFN8hO40sZMP7C6CUdl/Q3ONIz92bs1e4U
         9zfgl3dC99kyIXwTe5fmOwV5VhorSp/yy4DdYdx78zqUQl98JQV/NplRnfc50lchkZBR
         3uPnIiNYYp/xbU8debVFOig5/dSJDwzAVE717DfytpSoIvwI9mBf6MoN94XkQVlIBwb+
         A+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yzgVh8q72e5lcVm++2IIzif8zM7VA/v9GcMX12EZvI4=;
        b=JlEqKxS2QATrZ9GyDWsphiG8icKJbtDOQSg5sUX9yNUPPdmhSuXlzNBVMRoZdSyY+M
         hY0NYLtFYaWoGggNv7faGjTnEKoEVEfoXksaL1zkk0E7xDQMyFE80P+BQ76R5hwWDv++
         j8vy35jxZWnEeUysfC045k671Q8TBEC6I9GgkoGeN1M9hX5DwV3JIJah9NXOvfPI7KzE
         OA2gBwksWq0woss5SmjumU5AdKbGGtH8NQQvPeiZSlp3lKhuTpfbkLHn7doFdN4UpNKP
         9di52yVkpWRtS+oX4uvzJgXQdoWeuijGX6gf2bP8emUEE6NkLKPIze8ciAumbewvlyNt
         QeMQ==
X-Gm-Message-State: AOAM532RuBaN5a/dIPAz0L4T7/OBv0zNKNkZbE7wvwn/TJKgwgSs+whm
        PSuY47uT5sd+XivcVmLXPdAIZXXwD5566A==
X-Google-Smtp-Source: ABdhPJzNUpxtOW+qJzPD1/pacNCzbKWwlgkT1vIDA3lYNXCEZxg/bl1driv5OQ+9GMWKvA8/REmXoA==
X-Received: by 2002:a9d:3d64:: with SMTP id a91mr19198477otc.144.1608734927776;
        Wed, 23 Dec 2020 06:48:47 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id i8sm2909690oih.2.2020.12.23.06.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 06:48:47 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/4] completion: bash: a bunch of fixes
Date:   Wed, 23 Dec 2020 08:48:41 -0600
Message-Id: <20201223144845.143039-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0.rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These should be pretty obvious and straightforward.

Changes since v1:

 * Removed test for suffix in variable names

Felipe Contreras (4):
  completion: bash: fix prefix detection in branch.*
  completion: bash: fix for suboptions with value
  completion: bash: fix for multiple dash commands
  completion: bash: add correct suffix in variables

 contrib/completion/git-completion.bash | 14 +++++++-------
 t/t9902-completion.sh                  | 15 +++++++++++++++
 2 files changed, 22 insertions(+), 7 deletions(-)

Range-diff:
1:  26bbb19677 = 1:  dd49b0e680 completion: bash: fix prefix detection in branch.*
3:  aad0bc6a0f = 2:  6ac184b9a4 completion: bash: fix for suboptions with value
4:  77a4b0b0d0 = 3:  960a692fda completion: bash: fix for multiple dash commands
2:  4bcc8a5fca ! 4:  a95c3edaf9 completion: bash: add correct suffix in variables
    @@ Commit message
     
           git config branch.autoSetupMe<tab>
     
    +    This fix only works for versions of bash greater than 4.0, before that
    +    "local sfx" creates an empty string, therefore the unset expansion
    +    doesn't work. The same happens in zsh.
    +
    +    Therefore we don't add the test for that for now.
    +
    +    The correct fix for all shells requires semantic changes in __gitcomp,
    +    but that can be done later.
    +
    +    Cc: SZEDER Gábor <szeder.dev@gmail.com>
         Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
     
      ## contrib/completion/git-completion.bash ##
    @@ contrib/completion/git-completion.bash: __git_complete_config_variable_name ()
      		return
      		;;
      	url.*.*)
    -
    - ## t/t9902-completion.sh ##
    -@@ t/t9902-completion.sh: test_expect_success 'git config - value' '
    - 	EOF
    - '
    - 
    -+test_expect_success 'git config - direct completions' '
    -+	test_completion "git config branch.autoSetup" <<-\EOF
    -+	branch.autoSetupMerge Z
    -+	branch.autoSetupRebase Z
    -+	EOF
    -+'
    -+
    - test_expect_success 'git -c - section' '
    - 	test_completion "git -c br" <<-\EOF
    - 	branch.Z
-- 
2.30.0.rc1

