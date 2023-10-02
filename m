Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197FBE784A6
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 02:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbjJBClv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 22:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235459AbjJBCl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 22:41:29 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BD3CD9
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 19:41:02 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-79fe612beabso285194339f.3
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 19:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696214462; x=1696819262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bH2hzoWai8vH7Zjh0kf9Emav2ZMVmyeQiZtNTadsv4M=;
        b=lASEcsrNuT4hGZb3nIUzcE4YEcwJxX9o6ceBa89bpPNCBX7C8Mge/HNFFJxJn8wUsO
         RK4jelrF4vFKOgutPbxn5UkUuJPPx7PooeFr21XO3Kwn8JjnTQY4y/bsQ75dGUlzZ76s
         27basMjKCFH34+fDgb17OqJxqKXHSNvcHZ6YOpOfI6QAk7wijK9MlndH4v0UZ3HI2S0z
         twy6pr1Kh1JEYyXy9tF8RrEatHYmk0to6J/Tqp8tp1hs0tfeLif0o229teT/NrcctSoD
         rVRxlcHElilVoRQt2kWVFpuCEqibvlLOENAJgKslknj57FiBTHNvD5g6XTylZvQTvbI6
         /nmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696214462; x=1696819262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bH2hzoWai8vH7Zjh0kf9Emav2ZMVmyeQiZtNTadsv4M=;
        b=I3FdlKyXn8vGTVRLNLhF8RipsanfD0OUnn3xlDog0ZVCbT1m/XIy95kDp00V0YkdF3
         AthjdO7pfEdC/5UoV59Rp5D4Zprm8taXF8AjKVH2fdBVZrkD2S1jXrNZcMQXZbFA3hYk
         tDxUtwufHfrS2iedg6BAs4mS6xKW5Rxvcptt+x9c80TSW5vcy4vliNwYNFjDCwmLGuiu
         9vc3kM8eYDjpJPWXn6eO5LDxjWJqwFGrcLOEgNBCGldYNIlGCLxqf1zKa3C1DpKz8zES
         YQN6GYcpJyc4+UxhK/RFa4NzzctIDbWF+3RjTArchulCBHCarDX6Be5cALRgoJOsfD6K
         20fg==
X-Gm-Message-State: AOJu0YwRl8xE9b2Do791wY7euAy5iXrMB8CYNko8G4MELMzYCMHnOgX/
        VacYiGU2BAOfrM0vXoOkzoY=
X-Google-Smtp-Source: AGHT+IEwJdTV/uujbwpgJGjS9gG1Zq6HGmBjhfqI7Pj7Z9XYdRfcCKUwKGNAP7cH1OTRMv8u8cBgKw==
X-Received: by 2002:a5e:891a:0:b0:794:e11c:d8c3 with SMTP id k26-20020a5e891a000000b00794e11cd8c3mr11482632ioj.16.1696214462207;
        Sun, 01 Oct 2023 19:41:02 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id v6-20020a056602058600b0079f9f7a2565sm6346113iox.38.2023.10.01.19.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 19:41:01 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v2 26/30] builtin/ls-tree: let the oid determine the output algorithm
Date:   Sun,  1 Oct 2023 21:40:30 -0500
Message-Id: <20231002024034.2611-26-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
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

