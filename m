Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C06BC433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 20:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75B6C2076E
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 20:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjhlSdP9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgHEUBu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgHEQkH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 12:40:07 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870ACC0A54D8
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 06:34:46 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k20so6353518wmi.5
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 06:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=q/VKbgaqXwb22OtOuemlOUEe/c49c2WOTrwLfmpWBjY=;
        b=XjhlSdP9+4p+U7DY3UPgsqcy1Vg+OdRYlpe96boOpKURm5gc/1ZCCgrsVpmIecmwCV
         Fe3HLnHOJDSzpZVaHsobSFiXQFeY7foW58SnpLgV6q75vE0U3v3FKh6t7aBc1/Qiyr2w
         F9EDKscHCaMJ2BjizD1jb6aABt4j5i93nbSKEOU8QXpyp4isxPyB8biG8Ri5rCeGR8co
         ejaq2NCx0Uts2zhyIbZfAo5z+OYG7Sa04VYKfEn2dro3Wvy8EJwBVTXSDDGQR5biq/DZ
         IcLTEvIJZGenbvkzD8KgRKrDcWwIMnyJLLkQwwXcJyoaCyrS0r7KyDO8pAj/fIwY/7EI
         bMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=q/VKbgaqXwb22OtOuemlOUEe/c49c2WOTrwLfmpWBjY=;
        b=XKhXnVJtlC7zTNvtNqTQWWkU5I2NOJRiQVqzE2jxIcyb3Pfeyd36MUEygUEtqdZO2D
         /PlSn2XCLrKwsZ2koBz7Ak26d+hHH8YB98BRiudkd+sF69yVH3uAOPONiUNcdcgtcYbf
         11Q7EJdgX/orOZ7ryw0FhW3gGMrk5fOBR9vtjAmFg//uILCC4EapyTxvQPteXoXsrLSX
         BVtNhD70hErcJNN0FxJ+MWzjxwDjClhT+wocZ8ZIRb+yIYg5dqUk+goV6kpVzmdP9ZSO
         FMtcJWis2+DqjxaTGBMgST4Wink7KjFALsaVgWym1/WE19V/Chmvc0HrOp3/iJHOo4/u
         m4LQ==
X-Gm-Message-State: AOAM533nwIZtLdNTb5Q4AAZwmqk9guJx9oqQsNjIgPglhn94Sx1EeiDK
        JAfjlu+jb70SScN7S+Q4HbLg+NNZ
X-Google-Smtp-Source: ABdhPJzP4LPDuOJDLo+PmPUDMZlwb2/our4B2Ej7Gd2KhJdlJgExE0vUqn+AaWVJfTV5F22j1bbbeQ==
X-Received: by 2002:a1c:32c3:: with SMTP id y186mr3289375wmy.15.1596634467640;
        Wed, 05 Aug 2020 06:34:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r206sm2946757wma.6.2020.08.05.06.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:34:27 -0700 (PDT)
Message-Id: <37090d232221415b227c165bd44f6711d21f376b.1596634463.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.693.git.1596634463.gitgitgadget@gmail.com>
References: <pull.693.git.1596634463.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Marco=20Trevisan=20=28Trevi=C3=B1o=29?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 05 Aug 2020 13:34:23 +0000
Subject: [PATCH 3/3] mergetool-lib: give kdiff3 prioirty in KDE environments
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Marco Trevisan <mail@3v1n0.net>,
        =?UTF-8?q?Marco=20Trevisan=20=28Trevi=C3=B1o=29?= <mail@3v1n0.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Marco=20Trevisan=20=28Trevi=C3=B1o=29?= <mail@3v1n0.net>

Signed-off-by: Marco Trevisan (Treviño) <mail@3v1n0.net>
---
 git-mergetool--lib.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 243cd2b06b..90de6ee884 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -288,12 +288,15 @@ list_merge_tool_candidates () {
 	fi
 	if test -n "$DISPLAY"
 	then
-		cross_desktop_tools="opendiff kdiff3 tkdiff xxdiff"
+		cross_desktop_tools="opendiff tkdiff xxdiff"
 		if is_desktop "GNOME"
 		then
-			tools="meld $cross_desktop_tools $tools"
+			tools="meld $cross_desktop_tools kdiff3 $tools"
+		elif is_desktop "KDE"
+		then
+			tools="kdiff3 $cross_desktop_tools meld $tools"
 		else
-			tools="$cross_desktop_tools meld $tools"
+			tools="$cross_desktop_tools kdiff3 meld $tools"
 		fi
 		tools="$tools gvimdiff diffuse diffmerge ecmerge"
 		tools="$tools p4merge araxis bc codecompare"
-- 
gitgitgadget
