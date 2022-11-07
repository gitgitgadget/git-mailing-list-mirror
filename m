Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1C4C433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 13:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbiKGN52 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 08:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbiKGN5T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 08:57:19 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732681D0EF
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 05:57:18 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so10347107pjd.4
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 05:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpOJtrcZ2ChND9hM7TadVyWqECeKR8W8pnfYdbw+juY=;
        b=UtEcRkap9B7a6dUU61DU92FXolrh1ZWnS3LQXWadQSLneP5zmrM6bhjpylh8yrdHv4
         mJmphX+gIAdmV+vR6dFDy734movbl1ehg8eg/5qo9am2sD9IdxJ2Q9NGuBqH0AfWgADi
         pD+TAbZMv1JeRijrI6rizMVShJ2+VEfT2xpTFMLUWcLcXmrkXSkqs0K+IIGN4hjtwcl9
         I63I4kliEBxObb0XpYsQLKdTcFrCZoGKbbTb8UtH5cWvLwRvko7lHHx+jReXRdSvyWIG
         Gpo9JW5ZbT4NhNA7bhJxwlA/Ac6yuAJ3vtbk3+MnJHGQY14wYGuAK4btP7Z/TArcOEzq
         TNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FpOJtrcZ2ChND9hM7TadVyWqECeKR8W8pnfYdbw+juY=;
        b=Ie6CA0UMGh6Zs58zfFa9LpF4Zgd7OdQKTdJDSV5cvgIhO/FgOmnkYNTTIWQNYCeS6f
         IzXqjZFUDaRIZhUptRHlrCQ/apowhujJqPmq7QITlNbOz06LuixV3fIMgFNyydjV22Cs
         77Rj+HHjCDMvIjRw1c+1Xl5P0W1mOTsL2X3RcVNErKdW1cCw+Z6lK5jiI1B9seMiFhrz
         3+yiuvjp5BsdjhxXA/LHXF9vRFvRVhj9BhH5uVmhuHKivXs0xpL9lt1BfaqeMGx7NmyQ
         JW6CA8NJkCXJ6YqZFJnPRaCe6pHeJFmvL/8oUzNQZzo21nkjDvAzwP7jwSFdHWCE5n3l
         NnzA==
X-Gm-Message-State: ACrzQf0OEYylWNtz1i+hA0liUGaxSdShCqccEfrVi4mO5Chat9SFBDE4
        IYQUSDwxltrMvAj9dShD/0oZZTOcQDKnZaCR
X-Google-Smtp-Source: AMsMyM5Xcds7Y9lM34x4dF72+g4RYvVTuKXFGdtRRZYafy8O+Lt55uPjV7rRr4yBkbYgoGQrMCojlQ==
X-Received: by 2002:a17:903:248:b0:172:7520:db07 with SMTP id j8-20020a170903024800b001727520db07mr50787022plh.76.1667829437965;
        Mon, 07 Nov 2022 05:57:17 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.56])
        by smtp.gmail.com with ESMTPSA id w27-20020aa79a1b000000b00562ef28aac6sm4511383pfj.185.2022.11.07.05.57.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Nov 2022 05:57:17 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: [PATCH v2 3/3] notes.c: drop unreachable code in "append_edit()"
Date:   Mon,  7 Nov 2022 21:57:05 +0800
Message-Id: <2475ea0c04d7b5e2812f13d0c8701a0056b305b8.1667828335.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.38.1.383.ge7205ac0a40.dirty
In-Reply-To: <cover.1667828335.git.dyroneteng@gmail.com>
References: <cover.1667828335.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

Situation of removing note shouldn't happen in "append_edit()",
unless it's a bug. So, let's drop the unreachable "else" code
in "append_edit()".

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/notes.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 02b88e54d8..6d42592c79 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -10,6 +10,7 @@
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
+#include "git-compat-util.h"
 #include "notes.h"
 #include "object-store.h"
 #include "repository.h"
@@ -646,11 +647,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 			_("Both original and appended notes are empty in %s, do nothing\n"),
 			oid_to_hex(&object));
 	} else {
-		fprintf(stderr, _("Removing note for object %s\n"),
-			oid_to_hex(&object));
-		remove_note(t, object.hash);
-		logmsg = xstrfmt("Notes removed by 'git notes %s'", argv[0]);
-		commit_notes(the_repository, t, logmsg);
+		BUG("compute_notes failed");
 	}
 
 	free(logmsg);
-- 
2.38.1.383.ge7205ac0a40.dirty

