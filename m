Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9707820986
	for <e@80x24.org>; Sat, 22 Oct 2016 23:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935890AbcJVXcy (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 19:32:54 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:38857 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935021AbcJVXcs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 19:32:48 -0400
Received: by mail-it0-f54.google.com with SMTP id 66so74080678itl.1
        for <git@vger.kernel.org>; Sat, 22 Oct 2016 16:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vIDTLUrIhl4W17lpfRoJKk+ZmMqRfYeYc0oexmf57GI=;
        b=JvY62mMAYOH9MGcWLkMTUKrhdK377PRb7g6LHL8F3Plb3kWNxBOs8IjLsVaA6pXQtB
         KIdH2uxORimA9wt6i9UbEHePO8ExbXqGQ+Mn/QyURJHrCcYhbOyyrrni/WfART5jDVEE
         3dWuBNtpunmL66P+HqUvUIEsGV6YdHAOXyq14HFH5QX8UWUxTfuMORQN76OQuPw/nYE1
         gBFZ/UUgh265/4qnlDLnsVBy5lc2tkV83tqVnxaCnjV4uBh618OZHtsp6CVBBbIk5rNw
         kDeTeUDGB5ytx3e0sOiaz6uxhkpfzPruDru/S2CENNeaj8k3NORVU+6suFRFCLfJ0Oti
         JN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vIDTLUrIhl4W17lpfRoJKk+ZmMqRfYeYc0oexmf57GI=;
        b=LiVPg8wZYkRh4b1bjRTyY8rYz38USkjeHflpACIgVlAvO18SXfmXhW8fcji/klrhJq
         rpL4kB6QTj49XMK0rO4kzmas8KJaMJ5NBgPS5FFOxn2ZM/pgLYamP/KttT2iV9XmONhP
         vvA9KVj63TF1Nl3SgO4IsL9MGqwBfSKaTAR0JdU84Af71foup77YiusyeFZpXZe6mXgt
         Qr9Ytd3/IqYPwcaqg011PoTjzlWsi905p4u26zlVP2/khopxiIygJalcIlA4sO0F17Gp
         expSs5CiFKqsuKnjiR/5A+NdHazUDyJkNOxIPkS/72h70JRLRcyUfW1WOkvDG4IlP4LA
         r38Q==
X-Gm-Message-State: ABUngvd6CloDxLVor60cVTzuIM4GRbRuH92I1EvrYOQ9ak4DA8AwIbpKzKr6TUp4kYjD31tT
X-Received: by 10.36.116.18 with SMTP id o18mr7884109itc.84.1477179167094;
        Sat, 22 Oct 2016 16:32:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:4ca0:b1d9:cc22:1c7b])
        by smtp.gmail.com with ESMTPSA id j78sm1986933ita.6.2016.10.22.16.32.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 22 Oct 2016 16:32:46 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 08/36] attr.c: tighten constness around "git_attr" structure
Date:   Sat, 22 Oct 2016 16:31:57 -0700
Message-Id: <20161022233225.8883-9-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.508.g6572022
In-Reply-To: <20161022233225.8883-1-sbeller@google.com>
References: <20161022233225.8883-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

It holds an interned string, and git_attr_name() is a way to peek
into it.  Make sure the involved pointer types are pointer-to-const.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c | 2 +-
 attr.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/attr.c b/attr.c
index 7bfeef3..5c35d42 100644
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
index 8b08d33..00d7a66 100644
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
2.10.1.508.g6572022

