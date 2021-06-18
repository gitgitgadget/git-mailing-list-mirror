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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059B5C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D60FB613C2
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236390AbhFRS2r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236345AbhFRS2d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:28:33 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92B7C06124A
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:19 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id l12so11486065oig.2
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nODSHHAKBDo2grTSrVsZagzbFmQoCQJ/QtqVcd0Obsc=;
        b=huvIN6qZWXtxZOQnkBZaeCYgivnYOLHrfQ+OLhnkAZb3BYh1yV7IkQ/EZfqHd8fBdN
         z+9r3mUgUK1RwDJZKTVvvU6wClLSlRl8uuCRjSCuxfQyVf/CA/kQBRjxrN1FC+LUH8l1
         oSSxWbWLocCwxNuKbB9iBgXMhji30fHWGCGZv0JtKMO9vzra6nM639rlrO/xmKihoCFg
         kYLR+7XUXbRLqBuo2555EOizHNpECWwq+Yy5Ka1wYZAdGka4vz3BgbgGo5Z+jvlhOgXq
         pqP0CWoSLq98+cwKEMlGmlyGA0FF7IytTeiUafCkshxYmrPjAh1LvcOD22phfpxrf7fp
         c41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nODSHHAKBDo2grTSrVsZagzbFmQoCQJ/QtqVcd0Obsc=;
        b=KiXmoJHkwR5sA45Uhen5mwcCFOnaiQj/1gIr4HxjapvSBDbmhN4BmIb+Occ2PcExBE
         Nwa54C8ve7dcPDYweCBZS3TgQ8G9YecWskMJB84Co5RC30iFXp5YMppm7qgvh+vAICb4
         YRhQqIE8egZHbcIDdi1Ju/IAQ+eRiZD8cwvC+SjOjh+x9zsFJLLK6PjNvpFp86tTG5SV
         yESYRXQSaSuxWPqphuyBAYednfFmsb3YH7t/63gGznV5Tk6E6APPj0RhmQUBJromZYqe
         kPvLEds3FUfSWiEebACbds7JHaO+GZf7uVAF+qhcplmpEKhRGby5cYjeGHOk7ZaXp9fx
         TdqQ==
X-Gm-Message-State: AOAM531bdtWPFxGAsqnpl/uu/QsbL9AzghXuJGhigCglJVl+JHT6JzWc
        GWhpIX6XZZabr1MJH0wkeDjGk44FWGDqEQ==
X-Google-Smtp-Source: ABdhPJwpaE2KF8PkE0XKvANt5jAZHci99quP3PENmNQdN8py9OknA1vvmDiUknFulGvYNtQS/ZlRIw==
X-Received: by 2002:aca:2804:: with SMTP id 4mr8037392oix.141.1624040779115;
        Fri, 18 Jun 2021 11:26:19 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id q26sm1999885ood.7.2021.06.18.11.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:26:18 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 31/45] completion: bash: improve __gitcomp description
Date:   Fri, 18 Jun 2021 13:25:04 -0500
Message-Id: <20210618182518.697912-32-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It does a lot more than what is stated now.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index cb25916f65..0218ae7eb6 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -319,8 +319,7 @@ __gitcompadd ()
 	done
 }
 
-# Generates completion reply, appending a space to possible completion words,
-# if necessary.
+# Creates completion replies, reorganizing options and adding suffixes as needed.
 # It accepts 1 to 4 arguments:
 # 1: List of possible completion words.
 # 2: A prefix to be added to each possible completion word (optional).
-- 
2.32.0

