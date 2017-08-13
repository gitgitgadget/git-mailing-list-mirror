Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF8CA1F667
	for <e@80x24.org>; Sun, 13 Aug 2017 19:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751495AbdHMTgb (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Aug 2017 15:36:31 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35043 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbdHMTg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Aug 2017 15:36:27 -0400
Received: by mail-it0-f65.google.com with SMTP id 76so6811433ith.2
        for <git@vger.kernel.org>; Sun, 13 Aug 2017 12:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=dzjIuMPltDYQnxLwTgSEe85tRI9h+/Xeo4TT9oePz2I=;
        b=SJqGZGxgklfGO/fYdcCncHz+rhFf6SglDQi4PjdO1fJ9hgNeP8owARHy2nJP19478U
         qMUVmkyhwR7CQG0AnhbJu1T45dzwcYDdNxsrjKbhLO9Au9aeGGgPB+sJcWWl7s7yrVNa
         9mTDOyRIgB8YCinyhXhgsYQODjstt2y0fCzxDbBJQadUno4Nx7S44kxytrei/4CmgLeS
         aav1uSs5iU3dMAGLlWtW3z4/SgxvNXZYUDex0D1T1ZnxocVLus77ldbkz9MXetzA34Sl
         PhrAnYDBS/9DZemdoEHkPC+6LYG3l/YmjPF3/YMo3aFDVR3LjQyTg7K5xlFwU8tG15c2
         pNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=dzjIuMPltDYQnxLwTgSEe85tRI9h+/Xeo4TT9oePz2I=;
        b=MA6cEE1ruCzegMAJ05hV7AAJUmv9zfmJU5kB8k6PxVpzdvRULwEUlOZHw7y8rdznhf
         mRa1+t600qIxt/t26SAaYDQkYlEje7CJq4Rb8sakL2CGkVU4OhUktYGCcO42f82TCTnH
         4kF4G1o19NhTsqwBcTvQ8qbsOA6IkHMcsPlq3IPj+I+AimxmdY/RKqpMoyYPLwJwIx93
         D0QfydD5aRa4F2BuUyOh6jaNIh8n1pZx97L4A/WmL/XqL0qoz8E4gPptXaxFmiWa94Oq
         spegQF+n4TtJPL8BUe2w2wVgr/gn2d19KgyMykzyTkYmU4u+b9SSAr4DWnZUFiiRrsS4
         SeUw==
X-Gm-Message-State: AHYfb5iT6WSYi66YEdqBjWDrByOywbykLEE7EeEgT2dx0xva9P2xeTL1
        /58KW1Ms3wLr71iikTQ=
X-Received: by 10.36.162.72 with SMTP id o8mr3641282iti.56.1502652986729;
        Sun, 13 Aug 2017 12:36:26 -0700 (PDT)
Received: from localhost.localdomain ([192.252.136.182])
        by smtp.gmail.com with ESMTPSA id s66sm2045678ita.9.2017.08.13.12.36.25
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 Aug 2017 12:36:25 -0700 (PDT)
From:   Richard Maw <richard.maw@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 3/7] Add helper for skipping namespace prefixes
Date:   Sun, 13 Aug 2017 20:36:07 +0100
Message-Id: <20170813193611.4233-4-richard.maw@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20170813193611.4233-1-richard.maw@gmail.com>
References: <20170813193611.4233-1-richard.maw@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Normally your own namespace is known and you only need to skip that prefix,
but when you need to classify the type of a ref
it helps to be able to consider what type of ref it would be
if it were outside of a namespace.
---
 git-compat-util.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index db9c22d..c5e0a34 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -501,6 +501,25 @@ static inline int skip_prefix_mem(const char *buf, size_t len,
 	return 0;
 }
 
+static inline int skip_namespace(const char *refname, const char **out)
+{
+	const char *c = refname;
+
+	while (skip_prefix(c, "refs/namespaces/", &c)) {
+		c = strchr(c, '/');
+		if (!c)
+			return 0;
+
+		c++;
+	}
+
+	if (c == refname)
+		return 0;
+
+	*out = c;
+	return 1;
+}
+
 /*
  * If buf ends with suffix, return 1 and subtract the length of the suffix
  * from *len. Otherwise, return 0 and leave *len untouched.
-- 
2.9.0

