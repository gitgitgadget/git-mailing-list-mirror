Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BCFC433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 09:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346901AbiEZJV3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 05:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346865AbiEZJVX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 05:21:23 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDE44EA21
        for <git@vger.kernel.org>; Thu, 26 May 2022 02:21:10 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id z15so1353318wrg.11
        for <git@vger.kernel.org>; Thu, 26 May 2022 02:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SXIb1d080r869ebsSMhvEbGJtPuTMiwSkZ0g3RheWbA=;
        b=UXcIWHxoxquD1t6s9bdALNj1Ud7JZq4Mpvo4PXEXJpJ0Az+MALzYXoEbCLxvG6k1Tb
         IU67YXH+Q/CpkYll5SZywYLsyx0oZudd3T7XV/9ta67R78IbwbEl4BTe/haof9M2qqEd
         wmx5XG12lGIUvmcjf6h8Kpsf3XbJafdiYIQSe+U8P4N+ZVvJKs8+tlF85pcjg4EaMUpd
         vQHjZ69HxlfzJ6IZBn4BiaRsrDbCaVHLBPLFbkfevQh+DHAomhTzY8pMcopQAiLxBHJB
         /40nNXeK/wbtqj/3SV8mvNKkIuepDQCJj7ggoi4M918rcexo+1UnC9OvQvLRz3KBAih/
         BbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SXIb1d080r869ebsSMhvEbGJtPuTMiwSkZ0g3RheWbA=;
        b=eGZgd3hJ0avTZ2GM70RjCwYF2Nff0iPPJwbGk+9IqFVzSIRS60jT6Qr7mMGyF38mau
         YINQyeUt5qMryGGHf/QsJvnAGAko45DOfZMTaxbzD2l/pC/VRSAwOkOsnOnCJR8ZRUs9
         crN8j8WesRMbtFnM9rtBbAhWPvtldVU9JERczm4sUfZXQd+itGAkxYm5Mtz9gAJjzVv+
         Un2gGoFGKchjFqh3lJI+zzgtcbjFWCpJvXuxpmGBQHMD6EHdmE4fWt5eL0vG1UCRc0Uf
         q42wB3XJZbc8LEPmHxTpLheQjiCsZebNcO29UVTR1hk+Z26y3rDJg6mM7r7peWU8ZnXI
         L0nw==
X-Gm-Message-State: AOAM531Sa1aL4HEM23xWNINUpbp43SUhKFnik5abLNFJBpYq9dAriBcu
        BluJ56kEO12xu2siulGq3WCm6TbijmI=
X-Google-Smtp-Source: ABdhPJywy8s5HmAEuno+XGRi1xgj32T7IMVsHf7Il1K9gd1AUL/muC5Z/9KZXUb68Hw07oatETf1hg==
X-Received: by 2002:a05:6000:2a2:b0:20f:d7ca:47b with SMTP id l2-20020a05600002a200b0020fd7ca047bmr16931526wry.298.1653556868737;
        Thu, 26 May 2022 02:21:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bd14-20020a05600c1f0e00b0039749b01ea7sm1535679wmb.32.2022.05.26.02.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 02:21:08 -0700 (PDT)
Message-Id: <d0fb54105940f19809eeb5d5e156bf3889d16b0c.1653556865.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
References: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 May 2022 09:21:04 +0000
Subject: [PATCH 2/3] rebase: help users when dying with `preserve-merges`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philip Oakley <philipoakley@iee.email>,
        Philip Oakley <philipoakley@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philip Oakley <philipoakley@iee.email>

Git will die if a "rebase --preserve-merges" is in progress.
Users cannot --quit, --abort or --continue the rebase.

Make the `rebase --abort` option available to allow users to remove
traces of any preserve-merges rebase, even if they had upgraded
during a rebase.

One trigger was an unexpectedly difficult to resolve conflict, as
reported on the `git-users` group.
(https://groups.google.com/g/git-for-windows/c/3jMWbBlXXHM)

Tell the user the options to resolve the problem manually.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
 builtin/rebase.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 6ce7e98a6f1..aada25a8870 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1182,8 +1182,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	} else if (is_directory(merge_dir())) {
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "%s/rewritten", merge_dir());
-		if (is_directory(buf.buf)) {
-			die("`rebase -p` is no longer supported");
+		if (is_directory(buf.buf) && !(action == ACTION_ABORT)) {
+			die("`rebase --preserve-merges` (-p) is no longer supported.\n"
+			"Use `git rebase --abort` to terminate current rebase.\n"
+			"Or downgrade to v2.33, or earlier, to complete the rebase.\n");
 		} else {
 			strbuf_reset(&buf);
 			strbuf_addf(&buf, "%s/interactive", merge_dir());
-- 
gitgitgadget

