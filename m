Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E502C43217
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 09:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiKIJHt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 04:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiKIJHL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 04:07:11 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94C7209BC
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 01:07:10 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso1223331pjg.5
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 01:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8Iy1yxP/4xnnTUtgOq+E/Gt0gSKCDRpX0Fn0wF9npI=;
        b=Nzv8AB9Nr9QbWjyd6RmyOQSg4m7x3YCWOs3UF5iyk0oIPWMZY76Y0BEgvivCjAYQTa
         B5xL6mlXf0QO6cT7Qc2XbSF3Kn+tE8t2Prpkd723zm+zwtB/qcD3x+AByKerVCgkU8Sy
         zlrxV3CMCJDyS2bynCMGVcXq/zB1rU098MGMqCUcorwksdf1euvnutVK8mdyEd0ybY5O
         7Ihj0jyjwV5OaXEvLgw4nkKHTdhc65cslGaZ2/on8MTjJ33oIGzTBZyPLEeyljsq6s9W
         imWTQtdifOh33UPFe3B0LV9+JsBfCsXlRKqotNtbddZaKi69eNCJ5o3dfqU1zy2wuoO4
         yHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8Iy1yxP/4xnnTUtgOq+E/Gt0gSKCDRpX0Fn0wF9npI=;
        b=TiwW9Fj1o6wwhT3VM904fpaVLjciX4Rk8Pm+phRlys9207oqvhJepyAhqa1iBXfxLT
         q8mCLcfRBOrONNaUMbOZe8fsKsQ82imav3ihIbplZoIOT6VHOqdxA4GbIq17m8/fjxR5
         8SeZ97vTV44gZVOehwnJ035Zz2xYgqegYUSmZDL2fDZDcTlfRrwZ0VAeCZfp+qfBaugn
         6c9PoYy2rNn62Z8jOSgDiMJcbQEvZg/6O4T7YRoNzK0vohYzeuet4bBnvlUo4vGWu47B
         89a4vp9Gmrgv6xzR084GcQkZ6KX2aOIrsJzoF043ICtJhDUHVHl5X2yIz+L7yI7K+MWF
         AfeQ==
X-Gm-Message-State: ACrzQf0dNbmoRcG1rHv0v8MfzDIRGgPBwMlD3kH71r8uPvb4P+tvmT5v
        Et+Mz9hZYIGuFYNKjVlPCHbU3UOpnONU1yXd
X-Google-Smtp-Source: AMsMyM6sXosSRq+/g0h6f5SnKio+TQuUKRTQJ1aMJLlfabYw2fVhNG/Uz4m9k8ch0Poflwe79LcTiQ==
X-Received: by 2002:a17:902:b788:b0:186:a810:4072 with SMTP id e8-20020a170902b78800b00186a8104072mr60295734pls.86.1667984830222;
        Wed, 09 Nov 2022 01:07:10 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.63])
        by smtp.gmail.com with ESMTPSA id mg7-20020a17090b370700b00212d4cbcbfdsm727509pjb.22.2022.11.09.01.07.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Nov 2022 01:07:10 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: [PATCH v3 4/5] notes.c: provide tips when target and append note are both empty
Date:   Wed,  9 Nov 2022 17:06:55 +0800
Message-Id: <0d8ce0b14b0c956c33c99e9160a4752ef7bd7df4.1667980450.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.38.1.386.g196e80358e8
In-Reply-To: <cover.1667980450.git.dyroneteng@gmail.com>
References: <cover.1667980450.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

When "git notes append <object>" is executed, if there is no note in
the given object and the appended note is empty too, we could print
the exact tips to end-user.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/notes.c  | 5 ++++-
 t/t3301-notes.sh | 5 +++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 8c3a1cd913..a6273781fb 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -631,7 +631,10 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 			BUG("combine_notes_overwrite failed");
 		logmsg = xstrfmt("Notes added by 'git notes %s'", argv[0]);
 		commit_notes(the_repository, t, logmsg);
-	}
+	} else if (!d.buf.len && !note)
+		fprintf(stderr,
+			_("Both original and appended notes are empty in %s, do nothing\n"),
+			oid_to_hex(&object));
 
 	free(logmsg);
 	free_note_data(&d);
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 3288aaec7d..e7807e052a 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -552,6 +552,7 @@ test_expect_success 'appending empty string does not change existing note' '
 '
 
 test_expect_success 'git notes append == add when there is no existing note' '
+	test_when_finished git notes remove HEAD &&
 	git notes remove HEAD &&
 	test_must_fail git notes list HEAD &&
 	git notes append -m "Initial set of notes${LF}${LF}More notes appended with git notes append" &&
@@ -560,9 +561,9 @@ test_expect_success 'git notes append == add when there is no existing note' '
 '
 
 test_expect_success 'appending empty string to non-existing note does not create note' '
-	git notes remove HEAD &&
 	test_must_fail git notes list HEAD &&
-	git notes append -m "" &&
+	git notes append -m "" >output 2>&1 &&
+	grep "Both original and appended notes are empty" output &&
 	test_must_fail git notes list HEAD
 '
 
-- 
2.38.1.386.g196e80358e8

