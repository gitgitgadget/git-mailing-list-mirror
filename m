Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C096C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 03:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 460A560EE9
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 03:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239019AbhINDkY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 23:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238846AbhINDkO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 23:40:14 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC80C061762
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 20:38:50 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id u19-20020a7bc053000000b002f8d045b2caso1378887wmc.1
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 20:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=k48/OY3a/Od2qbkotgxVXMxzPpJgzp+Wqzz1gQdi384=;
        b=aWv+mN4kqDd42KqpRFWyC74g0/6F+WUg+IkJO7chbMmfZ5Xx27Lslv7fzdayr1UPEm
         dPdvd0BD1QW5QtVKbeuLLIGEgRjdcSVpeRCBUiLi+RW60kYgHxJMS8JLOO7PZNKmyJKI
         fFP6BOYfXC/KK+rpj8EmuhTkITCzIkyH5EUSPwJWxq/DkCbjwURAAZ2Hue7tj+BsIlE0
         mFNC1yAYQxwd2G4vH3AvwKcf8ZTQRTs/Fool8T8jndt/zoUyf/jdRQ2ScZkAQF4Ubcqo
         QJF6MjSWQ7zk6f1g2qbTKzjXjF7LtXNgcOqjjxmFBtDY82c/GW42haXloXwaIh99CQl2
         c9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=k48/OY3a/Od2qbkotgxVXMxzPpJgzp+Wqzz1gQdi384=;
        b=XUqLS3MNM7Bhuq6tbgZC6RvzAqP+/7OaMH7qrEWIHB1yc1cQay04hamE621RwznzT4
         FtPPrDfbvEM1huQKmkDYoJ24jT9sVtH8Pgz1wpa/vDhCtkg5f0J2YA2yZNPw+kZEdI0R
         CzEiJqiFeW122mX4QmiHfH4W0KNczoyBXY2JBiU/bpY/BXuhF6LUnmlbh5cAaIaLu2L0
         5/4dKiujjnyxkIX32/8brKLQOLnISULSqUvg+puwdLuPIsN8EpKhEHVVPcxAq17e0yrx
         E17Aj+hg2nkePDG626U7FGQoBF9IA2CjulSFpnWEkjvHlfxCHlIQhETV4EcJxGkIcgfA
         9M5w==
X-Gm-Message-State: AOAM531ZwGEhWGcxoVBP5277cPgNw3/pMtMpSv4uKOeZ0ghQaDn/dyOh
        5FMyuNiWhlN/VuHetQu9rsQdaBlL8Fc=
X-Google-Smtp-Source: ABdhPJycNlMtWokGlOiWXygAcsECLq995JILSbnsgIX7PtsnRoHnZxG2ZK87LuECthxZoJ6te/lO+w==
X-Received: by 2002:a7b:c405:: with SMTP id k5mr13178037wmi.24.1631590729049;
        Mon, 13 Sep 2021 20:38:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w1sm8332895wmc.19.2021.09.13.20.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 20:38:48 -0700 (PDT)
Message-Id: <6b5760389863d86fc15c69cfb31bafce5ad636e1.1631590725.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
References: <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com>
        <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Sep 2021 03:38:43 +0000
Subject: [PATCH v3 4/6] update-index: use the bulk-checkin infrastructure
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, "Randall S. Becker" <rsbecker@nexbridge.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

The update-index functionality is used internally by 'git stash push' to
setup the internal stashed commit.

This change enables bulk-checkin for update-index infrastructure to
speed up adding new objects to the object database by leveraging the
pack functionality and the new bulk-fsync functionality. This mode
is enabled when passing paths to update-index via the --stdin flag,
as is done by 'git stash'.

There is some risk with this change, since under batch fsync, the object
files will not be available until the update-index is entirely complete.
This usage is unlikely, since any tool invoking update-index and
expecting to see objects would have to snoop the output of --verbose to
find out when update-index has actually processed a given path.
Additionally the index is locked for the duration of the update.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 builtin/update-index.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 187203e8bb5..b0689f2cdf6 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -5,6 +5,7 @@
  */
 #define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
+#include "bulk-checkin.h"
 #include "config.h"
 #include "lockfile.h"
 #include "quote.h"
@@ -1150,6 +1151,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		struct strbuf unquoted = STRBUF_INIT;
 
 		setup_work_tree();
+		plug_bulk_checkin();
 		while (getline_fn(&buf, stdin) != EOF) {
 			char *p;
 			if (!nul_term_line && buf.buf[0] == '"') {
@@ -1164,6 +1166,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 				chmod_path(set_executable_bit, p);
 			free(p);
 		}
+		unplug_bulk_checkin(&lock_file);
 		strbuf_release(&unquoted);
 		strbuf_release(&buf);
 	}
-- 
gitgitgadget

