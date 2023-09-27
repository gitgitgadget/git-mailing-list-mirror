Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68BBE82CCC
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 19:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjI0T47 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjI0T4e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 15:56:34 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6216CE3
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:56:10 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-79fa87d8f7aso343454439f.3
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695844570; x=1696449370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bH2hzoWai8vH7Zjh0kf9Emav2ZMVmyeQiZtNTadsv4M=;
        b=mOZRSvFuuuaYGmdH1Poe9JzBOzPCbeLgDDw0FnsFR0JADmHlB114XUYPZwfLUgP8Ts
         GBiPXh0guaopV7DdEukdVisJIAHtcARmjve4tocaJYWCWC+7tvp6+puiTCdteld9Cw6n
         1dWb+Kwp8sCt5WpKz4Ez4J/6edi2/Hv7dw2iXgpKo6IrROXyeLCHtA2r/G1oDjQYFQz+
         MPTGHybEOJk8yz0fQziSdn6PohAZHzTNhXVF1Hu/79k06ebwyVpUkU+Z5c8G74Foursl
         LkT3leu/LW7mopIUiACH2rFP8yf13pz4XKERf+F8ztONfeRUPM1/6U/OVxZnFUopdoT4
         gvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695844570; x=1696449370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bH2hzoWai8vH7Zjh0kf9Emav2ZMVmyeQiZtNTadsv4M=;
        b=P63i3dlgAgL9E7we5FA//ZhtGxLMz6YkAmMazTFC6m1en/d0hOCMLjVCdgmCB6BQU5
         txgo8aBZZ2m5P3GCPcFlIE8UMGi5+oDSag429lQ2DNa4d6p5wmIAIOHbEJNUIwFWh6rg
         wDo/wAXkyRyEQIYfm+Cd4Hq4g+CNtzhUd8D0JbzO0xXCBLfVbjbifXFspiT0Aatrdc0L
         8gCfgFZjzAG08VzVPptFXqGEH5Fdsve02TvEYMGlPd7mpCqKXJziB8dF0qxQp/H7bcOH
         OpK5UCII5zN/wkIa29fyIoxSzkR2spyVnQIPmgRp9NtMmuB5QCOTa3r/4T3R3LS3JSR0
         JS5A==
X-Gm-Message-State: AOJu0YzlomgwVY0N0ooxrTIPier58swJf4UmhV6RV0gnw0AMa8OobxPe
        rDY05gQHKi9KpfnaJ3AkAjM=
X-Google-Smtp-Source: AGHT+IFAQ20+gJHatmpOOAW17oWZGaVhHsDUl1kxlPof4VE3IiOUQZ8yq1vpk99CWQ7tVh4dqFwUYg==
X-Received: by 2002:a6b:4902:0:b0:780:d76c:b640 with SMTP id u2-20020a6b4902000000b00780d76cb640mr2966848iob.9.1695844569892;
        Wed, 27 Sep 2023 12:56:09 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id o23-20020a6b5a17000000b007836c7e8dccsm2935628iob.17.2023.09.27.12.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:56:09 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 26/30] builtin/ls-tree: Let the oid determine the output algorithm
Date:   Wed, 27 Sep 2023 14:55:33 -0500
Message-Id: <20230927195537.1682-26-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

Update cmd_ls_tree to call get_oid_with_context and pass
GET_OID_HASH_ANY instead of calling the simpler repo_get_oid.

This implments in ls-tree the behavior that asking to display a sha1
hash displays the corrresponding sha1 encoded object and asking to
display a sha256 hash displayes the corresponding sha256 encoded
object.

This is useful for testing the conversion of an object to an
equivlanet object encoded with a different hash function.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 builtin/ls-tree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index f558db5f3b80..71281ab705b6 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -376,6 +376,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	struct ls_tree_cmdmode_to_fmt *m2f = ls_tree_cmdmode_format;
+	struct object_context obj_context;
 	int ret;
 
 	git_config(git_default_config, NULL);
@@ -407,7 +408,9 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 			ls_tree_usage, ls_tree_options);
 	if (argc < 1)
 		usage_with_options(ls_tree_usage, ls_tree_options);
-	if (repo_get_oid(the_repository, argv[0], &oid))
+	if (get_oid_with_context(the_repository, argv[0],
+				 GET_OID_HASH_ANY, &oid,
+				 &obj_context))
 		die("Not a valid object name %s", argv[0]);
 
 	/*
-- 
2.41.0

