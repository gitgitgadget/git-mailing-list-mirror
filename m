Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 522EC201A9
	for <e@80x24.org>; Sat, 18 Feb 2017 00:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751099AbdBRAXo (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 19:23:44 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34137 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbdBRAXn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 19:23:43 -0500
Received: by mail-wr0-f193.google.com with SMTP id 89so49424wrr.1
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 16:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eskkwH+wgWCmSioKki0tIYNGtbtaHCjiiFwjgm7oViQ=;
        b=QNRYhT/yp5jBMlRzPOo0BKHM4v24PA3QbQEGC8mPtSUwIKWBUxk3ot85URfNSwYQvY
         sSEZXW6gG7q+oz/D5modFqP5ud/QVzkvFEq72pBxeEpFN9NBl5UTxnjszwB1rCamUWva
         FdAmAKF89iGh5XZCc3xjyUOOkKma2XsQB9PsGPK0M6DVckOo8kKNLBeYsDrkwGBEjMEn
         pCdeK1K/5mAOZd5Ohj1XDde+KEUZ2g2cq/Yug6W/Tnkg/CZ+uscjyY/ETEDYJfwOWEpY
         FjlAeS52QWcCCM5oIOoRH0tPIHFF7dNb3TccEOpurNm7aJFIkaO+e47S+sni73M/AmWZ
         DGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eskkwH+wgWCmSioKki0tIYNGtbtaHCjiiFwjgm7oViQ=;
        b=Vi+vo/Io97i1Ffnehn2um790331aZoyQtzs6ilHOW7hfTZwhJvtWjyrKZ29Gw43TYf
         2z+syeRip0KxM/hM+ibRlzsShyGoViCN0SzHVQ/aZBN8mkw5HhKened3MzcpsGH7hU2u
         fgwNczEDJHzzS+NnV4jSbLu2PFZAn2nJEU5RqUZIFzFiB5Inu4F7Vea1Tel8iK+Sw/Xq
         rccu0XVgJTjs6gsNVkQaONcDcNMYqNwkw9rozIZ8lQu8hcwu1CQRsUcSKxuaIGV4L2nM
         EOE4b3ELp0tlmZ/oWba7lUXURWC3xVQgJgoCHvZ9jtJ2yBC6Z24nqXiujxJhzHDp9TWu
         0nQA==
X-Gm-Message-State: AMke39kOzZvvdjuCDWRJD6hSCOEtV6frICyg1fe9LqY0vrNaQbYcm1xlj4Eixki5tF8l1w==
X-Received: by 10.223.151.214 with SMTP id t22mr7915894wrb.2.1487377421216;
        Fri, 17 Feb 2017 16:23:41 -0800 (PST)
Received: from hobo (139.14.90.146.dyn.plus.net. [146.90.14.139])
        by smtp.gmail.com with ESMTPSA id j80sm3552145wmd.14.2017.02.17.16.23.40
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Feb 2017 16:23:40 -0800 (PST)
From:   Ross Lagerwall <rosslagerwall@gmail.com>
To:     git@vger.kernel.org
Cc:     Ross Lagerwall <rosslagerwall@gmail.com>
Subject: [PATCH] remote: Ignore failure to remove missing branch.<name>.merge
Date:   Sat, 18 Feb 2017 00:23:41 +0000
Message-Id: <20170218002341.23099-1-rosslagerwall@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a branch is configured with a default remote but no
branch.<name>.merge and then the remote is removed, git fails to remove
the remote with:
"fatal: could not unset 'branch.<name>.merge'"

Instead, ignore this since it is not an error and shouldn't prevent the
remote from being removed.

Signed-off-by: Ross Lagerwall <rosslagerwall@gmail.com>
---
 builtin/remote.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index e52cf3925..5dd22c2eb 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -769,7 +769,9 @@ static int rm(int argc, const char **argv)
 				strbuf_reset(&buf);
 				strbuf_addf(&buf, "branch.%s.%s",
 						item->string, *k);
-				git_config_set(buf.buf, NULL);
+				result = git_config_set_gently(buf.buf, NULL);
+				if (result && result != CONFIG_NOTHING_SET)
+					die(_("COULd not unset '%s'"), buf.buf);
 			}
 		}
 	}
-- 
2.11.0

