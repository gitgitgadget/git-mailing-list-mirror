Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B78FC43331
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 18:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7DB064F6A
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 18:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbhCRSoR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 14:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbhCRSn6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 14:43:58 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E91CC06174A
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 11:43:58 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id y2so2439118qtw.13
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 11:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RxRgmNwhYskRZr9/hTOj9NeF1VXDYabFit/FiD/UZTs=;
        b=hLbSfHqMNvBNRqvvAQICheXmyCJIKIaVFELzkHNgkX63D/Ifsy6mvreT0X4uZPafmf
         n6EkatIgEV0yePi5Zzx4DmRK2BdiKSKaGjrT/9CTwuRWPWoVDtla73qCYkTj8U+ILmpu
         F+Jom0/kjlroRFqBHOMVcIhZTRqFT19LEiLU8CIMA0eheLMNfYPj0suVOaw8WBFxgCdi
         Ely6XfEbFmbEDRchu1au4DcM1smz9/aYpPEVktEUYj7x5Hvr/1+e5328vSye+AkvBddh
         iJOUb+C3THHBkGIV6A6d6qy5W6Dsli5HCCgjeOYAtHrRUDOWgFWuiHIVMWR53EeQDGR5
         TWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RxRgmNwhYskRZr9/hTOj9NeF1VXDYabFit/FiD/UZTs=;
        b=lo6uGMU9HaONb67hx+yWfp/CVlFeQHr5UNKmB60jbqz6wu6BJfxKBeQJLtpFWrCNkd
         dbds7cYH1CDfZnYMLdvoVoWePJNgPkpEtpVVtYzxAXdKimgBL5D02+m1oTJnEDeA/GpC
         3dn1kOQ6zpl6A79sKRUrCTygpzYAQAM1aub4KdvctSePz+HDQOw+hhIL/5jEitn2CfNk
         aC9t/UAa4BHM3YMLkQMvWxKXsqNfeaWMWTFgMPlWLwbEnYUfWSCXEKgq9uf1IePaziNF
         JA6aBxawKgDhjeXz+O7q7hFo8g5bqnlome5n6gzUEkK8kzPUK7+qvo/MDzy0xcJZyhO+
         64dQ==
X-Gm-Message-State: AOAM530hmJ+JiRa5Gm9u3RpMGkaROavIWiuf2W6Vlbcx8l1Sm6CRWQjJ
        QrjuGiLjngdNhtgqpMRFRsYBd+DSpLPjWQ==
X-Google-Smtp-Source: ABdhPJxE70s89U7+gmlQY82ATMbySzD86oLuhTnid+jt5/76BYFL0UIJUtuumIFg9LGnhEXQCc1bMA==
X-Received: by 2002:ac8:70d8:: with SMTP id g24mr5028893qtp.389.1616093037448;
        Thu, 18 Mar 2021 11:43:57 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id f9sm2037324qto.46.2021.03.18.11.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 11:43:57 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de
Subject: [PATCH 1/2] symlinks: update comment on threaded_check_leading_path()
Date:   Thu, 18 Mar 2021 15:43:46 -0300
Message-Id: <ec8d5f86994d91b6dc430ff2e1b79a7cdf8120f9.1616091229.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1616091229.git.matheus.bernardino@usp.br>
References: <cover.1616091229.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 1d718a5108 ("do not overwrite untracked symlinks", 2011-02-20),
the comment on top of threaded_check_leading_path() is outdated and no
longer reflects the behavior of this function. Let's updated it to avoid
confusions. While we are here, also remove some duplicated comments to
avoid similar maintenance problems.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 symlinks.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/symlinks.c b/symlinks.c
index 7dbb6b23d9..fbccd340f0 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -202,36 +202,23 @@ int threaded_has_symlink_leading_path(struct cache_def *cache, const char *name,
 	return lstat_cache(cache, name, len, FL_SYMLINK|FL_DIR, USE_ONLY_LSTAT) & FL_SYMLINK;
 }
 
-/*
- * Return non-zero if path 'name' has a leading symlink component
- */
 int has_symlink_leading_path(const char *name, int len)
 {
 	return threaded_has_symlink_leading_path(&default_cache, name, len);
 }
 
-/*
- * Return zero if path 'name' has a leading symlink component or
- * if some leading path component does not exists.
- *
- * Return -1 if leading path exists and is a directory.
- *
- * Return path length if leading path exists and is neither a
- * directory nor a symlink.
- */
 int check_leading_path(const char *name, int len)
 {
 	return threaded_check_leading_path(&default_cache, name, len);
 }
 
 /*
- * Return zero if path 'name' has a leading symlink component or
- * if some leading path component does not exists.
+ * Return zero if some leading path component of 'name' does not exist.
  *
  * Return -1 if leading path exists and is a directory.
  *
- * Return path length if leading path exists and is neither a
- * directory nor a symlink.
+ * Return the length of a leading component if it either exists but it's not a
+ * directory, or if we were unable to lstat() it.
  */
 static int threaded_check_leading_path(struct cache_def *cache, const char *name, int len)
 {
@@ -246,13 +233,6 @@ static int threaded_check_leading_path(struct cache_def *cache, const char *name
 		return match_len;
 }
 
-/*
- * Return non-zero if all path components of 'name' exists as a
- * directory.  If prefix_len > 0, we will test with the stat()
- * function instead of the lstat() function for a prefix length of
- * 'prefix_len', thus we then allow for symlinks in the prefix part as
- * long as those points to real existing directories.
- */
 int has_dirs_only_path(const char *name, int len, int prefix_len)
 {
 	return threaded_has_dirs_only_path(&default_cache, name, len, prefix_len);
-- 
2.30.1

