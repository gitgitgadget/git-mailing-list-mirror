Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210E0C433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiCUXLf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbiCUXKD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:10:03 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDD313F83
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:58:24 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id o7-20020a05600c4fc700b0038c87edc21eso687451wmq.0
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+V93n5I+rGRbi1qiV0MM8iJS8/0/yRXFSrKSN0u3jX0=;
        b=OFJETiTYZKf1Ywq9JmS5p3nTNAGruwvGfuTzzftNdhy07nT0buCSe+1ceqIQREQNuD
         cWzeYDBuv7gjmJIuNyhJUR/NrK/IZSAgp1pagkvPdKMY5t5dzDTp5V/JmrqK9YCB1o4P
         2JPmHD6KFCa+Hl1jvktaxEBm5JTGLZqBvADNQe3rawaA9hhJtKuwhtBLtKRdhR1FVAjM
         15ZHTtMRNpIrDh97tkowpNhPWSfyVRzaKXMlQVggu5NK0NacJp7ZZ1dbBPeymEoWVFM4
         caVLL8ycfgeMk9U/CPRCnAvgp1Pf1gP9zJw6UGa256CxJB7XH5zfjg+5j1zW7UQkKBoS
         pIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+V93n5I+rGRbi1qiV0MM8iJS8/0/yRXFSrKSN0u3jX0=;
        b=NlB9cskDNSSFYiUqJlEB9+77JvZvJQlvkP2LrAz2cOoJ2+j1BTKVgKLbm33/Hluqx5
         L4L/iul515sb3Cuu6MGScZD1+7NMeL+Pyzv27keA9QHfnNWcd5v7vc8LTumr+3vpqo7f
         jtsNrl4pYoxEfaliY4D4iAsRj+IxipXL2ET7o6WzPr2pD0z/leLF+ri0ToSpUUgJU8qh
         0WfPlvhG2+6aOQxY7iqc9v5oUQ8JL0sWjA7vXpq/fPgh/XpWt8uYwSCmDhRwd3zrDLVY
         XAM4fAGdKToRaE8UUiMMXtUkUhEEE3gLPLvaLWcKE9LlwgaLjVxmHObhOw+zHnJUNQkS
         8oCg==
X-Gm-Message-State: AOAM531mRa2AA5gOBxQMc/7HP6Mc4OhhJvXE4QSCkrT33MBBeder3EG/
        XEYGCx89Otcgq3y1arHOwrXs3B7GaAw=
X-Google-Smtp-Source: ABdhPJzdDVhL2d05zPytKOrdQwKdBNYqgb2mUCuL6xf5sdJ0J7nIigAG2pvYBAo5w1HAn5Q84r+03Q==
X-Received: by 2002:a1c:cc06:0:b0:389:79c7:aee6 with SMTP id h6-20020a1ccc06000000b0038979c7aee6mr1139787wmb.47.1647903367939;
        Mon, 21 Mar 2022 15:56:07 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:56:07 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 28/41] help.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:55:10 +0000
Message-Id: <20220321225523.724509-29-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220321225523.724509-1-gitter.spiros@gmail.com>
References: <20220321225523.724509-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The C standard specifies two constants, EXIT_SUCCESS and  EXIT_FAILURE, that may
be  passed  to exit() to indicate successful or unsuccessful termination,
respectively. The value of status in exit(status) may be EXIT_SUCCESS,
EXIT_FAILURE, or any other value, though only the least significant 8 bits (that
is, status & 0377) shall be available to a waiting parent proces. So exit(-1)
return 255.

Use the C standard EXIT_SUCCESS and EXIT_FAILURE to indicate the program exit
status instead of "0" or "1", respectively. In <stdlib.h> EXIT_FAILURE has the
value "1": use EXIT_FAILURE even if the program uses exit(-1), ie 255, for
consistency.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 help.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/help.c b/help.c
index afd3af2412..e661dfddd8 100644
--- a/help.c
+++ b/help.c
@@ -582,7 +582,7 @@ const char *help_unknown_cmd(const char *cmd)
 
 	if (autocorrect == AUTOCORRECT_NEVER) {
 		fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
-		exit(1);
+		exit(EXIT_FAILURE);
 	}
 
 	load_command_list("git-", &main_cmds, &other_cmds);
@@ -667,7 +667,7 @@ const char *help_unknown_cmd(const char *cmd)
 			strbuf_release(&msg);
 			if (!(starts_with(answer, "y") ||
 			      starts_with(answer, "Y")))
-				exit(1);
+				exit(EXIT_FAILURE);
 		} else {
 			fprintf_ln(stderr,
 				   _("Continuing in %0.1f seconds, "
@@ -690,7 +690,7 @@ const char *help_unknown_cmd(const char *cmd)
 			fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
 	}
 
-	exit(1);
+	exit(EXIT_FAILURE);
 }
 
 void get_version_info(struct strbuf *buf, int show_build_options)
@@ -789,5 +789,5 @@ NORETURN void help_unknown_ref(const char *ref, const char *cmd,
 	}
 
 	string_list_clear(&suggested_refs, 0);
-	exit(1);
+	exit(EXIT_FAILURE);
 }
-- 
2.35.1

