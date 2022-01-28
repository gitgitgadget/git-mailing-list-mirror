Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53FAC433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 00:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344573AbiA1AMq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 19:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344501AbiA1AMl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 19:12:41 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFD1C061747
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 16:12:41 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id v13so7642090wrv.10
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 16:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6t4zwA2s9MdWvpmCtWClF0zdY8OAi7qhJLIO4F/BgO4=;
        b=Cgo63HZHm1EgzqmvwWYahnHWFXuNcpgix9W/xSQWY3xkhztM+yEsKL0hgr+sNLEPgp
         dapaKTf1NiJkBX3xeeS2PxmNJ22mRukAboP5Q/bAqhqA9Ikgnx6mKTIY7EfIKl0aunWP
         CwDdpKFHvVHAr/STmdbKP1kxjEPZMys7l05ZxfRnc5qgcot3ynLGNc3lkSq6zdEuCSN8
         leHpwCfVm1jLa0vq4B973oTcxkKlGnozqY5D22U/jnfX6cQAXkSNfcMmXxxKcdceuEZx
         J7LryWxZPOr6h11VUJAF/o5CKgZY3VsdtFvwRCo42tWJhThE2eeStM4VANivrFe7aecN
         LZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6t4zwA2s9MdWvpmCtWClF0zdY8OAi7qhJLIO4F/BgO4=;
        b=OPSzQnlo2qiG4wCkQYOUmgdUp0CidkkkCYx7OrH85mL5BoVX/rPng1H/fQlqp4w4zC
         +KTVXM7P8cXNEnSUwjdL5pBhnsDm4tOGTl/R3qlRKXOTXwxXu6UhbAuZdO31v7/Gs3rM
         EoYlPm6k3F/MofHMhTox69QfHHCr5ddLL0ymWHzAFTB6PueFki8CYvFz/gifb1FzQs2w
         8DkbzvQrAyrwwEX4AvUOCSh3yGuVY9SH6UamK6IzlTWMZRDSBs1RX6E0ByGwopo2SBjc
         qXa0dpKKfQnFDAMSX97KEFqeDMiznjcEJLfDYzXUYZqpOqI/q1LLT9JjOsUOJy2Ocdtq
         lZig==
X-Gm-Message-State: AOAM532qrBC2pifYbFugHWppQbZG1nBHPe1IQjwYAfnB9vtgWT4Kiiv/
        L90dBN7hQhSzZMx02TzjTVJrC7SFdw8=
X-Google-Smtp-Source: ABdhPJy4HCWEI1C8xbczfPfnrdX3rOC4LXJbYB4B58H5HTiwelOvIZYaFmwY/bkSw4mBYsBtUsJs6A==
X-Received: by 2002:a5d:6488:: with SMTP id o8mr4934027wri.206.1643328759643;
        Thu, 27 Jan 2022 16:12:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i3sm3297247wru.33.2022.01.27.16.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 16:12:39 -0800 (PST)
Message-Id: <1b14ed3d7976b8fe4149822dcbb32343e0554a38.1643328752.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Jan 2022 00:12:29 +0000
Subject: [PATCH 08/11] bisect--helper: using `--bisect-state` without an
 argument is a bug
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `bisect--helper` command is not expected to be used directly by the
user. Therefore, it is a bug if it receives no argument to the
`--bisect-state` command mode, not a user error. Which means that we
need to call `BUG()` instead of `die()`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 4450305c81c..009c919a989 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -872,7 +872,7 @@ static enum bisect_error bisect_state(struct bisect_terms *terms, const char **a
 	struct oid_array revs = OID_ARRAY_INIT;
 
 	if (!argc)
-		return error(_("Please call `--bisect-state` with at least one argument"));
+		BUG("bisect_state() called without argument");
 
 	if (bisect_autostart(terms))
 		return BISECT_FAILED;
-- 
gitgitgadget

