Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2019220958
	for <e@80x24.org>; Thu, 23 Mar 2017 21:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935927AbdCWVJr (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 17:09:47 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35618 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756728AbdCWVJp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 17:09:45 -0400
Received: by mail-pf0-f172.google.com with SMTP id 20so62943748pfk.2
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 14:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ljSyvAGwLxPLDpzvq9GqiJ9v6ljm/3jWWVNmZ4JL6tE=;
        b=cKOdN0gAXt9Ry9kwAc5rM5yhhxIL1k6ejgAJPEdJhm9ehQyfjjY/9ogUpJet+cxW86
         DMi0eB3xpp1BiDDAd+uKA2d3/o0uhPOY0r7Z448NsIhYkvSQQFqWu9Dy1D2gtrCnjUZ8
         ZDrFiczqTtQNiS214KZ8PyFpCZXmBVaALhNu60jz93zC1XZu+KFSK5zub2b4Eof5Kxxf
         5RvFGsTHjdLHaX5ppsaUKprDZksD/2ciK0juwKiBaWxwUqpyzpQEmIS9fvsmigTnYdPo
         FunpojhwSevZwgsWOBmByUq8zOR7Yo1WZsu5/HKzL3WYUqGORbfM7vRuXNdOUa/PQR3N
         YtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ljSyvAGwLxPLDpzvq9GqiJ9v6ljm/3jWWVNmZ4JL6tE=;
        b=FLXHMTSRhczgIwJAbAQ0DTAFyyJKaUO6AYAmn8kbgbLuCyJkm4mEFaSzb8Qzb+eyOS
         6Xt/6n++cTAMUmovw/Hq4U2sY0w6tXMTVuwOmpLN6Wz7DCcb6h8breWpgeR7V7YZmyMm
         A6LVfdRmKXHGiBU5ZDXnCHY5+7WwT2iXTWoOQOFthiL8v0YoXCNQv9ISoHmeinAOzsvK
         NeJRrqNQsIdS2qmi45rt1gxV7owol8f9xhTK6r+kACv0FxeN3rETkocv6oLqoxu2OMc1
         4/LXvfBohuM5pOWptU+8HY/FP9+c/MqCd9xr6xO1hl9dy1wFMM6FMZa33c7fjR+mXAvh
         lNJw==
X-Gm-Message-State: AFeK/H1EXiwhfYTJu/RN33E+J3GyULP+tekSI36lggbl/Bsd88xjEZrcjs0bu4mqDeeue6N9
X-Received: by 10.84.129.195 with SMTP id b61mr6249964plb.83.1490303374218;
        Thu, 23 Mar 2017 14:09:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c402:7caa:e939:6e82])
        by smtp.gmail.com with ESMTPSA id x21sm184265pfa.71.2017.03.23.14.09.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 14:09:33 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 6/8] submodule.c: stricter checking for submodules in is_submodule_modified
Date:   Thu, 23 Mar 2017 14:09:22 -0700
Message-Id: <20170323210924.26818-7-sbeller@google.com>
X-Mailer: git-send-email 2.12.1.438.gb674c4c09c
In-Reply-To: <20170323210924.26818-1-sbeller@google.com>
References: <20170323004329.15892-1-sbeller@google.com>
 <20170323210924.26818-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By having a stricter check in the superproject we catch errors earlier,
instead of spawning a child process to tell us.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index 93d6f08b50..e06e52b993 100644
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
2.12.1.438.gb674c4c09c

