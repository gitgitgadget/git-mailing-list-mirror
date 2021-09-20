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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B459CC433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CCA5611ED
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347800AbhIUCVu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236467AbhIUBuT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 21:50:19 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0562FC07E5C2
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 15:15:17 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d6so33570896wrc.11
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 15:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=k48/OY3a/Od2qbkotgxVXMxzPpJgzp+Wqzz1gQdi384=;
        b=ftnw/rAjZF8jODN8OPNQFvJFATqUuFL4gfZ21GvP47QcbA2szBa+NA43yPaBZ9oaef
         7L/E4n44L4zpthy+paey7G7Dic5QztVWo+DnKNf1akL2rdEv+L/OhXzinl/2GRp3t82D
         UqskCspAQyAvSm5vJIFvAXdTyEtFrtPBWk9C/xD1tXi7DxNpBzBLO6266m1wSesVFY43
         oofocgLv8UM+fKb1myLEUVszg0YNPpw/o7GHbpvzl06LEophC2iFU8iXjKr02l3eVSw7
         +rWIWrhB/6LemyNp8oNnXDrUpyN6NbxxdRQrEnFUqwn42wrKpZS77Gsrp8ySa3Lw4wiU
         keUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=k48/OY3a/Od2qbkotgxVXMxzPpJgzp+Wqzz1gQdi384=;
        b=oJY/hCCWa6Crkd//exWw9Y1xuN43QVfKs0IdVGqWZfZ7NkHRJLOtlF+r9Lc2vvyspx
         j1I3J3RldrZvbJkUiJIX4bXe2ATjbQdu20+ie06+tQ0vF+Z/1vhkuFOd1Kcwo/DqERDw
         nbWktJ0nn9mJRZuQaLNcF7+q2ZtW+odUbKsuGIvwGr+YDNn8Cs6CHHr21HTyCXZAXLkl
         Kjp/pFko17mVHqZqxglhdUKuSUtyYsAJ9oz+x8QmxsJGR9IaC/ZGOS6D6JIsXavr9Fii
         hgyZJzY5+tqVrstAyGn7cv92OnFuuEEvzWQPlqwT2PiA6+jikiIr+G4tUCVXExy8eXvT
         UJAQ==
X-Gm-Message-State: AOAM533HnoqPikmaho2hekpVCzFANIZGuXS965c31zErgdptVU1Wbly1
        LzoaE+tq8Q6o7qz40WcHu31U1gB1PDw=
X-Google-Smtp-Source: ABdhPJyDInyBcF4kp9J0IdisDzaYRoeGFz9ExUKd8muQM+ZhtucBzn3LYzlHQhcnhUt3FLyC9HSXVQ==
X-Received: by 2002:a5d:55cf:: with SMTP id i15mr30205236wrw.224.1632176115611;
        Mon, 20 Sep 2021 15:15:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 48sm18306290wrc.14.2021.09.20.15.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 15:15:15 -0700 (PDT)
Message-Id: <f7f756f3932cdbca587de397598758c685bac29a.1632176111.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v4.git.git.1632176111.gitgitgadget@gmail.com>
References: <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
        <pull.1076.v4.git.git.1632176111.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Sep 2021 22:15:09 +0000
Subject: [PATCH v4 4/6] update-index: use the bulk-checkin infrastructure
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
        Bagas Sanjaya <bagasdotme@gmail.com>,
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

