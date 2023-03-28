Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CAFC76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 14:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjC1O3O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 10:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjC1O3J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 10:29:09 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40399B46B
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 07:29:04 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id iw3so11833940plb.6
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 07:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680013743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BqGm+bNuuhFMPsADKLlDOpFAcKmzD2dl9L1++FEAjY=;
        b=M5Dftvb1H6Nn4e9h44+qmT966kZY/jUPS1C7KtcEKsvhMK+qqor6b/VnCZ7Kpv4Wfd
         bFcrr0vi7avUnGqE6FodFiG732LSbjLvITPy6FMnKfneZEn7McCZB476Nknbba91Qdni
         g/nVKDrKPiuaZ+oogf5A0wUlshGoYPej6LcGa/RCS2j+QewOTk4X9IKKyGDv6h7e9O4h
         al6pi47ietF4togV59TitwFFX82pmdrF25uYIWsTXCga+/ILjezSCKQ4bR8tCyFa8TN3
         35uU4YNEeWiN7gNTkYwvJMsb3h7oCDocajm7h9712XTZ+KpqqDuRqqolJtIb2FGbVFn3
         btQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680013743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2BqGm+bNuuhFMPsADKLlDOpFAcKmzD2dl9L1++FEAjY=;
        b=Iiydu+eoML4KFYYXbp0RV88ZOrPNjT/i72Dwn3/8ArNsX8YFMQpZZ+iMqFI44YgDSL
         W0cbs9V96ZkeMhD0O7E6wStFu2UkoA+CFfrGnqIkG8+eNm7foD5lLL7nkE2gXCEgOAD4
         FsfsWTUCttZhthnKu+LHIpbLMmibUFpYsyfVPqKGk8w4GfctFNUhmgrWz4oNqX/TxwaL
         +N0IaNX79GelzEVVtoqfnl+Wp6hGhqlzD7Gq1m2lXNp6Gu7HE+1lGzH6uXdv/blXpo4A
         BU3aW1lVNTW8HZTQMme51tlYIsc0cRZkqgq0gqa45zXObzunUSwGx/JD+JlTQgAnhS7I
         7NHw==
X-Gm-Message-State: AAQBX9cuwpXq1AUeGD9NmqQOtiH0dS7gUVdJmZWXJouCpZNmGyJ62WNZ
        piQENzxk3qCq3JPBroR39ro=
X-Google-Smtp-Source: AKy350YRv5kiuQwK6eNgXIn7/jDZq2gBP7jZKtddKzndRnTlFDc7o4MRKWOW9CKk92VVCQXHdDl1/g==
X-Received: by 2002:a17:90b:4b49:b0:237:2f3c:a1cd with SMTP id mi9-20020a17090b4b4900b002372f3ca1cdmr18455284pjb.19.1680013743581;
        Tue, 28 Mar 2023 07:29:03 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.62])
        by smtp.gmail.com with ESMTPSA id bg9-20020a1709028e8900b0019cbabf127dsm21189275plb.182.2023.03.28.07.29.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Mar 2023 07:29:03 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v7 4/4] notes.c: don't do stripespace when parse file arg
Date:   Tue, 28 Mar 2023 22:28:47 +0800
Message-Id: <b9d12f0c5f31d11f89993e476d461fe3f13de705.1680012650.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.40.0.rc2.4.gb9d12f0c
In-Reply-To: <cover.1680012650.git.dyroneteng@gmail.com>
References: <cover.1680012650.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

The file maybe is a binary and it could contains multiple line
breaks, if we do the stripespace on it's content, the notes will
be different to the original content.

The binary file as the notes maybe a rare scenario, but there're
some related tests about it in t3307, so let's fix the problem
and add a test in t3301.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/notes.c  |  1 -
 t/t3301-notes.sh | 10 +++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 94b69607..ade8fb73 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -274,7 +274,6 @@ static int parse_file_arg(const struct option *opt, const char *arg, int unset)
 			die_errno(_("cannot read '%s'"), arg);
 	} else if (strbuf_read_file(buf, arg, 1024) < 0)
 		die_errno(_("could not open or read '%s'"), arg);
-	strbuf_stripspace(buf, 0);
 
 	// we will note stripspace the buf here, because the file maybe
 	// is a binary and it maybe contains multiple continuous line breaks.
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 716192b5..2af318f5 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -192,8 +192,16 @@ test_expect_success 'show multi-line notes' '
 	test_cmp expect-multiline actual
 '
 
-test_expect_success 'show -F notes' '
+test_expect_success 'add -F notes with binary' '
+	test_when_finished "git notes remove" &&
 	test_commit 4th &&
+	cp "$TEST_DIRECTORY"/test-binary-1.png . &&
+	git notes add -F test-binary-1.png &&
+	git notes show >actual &&
+	test_cmp test-binary-1.png actual
+'
+
+test_expect_success 'show -F notes' '
 	echo "xyzzy" >note5 &&
 	git notes add -F note5 &&
 	commit=$(git rev-parse HEAD) &&
-- 
2.40.0.rc2.4.gb9d12f0c

