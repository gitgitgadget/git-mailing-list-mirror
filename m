Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5C6C433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbiCUXQq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbiCUXQc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:16:32 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5323719F0
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 16:04:48 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id d5so7821334lfj.9
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 16:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tOcKjz25Y+fbdMLra+nDprUOp7Xl7waEanzQpnRkU8A=;
        b=lNeo96+ToX3+ZW7w+26NE2kfudbmnnoL+HupHj7dBasQ/YWzWciuIuIWzA4nDvePkA
         9RrFde6j0CQnaS9CIQC0Bu70ZlnVR8zcOX42qwHM6L+iAqJkjC50jwuX/b2MB8XnoizB
         lnUekJCVqBn4i49dn3TyTPkLWFD2MnM3G6Vo7O35H+eD6Qs0eD9Bh9g3ihMYUVASUO1G
         JqAxwH7q45nyASNyEgfseWU35njite8wCus8fAwLNse7VZKGUDbLDn9vcFdEjd0Y9nV4
         regxxF8roZ894LmhYdy3fgzocAgzSEOGEwI7fzCpQUPJO9wkdZiC4jGXOsRA6/nmUGJx
         7CEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tOcKjz25Y+fbdMLra+nDprUOp7Xl7waEanzQpnRkU8A=;
        b=zqL+fNfIVbA1GiDMnAW6zO0n92rT92w+UcRI/oP/8Qqvs8ahIj/oKd0GVlGUAwpIdn
         34tawHZn0TvF3Oc9S2LtWCIIClpQxRJGK3a7VsaeK7sVjIKPwmQp0ysDiOKSm3NDZ4ZY
         KL0y/fI+919J4sS5609HkOCamVXadjEFJWL2PPC1Hu9zQ1G32luTVrjvtKsF6NUpxWPp
         a8tVC+CP+QgCbkHLfADRVY1uZa++3lJQZYwTbHwf+31UPSY9bTXGR1xcTFCVBlJadaoq
         ECWM2JzumRV7WA8UxCn4WWeOJy23iAtbRU60d7QFYyX1ttDSF7J13hY8+cUPE6HKatgf
         gxZw==
X-Gm-Message-State: AOAM532JRc/s5R6DXdE9jFXoXTTh9fVmsKQxdkt16esQMQmNWD080H9w
        zEOVqqLix6HDis8QPYYsaJh4D+JmjR0=
X-Google-Smtp-Source: ABdhPJzQJjUmAZEATXfrgvt0vvZLMlPgCQSG+LaBZ/V8iZFbNt0LQeP9iZJR95E5uhGKTmsvRjG8Eg==
X-Received: by 2002:a05:6000:1ac7:b0:1f1:f9ee:7c57 with SMTP id i7-20020a0560001ac700b001f1f9ee7c57mr19325840wry.52.1647903361519;
        Mon, 21 Mar 2022 15:56:01 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:56:01 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 22/41] update-index.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:55:04 +0000
Message-Id: <20220321225523.724509-23-gitter.spiros@gmail.com>
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
 builtin/update-index.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index aafe7eeac2..9e4c15e846 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -699,7 +699,7 @@ static void read_head_pointers(void)
 		die("No HEAD -- no initial commit yet?");
 	if (read_ref("MERGE_HEAD", &merge_head_oid)) {
 		fprintf(stderr, "Not in the middle of a merge.\n");
-		exit(0);
+		exit(EXIT_SUCCESS);
 	}
 }
 
@@ -1127,7 +1127,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		case PARSE_OPT_ERROR:
 			exit(129);
 		case PARSE_OPT_COMPLETE:
-			exit(0);
+			exit(EXIT_SUCCESS);
 		case PARSE_OPT_NON_OPTION:
 		case PARSE_OPT_DONE:
 		{
-- 
2.35.1

