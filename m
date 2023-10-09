Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5387EE95A9E
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 16:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377144AbjJIQGz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 12:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377102AbjJIQGu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 12:06:50 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8489291
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 09:06:48 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c1886777d9so55896181fa.0
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 09:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696867607; x=1697472407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YaoLmD52Y+EL+MseUZEJT5nWlN61NOhtDRWfe/woSqc=;
        b=GDrRaByLgYD+tSnQGwkNrF/hKDa1Yj/Z3wIHR6O2+TPGxuB0sk47et5kbjp+H7mV3V
         OIig6zKoHHYq32HRtr0Umm8ip+d4fu9cpNbaSq3TjMC57C46N/59BNZ4bvq0AovKxZc1
         hpiwMATSd79tpP0ocGSKT3myCg513rU9DPcTx+RQW19gHMJNlTHo7YFWyHigSpOZgv+s
         VozWU4yCi/3Qc9OHJXOndbjX+wPfFZwGQoNQhcWSgzFrR4cpbsKtfgdYKB+bcB3y3Dlf
         8tSWLe769mdPQjj8mnNPD8lhaSgHBn/a+bkzZ15tQf5dqKyKPQmZaznXrYGHZoOVnbcc
         JuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696867607; x=1697472407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YaoLmD52Y+EL+MseUZEJT5nWlN61NOhtDRWfe/woSqc=;
        b=n7XAvZfiuflRyWtpqEL1S0UwvLBDroOZEaPXFEW+tTeWNX/Xk6mqtB23HHqNoxdx0q
         IB9Mwyr9Q8WuLV9+KGItMMfkESPjEwCemLO4naKZ+QN3EGUDnipQbk/eCYXrAzmAgYr2
         zIy3kj7dfKOQfqlnqhvHmwhV8Ec3VniJFEToRnlN1xOqKxBjIcO4BZwBX3BxAJTL4ea0
         wmot+beDUWmR5gXIesPf+s1vo0g0hGMjamqeqXGK2JoWqNFer8Td30HD2kAI5P9Ug6T5
         u/OyJ7LsnDdaCU9keygaIolS+HeB3RVIQvcOHKPb0KZbETUjR/ZrT0JGStSP+4pyksfM
         Futw==
X-Gm-Message-State: AOJu0YwVblvC/i3THPdaPVBS0B08Sx2g10ZZ/uMy1l0DHEFzNAv/875O
        xdInd9wxrduQPHw6BfU1MaQ=
X-Google-Smtp-Source: AGHT+IFDbhxZGYpA5HCByF4Qb5PE1vX1pe1NX0b5BcnVPjoECL4EjXrqGNzxgC12V/c4xrGb9ccW1A==
X-Received: by 2002:a2e:8097:0:b0:2bb:aaec:abad with SMTP id i23-20020a2e8097000000b002bbaaecabadmr14968869ljg.30.1696867606530;
        Mon, 09 Oct 2023 09:06:46 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id j22-20020a2e8256000000b002b6daa3fa2csm2019715ljh.69.2023.10.09.09.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:06:46 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v4 3/3] completion: complete '--dd'
Date:   Mon,  9 Oct 2023 19:05:35 +0300
Message-Id: <20231009160535.236523-4-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231009160535.236523-1-sorganov@gmail.com>
References: <20230909125446.142715-1-sorganov@gmail.com>
 <20231009160535.236523-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'--dd' only makes sense for 'git log' and 'git show', so add it to
__git_log_show_options which is referenced in the completion for these
two commands.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 133ec92bfae7..ca4fa39f3ff8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2042,7 +2042,7 @@ __git_log_shortlog_options="
 "
 # Options accepted by log and show
 __git_log_show_options="
-	--diff-merges --diff-merges= --no-diff-merges --remerge-diff
+	--diff-merges --diff-merges= --no-diff-merges --dd --remerge-diff
 "
 
 __git_diff_merges_opts="off none on first-parent 1 separate m combined c dense-combined cc remerge r"
-- 
2.25.1

