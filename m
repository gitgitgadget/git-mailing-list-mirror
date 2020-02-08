Return-Path: <SRS0=24Vd=34=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDC0C3B184
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 09:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB91622314
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 09:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFscMeo7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgBHJIe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Feb 2020 04:08:34 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:38906 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbgBHJIc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Feb 2020 04:08:32 -0500
Received: by mail-wr1-f52.google.com with SMTP id y17so1616059wrh.5
        for <git@vger.kernel.org>; Sat, 08 Feb 2020 01:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yo7QEzRHNTsTu/TwkDBC91rjNACXUcRl6cHU+LuRfj4=;
        b=TFscMeo7w+FkKT7aeixVL/ANrJ+ByBjLUWVDMrlZp09nWq+zHHMjjRHAHUALiCExDo
         R7/ZsytClJlDmFXvFOQI/5vtIh26FPIIalmabSCYt+KBw+5zYqorUaikad6en5SAOagc
         cvegJZnnvP2OE9ZtjA5cZ9J/NrL0rOY6sRXRWSJiW9XT6/hAMaYAgmhx28vYKKfCLB9l
         BlcMI5liLrwr1YXHHHhgaGvd/AZ7U98KGkkG47enH8Brw+NLvgdxmwEbzRzq6OvwXTK0
         l6XsL6E+t+nBzZAfIvtQPkdFZ6wJBbe+4SgGIHoG/g+PcqoUpl4Ej21FVskLH3vHhQG0
         uM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yo7QEzRHNTsTu/TwkDBC91rjNACXUcRl6cHU+LuRfj4=;
        b=JrfyMU+DlQdHPCYxstg8ZwoO97mg39QW2+uLFi/10XHmdQXrXcGh/HTMI0uUzFVDN4
         ZqAoItqLZii8QV9xNKzSjcLu8YfwJn5MCHj21idXvXdreX44HVckqvMpwyVz7jWW8SYp
         VylEo8m05qmlkjUwTaJlizopEAo6ThY3sA575rQmfirQ8yN1lVKfdOc1ogudJOm7aR2m
         9wGwuuqLUrettDn48z8wH6t69A9xRejndoMbJRwQByZN2csLcow5yX1aAc4xPsFy2xR3
         PiOVxOGjanZXoLekicEcVGDqHAxH6xJKTvZQFKjyL71bF+jChsnBHeqv5YO43O1pxGBl
         GzPA==
X-Gm-Message-State: APjAAAVy2OBcMuZR2hSkYpp5oCtmHXgpQcNqEsC1um6uA+C5WLKGjEzF
        2WxfkpxnkatUilLZH2xOGa5GayDM
X-Google-Smtp-Source: APXvYqygaZwDqCGBKwVZ0Vbshpp18IJt4i7lO9cFuWKT27Yor6sHp0DCYgIhY0lsZNS7rKjsvM7A1Q==
X-Received: by 2002:a5d:448c:: with SMTP id j12mr4355452wrq.125.1581152910710;
        Sat, 08 Feb 2020 01:08:30 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id e1sm6999346wrt.84.2020.02.08.01.08.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Feb 2020 01:08:30 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 06/13] bisect: add enum to represent bisect returning codes
Date:   Sat,  8 Feb 2020 10:06:57 +0100
Message-Id: <20200208090704.26506-7-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200208090704.26506-1-mirucam@gmail.com>
References: <20200208090704.26506-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since we want to get rid of git-bisect.sh, it would be necessary to
convert those exit() calls to return statements so that errors can be
reported.

Create an enum called `bisect_error` with the bisecting return codes
to use in `bisect.c` libification process.

Change bisect_next_all() to make it return this enum.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 bisect.c |  2 +-
 bisect.h | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/bisect.c b/bisect.c
index 83cb5b3a98..e4573c7ba1 100644
--- a/bisect.c
+++ b/bisect.c
@@ -945,7 +945,7 @@ void read_bisect_terms(const char **read_bad, const char **read_good)
  * If no_checkout is non-zero, the bisection process does not
  * checkout the trial commit but instead simply updates BISECT_HEAD.
  */
-int bisect_next_all(struct repository *r, const char *prefix, int no_checkout)
+enum bisect_error bisect_next_all(struct repository *r, const char *prefix, int no_checkout)
 {
 	struct rev_info revs;
 	struct commit_list *tried;
diff --git a/bisect.h b/bisect.h
index 4e69a11ea8..c921ead02c 100644
--- a/bisect.h
+++ b/bisect.h
@@ -31,7 +31,19 @@ struct rev_list_info {
 	const char *header_prefix;
 };
 
-int bisect_next_all(struct repository *r,
+/*
+ * enum bisect_error represents the following return codes:
+ * BISECT_OK: success code. Internally, it means that next
+ * commit has been found (and possibly checked out) and it
+ * should be tested.
+ * BISECT_FAILED error code: default error code.
+ */
+enum bisect_error {
+	BISECT_OK = 0,
+	BISECT_FAILED = -1
+};
+
+enum bisect_error bisect_next_all(struct repository *r,
 		    const char *prefix,
 		    int no_checkout);
 
-- 
2.25.0

