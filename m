Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4A7C2D0EC
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CBDC20714
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0jepVW6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgC0AoD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 20:44:03 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35414 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgC0AoD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 20:44:03 -0400
Received: by mail-qt1-f193.google.com with SMTP id e14so7308918qts.2
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 17:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ibNOJpUhlTg2jT33AmcMJgUohLdCQoA58aRpHOquG1Y=;
        b=A0jepVW6VwOIYWfuWtIpmfx+UU7f2GeJzXLvE6OXg2B58WSs27B3oueFjUSAn+RuBK
         8qt1H7fKdVZ3Uh4AsksKOPCSYDgTLy3BKr7gVbTuzf5FdUAJtiDxVQFoSL/XuKvMts9l
         ZUL+vg+Q61vy764fb0K5B3xPxw7nq4X4usUsoA3mvFWppUsH0No6/CAU9CtzPWasMA40
         awZ/N2o80pOxLDIPM/24afE5IMaXFaTxBgpmWUDYUzuR+k7HDd/vAcS6hqpkv924hENJ
         Dsov1vo05VWsjwjypyGBUIUAcQJbU1G9lnqytf1GmO6nhCAdALaKQjDbHoMDkzwZ03jn
         I4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ibNOJpUhlTg2jT33AmcMJgUohLdCQoA58aRpHOquG1Y=;
        b=AopTceYI1LLZZ4se0EBbb7WlRKlKKu3mqGkJsKMj/A213JsRkGZSlHb3WhR/Sbdmzn
         pz9RL25wPy4xUB59JlJ9+NN4OdVZzIyTmn1f2xki/E/C/pXzWi1J7PM6c82o0Ph44YNX
         ci+vbwTyJFhrcUHqdnLimv7NFhnB1jTFS4zWSWIMmv/46ZArVVjXrREs9bNxt31PbWL6
         NJSJCxg+t8mAlXdlITl4vQnlU1hrVjiX1AtIZ23+f5WhVpl8cbrwYcQESc6/b9gKEBfE
         9WzEjOriYV6bZcLKPuZXG0p5Ufi1ztcZFNFMwLb+FPNevmJJ07UqQ8iwUj8OlhK90qNt
         qlIw==
X-Gm-Message-State: ANhLgQ14VUg7Y9ZPLTKMSqMNctsr6AJry2BzL2uzj0RzzSYAg/xcZrR0
        zNwXeUV5b/FYu63Dg1fMCfvXh42I
X-Google-Smtp-Source: ADFU+vsnyEhl9QJov0mbcMva4lrydpdNqSJ26akbrJm9tzEzPfWbXZjr+mzEgSxmkZt/z/sV/Cv0uQ==
X-Received: by 2002:aed:3e71:: with SMTP id m46mr1382352qtf.77.1585269840468;
        Thu, 26 Mar 2020 17:44:00 -0700 (PDT)
Received: from localhost.localdomain (ktnron0919w-grc-01-76-68-141-233.dsl.bell.ca. [76.68.141.233])
        by smtp.gmail.com with ESMTPSA id x127sm2578542qke.135.2020.03.26.17.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 17:43:59 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 9/9] fixup! t5512: stop losing git exit code in here-docs
Date:   Thu, 26 Mar 2020 20:43:45 -0400
Message-Id: <38924d9c4994b5bad93cbbd2659666f6b452a89f.1585269773.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1585209554.git.liu.denton@gmail.com>
References: <cover.1585209554.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5512-ls-remote.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 8928d1f62d..e98c3a0174 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -224,7 +224,7 @@ test_expect_success 'ls-remote --symref' '
 	oid=$(git rev-parse HEAD) &&
 	echo "$oid	refs/remotes/origin/HEAD" >>expect &&
 	generate_references \
-	refs/remotes/origin/master \
+		refs/remotes/origin/master \
 		refs/tags/mark \
 		refs/tags/mark1.1 \
 		refs/tags/mark1.10 \
-- 
2.26.0.159.g23e2136ad0

