Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D04C678D5
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 19:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjCHTWC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 14:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjCHTV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 14:21:57 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2F9CC309
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 11:21:55 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o38-20020a05600c512600b003e8320d1c11so2471610wms.1
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 11:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678303314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FbWlNZEuq+pZx1n/PRTiTJYEQ/r7ZV1yvpw1t1wQDs=;
        b=IQBW6qWostOyjZ6jJD5McoGO+0+AYUXRGCiU5T1I8Acqu6LW5CFgkINF/c99ZbxeEK
         HUQ1KlCKDFy5Kd3Tg5FN0nO2Oq1cMksAW/0tUR7SoP0GPky66VpA+T4LGmIp+JIyXLee
         ggZagVpECa37nWJYhQmDB76S/Y7teqgkgtm+SSl9t2cwEMZYMEjqAPTiKIHYVCilb9uu
         68us0eyNbQu+XhMv496LGRWZu6Wx4pcCJ6ej1EKhhFJmrsCsa2hdOOu7Xxny6DQbvbvD
         75x00+rD6jAX68JxtE3G08XCsrXLZzrj7uz0ste6egb4YSjhmQpDLR7+7gnopX4xYefu
         5WjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678303314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FbWlNZEuq+pZx1n/PRTiTJYEQ/r7ZV1yvpw1t1wQDs=;
        b=KME+mse/vvrLzkh9cYgg8uCIGnmoSW7GcXz7banWsX6I+JYMdjmf5NHl8VzsQ0a9Fj
         6qvPXtGTUsP/VYYqoNtwx88HGuW5ZE6gE8yYktsh5lENxjZggHqJayPaeibZ8jyy5AM3
         epHBTH0xsGsFaeHWVyqAnXuOvCFsXdlWYxP9XYwrEZrXEcxjJD8MSp2Me9m3eEJqAVSF
         ji7PeZE98JJMxveW8hluo4d425OjCTodsfXSUJIPNJ2PiAEPhWLqztwfGoVrha850nrP
         mFngqxlnKAFFx66LieO+Y+4yaP1UWz2OGU6ICPdHIQIzR6p9YfsYZ/d8FWA7s91DAFYJ
         ecgw==
X-Gm-Message-State: AO0yUKU0KQY8ywb8HjtlDwRMobxZ7LBRHmA1Bu3/EhqAjB8Tl3HmfprZ
        2zdsuHcRG709TJcqu0PMAUL6a67p6F06cQ==
X-Google-Smtp-Source: AK7set/QJbtG5Y/6ZmE+95OV3zfeL4QRWV2ibAFnltJ3dGJA70eXngAlr7elW9/QvOn0HZpSOWuhfQ==
X-Received: by 2002:a05:600c:4f13:b0:3dc:4fd7:31e9 with SMTP id l19-20020a05600c4f1300b003dc4fd731e9mr17805351wmq.7.1678303313919;
        Wed, 08 Mar 2023 11:21:53 -0800 (PST)
Received: from DESKTOP-FOQ07IR.localdomain ([2a00:a040:191:d233:88f:49ca:44fe:37f])
        by smtp.gmail.com with ESMTPSA id r11-20020a05600c458b00b003e20970175dsm321455wmo.32.2023.03.08.11.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 11:21:53 -0800 (PST)
From:   Roy Eldar <royeldar0@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com,
        Roy Eldar <royeldar0@gmail.com>
Subject: [PATCH RESEND 2/2] status: improve info for detached HEAD after clone
Date:   Wed,  8 Mar 2023 21:20:50 +0200
Message-Id: <20230308192050.1291-3-royeldar0@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230308192050.1291-1-royeldar0@gmail.com>
References: <20230308192050.1291-1-royeldar0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a remote ref or a tag is checked out, HEAD is automatically
detached, and "git status" says 'HEAD detached at ...', instead of
'Not currently on any branch.'; this is done by traversing the reflog
and parsing an entry like 'checkout: moving from ... to ...'.

In certain situations, HEAD can be detached after "git clone": for
example, when "--branch" specifies a non-branch (e.g. a tag). It is
preferable to avoid displaying 'Not currently on any branch.', so
'HEAD detached at $sha1' is shown instead.

Signed-off-by: Roy Eldar <royeldar0@gmail.com>
---
 t/t7508-status.sh | 2 +-
 wt-status.c       | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index d279157d28..0ab5bdc1e0 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -894,7 +894,7 @@ test_expect_success 'status shows detached HEAD properly after cloning a reposit
 
 	git clone -b test_tag upstream downstream &&
 	git -C downstream status >actual &&
-	grep -E "Not currently on any branch." actual
+	grep -E "HEAD detached at [0-9a-f]+" actual
 '
 
 test_expect_success 'setup status submodule summary' '
diff --git a/wt-status.c b/wt-status.c
index 3162241a57..f0a5fb578a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1632,6 +1632,13 @@ static int grab_1st_switch(struct object_id *ooid UNUSED,
 	struct grab_1st_switch_cbdata *cb = cb_data;
 	const char *target = NULL, *end;
 
+	if (skip_prefix(message, "clone: from ", &message)) {
+		oidcpy(&cb->noid, noid);
+		strbuf_reset(&cb->buf);
+		strbuf_add_unique_abbrev(&cb->buf, noid, DEFAULT_ABBREV);
+		return 1;
+	}
+
 	if (!skip_prefix(message, "checkout: moving from ", &message))
 		return 0;
 	target = strstr(message, " to ");
-- 
2.30.2

