Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226F2C433E1
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 21:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01A582072E
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 21:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiHCbybz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgFJVTr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgFJVTj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 17:19:39 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD40C08C5C2
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 14:19:38 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x13so3944112wrv.4
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 14:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=azMY6CWcHFb5wZNaSBX4BXiCB1ZuxEgT2C6hfHTdbTw=;
        b=EiHCbybzyOtoJbJR248dTPBUu/7yo+KMFQ2rN5RpDn7r+urp7ZOvMU2mUpRMDeDSV6
         7RFHjrUK2U66yKmC18shROoDhwQ9zyl4VDMNXUlSxqdsedTnh2Z6Lxwq2IYDW1W4iMP/
         mU97Y43Z3I8V3a6K0XfMrQFYNI7A1VO07p0gg+iyeilzLF5JEvAP7gR3j7EFwqUN6ec9
         L2Vx11I3UGusnz6WZJhfTQ47F5Db8sqSHrHlN71j80zTsNaXxVKN3/dtfQI2VOkYPCtr
         SRPazmfTlDJ+muJYlC9YgzoFSM67PczyjzQd03NBoY4BhEKFB3SlVZvZcyopOlfcPkOW
         VUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=azMY6CWcHFb5wZNaSBX4BXiCB1ZuxEgT2C6hfHTdbTw=;
        b=HiLrt4ZZ1MikLmLnfj9ktGxQiRAVHJWA9agy+7/XA/XXSdg7vD1DgH1NUy+MQUmByE
         +ASpSnh5poS9BBWjBGSaJ4bd4Iyxd5N4oSAnzscyKNWSyJkzQr9DI0qn2vu6xJQOOePI
         utWA08ICYhJLZdHxmyxkDyrmbQ0uE1d5piETO917aezd2mba/MazmWuU+5e3yO+ICG9C
         qLS6MBFpKfztSvVoa9UUsWiXsa6oIw4zOSa6x5vFJ77GQZgttpQ1wEpkzhnZx287KfH2
         LgB00goYKJvsoCZaL5W2xW/Zx6SeBiiU9PlSIXyfPJVU6htsw7Z3Au9Rwo6xWHBIneVC
         AuUA==
X-Gm-Message-State: AOAM533VK2fvwQWVpFqme6vGzf4L5ZJhKj1/C9G14WyoDr8EGAdImexJ
        iiTCp7qlDEgM+rp2UOQH1MbiTfIV
X-Google-Smtp-Source: ABdhPJx03C5FyqVm3DIN33PCPVvzctpf0+XZ7xO38Zl8YXLbhnw7ejU1DqYLF0WX3gn+yclQOyGgkA==
X-Received: by 2002:adf:a350:: with SMTP id d16mr5942493wrb.237.1591823977402;
        Wed, 10 Jun 2020 14:19:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d18sm1480978wrn.34.2020.06.10.14.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 14:19:36 -0700 (PDT)
Message-Id: <06ef42052d534a668bf5227e79f1ca3b5c6aa2c1.1591823971.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.656.git.1591823971.gitgitgadget@gmail.com>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Jun 2020 21:19:26 +0000
Subject: [PATCH 5/9] submodule: use the (possibly overridden) default branch
 name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     don@goodman-wilson.com, stolee@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

To allow for overriding the default branch name, we have introduced a
config setting. With this patch, the `git submodule` command learns
about this, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/submodule--helper.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 46c03d2a126..0b4abb5a64b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1980,8 +1980,14 @@ static const char *remote_submodule_branch(const char *path)
 		branch = sub->branch;
 	free(key);
 
-	if (!branch)
-		return "master";
+	if (!branch) {
+		static char *default_branch;
+
+		if (!default_branch)
+			default_branch = git_default_branch_name(1);
+
+		return default_branch;
+	}
 
 	if (!strcmp(branch, ".")) {
 		const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
-- 
gitgitgadget

