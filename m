Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4573EC2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 19:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1511B2073A
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 19:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3dUTc8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgAUTfV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 14:35:21 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33738 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgAUTfV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 14:35:21 -0500
Received: by mail-wr1-f68.google.com with SMTP id b6so4694914wrq.0
        for <git@vger.kernel.org>; Tue, 21 Jan 2020 11:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/uAW6Tkc9XQvrpbbufvHqa0mrC5LgecDP27DlqZiEKA=;
        b=Z3dUTc8+5Y78g12urH0UB2H3knQQq5A9l+H7yisOskWf16TPHmictHeBzU0z+bIU/0
         yPi3ZJ0jf2UNL2w6NHMov6V7O6zjEVxkaGfP51zxhKH6LuBMrwtSr+coHcNWfvF0J6Y1
         oEXDxdEWsgzTIwc0odAqpxIn/fG31u5GsOIdvvYysI1xkhV3+Qdoq7Io8eyEFVAQeG1S
         Kax+xAeSqik5DbpdR3X0gLhIT1wPyjAcZxhocpJhQLJbVL6u6hXyHrkhMLcFBSVfg6Kb
         A5SYhmANZOllNzmPQOuzF1x/edcAvZNdRSISr80wvC4jUXkREhGodQ4txqXT6SSLCX2T
         i9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/uAW6Tkc9XQvrpbbufvHqa0mrC5LgecDP27DlqZiEKA=;
        b=XbU95prvn448U+qkHY2YmG9hK45OLyC2so3Rx4cOQAVpAqEvhZ3mynK28+YItWrviN
         m2KwCmj/MFDGyhOEHGkTK4AfD1KSWlzXNx70d6Pswjxn14gS09Xoi26cAeU0eGohOC1X
         1PTd5XgWSLdeTctqszqWsHpGWo33V4SfaFHfLVC3YqrJc/Xh+QuBpSJEZdouAxrqrmlE
         Gqff9lxqdOKO9E/xcHJqv4ur17xlpP0AuseJgeBfhZyS0s8xkHd+RqWp9oEc9gKcM9/t
         CcWGW92TIRoBwfQZRX6mXbWQua9bxODQEcYHyxziSPTCax+ar9rc8pQt++QGz4oDGqoz
         oOrQ==
X-Gm-Message-State: APjAAAWjRxVR9FwCR4AUJyXkFd7/fi2PBruAl7f39Ftf5+f9Ga8nJ9Ys
        fnFHwBb0+jTifOpWDq2zGvvXmxPQ
X-Google-Smtp-Source: APXvYqwk7uUHM93SWmLWrcAJl/0Qtx4/NGKJLohF+5nCTgqMNzQVoZyQkA+CM7m80H3bjp9QBL4T1g==
X-Received: by 2002:a5d:6388:: with SMTP id p8mr6764382wru.299.1579635318998;
        Tue, 21 Jan 2020 11:35:18 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-3-145.w86-222.abo.wanadoo.fr. [86.222.146.145])
        by smtp.googlemail.com with ESMTPSA id r62sm583515wma.32.2020.01.21.11.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jan 2020 11:35:18 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org, phillip.wood@dunelm.org.uk,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v1] builtin/rebase: remove a call to get_oid() on `options.switch_to'
Date:   Tue, 21 Jan 2020 20:32:26 +0100
Message-Id: <20200121193226.24297-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When `options.switch_to' is set, `options.orig_head' is populated right
after.  Therefore, there is no need to parse `switch_to' again.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 6154ad8fa5..16d2ec7ebc 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -2056,19 +2056,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		if (!(options.flags & REBASE_FORCE)) {
 			/* Lazily switch to the target branch if needed... */
 			if (options.switch_to) {
-				struct object_id oid;
-
-				if (get_oid(options.switch_to, &oid) < 0) {
-					ret = !!error(_("could not parse '%s'"),
-						      options.switch_to);
-					goto cleanup;
-				}
-
 				strbuf_reset(&buf);
 				strbuf_addf(&buf, "%s: checkout %s",
 					    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
 					    options.switch_to);
-				if (reset_head(&oid, "checkout",
+				if (reset_head(&options.orig_head, "checkout",
 					       options.head_name,
 					       RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
 					       NULL, buf.buf) < 0) {
-- 
2.24.1

