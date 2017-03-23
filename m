Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9336B20323
	for <e@80x24.org>; Thu, 23 Mar 2017 00:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751706AbdCWAnn (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 20:43:43 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35797 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbdCWAnk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 20:43:40 -0400
Received: by mail-pg0-f46.google.com with SMTP id t143so48712376pgb.2
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 17:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TGTLkFhgs/qPo1OfOXfw9ZzHH4rlghOF6uUUTUbxF+c=;
        b=p4d+SAZNYfLzQ95At6nGVNzQB9cmNX6LMTwOBXJ6kYjEyfPiWEC8aZMn+7eq9Zr3tu
         Vbk70/WYD48gSZH3pjcy1dpgKLGWMvTZmUO+G2WIUuxIQjLbohaee6a+PjA4X+O6av6s
         aPAQzP4iifp/P+ZET4wqCmOxMmN3hax+/uOTOnD1ZCc3LqVqStoK/zk11jISjdMjyVhM
         58sjm88v2u49V6m5UNUiXH8a3abAz+BHBI6v6Tr8cjjpRRiI5wRgPV7tlDSIPwdJ9X55
         udIzG6IXMGEacPTkN5ShXMNIdUfkk4AIarHGs2LAcD4hxA087XobJQul/R3OG6Sy10ot
         l5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TGTLkFhgs/qPo1OfOXfw9ZzHH4rlghOF6uUUTUbxF+c=;
        b=IJTZdeUkbBCDQoItRjMdoIQeKIqIQ/nkGAXGrxLujvgYt2VNDOuDQeFaqV6wUMdHN+
         xiR5JjCaDh63V+aeKHx+ihpm+xytZe7nNKEoiJCpoVxHWgWFdCsiVpj1qI5AP4MPIXHD
         +psI3TwT0lS4zztT96VYZDToNqdpW4WQfinpfkj4y8aCP84QJKa4P1fbICbjfLuW1B58
         NJH9UodQwYM84WUls79h/DEcRsp9LHsi5DZuYG2kEFGYYi7gA0stNPFlsBNx5LIZG5Uy
         E4/CzmLXI79qeXMlSawrIQnxWDZXFSX9hnY6LRsoIYiqx4233NM0Z4h1przJSsFoI7sz
         5C1w==
X-Gm-Message-State: AFeK/H14cd0p1LAiLw0dsTfXkxc58KFfqntNz28Y31bGXFeE6NxzPaZnZdGcWt6+DpuXny63
X-Received: by 10.99.211.69 with SMTP id u5mr1879416pgi.82.1490229817012;
        Wed, 22 Mar 2017 17:43:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:1959:c634:6437:385])
        by smtp.gmail.com with ESMTPSA id v26sm6097777pfl.16.2017.03.22.17.43.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Mar 2017 17:43:36 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/3] submodule.c, is_submodule_modified: stricter checking for submodules
Date:   Wed, 22 Mar 2017 17:43:28 -0700
Message-Id: <20170323004329.15892-3-sbeller@google.com>
X-Mailer: git-send-email 2.12.1.432.gfe308fe33c.dirty
In-Reply-To: <20170323004329.15892-1-sbeller@google.com>
References: <20170323004329.15892-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By having a stricter check in the superproject we catch errors earlier,
instead of spawning a child process to tell us.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index d355ddb46b..66335159ae 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1050,11 +1050,12 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	git_dir = read_gitfile(buf.buf);
 	if (!git_dir)
 		git_dir = buf.buf;
-	if (!is_directory(git_dir)) {
+	if (!is_git_directory(git_dir)) {
+		if (is_directory(git_dir))
+			die(_("'%s' not recognized as a git repository"), git_dir);
 		strbuf_release(&buf);
 		/* The submodule is not checked out, so it is not modified */
 		return 0;
-
 	}
 	strbuf_reset(&buf);
 
-- 
2.12.1.432.gfe308fe33c.dirty

