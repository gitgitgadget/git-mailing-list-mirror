Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D96AC2BA17
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 17:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8777206F8
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 17:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyD3mVQQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgDFR5V (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:57:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34566 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgDFR5V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 13:57:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id 65so574604wrl.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 10:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7eLzADI8fVOR0dEK2teQA7yIJdjrd+Gxg4EV0yars0E=;
        b=cyD3mVQQ8EhHwjIeKYJNO/D4I0P9Z4b+RibcK8+g+T4DWjDtyPGQH8DEWyep2PVOal
         OCBvkwPrm/m4uetvkwNj7taLDcYpy4lc4a5jEZAkcCC9nO8Vk0LR1A3hjQDeHFx9qDMb
         Gn5NgsGZSLmzMB+kKgSQ+C6ouCCfQhi7HvQEeRr1pJTw5k8iVJTuvnUB+jkIY/v18d58
         mhovC+oCLTmRvesKdnfpYzKGYXIp2SZj9ROACa0wUuaOf444J1lzbD0kJvLjv30+rmgV
         U6P9jLEDcoB1TEqbECnlcf/Q7JVACsba3pV6Q59Klt2SGBsRYUHC9yqDaw0w7B/fY78m
         KV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7eLzADI8fVOR0dEK2teQA7yIJdjrd+Gxg4EV0yars0E=;
        b=cYtBTpdtiafVg+07/zzPUl+JcHinxpWMq0r9pEufl6lsiBwgU9TfoqLc4sDbtL1XNI
         0F7gc1UFcsQe0w6SvciPjfcTmC3LYIfurQudoYa0l+Hh78Xw8eNhlQiKjpTUm4YHU8ld
         hVg9ySM8DQVJc9jqLwq+fF/WfULNdvyWbQpRW8HK5N30Er+lCCqJEaUvSRY90VMIf75J
         yFIqP0UcaD+u1Y0sPG1kjuYJLSEwhUH6CEYOx/l6EwTai12nF/a8t0EgQ1g7HzUmeyrA
         DyawSQRUFSJfA9T/7zSddQKSSH1jPHBCA1DQXTZByfarKFFOmJIzLixEcq6mcpTefOLE
         422w==
X-Gm-Message-State: AGi0PuY4bohZaTs2RfbZ1zpFZwGQfnas7B7dDuoho1/oxf8NlgRNbv/8
        Yr3cVcZmW40bzWRMpYp/JCY8oaUQM28=
X-Google-Smtp-Source: APiQypKsd4wbZfhFilrUl2/RcI3g70jauMRAOh47OAeKrhWHk5vfQGLUithhw5sSEYFU3qKNbgvpPQ==
X-Received: by 2002:a5d:61c4:: with SMTP id q4mr384084wrv.363.1586195840064;
        Mon, 06 Apr 2020 10:57:20 -0700 (PDT)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id j10sm10465041wru.85.2020.04.06.10.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 10:57:19 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v6 1/2] remote.c: fix %(push) for triangular workflows
Date:   Mon,  6 Apr 2020 19:56:47 +0200
Message-Id: <20200406175648.25737-2-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200406175648.25737-1-damien.olivier.robert+git@gmail.com>
References: <20200406175648.25737-1-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The behaviour of `git push` when push.default is simple or upstream
changes in a triangular workflow, but this was not taken into account by
%(push). Update the code to detect triangular workflows and fix this.

Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
---
 remote.c | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/remote.c b/remote.c
index c43196ec06..3750a2bcc1 100644
--- a/remote.c
+++ b/remote.c
@@ -1656,6 +1656,18 @@ static const char *tracking_for_push_dest(struct remote *remote,
 	return ret;
 }
 
+static int is_workflow_triangular(struct branch *branch)
+{
+	struct remote *fetch_remote = remote_get(remote_for_branch(branch, NULL));
+	struct remote *push_remote = remote_get(pushremote_for_branch(branch, NULL));
+	return (fetch_remote && push_remote && fetch_remote != push_remote);
+}
+
+/**
+ * Return the tracking branch, as in %(push), that corresponds to the ref we
+ * would push to given a bare `git push` while `branch` is checked out.
+ * See also branch_get_push_remoteref above.
+ */
 static const char *branch_get_push_1(struct branch *branch, struct strbuf *err)
 {
 	struct remote *remote;
@@ -1693,23 +1705,31 @@ static const char *branch_get_push_1(struct branch *branch, struct strbuf *err)
 		return tracking_for_push_dest(remote, branch->refname, err);
 
 	case PUSH_DEFAULT_UPSTREAM:
-		return branch_get_upstream(branch, err);
+		if (is_workflow_triangular(branch))
+			return error_buf(err, _("push has no destination (push.default is 'upstream' and we are in a triangular workflow)"));
+		else
+			return branch_get_upstream(branch, err);
 
 	case PUSH_DEFAULT_UNSPECIFIED:
 	case PUSH_DEFAULT_SIMPLE:
 		{
 			const char *up, *cur;
 
-			up = branch_get_upstream(branch, err);
-			if (!up)
-				return NULL;
-			cur = tracking_for_push_dest(remote, branch->refname, err);
-			if (!cur)
-				return NULL;
-			if (strcmp(cur, up))
-				return error_buf(err,
-						 _("cannot resolve 'simple' push to a single destination"));
-			return cur;
+			if (is_workflow_triangular(branch)) {
+				return tracking_for_push_dest(remote, branch->refname, err);
+			}
+			else {
+				up = branch_get_upstream(branch, err);
+				if (!up)
+					return NULL;
+				cur = tracking_for_push_dest(remote, branch->refname, err);
+				if (!cur)
+					return NULL;
+				if (strcmp(cur, up))
+					return error_buf(err,
+							 _("cannot resolve 'simple' push to a single destination"));
+				return cur;
+			}
 		}
 	}
 
-- 
Patched on top of v2.26.0-106-g9fadedd637 (git version 2.26.0)

