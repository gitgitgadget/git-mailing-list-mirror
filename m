Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 322DA1FEB3
	for <e@80x24.org>; Fri, 13 Jan 2017 00:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750997AbdAMAAq (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 19:00:46 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34890 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbdAMAAo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 19:00:44 -0500
Received: by mail-pf0-f182.google.com with SMTP id f144so20663220pfa.2
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 16:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CwEF/0dnoaCz+4Q1E99ouU9+vDJ7os33IMsdNdkgcno=;
        b=WtpjHwdTvLwtFmfez1HikJ9czkuvFQHdt1koiquFuHFMdA/WdN3QS9sfoLlopxtIse
         rBmCbn0PZHrtS5wIX9HXeRy+yIEaCmjq0Kh/BheV/DA8Tb8wlwgx4Duz62YUjgV7HQ7e
         fSEOdAoQyrGINChIKdL1CZ8Jy2YGWhYoujXXqwVCCqxhzRpnjhzQcVwMp8C94oJDgcSP
         x9sU+tbtcmkw37vD3QgpK9OT9lqCZ3QR8KBSvagUQaAwcZM/4Y+aq7+yCH5iaFrsAp2C
         MLkoH59Gr0ocIfo7HRmufVuTcynUDJMjLlNsJ3SZ7kwwD/qmkg2SL0Vd1Icghctlm9s2
         EbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CwEF/0dnoaCz+4Q1E99ouU9+vDJ7os33IMsdNdkgcno=;
        b=KwKNRI2RUB6bpB8p/IcCYGWxaP4wh6sVLwGfIwpZJNfjH8No236BgtEn4o3+1uqIlH
         aQr4USSMTgfFb4gEfEq+suog5T9wJQ6G2ylfk9vD44xcBUJuDZ+s2Trall+nsFt8+M2T
         EFhYukQ0gt7ws+BQXbLgpT2fiwvVAsWWb0l7fxUXSiEDSJj3jbtpjAsIS1xE6jrN+0QM
         Yi7r/WXvWV1Cg+3vImqt0Ju04Rn5zTfcy5piCffCmcyUba5L6xqB0syUnjALP77d9D9K
         mq9vYzf2EtPv1g75/ZY8t/ImvwjxBVXYz7lTAT6aRN6emS2haMgLcMa0iCBimdQdlMVf
         mHVg==
X-Gm-Message-State: AIkVDXKxHLom+LW7f0QsUtMOLMLqajwCMM3pkSO6vgBcbqBo9i0eVsVffeNkTkF//tvyYaCC
X-Received: by 10.98.103.195 with SMTP id t64mr10577315pfj.106.1484265254216;
        Thu, 12 Jan 2017 15:54:14 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id e6sm24312192pgf.4.2017.01.12.15.54.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jan 2017 15:54:12 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, pclouds@gmail.com,
        sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 08/27] attr.c: tighten constness around "git_attr" structure
Date:   Thu, 12 Jan 2017 15:53:35 -0800
Message-Id: <20170112235354.153403-9-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170112235354.153403-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

It holds an interned string, and git_attr_name() is a way to peek
into it.  Make sure the involved pointer types are pointer-to-const.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c | 2 +-
 attr.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/attr.c b/attr.c
index e42f931b3..f7cf7ae30 100644
--- a/attr.c
+++ b/attr.c
@@ -43,7 +43,7 @@ static int cannot_trust_maybe_real;
 static struct git_attr_check *check_all_attr;
 static struct git_attr *(git_attr_hash[HASHSIZE]);
 
-char *git_attr_name(struct git_attr *attr)
+const char *git_attr_name(const struct git_attr *attr)
 {
 	return attr->name;
 }
diff --git a/attr.h b/attr.h
index 8b08d33af..00d7a662c 100644
--- a/attr.h
+++ b/attr.h
@@ -25,7 +25,7 @@ extern const char git_attr__false[];
  * Unset one is returned as NULL.
  */
 struct git_attr_check {
-	struct git_attr *attr;
+	const struct git_attr *attr;
 	const char *value;
 };
 
@@ -34,7 +34,7 @@ struct git_attr_check {
  * return value is a pointer to a null-delimited string that is part
  * of the internal data structure; it should not be modified or freed.
  */
-char *git_attr_name(struct git_attr *);
+extern const char *git_attr_name(const struct git_attr *);
 
 int git_check_attr(const char *path, int, struct git_attr_check *);
 
-- 
2.11.0.390.gc69c2f50cf-goog

