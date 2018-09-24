Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD1531F453
	for <e@80x24.org>; Mon, 24 Sep 2018 21:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbeIYD3z (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 23:29:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41333 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbeIYD3z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 23:29:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id m77-v6so965172pfi.8
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 14:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G7QajSHZIL3nM2um0Hs2DjmM8jFgJs7tp9wEd7/Hc+0=;
        b=Y06KkOeSkOyVO8v3Q9lQPt9KmV60RZz0Drr3dtx+Ymx8bW9/w8iFQp3SjBcuX6+0CV
         7tae7au6CYNMZo7JYRhYMcmcfp9HqC8DAbrRY23Qu4VpxSrg58tb9M5+ro9MBpakq0qU
         0oFEKgAtk6dnMNLpTeAYltGe8yoQwkI5NYyvfuVRG1IWH3ptCxZhGOFM/nNhMn2+OS24
         89/PtlB0Cg/aQ1V1DXjAbPW6zCDWPlZI6fUC0jaqaLC2I064d9AHowFHHVD8LfJllvLu
         vUkqiCmxoCXiNPlA50CeIUewhCB87t44eOwHqwTQ//FH5MKsh5xDOFFGoh76L+sJHRcp
         LDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G7QajSHZIL3nM2um0Hs2DjmM8jFgJs7tp9wEd7/Hc+0=;
        b=UbSvcRpa8evkBX6wMgh4+re450hU8LUdP3h9FXP29i8IBL36f1qT9UXh9PmtAOFHmH
         92mpgI0QEmTUX1aam4LTrNpKOBDRy5QwPd5oK5Q+xjiBgnQoYbpM8kX6SdDWlFQx28Wr
         /una7RnSabFOi53QBgcrUDVzKKK6/9bNZ1JviyOyoLImYQvNlfk4Y+VfTmw+f42G+cqq
         mkF82WcKEC2fSkVAV1aVfnkaeA/FYDgMSqnM+Pv7ZIHCfOrtIKmKxegLGWLEhmXTMtSr
         xdV6z8YCcWVJVYV2IqDYH0WwwcFIge7Yw2i8RSassEajtpYDJBM2MJXJ9q8brpttecbY
         f45Q==
X-Gm-Message-State: ABuFfogI363syaSiiAap0S4/ICFJi9vLXIAbeRwbl+EMBJzcEIgrNEDo
        NbzKgK8B6uNNRfFYr8ZM+piZAw1Y
X-Google-Smtp-Source: ACcGV63Efj9FEZ3t0ZdM77ahI0rU8WzTL4GyST5m7FfOUdHFjiNfD2vdeVzx1C1P5C+fkl5s5CxEjA==
X-Received: by 2002:a17:902:4201:: with SMTP id g1-v6mr525111pld.203.1537824343902;
        Mon, 24 Sep 2018 14:25:43 -0700 (PDT)
Received: from localhost.localdomain (hq.xevo.com. [4.14.243.50])
        by smtp.googlemail.com with ESMTPSA id b62-v6sm303062pfm.183.2018.09.24.14.25.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 14:25:42 -0700 (PDT)
From:   Sam McKelvie <sammck@gmail.com>
X-Google-Original-From: Sam McKelvie <smckelvie@xevo.com>
To:     git@vger.kernel.org
Cc:     Sam McKelvie <smckelvie@xevo.com>
Subject: [PATCH] submodule.c: Make get_superproject_working_tree() work when supermodule has unmerged changes of the submodule reference
Date:   Mon, 24 Sep 2018 14:23:52 -0700
Message-Id: <20180924212352.41909-1-smckelvie@xevo.com>
X-Mailer: git-send-email 2.19.0.606.g67c3761e7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

    Previously, "fatal: BUG: returned path string doesn't match cwd?" is displayed and
    git-rev-parse aborted.

    The problem is due to the fact that when a merge of the submodule reference is in progress,
    "git --stage —full-name <submodule-relative-path>” returns three seperate entries for the
    submodule (one for each stage) rather than a single entry; e.g.,

    $ git ls-files --stage --full-name submodule-child-test
    160000 dbbd2766fa330fa741ea59bb38689fcc2d283ac5 1       submodule-child-test
    160000 f174d1dbfe863a59692c3bdae730a36f2a788c51 2       submodule-child-test
    160000 e6178f3a58b958543952e12824aa2106d560f21d 3       submodule-child-test

    The code in get_superproject_working_tree() expected exactly one entry to be returned;
    this patch makes it use the first entry if multiple entries are returned.

    Signed-off-by: Sam McKelvie <smckelvie@xevo.com>
---
 submodule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index 33de6ee5f..5b9d5ad7e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1885,7 +1885,7 @@ const char *get_superproject_working_tree(void)
 		 * We're only interested in the name after the tab.
 		 */
 		super_sub = strchr(sb.buf, '\t') + 1;
-		super_sub_len = sb.buf + sb.len - super_sub - 1;
+		super_sub_len = strlen(super_sub);
 
 		if (super_sub_len > cwd_len ||
 		    strcmp(&cwd[cwd_len - super_sub_len], super_sub))
-- 
2.19.0.605.g01d371f74.dirty

