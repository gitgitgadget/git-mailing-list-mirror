Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1028A20899
	for <e@80x24.org>; Wed,  2 Aug 2017 19:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752334AbdHBTte (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 15:49:34 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34183 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbdHBTtc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 15:49:32 -0400
Received: by mail-pf0-f181.google.com with SMTP id o86so21547604pfj.1
        for <git@vger.kernel.org>; Wed, 02 Aug 2017 12:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1vFswb7Flr42qsfLsHMPX7iutZIWMnhOl1XkF/UI89w=;
        b=X7QpAf8TdKa9ZoH8NNZjW3rZGRlgdVWRROH2UOPXEd7rIF8Q5YbPjUqb9DwBDMEU7+
         6kvINylcVRrhuMEdK6fvZmhDUgFAUfuotI2Uf8cUvJHlciVgrYo4uHADBMEsx6sqd25N
         H9u2IM2VDP0hTM2E8zcpqcBVBcousGCfvWde8uo5iWLgVuannFMj3WFyzg3mYOHvC734
         GJwfN7i6xe29qTCE/1JHtmOq5KPiQ+XMvKF1r0/j7FDOQfPUe5JpzaLx9/HS0sRhNKc6
         SHgpCPA/gFijDuOWWIz/uPFEowbwimQbjWXeV29uotUr13oevGKdy2kOZ7pagKKHQBZN
         UrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1vFswb7Flr42qsfLsHMPX7iutZIWMnhOl1XkF/UI89w=;
        b=NJ+5PE88HjQO35SGgqosnWFXOVh4EFxkVlUXZTdjs/ZSNcqas7ptYfrmSulW5f9S6m
         BhuDvB13d0J3mYbdXu/5UuiDjIuwkd7eolLkJZS+VC6hXDCT3a2N6eg1CE4UtWgFmWRL
         VAE0iih0naHDvGtDr9eiOas33im8kemONenivdbR9Ix3n3xOpz+Pta5pAURXEyeqYmx3
         6tHcZprMymKFn2aPMouXn5sUJDHXOiRC/PItIhzfj+6g66H3xEzXFZ9iivVMFdadXZqb
         429/wsAtx1bw7dFPilEt5zQ9V3FVwKChSBn6fZsQ++W0mS/G2NqKJq3XSAJ9E+n9EsAY
         Al+g==
X-Gm-Message-State: AIVw110EzG5nSO6JwpBCNePguS2pFc7fym+x+QXv1UiEuxCO9XrYb9+T
        6ZFw+W5+Ndk0qCX4VJxaig==
X-Received: by 10.84.232.129 with SMTP id i1mr26236436plk.28.1501703370931;
        Wed, 02 Aug 2017 12:49:30 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id e64sm63401460pfb.129.2017.08.02.12.49.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Aug 2017 12:49:29 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 02/10] repository: have the_repository use the_index
Date:   Wed,  2 Aug 2017 12:49:15 -0700
Message-Id: <20170802194923.88239-3-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc1.383.gd1ce394fe2-goog
In-Reply-To: <20170802194923.88239-1-bmwill@google.com>
References: <20170718190527.78049-1-bmwill@google.com>
 <20170802194923.88239-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Have the index state which is stored in 'the_repository' be a pointer to
the in-core index 'the_index'.  This makes it easier to begin
transitioning more parts of the code base to operate on a 'struct
repository'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 repository.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/repository.c b/repository.c
index 8e60af1d5..c0e0e0e7e 100644
--- a/repository.c
+++ b/repository.c
@@ -4,7 +4,9 @@
 #include "submodule-config.h"
 
 /* The main repository */
-static struct repository the_repo;
+static struct repository the_repo = {
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index, 0, 0
+};
 struct repository *the_repository = &the_repo;
 
 static char *git_path_from_env(const char *envvar, const char *git_dir,
-- 
2.14.0.rc1.383.gd1ce394fe2-goog

