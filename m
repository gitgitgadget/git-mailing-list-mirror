Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1D0C433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E46C961251
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbhJDCAU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 22:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbhJDCAS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 22:00:18 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49722C061781
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 18:58:30 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r7so12299129wrc.10
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 18:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xeI+ChQIs9rABQwn6X5yx+5WsnJVtgEtVV0J/ZHmBL4=;
        b=MGfSYbIBz+sl2hjdSOj9OTQnfX7VBO8pbWS/xZPI1Y45zyBx8o3+PfsgET4X8Bs0re
         ETsayFnvrzhSEUJNWcK7gR35rECisxJgtyUCeQx2535b/gXx2vVMDiqTEHV0li77dEft
         XID8jpsPsml7Wr2p/8Ch0jOVbZkS0zGtu43QRVcVDHfVgbL3K+ZHWsNwl2hp2+a1NKt5
         bDhGHkxbAjcjG06oG/mkGvz+DtjytgvBvCWb8Mhugt5WwotXUsvsH1G9IukacuT0yj0j
         bUdqPBxv0AyjWvMCsREQwns5aXVbG2DZqRB/HPvoOCbPK28Kq9mm3JlpW0BYQDfxYQkH
         3VJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xeI+ChQIs9rABQwn6X5yx+5WsnJVtgEtVV0J/ZHmBL4=;
        b=q8PacU9KjMLXXBqHxz5zRjdPoX/NxofE0mXe7JxCFHc0lsb0GSsJCxmysCPzDcl8aK
         H4KZ/4c9cZEY4ReZCrnYcHkeGeAzWUcYYGyVhfDj7t+kD3mAs9uTgPFltFPhyfVLaZ27
         aAqgITrYLFbsWHp9oewJed9t6r01R+erzih/XMA/xXxUN8FI0VBIabgVZwHX1v/ZFrJW
         yDKhPgHdS4FneIQrfMlTPvXehij/iY0GsetPE9YXhDT06/7jr+9R8AWQsiGfSiEaKrzV
         wguYNUXkVIREDwQigTjTfJzaTHwnH0Bt+FHG+hkizQgP0HPyQBlFWBPOVAyAYiBgsFwt
         a7tQ==
X-Gm-Message-State: AOAM5301g/NgpOONPszkFGtwAhudugVI9m4MkAPDAZeikwVYb2NFH/gU
        7Z4cAj/4MN0/zjcAewSptyJ3kXU+Atb78g==
X-Google-Smtp-Source: ABdhPJxbCepRdVDKYhzGSCfkO1yQVNs1mTRr34s+mRzXcpS7o19IBSriIAeMZ001rNsO0NeO9F8Zug==
X-Received: by 2002:adf:9784:: with SMTP id s4mr3608739wrb.277.1633312708694;
        Sun, 03 Oct 2021 18:58:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y23sm15349355wmi.16.2021.10.03.18.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 18:58:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ben Boeckel <mathstuf@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Heba Waly <heba.waly@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/5] advice.[ch]: remove advice.pushNonFastForward alias
Date:   Mon,  4 Oct 2021 03:58:22 +0200
Message-Id: <patch-3.5-00eaaeccbcb-20211004T015432Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1404.g7bcfc82b295
In-Reply-To: <cover-0.5-00000000000-20211004T015432Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20211004T015432Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The advice.pushNonFastForward variable has been primarily known as
advice.pushUpdateRejected since 1184564eac8 (push: rename config
variable for more general use, 2012-12-02). It's been long enough by
far that we can declare this deprecation period over and remove it.

The only downside for users is going to be that they'll potentially
see a more verbose warning that they'll have to re-squash by changing
their config, but that's hardly an undue burden.

Doing this allows us to simplify the advice_enabled() function down to
something truly trivial.

Change the only in-tree user of this, it was added in
fd47d7b94db (git-remote-mediawiki: obey advice.pushNonFastForward,
2011-09-27), and not renamed in 1184564eac8 along with the rest.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 advice.c                                    | 12 +-----------
 advice.h                                    |  1 -
 contrib/mw-to-git/git-remote-mediawiki.perl |  2 +-
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/advice.c b/advice.c
index 9691c7e7899..b395bc7d187 100644
--- a/advice.c
+++ b/advice.c
@@ -52,10 +52,6 @@ static struct {
 	[ADVICE_PUSH_FETCH_FIRST]			= { "pushFetchFirst", 1 },
 	[ADVICE_PUSH_NEEDS_FORCE]			= { "pushNeedsForce", 1 },
 	[ADVICE_PUSH_REF_NEEDS_UPDATE]			= { "pushRefNeedsUpdate", 1 },
-
-	/* make this an alias for backward compatibility */
-	[ADVICE_PUSH_UPDATE_REJECTED_ALIAS]		= { "pushNonFastForward", 1 },
-
 	[ADVICE_PUSH_NON_FF_CURRENT]			= { "pushNonFFCurrent", 1 },
 	[ADVICE_PUSH_NON_FF_MATCHING]			= { "pushNonFFMatching", 1 },
 	[ADVICE_PUSH_UNQUALIFIED_REF_NAME]		= { "pushUnqualifiedRefName", 1 },
@@ -116,13 +112,7 @@ void advise(const char *advice, ...)
 
 int advice_enabled(enum advice_type type)
 {
-	switch(type) {
-	case ADVICE_PUSH_UPDATE_REJECTED:
-		return advice_setting[ADVICE_PUSH_UPDATE_REJECTED].enabled &&
-		       advice_setting[ADVICE_PUSH_UPDATE_REJECTED_ALIAS].enabled;
-	default:
-		return advice_setting[type].enabled;
-	}
+	return advice_setting[type].enabled;
 }
 
 void advise_if_enabled(enum advice_type type, const char *advice, ...)
diff --git a/advice.h b/advice.h
index 694219f5cb2..ab25c6ba9a0 100644
--- a/advice.h
+++ b/advice.h
@@ -32,7 +32,6 @@ enum advice_type {
 	ADVICE_PUSH_NON_FF_CURRENT,
 	ADVICE_PUSH_NON_FF_MATCHING,
 	ADVICE_PUSH_UNQUALIFIED_REF_NAME,
-	ADVICE_PUSH_UPDATE_REJECTED_ALIAS,
 	ADVICE_PUSH_UPDATE_REJECTED,
 	ADVICE_PUSH_REF_NEEDS_UPDATE,
 	ADVICE_RESET_QUIET_WARNING,
diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index a5624413dc1..158e89e5048 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -983,7 +983,7 @@ sub mw_import_revids {
 }
 
 sub error_non_fast_forward {
-	my $advice = run_git_quoted(["config", "--bool", "advice.pushNonFastForward"]);
+	my $advice = run_git_quoted(["config", "--bool", "advice.pushUpdateRejected"]);
 	chomp($advice);
 	if ($advice ne 'false') {
 		# Native git-push would show this after the summary.
-- 
2.33.0.1404.g7bcfc82b295

