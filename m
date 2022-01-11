Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE05C4332F
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 18:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350155AbiAKSGx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 13:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350386AbiAKSGB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 13:06:01 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68872C034006
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 10:05:18 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id l25so23650449wrb.13
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 10:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4rzeAfsdKFxeSNaMkn39eRWp7+GTFEzkUIQoVP3u7vU=;
        b=ZykgYuCgicUpPdsWpSfCMRgkNBBCAt8m2op5WGSrfDFsDm72CRUWvz0Zom4T73XFi9
         wi1Cqebr1hH2n2QWTNXkl808/nhgGOHq0+aO42T4lC9S6mSG0T3tADB4sghVBvBGOXCb
         J0zNKRg09Vh+yi0MQfTZeBvyVQDHmWPqeTemh0ScLH1r+fwuqQVWDIFQOeH0Eq8isbXM
         GeD2J5ei/OxA2Ils1FSxrYVxqYz/JNaaZFwrn3wIcy6il5hmUWhvFhXWJ+CALOXvukp1
         ZtRgEeYdEXemtvIYsWeJmWecbzCqfIOhfdpc+XHd/puXVbjvhuTbfXMeHqNIfD2n+Mtf
         1Yhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4rzeAfsdKFxeSNaMkn39eRWp7+GTFEzkUIQoVP3u7vU=;
        b=C5fCsBCuDuO/Qz4niEZ3T63azUcvWG0OKrnMgMszHgZ/7D822ESmf1Sj+vHp7X2xk2
         7yptGbzK7ZTOAcBm7yzEFNBm99frK6dW2QRNqE2qNzedZ2Zf3SVosu0rYOqTvRL2IQok
         ZV9g2HqlXzi6bYnxWv+E9WEuTt4xkeYguQTyHKOw1pvD9jw8X5tHLNqz9L8dhli4ErGR
         CNMHMcSQjTese10E18Nx2Bms5eIyhwa1TYjChjUtG5Zs0DU5pHCo5vi49a0GOwXDmP0i
         OM2f76CX8mfaW2ykMci0f2vz6ZNcYAq1wsKYV5UYWn3ys1bgxsFJCTYtJFgcrwINGuBl
         YF7w==
X-Gm-Message-State: AOAM531OAqiPmxssw64Iq2JC5q/vL2j29GPvLHLkTkTc2fr9tH4t4us2
        mgYbhs2CyEeiiztcwW9UPgDN4RjcJrk=
X-Google-Smtp-Source: ABdhPJxnbTHZ1m8O2VApqRjgHyWI/NSwGAMUIhrvlD6Q8K2kAkmM26KmlyxFSQ52MsRff3JZ8wxR0w==
X-Received: by 2002:adf:a141:: with SMTP id r1mr4786153wrr.124.1641924316848;
        Tue, 11 Jan 2022 10:05:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o12sm11160974wrc.69.2022.01.11.10.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 10:05:16 -0800 (PST)
Message-Id: <80697e9259e4a2c12fd0546f5f1895fb3068a66c.1641924306.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1109.v2.git.1641924306.gitgitgadget@gmail.com>
References: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
        <pull.1109.v2.git.1641924306.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 Jan 2022 18:05:06 +0000
Subject: [PATCH v2 9/9] update-index: reduce scope of index expansion in
 do_reupdate
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Replace unconditional index expansion in 'do_reupdate()' with one scoped to
only where a full index is needed. A full index is only required in
'do_reupdate()' when a sparse directory in the index differs from HEAD; in
that case, the index is expanded and the operation restarted.

Because the index should only be expanded if a sparse directory is modified,
add a test ensuring the index is not expanded when differences only exist
within the sparse cone.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/update-index.c                   | 14 +++++++++++---
 t/t1092-sparse-checkout-compatibility.sh |  5 ++++-
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 605cc693bbd..52ecc714d99 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -606,7 +606,7 @@ static struct cache_entry *read_one_ent(const char *which,
 			error("%s: not in %s branch.", path, which);
 		return NULL;
 	}
-	if (mode == S_IFDIR) {
+	if (!the_index.sparse_index && mode == S_IFDIR) {
 		if (which)
 			error("%s: not a blob in %s branch.", path, which);
 		return NULL;
@@ -743,8 +743,6 @@ static int do_reupdate(int ac, const char **av,
 		 */
 		has_head = 0;
  redo:
-	/* TODO: audit for interaction with sparse-index. */
-	ensure_full_index(&the_index);
 	for (pos = 0; pos < active_nr; pos++) {
 		const struct cache_entry *ce = active_cache[pos];
 		struct cache_entry *old = NULL;
@@ -761,6 +759,16 @@ static int do_reupdate(int ac, const char **av,
 			discard_cache_entry(old);
 			continue; /* unchanged */
 		}
+
+		/* At this point, we know the contents of the sparse directory are
+		 * modified with respect to HEAD, so we expand the index and restart
+		 * to process each path individually
+		 */
+		if (S_ISSPARSEDIR(ce->ce_mode)) {
+			ensure_full_index(&the_index);
+			goto redo;
+		}
+
 		/* Be careful.  The working tree may not have the
 		 * path anymore, in which case, under 'allow_remove',
 		 * or worse yet 'allow_replace', active_nr may decrease.
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index fceaba7101d..53f84881de7 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1265,7 +1265,10 @@ test_expect_success 'sparse index is not expanded: update-index' '
 
 	ensure_not_expanded update-index --add README.md &&
 	ensure_not_expanded update-index a &&
-	ensure_not_expanded update-index --remove deep/a
+	ensure_not_expanded update-index --remove deep/a &&
+
+	ensure_not_expanded reset --soft update-deep &&
+	ensure_not_expanded update-index --add --remove --again
 '
 
 test_expect_success 'sparse index is not expanded: blame' '
-- 
gitgitgadget
