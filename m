Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08146C43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC1B21655
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VOdW3GbP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731744AbfLMAns (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:43:48 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:41711 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731742AbfLMAnq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 19:43:46 -0500
Received: by mail-pf1-f202.google.com with SMTP id x6so383913pfx.8
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 16:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YtdEjzBrK3lY1BT8ax8tXHqKEGSgbBflR/DmC9gkdrA=;
        b=VOdW3GbPiQKJTqA/nYfrbcZd64UOsLzD89af/MyruRy+r8mKtEQEEmJWM+F4lcP1QF
         jqUWGdB8e4vtwZYCSeYxgxwMq0oXnFlcL88airznGOZ8aZ5gpTb2UXul9UOM8LP3Ztnb
         zougUNZZZH0kP8A23DVmrNF21cV8Ykw3oX+WyMb8vC4bDk44jT+X0o+vvdR/STOHK6dS
         S4elUSAFzRV9aK1NtbXW7VirB4XQ3a1Hn6ojuXbK1kKAeW/dSm222nvR6m4ZP60KkQdO
         QBAyUdq3Zik6IVvyc8C/k+2tSVLuKx6WQWQN+oFEuDbxZMcrWvWaBb3aSHrfqUKS8tTV
         Kk6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YtdEjzBrK3lY1BT8ax8tXHqKEGSgbBflR/DmC9gkdrA=;
        b=pQEABEqS0fg/Sw2fIc9xD9/z9ctoNk0qdDLR3/6mG4GNyugcmVn+Cu+TGsbGUrETao
         vcVMkIYSk5HyjYEqUBzZzs/y2amvLQzb9loUR8i6Ss51oShgYmxBKgbtp/HgtMJbcv5f
         a0b/o5D8LFR/aS9UwMvLISQk/x7cjw2S3Suj1NBg0rYXgdk8cGRdJrl0VavNrVJ6H7rU
         ocZM9svm9L7Ft/zHElRNkLBQ5dNooNiJp2XkbdgcAVZ8h3fYi5Tc5IXbw/tlhwaDH9dl
         Z9sDbNAQ5G+Seuy9VS7TXh55CyPAn082sQsG7DXDvDersnvv8yMLNbLy4oyYjzF/RWjK
         ibvg==
X-Gm-Message-State: APjAAAVu8o7pz8uUyo6KPlrFKBdlpDIxoH95b1WRzRM5uWOp0qcjwDCt
        m9MR5G1heood1iQcrCaUmQuvhqq6ku0oAtgn55o2x+fpnGR4gOLM0S9n+hKF8xNAXnnFcZsDE14
        8hJ3yCIxPfVPeWWZdrBRggvSpjfVEsZVY+/2CMAp4X0UKBOg3nQBDQqEO8zHy4okP2BzZ6gNOtQ
        ==
X-Google-Smtp-Source: APXvYqzQWHdWvYgksefpZGXaLWapirdc55XHHO9R3i3mWjQyhN9Z7/6Y6lwyYx9visnq+FRW8oBQ3JsSxmW2Zc3lhIg=
X-Received: by 2002:a63:ea17:: with SMTP id c23mr13911120pgi.85.1576197825930;
 Thu, 12 Dec 2019 16:43:45 -0800 (PST)
Date:   Thu, 12 Dec 2019 16:43:05 -0800
In-Reply-To: <20191213004312.169753-1-emilyshaffer@google.com>
Message-Id: <20191213004312.169753-9-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191213004312.169753-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v4 08/15] bugreport: include user interactive shell
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's possible a user may complain about the way that Git interacts with
their interactive shell, e.g. autocompletion or shell prompt. In that
case, it's useful for us to know which shell they're using
interactively.

$SHELL isn't set by every shell, but getenv() returns NULL in the
event the variable isn't found, so we'll see a line like "$SHELL:
(null)" to tell us that variable wasn't set.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 bugreport.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/bugreport.c b/bugreport.c
index f5598513d9..759cc0b0f8 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -45,6 +45,9 @@ static void get_system_info(struct strbuf *sys_info)
 	strbuf_addstr(sys_info, gnu_get_libc_version());
 	strbuf_complete_line(sys_info);
 
+	strbuf_addf(sys_info, "$SHELL (typically, interactive shell): %s\n",
+		    getenv("SHELL"));
+
 	strbuf_addstr(sys_info, "git-http-fetch -V:\n");
 	get_http_version_info(sys_info);
 	strbuf_complete_line(sys_info);
-- 
2.24.1.735.g03f4e72817-goog

