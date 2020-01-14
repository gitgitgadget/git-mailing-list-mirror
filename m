Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EC5C33CB2
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 19:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AAAC24673
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 19:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nizHt4uS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgANT0L (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:26:11 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53096 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANT0J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 14:26:09 -0500
Received: by mail-wm1-f66.google.com with SMTP id p9so15215845wmc.2
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 11:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HVRlTlXZbNOLul/8o68mw0iN43RgdF5pYmEwFEO2E1U=;
        b=nizHt4uSbyCFy1XfwFjav4iX79RdS38fLZ3WhyB6X1yHbJ0kxF281fGGEq9i8r7k7y
         8fG86/7NX+v4XNfpZA/VVSiCkv/KUdJ5iRi1Qcbzegv76nWUdgM6WKyKqGPBH7+yoneE
         0hjoiGY0jx1A7AbrBhaBs+y7nUwJF34k9qwnUbW3pnUTNF/3cPXO6hmP7HatC09S1Uct
         S6nEWPqBsHZ5STvCwlLYeVz3c7SiFDmPcc9bjBJ/MvCV2rTeeC7V1T4WqQo/mSmdzzZh
         /vr3IAk/ShRq0LqLw9S71ueI7RuAfAEmXUaRUrxThGd4gsH4vnPVElR/74ubpFH37UFe
         n7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HVRlTlXZbNOLul/8o68mw0iN43RgdF5pYmEwFEO2E1U=;
        b=ZrEiBaIa2yRIZXIIeHxPL/4n6QX/v0kyrmE7J5l17YJowgahe/wB3L39UyjcOp1iTE
         cpNv/sI0/NqY1sC0onzX4k1X/a2m+igl26IYDjeTyM25V9/cRe/k4hNKkoD9Edeo9dT0
         3e2nH59Bm6mcm7TTS72bXK8wKSs3DZyZoNEDA3q3pn7797Toa5klg/c9nMV21w1uoAyL
         8iGcdO5JStVM09awA2378Nn59tNXdJKpzfEJrclfGtWf1O2zKemmkIVIOv8fkfTQsdOl
         22McnAOYKxJfWTaWvLjErbbCT6I5wbN5fH/RN7EkdiTS3JD1ljXGALZR9ZDXZKUEMloz
         Ussg==
X-Gm-Message-State: APjAAAXThmj8KAYur9wUx+WVB8qk3/o56pXK0cHEAVTt+576Hw9ohODh
        HdUgp/hNX84ZNfCT2SbMa8nMJa8t
X-Google-Smtp-Source: APXvYqwVQhbR9PALuH6J4/cCUrKqVIwvcGKE5BpRrzKfQhvOoVF6uizhrfFADzd/XIzEmII27gUPRg==
X-Received: by 2002:a1c:20d6:: with SMTP id g205mr29221608wmg.38.1579029967947;
        Tue, 14 Jan 2020 11:26:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h8sm22014891wrx.63.2020.01.14.11.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 11:26:07 -0800 (PST)
Message-Id: <9be49908fd85e27d49c1c23ec6928785eabd7f65.1579029963.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.git.1579029962.gitgitgadget@gmail.com>
References: <pull.513.git.1579029962.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Jan 2020 19:25:59 +0000
Subject: [PATCH 5/8] sparse-checkout: detect short patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In cone mode, the shortest pattern the sparse-checkout command will
write into the sparse-checkout file is "/*". This is handled carefully
in add_pattern_to_hashsets(), so warn if any other pattern is this
short. This will assist future pattern checks by allowing us to assume
there are at least three characters in the pattern.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.c                              | 3 ++-
 t/t1091-sparse-checkout-builtin.sh | 9 +++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index f8e350dda2..1c96ddf5e3 100644
--- a/dir.c
+++ b/dir.c
@@ -651,7 +651,8 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 		return;
 	}
 
-	if (strstr(given->pattern, "**")) {
+	if (given->patternlen <= 2 ||
+	    strstr(given->pattern, "**")) {
 		/* Not a cone pattern. */
 		pl->use_cone_patterns = 0;
 		warning(_("unrecognized pattern: '%s'"), given->pattern);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index e532a52f89..974a4fec8f 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -339,4 +339,13 @@ test_expect_success 'pattern-checks: /A/**/B/' '
 	check_files repo/deep/deeper1 "deepest"
 '
 
+test_expect_success 'pattern-checks: too short' '
+	cat >repo/.git/info/sparse-checkout <<-\EOF &&
+	/*
+	!/*/
+	/a
+	EOF
+	check_read_tree_errors repo "a" "disabling cone pattern matching"
+'
+
 test_done
-- 
gitgitgadget

