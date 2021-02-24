Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41867C433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0788A64F07
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbhBXT60 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbhBXTyK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:54:10 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921C8C061A27
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:20 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id c7so3040601wru.8
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RSr0Gq027279ByhEI+zgUVoVtL+wMABxsiJm9gfkyPk=;
        b=C+3UW1HzEdUj8ouhg6uRZN9IHpZIi7OyiH42G3AsNPlh7kbWY4363V7kh14iQIAa+o
         LzRsosxBrhAiGT20QBa8smI0135+yEkV/BvZQ2dlvvHF50B50d2gXVt/PFaWJ+RHCg2g
         /gOxxoC8BYjy4BcNbc0DPWAq6I+od7YCQnVsBmxQ9N71TJ9K9BBQC8L2hiO/a5sbIicL
         sGOB4H8QtX3UMENvWlRddTDtVZxTEivgtc/M03+oVGL5vlRHZ1Re6bIVwQMVAMlq6QVR
         2yAx1BlahRWzJ7tFy5hWzGyjCLoVmrGk/vyWvVif4dopnRPQJz2slRdxT44n9VYfjpt5
         k4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RSr0Gq027279ByhEI+zgUVoVtL+wMABxsiJm9gfkyPk=;
        b=P+jP4ylxXVRICxKPL3mPuVw59RjBLiJVj/qNwHFgGynZXarQpgVMDHGlA61PpYGF7D
         WAHAuQMEB1alDDFh2UMUy2O3ytJZzmdx3pF6yH2pN4LSaGzldhu9SEQlY4mwghsdiNq4
         OyOUyffljFXgMw7TlUGEtCBC/jO/uo+7Fb3npfzZOLUwfEI83cDrmHqvHueOG13gwbUa
         RUMOHiHagTH51MXamQMlhzNj87RnN0b0HaiEksGCMaFXwscW86sB77VcZ5REcy9qz6sO
         1YjvJBEDUmyjPWwcBNeKuarrLOhlRBjpHcq/R/T1EyvMok6SLDLBSwuTj8YQ4b+8hWyg
         T6Zg==
X-Gm-Message-State: AOAM533CunPwaA+XqabxCEM0OEHZkmPjlf3FneCRbjyYcQGvz5jQJmqY
        zWdr/BJnp/4c4l3Jo42xn6zW49rQzXcn/Q==
X-Google-Smtp-Source: ABdhPJyLru16f64fWRIO83946eBrz9EPdW974lab99R9XVFdCrs567+8dQNkO/FZJCVSYL5tbokqWw==
X-Received: by 2002:a5d:6643:: with SMTP id f3mr12007497wrw.182.1614196339037;
        Wed, 24 Feb 2021 11:52:19 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y2sm4786072wrp.39.2021.02.24.11.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:52:18 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 31/35] userdiff golang: don't over-match intented constructs
Date:   Wed, 24 Feb 2021 20:51:25 +0100
Message-Id: <20210224195129.4004-32-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bug introduced when the "golang" driver was added in
1dbf0c0ad6c (userdiff: add built-in pattern for golang, 2018-03-01).

Unlike the default def_ff() driver in xemit.c it would match "type"
declarations inside functions. Let's make it mandatory that a "func"
or "type" must be at the beginning of the line with no whitespace to
get around this.

Go is such a regularly formatted language that I think this can be
counted on. I think the whitespace matching was probably copy/pasted
from an earlier userdiff.c pattern.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018/golang | 20 ++++++++++++++++++++
 userdiff.c     |  4 ++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/t/t4018/golang b/t/t4018/golang
index 72a35d66008..252b6049da4 100644
--- a/t/t4018/golang
+++ b/t/t4018/golang
@@ -51,3 +51,23 @@ type some struct { // comment
 	a Type
 	b ChangeMe
 }
+
+t4018 description: func combined with type
+t4018 header: func myfunc() {
+func myfunc() {
+	type mystruct struct {
+		a Foo
+		b Bar
+	}
+	ChangeMe
+
+t4018 description: anonymous indented func()
+t4018 header: func SomeThing() bool {
+func SomeThing() bool {
+	func() {
+		defer func() {
+			fmt.Println("hello")
+		}()
+	}()
+
+	ChangeMe
diff --git a/userdiff.c b/userdiff.c
index 698eca5ad35..704af241e44 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -129,9 +129,9 @@ IPATTERN("fountain",
 	 "[^ \t-]+"),
 PATTERNS("golang",
 	 /* Functions */
-	 "^[ \t]*(func[ \t].*)\n"
+	 "^(func[ \t].*)\n"
 	 /* Structs and interfaces */
-	 "^[ \t]*(type[ \t].*(struct|interface)[ \t].*)",
+	 "^(type[ \t].*[ \t](struct|interface)[ \t].*)",
 	 /* -- */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.eE]+i?|0[xX]?[0-9a-fA-F]+i?"
-- 
2.30.0.284.gd98b1dd5eaa7

