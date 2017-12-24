Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4814D1F406
	for <e@80x24.org>; Sun, 24 Dec 2017 10:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752137AbdLXKzG (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Dec 2017 05:55:06 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:45811 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752025AbdLXKzC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Dec 2017 05:55:02 -0500
Received: by mail-wm0-f65.google.com with SMTP id 9so28595637wme.4
        for <git@vger.kernel.org>; Sun, 24 Dec 2017 02:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ruDjXLcRzaXmSqSZOtwk3jiXrueAcv8I48ExzxkA7w4=;
        b=hZjTj2cEa1v/VQqbCLDX7RZFJkOqhpD9PN2uP/WXy5IDwCgYNRdF4Ij5GyQGkbZIBa
         ugZlvQDRuksRBDZbQPxyKIs4z8bJSKhtXbFr7zIZPFdcHin7flDmpdWLzB3DMI2TI1Bs
         S4lKYNfl0qhvKm3ia8D7TT7uCNWgco9/7lXeBzPUb+onzevAb7PwaEaL8e37zo4DhHoA
         j7LB0ibM+IIhlh2A4JqpIYZ1vTAKSYQnaFGNlcMmnsDc9gcvrT+BwhXkeBBiOeh0wWFt
         DQDmiD8Ayi9Lh3tsvmtfUFBOKE2e63DaOgknuQc8S8msESMiQQQFmz7lFZBV7jjKhpuS
         Cxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ruDjXLcRzaXmSqSZOtwk3jiXrueAcv8I48ExzxkA7w4=;
        b=k3mGjXflII/JmfRwmKchC1Sbj6fcO+6d0lDyZ508m5VndxqrWefhx4A+bXqqyt9kTp
         YUAwycf7Yu5QKsSU3bIjFO8PmT7mFLpBqmDld0xrhLv2iAS9BOUHp4iyNRCqluucV4X5
         PJoF+zmKa3Dgxkp40NJOL3n30FHYUJQWAudsD1ofPrZmPFRpTXSC2Q3PbVNEqOOuIumb
         5RsS7ozEFF4ds+0/eOlKNwNkVvHxyYark6MQt4w1OLFeicTqECgWUpGNgtLpebRe4Xi5
         3VhCXYQN0RjtPS15dkNJqkTk+KD0FriUeChFlFDi2zx8mzx+cV8+xSGZQYK3DLdVf8vE
         dqug==
X-Gm-Message-State: AKGB3mJRRwbRpbReX/uhAcCwPyOPXFbV49Pfe/T3Z2hdK9zaWLHdV7xX
        AIqbNRLPeOeew3IxWU53/NH98A==
X-Google-Smtp-Source: ACJfBou9lTi+M7eNkcsq6lTBu31IzqcXmXPeMLg59luuoJkwARTgcTHOspIq/fESHGLDpo/Cswpzew==
X-Received: by 10.80.212.196 with SMTP id e4mr21973022edj.97.1514112901443;
        Sun, 24 Dec 2017 02:55:01 -0800 (PST)
Received: from icid.telenet.be (d8D86700B.access.telenet.be. [141.134.112.11])
        by smtp.gmail.com with ESMTPSA id j27sm28560716eda.59.2017.12.24.02.55.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Dec 2017 02:55:00 -0800 (PST)
From:   Mark Nauwelaerts <mark.nauwelaerts@gmail.com>
To:     git@vger.kernel.org
Cc:     Mark Nauwelaerts <mnauw@users.sourceforge.net>
Subject: [PATCH 1/2] fast-export: ensure proper order of modify, copy and rename entries
Date:   Sun, 24 Dec 2017 11:52:08 +0100
Message-Id: <1514112729-31647-2-git-send-email-mark.nauwelaerts@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1514112729-31647-1-git-send-email-mark.nauwelaerts@gmail.com>
References: <1514112729-31647-1-git-send-email-mark.nauwelaerts@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Mark Nauwelaerts <mnauw@users.sourceforge.net>

As b3e8ca8 ("fast-export: do not copy from modified file", 2017-09-20)
indicates, if a commit both modifies a file and uses it as a source for a
copy, then the specifications of git-fast-import require that the copy
should be reported first followed by the modification to the source file.

The commit above addressed the problem by never reporting the copy.  However,
the copy can still be reported if the entries are sorted properly.  That
can be achieved by adjusting the order of the sort that is performed anyway
for other reasons of consistency.  This is merely an extra order condition.

Furthermore, when using fast-export to export or bridge to another
version control system which explicitly tracks copies, then the 'C' commands
in the output are quite useful and necessary.

Signed-off-by: Mark Nauwelaerts <mnauw@users.sourceforge.net>
---
 builtin/fast-export.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 2fb60d6..1b3e250 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -262,6 +262,14 @@ static void export_blob(const struct object_id *oid)
 		free(buf);
 }
 
+static int order_status(const char status)
+{
+	if (status == 'R')
+		return 2;
+	else
+		return status == 'M' ? 1 : 0;
+}
+
 static int depth_first(const void *a_, const void *b_)
 {
 	const struct diff_filepair *a = *((const struct diff_filepair **)a_);
@@ -288,8 +296,12 @@ static int depth_first(const void *a_, const void *b_)
 	 * Move 'R'ename entries last so that all references of the file
 	 * appear in the output before it is renamed (e.g., when a file
 	 * was copied and renamed in the same commit).
+	 * Moreover, 'C' needs to go before 'M' if the file was copied
+	 * and then modified a bit, as it should be done that way as well
+	 * at import time (also recall that 'C' is calculated on the
+	 * original content).
 	 */
-	return (a->status == 'R') - (b->status == 'R');
+	return order_status(a->status) - order_status(b->status);
 }
 
 static void print_path_1(const char *path)
-- 
2.7.4

