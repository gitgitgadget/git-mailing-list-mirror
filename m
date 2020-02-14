Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E6AC3B19D
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 14:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF972187F
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 14:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVnOxs2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387397AbgBNOov (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 09:44:51 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33939 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729278AbgBNOou (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 09:44:50 -0500
Received: by mail-wr1-f66.google.com with SMTP id n10so9244017wrm.1
        for <git@vger.kernel.org>; Fri, 14 Feb 2020 06:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3vHz707grPFrlVodQLLVK0XDj5wFTqWjLd0CoJDuBFc=;
        b=PVnOxs2oVkZx0jedPGMim9hMb3YGMYaLFMUaBYwkuqiLqPE2LXm3XKhG0h24T5lnEL
         x74TR4cpXFi18RUvIHl2ib7CpHpRfcfGRTXvPmPkCvr6xj6uHyVDj/XI8PE5hQVhvvQ2
         O1kYsXg0qFf4vLve78YV2xSuXxBD0fBBGFPyN/7+dE1asjiblVWWyjbakHkwsXxTgODQ
         2/tmiJ9ArdaSjixfZRRc1tJrq1GsOSTq25BEQMsTtNljk2xLQ9Gy+5Em2gU1r/G0a1be
         qPfW4C9/qOLhnXnHaInyD+mk3Im6f9x/w44K9xFTEKI77ylRlY+I9ykfF0n7Aln4qdCS
         B7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3vHz707grPFrlVodQLLVK0XDj5wFTqWjLd0CoJDuBFc=;
        b=oJJMdvbxZTumlvGcXWOZODrcJNfAVpEKOuL3+ug85OI5HY1g51doCOnIl/IERUUS/5
         zGXnqobK/w/jXW/n4Fx7GlXz4edYQ7qkSOuQubhEAowqvkXURH9xi91hyu34JqDp6TYp
         jcv8sbyxvMsX6MEJuJpvSoz4A0+K/C/SNf2UhsLEc058eHfG6OMre1qDi8IR6Fb0pfdr
         dQJ4VfQKa7fDrgkSbNAny72l1Fe6H+JPX5BdkqD9EahCwYXLtoai9l6kM9ORC6WmkET5
         oyL1iyrEeW210sBq+FWUeWDaBcQFzbMIUmy194rQZgJscWVb+WJxhDPwbz+x/5HEc298
         g01A==
X-Gm-Message-State: APjAAAXi309n+7aJZtn0OtZKV+kxY9RKhTgST+dQ4UuQl2/MqoHeVCsB
        LU03dDd9kR/qK84/o9zEXUk9o1Mq
X-Google-Smtp-Source: APXvYqwLsJRatRYejJ8ubKVqO1ufmjt8i11pYhl1wM4Ziy0dCGUJZbFy8YMep3jQg7L2vZDi1jea7A==
X-Received: by 2002:adf:df8f:: with SMTP id z15mr4283500wrl.282.1581691488355;
        Fri, 14 Feb 2020 06:44:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 21sm7779297wmo.8.2020.02.14.06.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 06:44:47 -0800 (PST)
Message-Id: <013b27760a0372a2a30e380c29919a5ca12ca135.1581691486.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.698.v6.git.git.1581691486.gitgitgadget@gmail.com>
References: <pull.698.v5.git.git.1581447484.gitgitgadget@gmail.com>
        <pull.698.v6.git.git.1581691486.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Feb 2020 14:44:40 +0000
Subject: [PATCH v6 1/7] git-p4: rewrite prompt to be Windows compatible
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>, Ben Keene <seraphire@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Keene <seraphire@gmail.com>

The existing function prompt(prompt_text) does not work correctly when
run on Windows 10 bash terminal when launched from the sourcetree
GUI application. The stdout is not flushed properly so the prompt text
is not displayed to the user until the next flush of stdout, which is
quite confusing.

Change this method by:
* Adding flush to stderr, stdout, and stdin
* Use readline from sys.stdin instead of raw_input.

The existing strip().lower() are retained.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 40d9e7c594e..65b6d4dca08 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -175,7 +175,10 @@ def prompt(prompt_text):
     """
     choices = set(m.group(1) for m in re.finditer(r"\[(.)\]", prompt_text))
     while True:
-        response = raw_input(prompt_text).strip().lower()
+        sys.stderr.flush()
+        sys.stdout.write(prompt_text)
+        sys.stdout.flush()
+        response=sys.stdin.readline().strip().lower()
         if not response:
             continue
         response = response[0]
-- 
gitgitgadget

