Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A24C2BA19
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C133B20731
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3b2Om5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgDDBMO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 21:12:14 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42698 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgDDBML (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 21:12:11 -0400
Received: by mail-qt1-f194.google.com with SMTP id b10so2484113qtt.9
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 18:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o0cVVs4U0C8huOh0K2x4n9ozqCvkQ76WZSM+jWciwC8=;
        b=P3b2Om5dOdXEIfO2TNXM7njg8ULgHS/K+cMHR1M2Mk02G2t1tEMltisU5o14+byro2
         DcwT9Twx+loJUl9MaemkGkq7kxwgJrNoT2cuTR4LUmdE0bVxIpSAfgE4DvMA141qNeLO
         AC1D24xIMPS86CYpGa9d4oLQ9nM/zBGdCkc3shsfJxVmiI7zrDaGrK+cmPQiR+Eye8qA
         7+B9ska1jX4bbtiKrBLcXNtTlAGX90Bt8urWkV5W/RseWgt7TqTRiYCnLNB/6e8sCN6W
         QhREZmiEGuNSjc5YcnQ4At+Aaik6rr/wO3OkeObQdfJ8M5uQYpD5B89OlvUNiNMd9DOf
         hILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o0cVVs4U0C8huOh0K2x4n9ozqCvkQ76WZSM+jWciwC8=;
        b=nuTHKdYA/q60M8R/93gskL7h6UxhNmIKJ5s/WGDYgbU1ytcZSHYH2+7EaH/uY5PqPJ
         aoyxoY3m5zno6AMaGNh1tmpghehciaB1zmPy37+FZSPeIxplPhn+TZhkztBjjMdZnMtN
         HSneMuCozRBXkRSviYSPcnZNiYqRf2Bm19MkV8zMFqj2+UdrjZS0Je67DfKn52wtPbqR
         mza/Bll666DHDTZ+dxuIQIyX9Mc4AXbua1CfXz0txjIwBnFtf0i9d6SXdEhGr3McwzFy
         yeOt3eOFW8w2ivfrphtO2qwpNwRM2aJwGNrH9tCl2VGTGfgAoIWlhXf1T9YVaK5QHhVC
         ET8w==
X-Gm-Message-State: AGi0PubJnc33CHrzvxnw0rwFq3pnwlOqzW/lRuGrV1yBkry/N0y5ktZh
        dGSaMa2OJQ+1Hn3Ndne2E/v8bqy7
X-Google-Smtp-Source: APiQypK97MReIBk0/VrHG/0EoVTl8IaFojp0Ywk5you7tfe1xg1/3J8Hv3r+xHZ7kbBktIHIaLiATA==
X-Received: by 2002:ac8:5486:: with SMTP id h6mr11073234qtq.256.1585962730328;
        Fri, 03 Apr 2020 18:12:10 -0700 (PDT)
Received: from localhost.localdomain (ktnron0919w-grc-01-76-68-143-128.dsl.bell.ca. [76.68.143.128])
        by smtp.gmail.com with ESMTPSA id a136sm3297503qkc.75.2020.04.03.18.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 18:12:09 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 11/23] sequencer: rename stash_sha1 to stash_oid
Date:   Fri,  3 Apr 2020 21:11:24 -0400
Message-Id: <a52583beff4494b9147b4c700f7be985b80f4197.1585962673.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1585962672.git.liu.denton@gmail.com>
References: <cover.1584782450.git.liu.denton@gmail.com> <cover.1585962672.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The preferred terminology is to refer to object identifiers as "OIDs".
Rename the `stash_sha1` variable to `stash_oid` in order to conform to
this.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 sequencer.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index ae9efe5825..4b7985942d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3651,23 +3651,23 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
 
 static int apply_autostash(const char *path)
 {
-	struct strbuf stash_sha1 = STRBUF_INIT;
+	struct strbuf stash_oid = STRBUF_INIT;
 	struct child_process child = CHILD_PROCESS_INIT;
 	int ret = 0;
 
-	if (!read_oneliner(&stash_sha1, path,
+	if (!read_oneliner(&stash_oid, path,
 			   READ_ONELINER_SKIP_IF_EMPTY)) {
-		strbuf_release(&stash_sha1);
+		strbuf_release(&stash_oid);
 		return 0;
 	}
-	strbuf_trim(&stash_sha1);
+	strbuf_trim(&stash_oid);
 
 	child.git_cmd = 1;
 	child.no_stdout = 1;
 	child.no_stderr = 1;
 	argv_array_push(&child.args, "stash");
 	argv_array_push(&child.args, "apply");
-	argv_array_push(&child.args, stash_sha1.buf);
+	argv_array_push(&child.args, stash_oid.buf);
 	if (!run_command(&child))
 		fprintf(stderr, _("Applied autostash.\n"));
 	else {
@@ -3679,9 +3679,9 @@ static int apply_autostash(const char *path)
 		argv_array_push(&store.args, "-m");
 		argv_array_push(&store.args, "autostash");
 		argv_array_push(&store.args, "-q");
-		argv_array_push(&store.args, stash_sha1.buf);
+		argv_array_push(&store.args, stash_oid.buf);
 		if (run_command(&store))
-			ret = error(_("cannot store %s"), stash_sha1.buf);
+			ret = error(_("cannot store %s"), stash_oid.buf);
 		else
 			fprintf(stderr,
 				_("Applying autostash resulted in conflicts.\n"
@@ -3690,7 +3690,7 @@ static int apply_autostash(const char *path)
 				  " \"git stash drop\" at any time.\n"));
 	}
 
-	strbuf_release(&stash_sha1);
+	strbuf_release(&stash_oid);
 	return ret;
 }
 
-- 
2.26.0.159.g23e2136ad0

