Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E3851F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 12:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfHMM1L (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 08:27:11 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:37547 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfHMM1J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 08:27:09 -0400
Received: by mail-wm1-f47.google.com with SMTP id z23so1284395wmf.2
        for <git@vger.kernel.org>; Tue, 13 Aug 2019 05:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9sVFiPRYTiEpvaDUvRdNMe1WTbGPvV2CpZYi/D0PW+Q=;
        b=LBM4x/dy1ZrqTdKHsRbur9ef695a2ri0W6z6GSRpfQKsAGvPAudxIqeO4S0A1oeD+k
         bTP5db2AL6QF7akQwhy/jAq/PQ/bJnL/BxR3cYijggmYdoxDiMHKncT5Dy//iTxcLXZT
         TMBvqqzsO4Uf3nwkJCncJC2HPOfyV1snwXS3Flt+ZYsOWTdqAWFTlCHnKDDoI0TP74DR
         XLHbrFNnNAptWl8gAEm7MGoXyWaOWoE3I0jBfqrYvTdpdD+Vxd2tjW8eYAdciU/Tb/7R
         unr198BHsWzBmQqMJdhI/fAnFP3iYNx4Wk5t38recrRmkQV3Hf0M/moQnHjUOKswp1Uh
         /mMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9sVFiPRYTiEpvaDUvRdNMe1WTbGPvV2CpZYi/D0PW+Q=;
        b=kZMLJKzLKOKTsfLEyKqg25fqbA3nhwWyFle2Fur5THbDwgvxx1NF2akRAf2Y8ShOE3
         Zcc5eWtZNx6I9BRfRg/x9M9TllPk8m6+XhipxdWyRWcPydzF4YDcB+dIWNSruKHwQMBa
         Srwje1ghcwbYferrTlrs+0pgZaLaViiEKjcFaJJIqAygCCKF9JkXzIFiqB9mnP7+o6UI
         x8A0EGN9PTbF63DhbChqX1P9FieSywRoIQT3SymJmmpyMOzsnB2kHo0ZlpbhI4ubghNw
         AGEXnFBx7z3JiYdzNMfdtJhtP+rNCI95gfCicxsTzdEX/bxmGOrWfwZaQBYQeEJBvrui
         1QbA==
X-Gm-Message-State: APjAAAXuxFnq5LIAHdUB8mwAI4L2s6Nw3Hdx5H0saiHJNTTAZB9RFN4H
        y6XC530pIu4K3+VL39iUrso=
X-Google-Smtp-Source: APXvYqz7mtOnariMzXFw9urxOUWujichAKk/ICymjR0XWOLLb2hVztBYp+uVkAGU44rlAk8VeTd5gQ==
X-Received: by 2002:a1c:f101:: with SMTP id p1mr2860196wmh.151.1565699228472;
        Tue, 13 Aug 2019 05:27:08 -0700 (PDT)
Received: from localhost.localdomain (x4db44abf.dyn.telefonica.de. [77.180.74.191])
        by smtp.gmail.com with ESMTPSA id r5sm1978069wmh.35.2019.08.13.05.27.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Aug 2019 05:27:07 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 04/11] completion: deduplicate configuration sections
Date:   Tue, 13 Aug 2019 14:26:45 +0200
Message-Id: <20190813122652.16468-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.350.gf4fdc32db7
In-Reply-To: <20190813122652.16468-1-szeder.dev@gmail.com>
References: <20190813122652.16468-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The number of configuration variables listed by the completion script
grew quite when we started to auto-generate it from the documentation
[1], so we now complete them in two steps: first we list only the
section names, then the rest [2].  To get the section names we simply
strip everything following the first dot in each variable name,
resulting in a lot of repeated section names, because most sections
contain more than one configuration variable.  This is not a
correctness issue in practice, because Bash's completion facilities
remove all repetitions anyway, but these repetitions make testing a
bit harder.

Replace the small 'sed' script removing subsections and variable names
with an 'awk' script that does the same, and in addition removes any
repeated configuration sections as well (by first creating and filling
an associative array indexed by all encountered configuration
sections, and then iterating over this array and printing the indices,
i.e. the unique section names).  This change makes the failing 'git
config - section' test in 't9902-completion.sh' pass.

Note that this changes the order of section names in the output, and
makes it downright undeterministic, but this is not an issue, because
Bash sorts them before presenting them to the user, and our completion
tests sort them as well before comparing with the expected output.

Yeah, it would be simpler and shorter to just append '| sort -u' to
that command, but that would incur the overhead of one more external
process and pipeline stage every time a user completes configuration
sections.

[1] e17ca92637 (completion: drop the hard coded list of config vars,
    2018-05-26)
[2] f22f682695 (completion: complete general config vars in two steps,
    2018-05-27)

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 10 +++++++++-
 t/t9902-completion.sh                  |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c59347daee..f89324d84f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2398,7 +2398,15 @@ _git_config ()
 		;;
 	*)
 		__git_compute_config_vars
-		__gitcomp "$(echo "$__git_config_vars" | sed 's/\.[^ ]*/./g')"
+		__gitcomp "$(echo "$__git_config_vars" |
+				awk -F . '{
+					sections[$1] = 1
+				}
+				END {
+					for (s in sections)
+						print s "."
+				}
+				')"
 	esac
 }
 
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index e15be1164d..008fba7c89 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1698,7 +1698,7 @@ do
 	'
 done
 
-test_expect_failure 'git config - section' '
+test_expect_success 'git config - section' '
 	test_completion "git config br" <<-\EOF
 	branch.Z
 	browser.Z
-- 
2.23.0.rc2.350.gf4fdc32db7

