Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AB3C433E0
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F31222253D
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbhADXvu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 18:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbhADXvu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 18:51:50 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFB9C0617AA
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 15:50:46 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 11so27691107oty.9
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 15:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SslbAurq9E10mVdLdx4PqWNtIyOJeDsTI2O8op1OF+4=;
        b=FbnpNugogDpPWXUs9zbx9FqTOldWRbI2AQjVpnUTnwaquZkON+SCDIFUxSx0y3rKuo
         5afMPP+sR4abI+OJa6XO7DGwvcf9kXOPj/QZEyNw9W1kgikFNOD2YNqVQ22qCRrjCgnD
         vBOd943/1p0js4ragnXuZ9yGEusFBM76T+1JDzm3rZM+NJiaZGNQppCTWSMo5dQ0NIkg
         MJwwFJtID/GDHptbvtfG5ww/UHuiAsCzaNPVNMGzL0cwhhsaEucmjpoO8cbQ3yG1ntTb
         dq84D511We0ZfxYPynQ3ZFGIno2G2CUSXHh5X6TrylnaFJ1Kl5MyCHvnx4NqqyiBa4UR
         VOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SslbAurq9E10mVdLdx4PqWNtIyOJeDsTI2O8op1OF+4=;
        b=q5xk+AM0TLhcR0CmFdZpT4pcZiXWgXQH3YJbYroLT6HMfxUsr0uqJJFI+h1B6q9f4O
         tt3MoNjgFlwoSYjn4i4bM7A+hkfdI9l3Fhh4O4WPkWUQBOqDBhpY82n7t55fXYHQF9P7
         QvRcDsy2lOM0AyTiwZKXaFHpTw6W+Ki6cGsJr0NjHjsFQOehB8XpPQTr8Uxgg4BvMXtw
         Q61UNqbKggpTyJ9p/6VANypVrniW9dIUpFV4pUcEHkmj76hoslpyxoKAZ0hOmaaSMQdv
         Pe8vVh8Atrv3jzQZm9COnis+e+hy9gecn1VqErky1C5w5BkTGT/cD8rMzqM3RhtSOfh5
         IbNA==
X-Gm-Message-State: AOAM530/kiHo7epD5sGE20fVdeEoQEhf6dUO55E/vinMchdJ4xrEPdxp
        RF5+RU+mL7FTu7z7DEzIbxpho2e/bUI=
X-Google-Smtp-Source: ABdhPJyknDr4hXu4G05M8C6rPVwGbg0vZVfgC77f9jlWAVG/SrAwQWudmgrjgN35/hpRoxZ9PbG2sw==
X-Received: by 2002:a9d:7f15:: with SMTP id j21mr54937585otq.76.1609804245962;
        Mon, 04 Jan 2021 15:50:45 -0800 (PST)
Received: from tiger.attlocal.net ([2600:1700:bae0:2de0::26])
        by smtp.gmail.com with ESMTPSA id o135sm13359600ooo.38.2021.01.04.15.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 15:50:45 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 16/17] merge-ort: process_renames() now needs more defensiveness
Date:   Mon,  4 Jan 2021 15:50:05 -0800
Message-Id: <20210104235006.2867404-17-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.106.g3ff750dc32.dirty
In-Reply-To: <20210104235006.2867404-1-newren@gmail.com>
References: <20210104235006.2867404-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since directory rename detection adds new paths to opt->priv->paths and
removes old ones, process_renames() needs to now check whether
pair->one->path actually exists in opt->priv->paths instead of just
assuming it does.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 115ff6d2d5..480f212cff 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1829,12 +1829,28 @@ static int process_renames(struct merge_options *opt,
 		const char *rename_branch = NULL, *delete_branch = NULL;
 
 		old_ent = strmap_get_entry(&opt->priv->paths, pair->one->path);
-		oldpath = old_ent->key;
-		oldinfo = old_ent->value;
-
 		new_ent = strmap_get_entry(&opt->priv->paths, pair->two->path);
-		newpath = new_ent->key;
-		newinfo = new_ent->value;
+		if (old_ent) {
+			oldpath = old_ent->key;
+			oldinfo = old_ent->value;
+		}
+		newpath = pair->two->path;
+		if (new_ent) {
+			newpath = new_ent->key;
+			newinfo = new_ent->value;
+		}
+
+		/*
+		 * If pair->one->path isn't in opt->priv->paths, that means
+		 * that either directory rename detection removed that
+		 * path, or a parent directory of oldpath was resolved and
+		 * we don't even need the rename; in either case, we can
+		 * skip it.  If oldinfo->merged.clean, then the other side
+		 * of history had no changes to oldpath and we don't need
+		 * the rename and can skip it.
+		 */
+		if (!oldinfo || oldinfo->merged.clean)
+			continue;
 
 		/*
 		 * diff_filepairs have copies of pathnames, thus we have to
-- 
2.29.1.106.g3ff750dc32.dirty

