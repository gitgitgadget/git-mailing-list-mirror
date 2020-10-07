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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40254C4363D
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 13:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAE1B20870
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 13:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmxrFbxx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgJGN0Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 09:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728427AbgJGN0P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 09:26:15 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B44DC061755
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 06:26:15 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id v12so2342827wmh.3
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 06:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ky0YtcXcWXGGL72SOhIKZydjoYaTyhAAybXbU/cCmK0=;
        b=ZmxrFbxxQBb+Z7UKf3E6WutOmr5PGF10SNIcEVhf4nXPAhd9zfpxO7DFl9vVPCruYZ
         5ML6nM7FbDrRNdbQDrj6G6sEpqhngUCajVNv3s644k7qVe/jwNS+U1MhFn7Zgvo4B4xW
         knauvT+H2UZQzRftkmDDEIWHesjO5sGT4aEzGkn3AK1fz8Qdj61qVT5DtFXbxA9nHxLh
         2QuvOmNCurc9STXVhsLGbp7be0pltUV0XFay6NPRh2Ic6IjBa0yoVhM/hfan/GPDGU54
         C+NBVl98EC4Oesnq77udRGlxYNCoBVF47KRaED7zcFw7SM7F88oc1pC2tbRdueZuvUiO
         ssRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ky0YtcXcWXGGL72SOhIKZydjoYaTyhAAybXbU/cCmK0=;
        b=NA/PyOt3MA8jHelpeZvIKDNJcvQ9JLPNUJ0s2I/QmsVoQ0FEdW2ixgcF0sKpaPDMBX
         hv3XRGinQBdPCRTlfP8/JnmXcb4f29OS8rXZ/Z3BNGGqgJsLegcEm4/pG6kK3eFJiJdf
         7UyEt4gZYbPqtXRtUF589fS/80UUOWNtcmOLZiH5NAX9ocDJjD8PMEc4X4yEpFr0k8JG
         t/9c5MFccphszj4AEiHRHxorUbqWz7yiXLbCoNK8OoZxIMXrC3wCAnDlGA+gR2pdpxQX
         HUfCeZ3kFPyv+LDm4eZXhtnDYjVgxZDa2RdG5sA8v68ed6EndBUKLvn1AxefNuGvGGKA
         a4fA==
X-Gm-Message-State: AOAM532KBy4/Cyz3qzuA2J/VVdR0Xwv1SthjxbDxs7bYKEDxLCGqg0iH
        SByZhsM3G8B/RnUgh/PqGkCeei/fP/U=
X-Google-Smtp-Source: ABdhPJz5KHViY8g+F8IFrJOrrFPC6UAbN4olWxxHytR7Lxf5xkrMUu+d0p4Bv2RuSvKZ6KxD/nJmdg==
X-Received: by 2002:a7b:cb17:: with SMTP id u23mr3227038wmj.166.1602077173327;
        Wed, 07 Oct 2020 06:26:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p13sm2819125wmb.5.2020.10.07.06.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 06:26:12 -0700 (PDT)
Message-Id: <pull.865.v3.git.git.1602077171751.gitgitgadget@gmail.com>
In-Reply-To: <pull.865.v2.git.git.1602048429067.gitgitgadget@gmail.com>
References: <pull.865.v2.git.git.1602048429067.gitgitgadget@gmail.com>
From:   "Konrad Borowski via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Oct 2020 13:26:11 +0000
Subject: [PATCH v3] userdiff: recognize 'macro_rules!' as starting a Rust
 function block
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

Signed-off-by: Konrad Borowski <konrad@borowski.pw>
---
    userdiff: support Rust macros
    
    Changes since v1:
    
     * Changed macro_rules! to be considered to use the same rule as rest of
       keywords to reduce the size of a change as suggested by Phillip Wood.
       This means that 'pub macro_rules!` (a syntax error) is considered to
       be a hunk header.
     * Written commit message in imperative mood as suggested by Johannes
       Sixt.
    
    Changes since v2:
    
     * Updated the commit message as suggested by Junio C Hamano.
     * Removed handling for 'macro_rules !' with a space in-between tokens.
       While it is allowed by the compiler to have a space between
       'macro_rules' and '!' it's pretty much never done.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-865%2Fxfix%2Fuserdiff-macro-rules-rust-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-865/xfix/userdiff-macro-rules-rust-v3
Pull-Request: https://github.com/git/git/pull/865

Range-diff vs v2:

 1:  a3fd67d84f ! 1:  0d8e6e06d4 userdiff: permit Rust's macro_rules! keyword in hunk headers
     @@ Metadata
      Author: Konrad Borowski <konrad@borowski.pw>
      
       ## Commit message ##
     -    userdiff: permit Rust's macro_rules! keyword in hunk headers
     -
     -    Changes since v1:
     -    - Changed macro_rules! to be considered to use the same
     -      rule as rest of keywords to reduce the size of a change
     -      as suggested by Phillip Wood. This means that
     -      'pub macro_rules!` (a syntax error) is considered to be
     -      a hunk header.
     -
     -    - Written commit message in imperative mood as suggested by
     -      Johannes Sixt.
     +    userdiff: recognize 'macro_rules!' as starting a Rust function block
      
          Signed-off-by: Konrad Borowski <konrad@borowski.pw>
      
     @@ userdiff.c: PATTERNS("ruby", "^[ \t]*((class|module|def)[ \t].*)$",
       	 "|//=?|[-+*/<>%&^|=!]=|<<=?|>>=?|===|\\.{1,3}|::|[!=]~"),
       PATTERNS("rust",
      -	 "^[\t ]*((pub(\\([^\\)]+\\))?[\t ]+)?((async|const|unsafe|extern([\t ]+\"[^\"]+\"))[\t ]+)?(struct|enum|union|mod|trait|fn|impl)[< \t]+[^;]*)$",
     -+	 "^[\t ]*((pub(\\([^\\)]+\\))?[\t ]+)?((async|const|unsafe|extern([\t ]+\"[^\"]+\"))[\t ]+)?(struct|enum|union|mod|trait|fn|impl|macro_rules[\t ]*!)[< \t]+[^;]*)$",
     ++	 "^[\t ]*((pub(\\([^\\)]+\\))?[\t ]+)?((async|const|unsafe|extern([\t ]+\"[^\"]+\"))[\t ]+)?(struct|enum|union|mod|trait|fn|impl|macro_rules!)[< \t]+[^;]*)$",
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
index fde02f225b..2903037724 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -165,7 +165,7 @@ PATTERNS("ruby", "^[ \t]*((class|module|def)[ \t].*)$",
 	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+|\\?(\\\\C-)?(\\\\M-)?."
 	 "|//=?|[-+*/<>%&^|=!]=|<<=?|>>=?|===|\\.{1,3}|::|[!=]~"),
 PATTERNS("rust",
-	 "^[\t ]*((pub(\\([^\\)]+\\))?[\t ]+)?((async|const|unsafe|extern([\t ]+\"[^\"]+\"))[\t ]+)?(struct|enum|union|mod|trait|fn|impl)[< \t]+[^;]*)$",
+	 "^[\t ]*((pub(\\([^\\)]+\\))?[\t ]+)?((async|const|unsafe|extern([\t ]+\"[^\"]+\"))[\t ]+)?(struct|enum|union|mod|trait|fn|impl|macro_rules!)[< \t]+[^;]*)$",
 	 /* -- */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[0-9][0-9_a-fA-Fiosuxz]*(\\.([0-9]*[eE][+-]?)?[0-9_fF]*)?"

base-commit: d98273ba77e1ab9ec755576bc86c716a97bf59d7
-- 
gitgitgadget
