Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F0591F576
	for <e@80x24.org>; Wed, 24 Jan 2018 09:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932744AbeAXJam (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 04:30:42 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46587 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932606AbeAXJak (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 04:30:40 -0500
Received: by mail-pg0-f66.google.com with SMTP id s9so2287895pgq.13
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 01:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2c7z25A3CVglvq6N7L/+em7MPOFT1B6Ks7R9Iqi2gSg=;
        b=DIXX5sPv0VMBfDu0oi2Z2SoiISe+/jFPIUsr93y4rrvby91J07In8uUzNv+uODBVBj
         oDB6DhTWRZ0XUvcV0JlYZMw1+Sprgp59wUG1ygoHqdGN5T3il7osjN0+NJP5D7ILOEug
         18fAo4iOVK2P4R+cjkFO3TJigUiJSyK2Pvn5nemPukJcAFL3+3/h/WG5t8ambYZ028n9
         FM2BOB3gG6Qp+Zwdi2uK0YC82gED4gzvwoqy8XotSlbJrR1SajlAzYQ2hLWi8+sS3zNk
         rrDhGBDcHVMD1gdPcp/e0hePLd8R0oy6qBGTasqzj0qYNYhUfJEXxJqlNAqihzZ408zE
         iL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2c7z25A3CVglvq6N7L/+em7MPOFT1B6Ks7R9Iqi2gSg=;
        b=SBlsTPo+prvFtDNiH/bFLLd7e8qLVQkV9uvxxSZlaO6o9yNy69f9laxmxMy8tg18hl
         KIfmqZRoH7CmPqYVT/nMGnIES4YZF9U71f9L3IGKcYALwQfyh23RgEjs6coOE/+ZbWLh
         yLkkqHKyA3ME/hiYjojyXHOqpV4grrklsOZ6Izgfd+/bkZfB3LO57OiinTqu2eKrotqM
         Hk1qd4XK6EBMqZaDdvAEnFivjpl8qquwkKxsJ3O4nUlV6Ua0fbqeshR0aOXmIt9+5HuD
         DFAJ0aMdL5iV1+Aw/nuJygLBqnJxovxDmiJw/CfSrar8leDIMBGRnPxeD6RRUolB8QK7
         klcQ==
X-Gm-Message-State: AKwxytd7MgSmEJayIueWoDXo/XxIoW9Or+NQxsww/S9z5a2GPXSkfrgU
        gVUN2OcDxBGFQ0rGjQsPBV55Xg==
X-Google-Smtp-Source: AH8x225kyL6x0+klWFAgIGT5sxT0cvwa7CqgCgu8uDA798yDbPJI6rGeehGST8pahIAWF9vShFYErA==
X-Received: by 2002:a17:902:5a3:: with SMTP id f32-v6mr7723209plf.48.1516786240153;
        Wed, 24 Jan 2018 01:30:40 -0800 (PST)
Received: from ash ([171.233.110.59])
        by smtp.gmail.com with ESMTPSA id w10sm32928562pgc.69.2018.01.24.01.30.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jan 2018 01:30:39 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 24 Jan 2018 16:30:35 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/5] dir.c: avoid stat() in valid_cached_dir()
Date:   Wed, 24 Jan 2018 16:30:20 +0700
Message-Id: <20180124093023.9071-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.0.47.g3d9b0fac3a
In-Reply-To: <20180124093023.9071-1-pclouds@gmail.com>
References: <20180118095036.29422-1-pclouds@gmail.com>
 <20180124093023.9071-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

stat() may follow a symlink and return stat data of the link's target
instead of the link itself. We are concerned about the link itself.

It's kind of hard to demonstrate the bug. I think when path->buf is a
symlink, we most likely find that its target's stat data does not
match our cached one, which means we ignore the cache and fall back to
slow path.

This is performance issue, not correctness (though we could still
catch it by verifying test-dump-untracked-cache. The less unlikely
case is, link target stat data matches the cached version and we
incorrectly go fast path, ignoring real data on disk. A test for this
may involve manipulating stat data, which may be not portable.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 3c54366a17..ee1605f004 100644
--- a/dir.c
+++ b/dir.c
@@ -1739,7 +1739,7 @@ static int valid_cached_dir(struct dir_struct *dir,
 	 */
 	refresh_fsmonitor(istate);
 	if (!(dir->untracked->use_fsmonitor && untracked->valid)) {
-		if (stat(path->len ? path->buf : ".", &st)) {
+		if (lstat(path->len ? path->buf : ".", &st)) {
 			invalidate_directory(dir->untracked, untracked);
 			memset(&untracked->stat_data, 0, sizeof(untracked->stat_data));
 			return 0;
-- 
2.16.0.47.g3d9b0fac3a

