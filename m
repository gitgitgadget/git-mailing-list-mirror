Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4105C1F406
	for <e@80x24.org>; Wed, 16 May 2018 22:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752228AbeEPW6w (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:58:52 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:49008 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752213AbeEPW6v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:58:51 -0400
Received: by mail-ua0-f201.google.com with SMTP id l31-v6so2244901uae.15
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=nRDFfnH2yckBd3M45VEP+xyy3n06/P4TgOVdXtawHl8=;
        b=iacLLuPoNFWU4uf0MiC7K2wCoD61NCq092PgBEKxaWEHWSBSSSDm15VjL5mI7fCRH+
         ywEvo/+TDiM8FHr86PqIR6CWt5eodj/It4bPsS3esZOl8A1RL11+5SKEn57MRCc/lAHp
         6XS8nWHvj96HDFxMiLI0tz5tQDb0dWDOEQnF3tETossuRzjDs68fyrBzlPq1et0S/CN5
         AvAjI/p4i0YlX1K0dOJA+FiySG7eS85XtbTc+jVcv3zZlKwPSTQRaKSlsTgAaNfqnGbr
         n0QfjhuYV3FG1h7jF0SwGhDMHhMVTnVus5tq6OM9CuB5tqrfw7b6niFjwpJXR4UFkHUf
         ZylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=nRDFfnH2yckBd3M45VEP+xyy3n06/P4TgOVdXtawHl8=;
        b=h+Ba1ggan7UOCfk+qLEabsRIl/NZK02vEK+WpWGjzBed+fYK5o/jJOAlvQDboShsJp
         kF5UOewVBNSlJ+gSH06Vk87jBaH0IMGM/xVkQcEPRU4bpr7yLSrCMbsORHYCNhfNXRJB
         kCMNC2kPcxE7hpTyy5zEDxZUfrSbfo1pu3l+l3ioWLga3tmHB4Qadfpkz+apfWsCdWSa
         TLvp6bLzyof2c2b02LsJHQY4gtYyxLACY2yVncyPBZX258K9FLLoYJlaAIL74WTjuXW8
         ZUXg29YVHn5FJC0uTtxOhLGpSBeg//CwKHXiVVAA3ADlkkhCtFdQOARWMBMnyzYGZ9eS
         eTNA==
X-Gm-Message-State: ALKqPwcVABJmHbccscYSH1+FWqnLR4xwrtqozEcM3C53FneixeSVjDFc
        Aw9nCY/ZKDqBSzleQ7UoLjLsAsSZKki33FxocH8nFGUtHclVqJAsrrl4BEXdtJu0x0v5E1VjAqk
        Hn49pX0NMd+F3k2op5h6wlsU8yiFpSyUHnUh6xAEujtx4N/nVfB58oLQMrg==
X-Google-Smtp-Source: AB8JxZqFBoM8L1OX2Kfn03DDph3jDZLLVqo6PUBfGMSA5Oh66kdiF/JGEVqzdL08S0s5M8a25KLjJz5p4ZQ=
MIME-Version: 1.0
X-Received: by 2002:a9f:3ed8:: with SMTP id n24-v6mr2310932uaj.78.1526511530262;
 Wed, 16 May 2018 15:58:50 -0700 (PDT)
Date:   Wed, 16 May 2018 15:57:52 -0700
In-Reply-To: <20180516225823.235426-1-bmwill@google.com>
Message-Id: <20180516225823.235426-6-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com> <20180516225823.235426-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH v2 05/36] refspec: convert valid_fetch_refspec to use parse_refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        sbeller@google.com, bmwill@google.com
Cc:     avarab@gmail.com, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'valid_fetch_refspec()' to use the new 'parse_refspec()'
function to only parse a single refspec and eliminate an allocation.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 refspec.c | 17 ++++++++---------
 refspec.h |  3 ++-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/refspec.c b/refspec.c
index af9d0d4b3..ab37b5ba1 100644
--- a/refspec.c
+++ b/refspec.c
@@ -146,15 +146,6 @@ static struct refspec_item *parse_refspec_internal(int nr_refspec, const char **
 	die("Invalid refspec '%s'", refspec[i]);
 }
 
-int valid_fetch_refspec(const char *fetch_refspec_str)
-{
-	struct refspec_item *refspec;
-
-	refspec = parse_refspec_internal(1, &fetch_refspec_str, 1, 1);
-	free_refspec(1, refspec);
-	return !!refspec;
-}
-
 struct refspec_item *parse_fetch_refspec(int nr_refspec, const char **refspec)
 {
 	return parse_refspec_internal(nr_refspec, refspec, 1, 0);
@@ -242,3 +233,11 @@ void refspec_clear(struct refspec *rs)
 
 	rs->fetch = 0;
 }
+
+int valid_fetch_refspec(const char *fetch_refspec_str)
+{
+	struct refspec_item refspec;
+	int ret = parse_refspec(&refspec, fetch_refspec_str, REFSPEC_FETCH);
+	refspec_item_clear(&refspec);
+	return ret;
+}
diff --git a/refspec.h b/refspec.h
index da3135825..1063c64cc 100644
--- a/refspec.h
+++ b/refspec.h
@@ -14,7 +14,6 @@ struct refspec_item {
 	char *dst;
 };
 
-int valid_fetch_refspec(const char *refspec);
 struct refspec_item *parse_fetch_refspec(int nr_refspec, const char **refspec);
 struct refspec_item *parse_push_refspec(int nr_refspec, const char **refspec);
 
@@ -45,4 +44,6 @@ void refspec_append(struct refspec *rs, const char *refspec);
 void refspec_appendn(struct refspec *rs, const char **refspecs, int nr);
 void refspec_clear(struct refspec *rs);
 
+int valid_fetch_refspec(const char *refspec);
+
 #endif /* REFSPEC_H */
-- 
2.17.0.441.gb46fe60e1d-goog

