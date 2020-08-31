Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA236C433E2
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 10:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B53F2206F0
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 10:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmvjQ+h9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgHaKv7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 06:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbgHaKvS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 06:51:18 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE48C061755
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 03:51:16 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e17so4798635wme.0
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 03:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2I9Y2hRuXgRqT6FgB1KECR88tDHWd7i0V/IscrZ+zbo=;
        b=NmvjQ+h9yl7Jvlrc91falnnqQJZKq1nTMgDSKywBooTVkwHSyyQ8cidCZl3VBJf0bE
         hwRCtJpgCDpQM08wlzrd4dyww9zthZlRroo3UeKMM3+vZEl6/FWj+uSRqcVQt5jWcesx
         yLUHSe5KOgnSNrAWOV4+QJlmDDRlZrdlOq02/6Qkx7MDhxuCM8R1eq2gdSbDm99cCnKe
         Ix+f4RjAF9oqU7jrfDo2FtbxgARRnQrW+M2MGskaNAku7xGnxMFrpYZCrWIOtjQQ1M6O
         jE3XNLuJyfF7NiYoQhuiZRxYfk9MtCCkhrf36xveTkAId0jvEUthrlx5lCRIAdPTgmss
         9p9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2I9Y2hRuXgRqT6FgB1KECR88tDHWd7i0V/IscrZ+zbo=;
        b=U4irJkq7wulMkHJY80q5bBDvrdXMVPWDg3cypKTOR9kwXAVCkZ883xTDKu0mqku17f
         RmkA2LTVBYVfIyo2BKVPqW9fciEn7PmK/nJNjNJkeRPLKSyup3aLia9WUTem7A59ihIF
         47r+YZod9XWPjEr16EP+kJ9/p83+skC9xxUvbZVSa6krkRk+yH1hp6dGv9qGUJskgJ1U
         nnLKX3T8RRx6De+bg+w48zAw+FBuW2xWEa8mOLRKtA2cwwjp9c4YIMjDSxhMdENKyyCz
         hSbnspT2KInqZqg8CbThLNKqiCPGJpi5YARC3D/fSMuNqbpqLRBoLU12g/893kKk2Vd6
         s4EQ==
X-Gm-Message-State: AOAM531GV8m+IIY3fGjL0wLk595dC5AqHSyHgRTlnIgmXY5TNafReTRf
        mmhaDnKmUGRvtZn7fXqAa9SnspMg7OQ=
X-Google-Smtp-Source: ABdhPJy8dWp4D5JWhqpgcSmE+xMzrTGfSiC90wPJGt66ttM/ZoKhY5JHLJVhhSruztjsT+m1fMBXXw==
X-Received: by 2002:a1c:b703:: with SMTP id h3mr783714wmf.131.1598871075064;
        Mon, 31 Aug 2020 03:51:15 -0700 (PDT)
Received: from localhost.localdomain ([178.237.236.228])
        by smtp.gmail.com with ESMTPSA id k84sm7674454wmf.6.2020.08.31.03.51.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2020 03:51:14 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v7 05/13] bisect: call 'clear_commit_marks_all()' in 'bisect_next_all()'
Date:   Mon, 31 Aug 2020 12:50:35 +0200
Message-Id: <20200831105043.97665-6-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200831105043.97665-1-mirucam@gmail.com>
References: <20200831105043.97665-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As there can be other revision walks after bisect_next_all(),
let's add a call to a function to clear all the marks at the
end of bisect_next_all().

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 bisect.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bisect.c b/bisect.c
index d42a3a3767..c6aba2b9f2 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1082,6 +1082,8 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 		  "Bisecting: %d revisions left to test after this %s\n",
 		  nr), nr, steps_msg);
 	free(steps_msg);
+	/* Clean up objects used, as they will be reused. */
+	clear_commit_marks_all(ALL_REV_FLAGS);
 
 	return bisect_checkout(bisect_rev, no_checkout);
 }
-- 
2.25.0

