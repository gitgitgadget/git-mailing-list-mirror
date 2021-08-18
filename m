Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998ABC4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 13:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8235F60FE6
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 13:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238441AbhHRN2v (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 09:28:51 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34682 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238474AbhHRN2J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 09:28:09 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DBCBC1FFBF
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 13:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629293253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=HRDxRM8XAsDcP6ET3nlP6tLHGO8ijk43iRgz+v8sHwM=;
        b=Dax70B63Q6p3ig8E/qVaRrfAa7WzliOEQFqR1m0sEA3Hs6UP5R7y0+HrzSJjCZE7SRrHxL
        P8Sb4/PJ0sT9fkadv3/zTnXLhPTwSrdyV/OBsn2NQ8fZVQ79u2wqN0IUvJOsa0Jv0euuA/
        f6HAoHZTCR6ZXyJ2z1qIrpVodMcB15Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629293253;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=HRDxRM8XAsDcP6ET3nlP6tLHGO8ijk43iRgz+v8sHwM=;
        b=N1ygpAAvlnVPvCzXHX1yBKLqPPm6RGsjG8g7PHOZkH+t9HJgko8gY1PYeRAT5uHtqxGoQK
        FhGdcrSQKJNMYNAg==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
        by relay2.suse.de (Postfix) with ESMTP id CB9A7A3B94;
        Wed, 18 Aug 2021 13:27:33 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     git@vger.kernel.org
Subject: [PATCH] completion: tcsh: Fix regression by drop of wrapper functions
Date:   Wed, 18 Aug 2021 15:27:29 +0200
Message-Id: <20210818132729.26021-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The cleanup of old compat wrappers in bash completion caused a
regression on tcsh completion that still uses them.
Let's update the tcsh call site as well for addressing it.

Fixes: 441ecdab37fe ("completion: bash: remove old compat wrappers")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 contrib/completion/git-completion.tcsh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.tcsh b/contrib/completion/git-completion.tcsh
index 4a790d8f4ec1..ba797e5b3cd5 100644
--- a/contrib/completion/git-completion.tcsh
+++ b/contrib/completion/git-completion.tcsh
@@ -80,8 +80,9 @@ else
 	COMP_CWORD=\$((\${#COMP_WORDS[@]}-1))
 fi
 
-# Call _git() or _gitk() of the bash script, based on the first argument
-_\${1}
+# Call __git_wrap__git_main() or __git_wrap__gitk_main() of the bash script,
+# based on the first argument
+__git_wrap__\${1}_main
 
 IFS=\$'\n'
 if [ \${#COMPREPLY[*]} -eq 0 ]; then
-- 
2.26.2

