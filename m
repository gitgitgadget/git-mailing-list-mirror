Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDE3C2D0D1
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 21:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFE724679
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 21:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zit9YTLa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfLSV2f (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 16:28:35 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43143 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfLSV2e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 16:28:34 -0500
Received: by mail-ed1-f68.google.com with SMTP id dc19so6291829edb.10
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 13:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xbAMdwUoczvFExTFmHXxzR/2/texrkL36eKuhAIvlbk=;
        b=Zit9YTLaOoVTXTVgV5L1ZJL3h0ymn9DyXBvDKeA1n7kMdL/htDgY9YEzvdsH/Tf4GV
         bz+5mvibC/4DfJ8L7wugVTwqaGO2/E8vUMHXbRjVh9+ex0hsJyTNH5sYDTRL5uIWndwd
         5/BRc0u7lDwbc1CQ6WculLbLvotO5d02/5G6+31Pm0KEIzgQzkzQAlAyeBOiDFWyzRUn
         nuOjyDDLXi0ltDcKGBH2Ou35VREeaUiV8RgEMFjpknX2Fp6Hj/6coWzywW+ASZMIkB7d
         1cgYveo0rF/WVj7qMGEJe2M7zSPtlsQ3L10+kup6YQbtk4mBY7ttmTGbyDECVRpvrOaf
         E1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xbAMdwUoczvFExTFmHXxzR/2/texrkL36eKuhAIvlbk=;
        b=iaNz7sKoVKNozwI+Vek0ZbsRpLixQWU+MBBttfiseAVkFUiUGRvutfrf/r5FgK8Jqr
         GX7/akzYVJNKaallFPL6LbVoMMswSr232c++Z13jMGTJxAJx0EofTLPj9jjjOTMrxWBP
         wBMk87hkJHCV1vbfLxSr4N/FzdCEeM9x5NhWW4A2qjUXK6aMrEtxjVZUH6yupNQxo7p5
         S88MJ0SCbrAWVF3tBRJXteBRcFe6vubWcO1n1pb+tn2NocidDrnqihucjl9uYQThWpCL
         IqU0b0bMLUrG+UXRrnf6KGBRtxDjpHHusabo4FFFNp3d9oOBspOFY0e3IdhA/3YrMmr4
         qI3g==
X-Gm-Message-State: APjAAAXmRzwNFExj/s/9IW9vJEeRJePVTF1ZX1xtMqJaB+egJH/eH3yO
        9BaqCaF81dwgAa9s8XILQJD4k6tr
X-Google-Smtp-Source: APXvYqwXuXb5pnUpJbgZPjPbWH1K81957LWlxeyZu3/HSEustWBjh5ergdBmycWTzlOndJYmsDgGjQ==
X-Received: by 2002:a17:906:1646:: with SMTP id n6mr11790768ejd.296.1576790911751;
        Thu, 19 Dec 2019 13:28:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p6sm790539eja.63.2019.12.19.13.28.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 13:28:31 -0800 (PST)
Message-Id: <8d2d98eec3c620c55100a322087ef83e4f51c8cf.1576790906.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v5.git.git.1576790906.gitgitgadget@gmail.com>
References: <pull.676.v4.git.git.1576697386.gitgitgadget@gmail.com>
        <pull.676.v5.git.git.1576790906.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Dec 2019 21:28:22 +0000
Subject: [PATCH v5 4/8] dir: exit before wildcard fall-through if there is no
 wildcard
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     blees@dcon.de, gitster@pobox.com, kyle@kyleam.com,
        sxlijin@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The DO_MATCH_LEADING_PATHSPEC had a fall-through case for if there was a
wildcard, noting that we don't yet have enough information to determine
if a further paths under the current directory might match due to the
presence of wildcards.  But if we have no wildcards in our pathspec,
then we shouldn't get to that fall-through case.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c                                              | 7 +++++++
 t/t3011-common-prefixes-and-directory-traversal.sh | 4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 5dacacd469..517a569e10 100644
--- a/dir.c
+++ b/dir.c
@@ -379,6 +379,13 @@ static int match_pathspec_item(const struct index_state *istate,
 			       item->nowildcard_len - prefix))
 			return 0;
 
+		/*
+		 * name has no wildcard, and it didn't match as a leading
+		 * pathspec so return.
+		 */
+		if (item->nowildcard_len == item->len)
+			return 0;
+
 		/*
 		 * Here is where we would perform a wildmatch to check if
 		 * "name" can be matched as a directory (or a prefix) against
diff --git a/t/t3011-common-prefixes-and-directory-traversal.sh b/t/t3011-common-prefixes-and-directory-traversal.sh
index 54f80c62b8..d6e161ddd8 100755
--- a/t/t3011-common-prefixes-and-directory-traversal.sh
+++ b/t/t3011-common-prefixes-and-directory-traversal.sh
@@ -92,7 +92,7 @@ test_expect_failure 'git ls-files -o untracked_repo/ does not recurse' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'git ls-files -o untracked_dir untracked_repo recurses into untracked_dir only' '
+test_expect_success 'git ls-files -o untracked_dir untracked_repo recurses into untracked_dir only' '
 	cat <<-EOF >expect &&
 	untracked_dir/empty
 	untracked_repo/
@@ -110,7 +110,7 @@ test_expect_success 'git ls-files -o untracked_dir/ untracked_repo/ recurses int
 	test_cmp expect actual
 '
 
-test_expect_failure 'git ls-files -o --directory untracked_dir untracked_repo does not recurse' '
+test_expect_success 'git ls-files -o --directory untracked_dir untracked_repo does not recurse' '
 	cat <<-EOF >expect &&
 	untracked_dir/
 	untracked_repo/
-- 
gitgitgadget

