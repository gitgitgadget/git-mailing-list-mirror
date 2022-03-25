Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDAEC433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 14:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359419AbiCYOzd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 10:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358573AbiCYOzb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 10:55:31 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B024242A28
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 07:53:57 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o68-20020a17090a0a4a00b001c686a48263so7414723pjo.1
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 07:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2nCuvmp6jJQODTHsi1SXP+sBtiJB9ipLHs0llF1y6cw=;
        b=lU12FIHuIh1masBtchM9RB7zMs7cjBy5D8CeSaGlXsCcrdUTRFCCwOe7l8OZYNxqfb
         KUiLDyNAf+VdwKRWlDcwEeqIT1ujn+19DMbH0pVJhc70dFbsowOPMlkCxgD5DJJedN3+
         mTIza2E6bTqMo05K6GmViT9ZjpSpe7pA0RyZ5+P3GjIX9jTfeJNsVxMJkbgbqqYUrJQc
         ZhZ6xH1t9P40msYULwX1RWQBSldaXTw1w+0nCVQpsGHK5BrTb55JtCpbl1YvEspn4ee6
         3GChdWQ3CA7SC5O/O4inbPtR9tWJQvpaKKydxvWqkniKQp6+4FAj60gPlcGKLr+QDAJY
         RY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2nCuvmp6jJQODTHsi1SXP+sBtiJB9ipLHs0llF1y6cw=;
        b=PcYGP4zcf7Fu2CfVStYNTBJgaMvwyroogRzhEzH6b3RD1Aq6osc1quM150sl9NiRVU
         7kQDZ+6vAuQKXsz47m4wVrSGu1GE95cN5a8LKIRb0xqWb+iBoC85giPRgSJ973j+VY/W
         ZaDCcOV8nYdUP6YLQXX++IteTRCt7BDejjYSsonoB+cwcovpz6S4X3xdK9c9/2pK42ZG
         SlTdp7V3Fw4Wasi6vAAnwItPnAk01YBc/UNwtWqSH3cguygLvgTSjfvVEpEEznxXG8n8
         BQO3s9c3s96yDHeyNxzUlj31Gv0QD+rUcAyP2678cOJ0MYVkDzLd+Cj+n3T38qip1XpL
         Oh6A==
X-Gm-Message-State: AOAM5305F6M3SR7c4FG0vMqeamUJiOvOq5DXI39bl2GUNgJpDK8rB5Sv
        hChEtc9JhdGYHvrGFSmsNN7hVrSFupg=
X-Google-Smtp-Source: ABdhPJxiQ6oco9Jhkodw/HuNn94NkGWzhhGWjeWVQz5dKr/AjK6KpIccvveIfN/+/5A815CaZKfXSA==
X-Received: by 2002:a17:90b:4c92:b0:1c7:a9a3:6274 with SMTP id my18-20020a17090b4c9200b001c7a9a36274mr13859648pjb.148.1648220036676;
        Fri, 25 Mar 2022 07:53:56 -0700 (PDT)
Received: from localhost.localdomain (59-115-38-164.dynamic-ip.hinet.net. [59.115.38.164])
        by smtp.gmail.com with ESMTPSA id h14-20020a63384e000000b00366ba5335e7sm5608908pgn.72.2022.03.25.07.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 07:53:56 -0700 (PDT)
From:   Danny Lin <danny0838@gmail.com>
To:     git develop <git@vger.kernel.org>
Cc:     Danny Lin <danny0838@gmail.com>
Subject: [PATCH] git-prompt: fix sequencer/todo detection
Date:   Fri, 25 Mar 2022 22:53:01 +0800
Message-Id: <20220325145301.3370-1-danny0838@gmail.com>
X-Mailer: git-send-email 2.35.1.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previous case does not correctly check the "p ..." pattern.

Signed-off-by: Danny Lin <danny0838@gmail.com>
---
 contrib/completion/git-prompt.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index db7c0068fb..8ae341a306 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -315,7 +315,7 @@ __git_sequencer_status ()
 	elif __git_eread "$g/sequencer/todo" todo
 	then
 		case "$todo" in
-		p[\ \	]|pick[\ \	]*)
+		p[\ \	]*|pick[\ \	]*)
 			r="|CHERRY-PICKING"
 			return 0
 		;;
-- 
2.35.1.windows.2

