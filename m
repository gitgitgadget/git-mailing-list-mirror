Return-Path: <SRS0=d2Ax=EG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E44C388F7
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 19:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFB5B206D8
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 19:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyYV8TBS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgJaThw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Oct 2020 15:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgJaThw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Oct 2020 15:37:52 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D738C0617A6
        for <git@vger.kernel.org>; Sat, 31 Oct 2020 12:37:52 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id y184so10244493lfa.12
        for <git@vger.kernel.org>; Sat, 31 Oct 2020 12:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=87sLlGT6APcy/1ks02GQMf9yIwlV7koDh7ZlbhargT8=;
        b=FyYV8TBSbcyyonk948JmK3Iw1/BegmDuR4Jsg6g4JQFdHF2QPp42fPBc6bkx27b0Lc
         ai58zBgmDjrPviVUYvg2WpFdyfzg7Vi++9VwJR78fPPHoimOrWgLqUBgwxJVnawhR9ON
         kZGL1oQCyfPBB5fmtfjs62ZOx7t3tIDr2FCOEntiyyBIP0T7mQhFFcSaPz6Lrrp0qIuq
         3JzxcOq/BEFKEnHaHkrXZ1SzcxFv3BtzeGWwINPAkhLvqdAKGOYusvk5bISRRNwZheK8
         vNpboj+4Bx9ANKACbC7//F1GhYT/s34ZIA6tkK7WO1VGaVAxndTZG6oYN8xaIvy0tFl4
         UZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=87sLlGT6APcy/1ks02GQMf9yIwlV7koDh7ZlbhargT8=;
        b=aA74X31VHWyt25qtlDe90Q8q9CuVsdEO55G3kD1k/mSTwPupg3L46I7A3/KwrTghmh
         uEtLvJ2Sckz/xxDzVyiin08nzEqXHvLHz4gNu9mUhsds+IP+q6djnp3Bpp/zdqF9ake3
         D/+AQhU+/iB9TTsmqfamjv+dwnYsGVIBevtKxPiukSktorIizTQwUAndXkrglH4inM5Q
         dPfSzbCBE7I/EI/5l1Nj22v2h65uJFbrXSG0Ig5MJc3tFPJq8+nWcluEzJWcAaXiTEfn
         HO9X1beHv1GOx799IR1vLVbw4qgwO8EmS24BXazfztnrPoCl+1HpJ8KgUYE9jT/6njyy
         17Qg==
X-Gm-Message-State: AOAM533UgThlEfYS21tR9b+FQq4I9acMlP7HroHJKxZNBm2LDVzOO9M+
        LYWuZU+LUSFVsCsgxNwom5aDca/WUSA=
X-Google-Smtp-Source: ABdhPJxBPHEK4VtVCsabLSsEZG1U4z9eEdlQTTl6XQ2utZ+TNSjg21hOsOxteKfLGN2p5x1vCoOPWQ==
X-Received: by 2002:a05:6512:47b:: with SMTP id x27mr2856245lfd.157.1604173069741;
        Sat, 31 Oct 2020 12:37:49 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id i19sm1051979lfj.212.2020.10.31.12.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 12:37:48 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH] doc/diff-options: fix out of place mentions of '--patch/-p'
Date:   Sat, 31 Oct 2020 22:37:34 +0300
Message-Id: <20201031193734.22702-1-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First, references to --patch and -p appeared in the description of
git-format-patch, where the options themselves are not included.

Next, the description of --unified option elsewhere had duplicate implied
statements: "Implies --patch. Implies -p."

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/diff-options.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 573fb9bb71e2..320304033483 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -36,9 +36,9 @@ endif::git-format-patch[]
 -U<n>::
 --unified=<n>::
 	Generate diffs with <n> lines of context instead of
-	the usual three. Implies `--patch`.
+	the usual three.
 ifndef::git-format-patch[]
-	Implies `-p`.
+	Implies `--patch`.
 endif::git-format-patch[]
 
 --output=<file>::
@@ -441,7 +441,10 @@ endif::git-format-patch[]
 
 --binary::
 	In addition to `--full-index`, output a binary diff that
-	can be applied with `git-apply`. Implies `--patch`.
+	can be applied with `git-apply`.
+ifndef::git-format-patch[]
+	Implies `--patch`.
+endif::git-format-patch[]
 
 --abbrev[=<n>]::
 	Instead of showing the full 40-byte hexadecimal object
-- 
2.25.1

