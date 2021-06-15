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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78ACC48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 16:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9746F616E8
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 16:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhFOQVT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 12:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFOQVR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 12:21:17 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0944C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 09:19:10 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id o3so18986425wri.8
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 09:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2AF5E25ZTUpFDWZubE0o3ziAyNkK2Hep/nQlc2KAIa0=;
        b=YCGIdlf9QItyR/kuBI6JsesvjrxpYWFSo0jr35qHbo5p6owQ4a44szR8dXWcMdfHsQ
         IKSCdAr/oa2FFtdnRt26tKRUGYCSjP5Y9pT96pPfRn3IaZ6fktHmfZl+ITwMOTWL4JSt
         gs9zWJfIYIWqWW2s1sWB3E6wQ/5H9gw9WRLVe3i0gbYAnAhkzLmItnqXBev+EMfYBcmJ
         a3hGsVXf0t3FijZuaYQetfgPVBWJN/lj399LXGKZ8sWmVPJfPjADhtPjd3jDiGlT35TZ
         GS3fr4giwWGRPs8tPY3Q9/EH1Tpik6G+XCcUg9WWwkxHT9T0HuPHAkFMMhKDNqW/A78D
         chwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2AF5E25ZTUpFDWZubE0o3ziAyNkK2Hep/nQlc2KAIa0=;
        b=mBowGCgWXhxLWDntMGRuxjXl/uXgtWHFN2J2NrsE/btAc2nabRwj0WZDBaTuZk+fG+
         PfuJJ2QYv+W8iKInlCdbDrj5R/NLkipLjPzeE5ERmgWpgR/kKYGv6z8i71L5v+94A+jc
         LC7UZl7t7YeH6A/bRuo8hbJgYQvj0Dgfb69TRYSyu432TV3nBxmY/RA28qtPQEViXT9N
         CkDWJRhoTWCArXKiSB2JqomAhD9kPB7SYOBrNzi0HFhp9vd2ABrNFKhw5hnKb2WiDkd2
         InwgavGo5WMgrgNqHeOrabdH8Zi9vghO0+KylIeX2EPk0aCtYO9hzwX7QldbHDb9bdl8
         i3CQ==
X-Gm-Message-State: AOAM533evIoK+kvWASbuqTZRC2rkaJje8zJf89OlZ/m+32As8g9VcDBP
        dk66aSl4htbaLuE0Mok8PFGUANLoh03bRg==
X-Google-Smtp-Source: ABdhPJxf401rewYSpdcEGe+S8CaFA6cqfc8wGoEA4UCVhEh7tnBGoiu+cwZ76zNmpMlWCg1iorSfUw==
X-Received: by 2002:adf:df88:: with SMTP id z8mr3769685wrl.330.1623773949232;
        Tue, 15 Jun 2021 09:19:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b8sm2671901wmd.35.2021.06.15.09.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 09:19:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/6] doc: replace "alice" and "bob" with "jdoe" and "msmith"
Date:   Tue, 15 Jun 2021 18:18:02 +0200
Message-Id: <patch-5.6-65b7123e701-20210615T161330Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.555.g0268d380f7b
In-Reply-To: <cover-0.6-00000000000-20210615T161330Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210615T161330Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "Alice" and "Bob" generic example users to jdoe@example.com
and msmith@example.com.

The former is widely used in RFC 5322 as an example E-Mail address,
the latter is not, but "Mary Smith <mary@example.com>". It has been
claimed that any reference to people's gender in our documentation is
distracting to some readers[1]. In this case it's easy enough to tweak
the example in such a way that the reader can insert their own
stand-in for "M.".

1. https://lore.kernel.org/git/pull.975.v3.git.1623766273.gitgitgadget@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-credential.txt         |  2 +-
 Documentation/git-imap-send.txt          |  4 ++--
 Documentation/git-interpret-trailers.txt | 22 +++++++++++-----------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index 206e3c5f407..86b4c32affa 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -69,7 +69,7 @@ information it has):
 
 	protocol=https
 	host=example.com
-	username=bob
+	username=jdoe
 	password=secr3t
 +
 In most cases, this means the attributes given in the input will be
diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 63cf498ce9f..902f0e8ed34 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -72,7 +72,7 @@ Using direct mode:
 [imap]
     folder = "INBOX.Drafts"
     host = imap://imap.example.com
-    user = bob
+    user = jdoe
     pass = p4ssw0rd
 .........................
 
@@ -82,7 +82,7 @@ Using direct mode with SSL:
 [imap]
     folder = "INBOX.Drafts"
     host = imaps://imap.example.com
-    user = bob
+    user = jdoe
     pass = p4ssw0rd
     port = 123
     ; sslVerify = false
diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 956a01d184f..17a19960ba3 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -277,13 +277,13 @@ $ cat msg.txt
 subject
 
 message
-$ cat msg.txt | git interpret-trailers --trailer 'sign: Alice <alice@example.com>' --trailer 'sign: Bob <bob@example.com>'
+$ cat msg.txt | git interpret-trailers --trailer 'sign: J. Doe <jdoe@example.com>' --trailer 'sign: M. Smith <msmith@example.com>'
 subject
 
 message
 
-Signed-off-by: Alice <alice@example.com>
-Signed-off-by: Bob <bob@example.com>
+Signed-off-by: J. Doe <jdoe@example.com>
+Signed-off-by: M. Smith <msmith@example.com>
 ------------
 
 * Use the `--in-place` option to edit a message file in place:
@@ -294,15 +294,15 @@ subject
 
 message
 
-Signed-off-by: Bob <bob@example.com>
-$ git interpret-trailers --trailer 'Acked-by: Alice <alice@example.com>' --in-place msg.txt
+Signed-off-by: M. Smith <msmith@example.com>
+$ git interpret-trailers --trailer 'Acked-by: J. Doe <jdoe@example.com>' --in-place msg.txt
 $ cat msg.txt
 subject
 
 message
 
-Signed-off-by: Bob <bob@example.com>
-Acked-by: Alice <alice@example.com>
+Signed-off-by: M. Smith <msmith@example.com>
+Acked-by: J. Doe <jdoe@example.com>
 ------------
 
 * Extract the last commit as a patch, and add a 'Cc' and a
@@ -311,7 +311,7 @@ Acked-by: Alice <alice@example.com>
 ------------
 $ git format-patch -1
 0001-foo.patch
-$ git interpret-trailers --trailer 'Cc: Alice <alice@example.com>' --trailer 'Reviewed-by: Bob <bob@example.com>' 0001-foo.patch >0001-bar.patch
+$ git interpret-trailers --trailer 'Cc: J. Doe <jdoe@example.com>' --trailer 'Reviewed-by: M. Smith <msmith@example.com>' 0001-foo.patch >0001-bar.patch
 ------------
 
 * Configure a 'sign' trailer with a command to automatically add a
@@ -326,12 +326,12 @@ $ git config trailer.sign.command 'echo "$(git config user.name) <$(git config u
 $ git interpret-trailers <<EOF
 > EOF
 
-Signed-off-by: Bob <bob@example.com>
+Signed-off-by: M. Smith <msmith@example.com>
 $ git interpret-trailers <<EOF
-> Signed-off-by: Alice <alice@example.com>
+> Signed-off-by: J. Doe <jdoe@example.com>
 > EOF
 
-Signed-off-by: Alice <alice@example.com>
+Signed-off-by: J. Doe <jdoe@example.com>
 ------------
 
 * Configure a 'fix' trailer with a key that contains a '#' and no
-- 
2.32.0.555.g0268d380f7b

