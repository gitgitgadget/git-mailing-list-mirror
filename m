Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3DBC46467
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 02:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbjALCtF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 21:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235894AbjALCsd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 21:48:33 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59205479E3
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 18:48:27 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9so18809967pll.9
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 18:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=grpJiDGtuxxbaSuxJxCwaSPK/TLOt4MfFcR3rGLBhUY=;
        b=LN//q2fckh1Aj1DRGkZKd6zu8zJYQFnYNrCPFUAP07dyOu/gdv1sJ9nHcNMLJqr9i5
         Xy77wtZMGn1T2QsIEtgZrKJPEdZfjV/oBTcxnK6mxjyFPxmzyumPMW+djQfM9sLDT7Q2
         B7n5DnozpTd5c+bOUaPld8mXpkhmZiGwFHm5ED/xUy6AAVY91Lg4Y+bLtS+OvnAyLLdC
         ayH7t8mMQmIGfjzdjODXpF6lClxVSftGjUKOTj7TJMR90wQioZmufqqHce8mAvVqb5yP
         +qay1ogLhlWLmyaAfScNqCNYMy0io1LmtarB41VPyUJzi7WwMETaanmC+cFjnV64VW6S
         ECpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=grpJiDGtuxxbaSuxJxCwaSPK/TLOt4MfFcR3rGLBhUY=;
        b=VI+liBW5si/Yn4BGDIeV84c/aMQjgKzceaZh4wWBhND/o/4y8MVQdqsF5OE/wjEUYf
         937/f6lYoz3acT8zWJizh1pQbsmlPtOqJ5WCM8EOGicMWlIo4VMCRdAozy6CdhXTxpsN
         +HqGIi9CAL7ydiHIdD3WwqfgT4IBZlx4sX/odKSrdsmaVmuPl4zGAQ4vX4b8fTSpCaQr
         kujJun2Z9oKvwVZuyN1LF+8jse5sd56kj+Ffs2wxBd34X8xeXoDV7HQ8sC9IuL9uW4D+
         IfP0ghCmoE9K/59vFOjxgJWvyoweEpnY3APac8UZLW4IViCC9Nh68odL4cxhiEhU9FlZ
         axSA==
X-Gm-Message-State: AFqh2kr+4LwqPKbboQ/RyEwRTg8ZlSwM+K/q0szFmOXkLYZzt5Ki3Q4a
        diGWj5E0rRy3oACpdhudw+E=
X-Google-Smtp-Source: AMrXdXtX43mLFef6alp+27x9h9W7DuHflCita08ps9gZ6bQaaiarn0ACKkVp7zv+4Vy62c8It6VIBg==
X-Received: by 2002:a17:902:9f8c:b0:193:3989:b6a with SMTP id g12-20020a1709029f8c00b0019339890b6amr11059731plq.23.1673491706859;
        Wed, 11 Jan 2023 18:48:26 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.48])
        by smtp.gmail.com with ESMTPSA id u9-20020a170903124900b001926392adf9sm10855227plh.271.2023.01.11.18.48.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jan 2023 18:48:26 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, tenglong.tl@alibaba-inc.com,
        sunshine@sunshineco.com
Subject: [PATCH v4 4/5] notes.c: provide tips when target and append note are both empty
Date:   Thu, 12 Jan 2023 10:48:08 +0800
Message-Id: <d41ba140505aa3459330afd652ff6a0f456222a0.1673490953.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.38.1.386.g6952793f2d9.dirty
In-Reply-To: <cover.1673490953.git.dyroneteng@gmail.com>
References: <cover.1673490953.git.dyroneteng@gmail.com>
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
index b71a81bff1..f2efb3736c 100644
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
2.38.1.386.g6952793f2d9.dirty

