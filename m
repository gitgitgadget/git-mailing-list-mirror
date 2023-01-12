Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87BCC54EBD
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 12:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjALMqg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 07:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjALMqO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 07:46:14 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D0113DDC
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 04:46:11 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id jo4so44488433ejb.7
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 04:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yW7Z0bTG93hxB1K9CLhY9doKlr5T5GPH1I8DY7Xqa0=;
        b=c1ZrBa9Ta8hQvh70kwhXaWYo/mzyjblJlePllM0pGc9Kx7zpgbUN3CwOujjKN6HjMp
         oPd9WrsrESBhpkgdmEoWfNeRaTv9vm3Zyh/KANzfWe0QhBkUAFr43UERl9JByvhiaLLl
         8ZTjAu/6uqsIH7ODFF39yCWAZwzlPlshiguzhlHt7FK7b2nDwKevdGY+1pBxvnXVNPh5
         kHt5J1TkTi0I6lN4eFj7XvWV1rO5LM2rtCTXUC3PY3rmaop9wnXTshQJVKsIVktgv6yR
         v0tn7DBC6P2w1luhB++ND1SdDG25kNxEb35Xm6cXVBqijBZWeOscX1Zg8/IFUkbpJWj5
         ESdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9yW7Z0bTG93hxB1K9CLhY9doKlr5T5GPH1I8DY7Xqa0=;
        b=Ver/E0bvYWzxMFB7YNsuupo1sWr9G1aEIZ9Otn83DhjDTgafFohrw/RMxh+pHax1tJ
         7DDTkLY4P6Omgy2b22gWNvjbR3NEcU3p3uB20t0RqjwHknNW1iPzUJ3idmqFYRjfzz3x
         9DYkknxRAx7kS4vKAyBcvrY27s9h6MIM4VyT2yFk2MWALzpxRjYYjfIdjZCqAfa3jLEh
         GROWLgb6j3QTHv9lq85oAxrBexJZzMCNPk5cyBSTR+a95AozuVYmUsQBH0gah+KTvzhj
         t/K238qja85C6c5K4vkOdyjuZMVrb/JYj0ZzW48K1HY5tQzbMjOyuA8j7gXA0y5Kg45D
         qC6g==
X-Gm-Message-State: AFqh2kp6H7IGv1Wz+KVboYUYurrxzNVpf9rAM/4GYJEXSaZX2UOSDdDM
        TcfdiBswQBq0Sh0Dgwy0Z0ZjZ7Nv8ypPSA==
X-Google-Smtp-Source: AMrXdXvKJK6H8wRU5YB7eOxNkQ6d5fAqSvNdiXbqNFoeINbppvZY3oZOh52+3k8c3iyVvkgtpb6k1g==
X-Received: by 2002:a17:907:238e:b0:84d:457a:39d5 with SMTP id vf14-20020a170907238e00b0084d457a39d5mr10377929ejb.44.1673527569910;
        Thu, 12 Jan 2023 04:46:09 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v17-20020a170906293100b007be301a1d51sm7373523ejd.211.2023.01.12.04.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 04:46:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/9] builtin/rebase.c: rename "squash_onto_name" to "to_free"
Date:   Thu, 12 Jan 2023 13:45:57 +0100
Message-Id: <patch-v2-5.9-4fea2b77c6d-20230112T124201Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1205.g2ca064edc27
In-Reply-To: <cover-v2-0.9-00000000000-20230112T124201Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20230112T124201Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The real use of the "squash_onto_name" added in [1] is to keep track
of a value for later free()-ing, we don't subsequently use it for
anything else.

Let's rename it in preparation for re-using it for free()-ing before
another assignment to "options.onto_name", which is an outstanding
leak that'll be fixed in a subsequent commit.

1. 9dba809a69a (builtin rebase: support --root, 2018-09-04)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/rebase.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 5859a5387d8..0d8c050f6b3 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1036,7 +1036,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	const char *rebase_merges = NULL;
 	struct string_list strategy_options = STRING_LIST_INIT_NODUP;
 	struct object_id squash_onto;
-	char *squash_onto_name = NULL;
+	char *to_free = NULL;
 	int reschedule_failed_exec = -1;
 	int allow_preemptive_ff = 1;
 	int preserve_merges_selected = 0;
@@ -1589,7 +1589,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 					&squash_onto, NULL, NULL) < 0)
 				die(_("Could not create new root commit"));
 			options.squash_onto = &squash_onto;
-			options.onto_name = squash_onto_name =
+			options.onto_name = to_free =
 				xstrdup(oid_to_hex(&squash_onto));
 		} else
 			options.root_with_onto = 1;
@@ -1835,7 +1835,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	free(options.cmd);
 	free(options.strategy);
 	strbuf_release(&options.git_format_patch_opt);
-	free(squash_onto_name);
+	free(to_free);
 	string_list_clear(&exec, 0);
 	string_list_clear(&strategy_options, 0);
 	return !!ret;
-- 
2.39.0.1205.g2ca064edc27

