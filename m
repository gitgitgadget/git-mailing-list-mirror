Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3145C20357
	for <e@80x24.org>; Mon, 17 Jul 2017 20:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751371AbdGQULq (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 16:11:46 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33775 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751349AbdGQULp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 16:11:45 -0400
Received: by mail-lf0-f67.google.com with SMTP id t72so26988lff.0
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 13:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kirhsXb6rTdUAfCgFokcXXRUlLlpllpm8nYrOxnunIw=;
        b=sZHOW3CDNCj8hs9Rode91l7THwpBpzChbBUaEbXeh21p6+JOZCw8LbsTI3KA+9klJB
         iPGhIXX78wGNzxdILZZt03cxn6vMM83KLhu54wCv7msArw7QNZ5fG9eaOCKXVpWws5Rx
         E+SfPtAFncFKErwmakdNCgIEf33xZdOzZg01x864mwUE9PC6fNDWjUylf+H6FQfZgN7+
         1Pqilm2ehpDSALLhH9nvwfpFm70lAO1gsl6NiJcRIprHbJA+VMLBocHOZtXiCTRz2u/N
         +cQy2yHfxEcelY+mY1ZFXd+pXqSPLxTi07ySSz5JsUJsvrdyyjAVQ+IW+2CsMEgLP8ah
         GFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kirhsXb6rTdUAfCgFokcXXRUlLlpllpm8nYrOxnunIw=;
        b=J74x7Oo6A1EFSfipo8GseCQyFszsEC1/1ykqs+C/tYL5kZCri0es1Xo7M59b6OzGiu
         qGMf4gkuFAZozAeklXDy4kcy1ysB/9ecoW/wL+iIYOoqtLbFMDJgIFfLKwn02yVdxBV2
         gOfGi44SMt1v2GndYzs60sorBA9FJck5SZ/VjnE9Y28RvZJN8TUAwjaOD0cKRb/DiWTk
         RMKhCBMhfWOW3LPSSJjqHhw1CE3uT42zOAKEnVZpJDyHVtHqp82q5DAPPmzcucgfivXE
         BjNmnZsEf9WUHEF3BsZola54kleRmEZKi8wLs2P771WRzYdYHYrj2RnrQc813LF+URel
         5k2g==
X-Gm-Message-State: AIVw1124Lycc6489X7zAgs9//EewMyDmRTaS7AYvhGABG/XF+xckyspf
        q9gXTfhYvxRVb7WO
X-Received: by 10.25.149.71 with SMTP id x68mr7539391lfd.136.1500322303843;
        Mon, 17 Jul 2017 13:11:43 -0700 (PDT)
Received: from localhost.localdomain (c83-248-253-33.bredband.comhem.se. [83.248.253.33])
        by smtp.gmail.com with ESMTPSA id l12sm30752ljb.39.2017.07.17.13.11.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Jul 2017 13:11:42 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 07/10] tag: handle `pager.tag`-configuration within the builtin
Date:   Mon, 17 Jul 2017 22:10:49 +0200
Message-Id: <37f4efda3f26649bc81c806576d770a2268aa4b2.1500321658.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.0.rc0
In-Reply-To: <cover.1500321657.git.martin.agren@gmail.com>
References: <cover.1499723297.git.martin.agren@gmail.com> <cover.1500321657.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the mechanisms introduced in two earlier patches to ignore
`pager.tag` in git.c and let the `git tag` builtin handle it on its own.

This is in preparation for the next patch, where we will want to ignore
`pager.tag` unless we run in list-mode. For this reason, place the call
to setup_auto_pager() after the options have been parsed and we have
decided whether we are in list-mode.

No functional change is intended. That said, there is a window between
where the pager is started before and after this patch, and if an error
occurs within this window, as of this patch the error message might not
be paged where it would have been paged before. Since
operation-parsing has to happen inside this window, a difference can be
seen with, e.g., `git -c pager.tag="echo pager is used" tag
--unknown-option`. This change in paging-behavior should be acceptable
since it only affects erroneous usages.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 builtin/tag.c | 2 ++
 git.c         | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 01154ea8d..9eda434fb 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -461,6 +461,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			cmdmode = 'l';
 	}
 
+	setup_auto_pager("tag", 0);
+
 	if ((create_tag_object || force) && (cmdmode != 0))
 		usage_with_options(git_tag_usage, options);
 
diff --git a/git.c b/git.c
index 66832f232..82ac2a092 100644
--- a/git.c
+++ b/git.c
@@ -466,7 +466,7 @@ static struct cmd_struct commands[] = {
 	{ "stripspace", cmd_stripspace },
 	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX},
 	{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
-	{ "tag", cmd_tag, RUN_SETUP },
+	{ "tag", cmd_tag, RUN_SETUP | DELAY_PAGER_CONFIG },
 	{ "unpack-file", cmd_unpack_file, RUN_SETUP },
 	{ "unpack-objects", cmd_unpack_objects, RUN_SETUP },
 	{ "update-index", cmd_update_index, RUN_SETUP },
-- 
2.14.0.rc0

