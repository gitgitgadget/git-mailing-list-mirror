Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34663ECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbiH3JeL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiH3JdI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:33:08 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6226E193F
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:40 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-11e9a7135easo12874152fac.6
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Xs7RKtRo2OpXdWWIGm4+Iq5x9rk9iFK6sJU7xTXkLtU=;
        b=SDmghbX0ZUcLPWzbKnlK54jp/eWE1jFjr2NDLSCCjdtIR/ICs2DX1nz8kgO/WlFWf5
         08EHA6iMRJREjeGzuu74szNt7tCBs/lB6eOUMN0z5IU6UwGfor070hJw2DMLHgh66PEy
         wlXoX3vPj4qh02WItjfqVD28Oh9/HhiMIdz9YvnajSwlTm8PQgy6eVbieJNpOGPIq5RF
         7w7hkosukouDXoSlUBLI2jPt8aZaMmchDJgvQT+zOplS6umBi2FiPbwRiG2uSiQyB5tG
         TVge5AkUWIgPbOehJ9rN4l4hiSFrO8DyKE5kKPAeJqnq+881WJdD3tnHtJIvjx1L38gl
         NSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Xs7RKtRo2OpXdWWIGm4+Iq5x9rk9iFK6sJU7xTXkLtU=;
        b=uS588woBsON401Ew9fWjuBmVLPdKUpIdFqQB79pI8cQA7gJv7iWV9kIp3yVeZvdcMB
         I83n4Pjjq9y0Y9p3P/pP4TkVUVLfmzQbQYOVtdrTPbss+f50OODWmrnrlH4VBcb4f382
         REOVNKbyVwOvMyTMTAg4Qez/FEuR4G3068T2ltz7lJf479bFYmLrpqadKSnMBrpSmbzl
         jG3h9d6rR6v/r+Gqmy3TDj6QX2ToSb5zwCI0FqOW5llSCnnKfpcXqYFhYBAd3szI4Xf5
         PFVBB93kOojsxKYZh+TtoX1YjRLq/OJfAnC41LFlTo8ZoshmOqtyI1RZi3QpaLNTerKC
         LVWA==
X-Gm-Message-State: ACgBeo0Xzexn0f5Ge1Smb32hH9eSQ9TWV03J9aicjouinLgOXLMgPvBZ
        M1wABI6Z1TbkTVXUrvZRQH25QhO+QPQ=
X-Google-Smtp-Source: AA6agR6N6fQo04Y9fk7eP9Nl1Zk/C1KzRQPQQgkBo+Q0mnMFQnWrRMunW2KlJGk6zMwlyYIrOtGeyA==
X-Received: by 2002:a05:6870:310:b0:f1:f473:a53f with SMTP id m16-20020a056870031000b000f1f473a53fmr9679318oaf.34.1661851958666;
        Tue, 30 Aug 2022 02:32:38 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id x11-20020a056830114b00b00636d0984f5asm6943133otq.11.2022.08.30.02.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:32:37 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 34/51] completion: bash: simplify config_variable_name
Date:   Tue, 30 Aug 2022 04:31:21 -0500
Message-Id: <20220830093138.1581538-35-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now sfx is never null.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d43ec03c12..9e15538f53 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2611,7 +2611,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
-		__gitcomp_nl $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "${sfx- }"
+		__gitcomp_nl $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	guitool.*.*)
@@ -2645,7 +2645,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__git_compute_all_commands
-		__gitcomp_nl "$__git_all_commands" "$pfx" "$cur_" "${sfx- }"
+		__gitcomp_nl "$__git_all_commands" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	remote.*.*)
@@ -2661,7 +2661,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
-		__gitcomp_nl "pushDefault" "$pfx" "$cur_" "${sfx- }"
+		__gitcomp_nl "pushDefault" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	url.*.*)
-- 
2.37.2.351.g9bf691b78c.dirty

