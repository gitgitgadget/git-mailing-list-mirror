Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FCDC47257
	for <git@archiver.kernel.org>; Fri,  1 May 2020 08:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1207920643
	for <git@archiver.kernel.org>; Fri,  1 May 2020 08:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s89kkGKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgEAI25 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 04:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbgEAI24 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 04:28:56 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C8EC035494
        for <git@vger.kernel.org>; Fri,  1 May 2020 01:28:55 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id q2so4440029qvd.1
        for <git@vger.kernel.org>; Fri, 01 May 2020 01:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TCe2anMaGp0ftwfxStoPptHHrEsKH1LTILKwcUPC/ag=;
        b=s89kkGKEltVMfmGTKdcXIjBe0rmBu2f9bUI6pkVtmG1qJYdrxLVIxz7kee8W/SJ4t7
         HpcyzcfU2kM8aR8aM5JMZhpe+3JIRnIH5kRXKXB7WvW3XVccuhy/vGFAe566BIamz9L5
         mKo4ir7k+RR6SexruEs3YlcrEjTBPi2V/A1QkANj2lYIzI174Q2bzacd9U3jpbSYCIo3
         EIXUnOOu0CbtdSGWSqKD40RifJMtI68r7jIIhf01SAWTWnQGw1meAI+K2nwqieGDOPkG
         holMFSkJt5pjqJ92/OKbn0NpjV3PzgrStboyZA0azzBFVDeP/UX9fGDJF5aeLvfeW+bz
         jx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=TCe2anMaGp0ftwfxStoPptHHrEsKH1LTILKwcUPC/ag=;
        b=dx8iwjPey3sdx/gKtUQg4hESEy9hCfnBk2itWKXuRcJArEiTN85izHPv2Q42w9vo+Q
         40AQDhh1iEKPkwRXbojbE/jFAKyETEAFPEuf8b2i3agEXR/+HL0zVZUIWc5+u6BgflDB
         ldsNknIkEA15S/1an0iFi+3skr3becnaDTgXA0QP1FbDhpqFusekTxBmzFpPu5WyNH36
         2cjkUHXSUBd8oytUFEGWxZgPfcfYlxVQm9u1pXGnvE7rMKhppZZtcUokyTowxSiENi3T
         v8voyBOQR9DJk8xJ0iimyotO6zNGuZ4cjTq/5RGA/BmD92L8l2pkH0SegkxbPh3KUxlc
         2yXw==
X-Gm-Message-State: AGi0PuZ6xKN36ka2hicCDRxw5RTvVSWmijDXlxr0nl6TdTyMAHpyUug1
        /1I0tpoddUl2+rjlkBGxUw2+Msev
X-Google-Smtp-Source: APiQypI00XKqpdxkT4LULy56bgXN+bEDdET5MLK5nviLzW+DM4OrI6TsJR4IL4NFqfpuaOYQ7SOm8g==
X-Received: by 2002:a05:6214:122:: with SMTP id w2mr2940553qvs.165.1588321734686;
        Fri, 01 May 2020 01:28:54 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id 70sm2258138qkh.67.2020.05.01.01.28.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 01:28:54 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Harri=20Meht=C3=A4l=C3=A4?= <harri.mehtala@finago.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/2] restore: require --source when combining --worktree and --staged
Date:   Fri,  1 May 2020 04:27:45 -0400
Message-Id: <20200501082746.23943-2-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7
In-Reply-To: <20200501082746.23943-1-sunshine@sunshineco.com>
References: <20200501082746.23943-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The default restore source for --worktree is the index, and the default
source for --staged is HEAD. When combining --worktree and --staged in
the same invocation, the restore source is ambiguous ("should it restore
from the index or from HEAD?"). To avoid such ambiguity, the git-restore
documentation has always stated that --source must be used when
combining --worktree and --staged. However, this restriction is not
actually enforced. Address this deficiency by making the implementation
match the documented behavior (to wit, error out if --source is not
specified when combining --worktree and --staged).

While at it, enhance the documentation to mention the --source
requirement prominently in the "Description" section (rather than only
in the description of the --source option itself).

Reported-by: Harri Mehtälä <harri.mehtala@finago.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-restore.txt | 3 ++-
 builtin/checkout.c            | 3 +++
 t/t2070-restore.sh            | 5 +++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
index 8e3b339802..8906499637 100644
--- a/Documentation/git-restore.txt
+++ b/Documentation/git-restore.txt
@@ -24,7 +24,8 @@ The command can also be used to restore the content in the index with
 
 By default, the restore sources for working tree and the index are the
 index and `HEAD` respectively. `--source` could be used to specify a
-commit as the restore source.
+commit as the restore source; it is required when combining `--staged`
+and `--worktree`.
 
 See "Reset, restore and revert" in linkgit:git[1] for the differences
 between the three commands.
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8bc94d392b..7a01d00f53 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1604,6 +1604,9 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	}
 	if (opts->checkout_index < 0 || opts->checkout_worktree < 0)
 		BUG("these flags should be non-negative by now");
+	if (opts->checkout_index > 0 && opts->checkout_worktree > 0 &&
+	    !opts->from_treeish)
+		die(_("--source required when using --worktree and --staged"));
 	/*
 	 * convenient shortcut: "git restore --staged" equals
 	 * "git restore --staged --source HEAD"
diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
index 076d0df7fc..19efa21fdb 100755
--- a/t/t2070-restore.sh
+++ b/t/t2070-restore.sh
@@ -69,6 +69,11 @@ test_expect_success 'restore --staged uses HEAD as source' '
 	test_cmp expected actual
 '
 
+test_expect_success 'restore --worktree --staged requires --source' '
+	test_must_fail git restore --worktree --staged first.t 2>err &&
+	test_i18ngrep "source required when using --worktree and --staged" err
+'
+
 test_expect_success 'restore --ignore-unmerged ignores unmerged entries' '
 	git init unmerged &&
 	(
-- 
2.26.2.526.g744177e7f7

