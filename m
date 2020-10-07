Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8632AC4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 05:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 304C4208C7
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 05:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PywiER1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgJGF1Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 01:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgJGF1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 01:27:16 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF062C061755
        for <git@vger.kernel.org>; Tue,  6 Oct 2020 22:27:11 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h7so631675wre.4
        for <git@vger.kernel.org>; Tue, 06 Oct 2020 22:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oPZqAOL/EYUVnri5ydtanMvgkEHDPxQmYz5+OuOXulQ=;
        b=PywiER1mOUb12vvFUSwWzxDxjWvpWiGexrqjT7Qj/hMLC+W8v56HNAluQcMdCsN7tA
         vkYPRSYFqMmLyykr9tZuAOut9cUqkQivke9xj5Xa2ayEjKmXnO3Jx1+jUdKhBhlbLf1Y
         MTk9izN7yb3fVDupaYxJAbVu7kgb3PqwvkFc8q5sX+kv1nes3W55AfiVmf3p/qAFz/3X
         MstwYhNstOGuo0YplZfApe5reFcchurJgLeyxVy98v23kH5Tzpxry8+LT9Mk1xlvOhZ5
         LTfk9WlwvUDZUNTA/ffi0aDOYIRfr0mJ6Ga2e91+sg2dtUpLUSeUNrrtBSywKgz2/Voz
         +zdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oPZqAOL/EYUVnri5ydtanMvgkEHDPxQmYz5+OuOXulQ=;
        b=r7G4tYJ1iQYwtpL6WiYkOlPUzckWHK95fPl4HJ8J4duTJyG0U1dl22c0MUYPR8JLQz
         YGQDbMnaMrThhmpqo7PJIZ9du8gFCLJ9FIzyubeIArCCHptWBXFY8+siD7zbAo0vfYfu
         u+sVgm9f3VNYDecCwbI10rh8biYRkiFRsem1AQpEqHbQOe41nwelKydFaC9/02kym7MF
         AT7lRFr8dzAkew22xjfQBJ8h0FkgLsUEv7LujlED9kjDwe9u2uDGo6fbX1nDHcfq2qZ9
         4/o3Jq3ul1EX/Q4hYwV2/F7KNQcPqXlkvgabtZl+9+F4MSLgH+tQv4gAqIBoZolQ21y/
         Gqdw==
X-Gm-Message-State: AOAM530Ff2sZQmnw3va0UQzLCCW86IRZgOgWN48jf7Te3O5iiTjGsd+v
        3wfa6NHDQybsSxCb2yHvalMM7vYPqJM=
X-Google-Smtp-Source: ABdhPJwLLaVOw8L2AGyM0xy5TjCQ7mrWfRNOd+tSdaY6nV7hZfHYSOE08kHl6KMFcsN9Gm8PTWxkbg==
X-Received: by 2002:a5d:444b:: with SMTP id x11mr1385644wrr.402.1602048430007;
        Tue, 06 Oct 2020 22:27:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l5sm1208226wrq.14.2020.10.06.22.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 22:27:09 -0700 (PDT)
Message-Id: <pull.865.v2.git.git.1602048429067.gitgitgadget@gmail.com>
In-Reply-To: <pull.865.git.git.1601986430388.gitgitgadget@gmail.com>
References: <pull.865.git.git.1601986430388.gitgitgadget@gmail.com>
From:   "Konrad Borowski via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Oct 2020 05:27:08 +0000
Subject: [PATCH v2] userdiff: permit Rust's macro_rules! keyword in hunk
 headers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Konrad Borowski <github@borowski.pw>,
        Konrad Borowski <konrad@borowski.pw>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Konrad Borowski <konrad@borowski.pw>

Changes since v1:
- Changed macro_rules! to be considered to use the same
  rule as rest of keywords to reduce the size of a change
  as suggested by Phillip Wood. This means that
  'pub macro_rules!` (a syntax error) is considered to be
  a hunk header.

- Written commit message in imperative mood as suggested by
  Johannes Sixt.

Signed-off-by: Konrad Borowski <konrad@borowski.pw>
---
    userdiff: support Rust macros

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-865%2Fxfix%2Fuserdiff-macro-rules-rust-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-865/xfix/userdiff-macro-rules-rust-v2
Pull-Request: https://github.com/git/git/pull/865

Range-diff vs v1:

 1:  9e071ddf63 ! 1:  a3fd67d84f userdiff: support Rust macros
     @@ Metadata
      Author: Konrad Borowski <konrad@borowski.pw>
      
       ## Commit message ##
     -    userdiff: support Rust macros
     +    userdiff: permit Rust's macro_rules! keyword in hunk headers
      
     -    This adds a support for macro_rules! keyword which declares
     -    a macro. It also includes a test case.
     +    Changes since v1:
     +    - Changed macro_rules! to be considered to use the same
     +      rule as rest of keywords to reduce the size of a change
     +      as suggested by Phillip Wood. This means that
     +      'pub macro_rules!` (a syntax error) is considered to be
     +      a hunk header.
     +
     +    - Written commit message in imperative mood as suggested by
     +      Johannes Sixt.
      
          Signed-off-by: Konrad Borowski <konrad@borowski.pw>
      
     @@ userdiff.c: PATTERNS("ruby", "^[ \t]*((class|module|def)[ \t].*)$",
       	 "|//=?|[-+*/<>%&^|=!]=|<<=?|>>=?|===|\\.{1,3}|::|[!=]~"),
       PATTERNS("rust",
      -	 "^[\t ]*((pub(\\([^\\)]+\\))?[\t ]+)?((async|const|unsafe|extern([\t ]+\"[^\"]+\"))[\t ]+)?(struct|enum|union|mod|trait|fn|impl)[< \t]+[^;]*)$",
     -+	 "^[\t ]*(((pub(\\([^\\)]+\\))?[\t ]+)?((async|const|unsafe|extern([\t ]+\"[^\"]+\"))[\t ]+)?(struct|enum|union|mod|trait|fn|impl)[< \t]+|macro_rules[\t ]*!)[^;]*)$",
     ++	 "^[\t ]*((pub(\\([^\\)]+\\))?[\t ]+)?((async|const|unsafe|extern([\t ]+\"[^\"]+\"))[\t ]+)?(struct|enum|union|mod|trait|fn|impl|macro_rules[\t ]*!)[< \t]+[^;]*)$",
       	 /* -- */
       	 "[a-zA-Z_][a-zA-Z0-9_]*"
       	 "|[0-9][0-9_a-fA-Fiosuxz]*(\\.([0-9]*[eE][+-]?)?[0-9_fF]*)?"


 t/t4018/rust-macro-rules | 6 ++++++
 userdiff.c               | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)
 create mode 100644 t/t4018/rust-macro-rules

diff --git a/t/t4018/rust-macro-rules b/t/t4018/rust-macro-rules
new file mode 100644
index 0000000000..ec610c5b62
--- /dev/null
+++ b/t/t4018/rust-macro-rules
@@ -0,0 +1,6 @@
+macro_rules! RIGHT {
+    () => {
+        // a comment
+        let x = ChangeMe;
+    };
+}
diff --git a/userdiff.c b/userdiff.c
index fde02f225b..c0f63c57b2 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -165,7 +165,7 @@ PATTERNS("ruby", "^[ \t]*((class|module|def)[ \t].*)$",
 	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+|\\?(\\\\C-)?(\\\\M-)?."
 	 "|//=?|[-+*/<>%&^|=!]=|<<=?|>>=?|===|\\.{1,3}|::|[!=]~"),
 PATTERNS("rust",
-	 "^[\t ]*((pub(\\([^\\)]+\\))?[\t ]+)?((async|const|unsafe|extern([\t ]+\"[^\"]+\"))[\t ]+)?(struct|enum|union|mod|trait|fn|impl)[< \t]+[^;]*)$",
+	 "^[\t ]*((pub(\\([^\\)]+\\))?[\t ]+)?((async|const|unsafe|extern([\t ]+\"[^\"]+\"))[\t ]+)?(struct|enum|union|mod|trait|fn|impl|macro_rules[\t ]*!)[< \t]+[^;]*)$",
 	 /* -- */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[0-9][0-9_a-fA-Fiosuxz]*(\\.([0-9]*[eE][+-]?)?[0-9_fF]*)?"

base-commit: d98273ba77e1ab9ec755576bc86c716a97bf59d7
-- 
gitgitgadget
