Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C75F0202AE
	for <e@80x24.org>; Thu,  6 Jul 2017 03:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752675AbdGFDbw (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 23:31:52 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36474 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752315AbdGFDbv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 23:31:51 -0400
Received: by mail-pf0-f195.google.com with SMTP id z6so1196342pfk.3
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 20:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cl8tnwkbQuADHp+SKs5llD1rwyA6tofso+MhjuZsfVY=;
        b=jS/zLp05EVqOdzMuWMkHMmFsU3tpCZuB8NvFHyj3457kNupqrEqnNz1OINjmnlMwYa
         uwFzze8dawqW9qIDCQCrNi8wvr5JxH2ju4lA/Bhj3C1EFtPL0eZGQkjp6FRcD378+i4G
         0VB1/htvo+UhEyr2Lo0uJK9TCgFcU4ut0mvPE6KTio2pUx6511s0NdClJBfnMPbZ2/1p
         OP53wm/zYx0p6mIOzpsL1zZ/WIwk+xDfPA1lsaieKcj3PmJxPNw+zfyknt28apClUPvS
         p0UnRxGsS4HLWnWKkdKVPHoSjl2mP6fplojY5IApGnu0TxDhPt/VixjTA+7V9eDWypUe
         tBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cl8tnwkbQuADHp+SKs5llD1rwyA6tofso+MhjuZsfVY=;
        b=pFZ8T0eHxmnjMv7uXrPuP0V5rCFPuiLR7tAGJE1hatuB/L+yTL3ezqMNQ1q0ys9Ncz
         kzKyq4spe+J4okM7tvgwxSUjUbannONszyF1EMPOc3220Q+q5ksB6Im/Fld9pdRFnmRH
         5C/u7kKvYobV4LB7ijAMnr1rRuRsoPAGV2r8X55d+VFxT9DNEI5hDDzp4p+pl5JewjKc
         iPTa0MFljtp7wWNC4dJwG/Fg0LlUCsYicW9PryzxvKhCUiepUXupOqiShLEp5gqj7E0V
         0V1NVfaZADBimSJnlYsF9l5e1Uu0GOLEAkW+mmLIPIBTaZ6lpgCt3YYb5X/igJDd30tQ
         oBPQ==
X-Gm-Message-State: AIVw112aAfonFBMYAHsemq23Pvoafpa53I0lZfuYsFWEizQfQM7t/lrE
        ep/OY22eKDRb9xij+Ed58Q==
X-Received: by 10.84.216.92 with SMTP id f28mr25778482plj.199.1499311910837;
        Wed, 05 Jul 2017 20:31:50 -0700 (PDT)
Received: from localhost.localdomain ([117.246.77.117])
        by smtp.gmail.com with ESMTPSA id p65sm1057938pfj.8.2017.07.05.20.31.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jul 2017 20:31:50 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH] merge-message: change meaning of "empty merge message"
Date:   Thu,  6 Jul 2017 09:01:49 +0530
Message-Id: <20170706033149.6275-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <xmqq60f9mo6b.fsf@gitster.mtv.corp.google.com>
References: <xmqq60f9mo6b.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the context of "git merge" the meaning of an "empty message"
is one that contains no line of text. This is not in line with
"git commit" where an "empty message" is one that contains only
whitespaces and/or signed-off-by lines. This could cause surprises
to users who are accustomed to the meaning of an "empty message"
of "git commit".

Prevent such surprises by changing the meaning of an empty 'merge
message' to be in line with that of an empty 'commit message'.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 builtin/merge.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 703827f00..db4bf1c40 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -748,6 +748,39 @@ static void abort_commit(struct commit_list *remoteheads, const char *err_msg)
 	exit(1);
 }
 
+/*
+ * Find out if the message in the strbuf contains only whitespace and
+ * Signed-off-by lines.
+ *
+ * This function is the "rest_is_space" function of "commit" with the unwanted
+ * parameter removed.
+ */
+static int message_is_empty(struct strbuf *sb)
+{
+	int i, eol;
+	const char *nl;
+
+	/* Check if the rest is just whitespace and Signed-off-by's. */
+	for (i = 0; i < sb->len; i++) {
+		nl = memchr(sb->buf + i, '\n', sb->len - i);
+		if (nl)
+			eol = nl - sb->buf;
+		else
+			eol = sb->len;
+
+		if (strlen(sign_off_header) <= eol - i &&
+		    starts_with(sb->buf + i, sign_off_header)) {
+			i = eol;
+			continue;
+		}
+		while (i < eol)
+			if (!isspace(sb->buf[i++]))
+				return 0;
+	}
+
+	return 1;
+}
+
 static const char merge_editor_comment[] =
 N_("Please enter a commit message to explain why this merge is necessary,\n"
    "especially if it merges an updated upstream into a topic branch.\n"
@@ -772,7 +805,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	}
 	read_merge_msg(&msg);
 	strbuf_stripspace(&msg, 0 < option_edit);
-	if (!msg.len)
+	if (!msg.len || message_is_empty(&msg))
 		abort_commit(remoteheads, _("Empty commit message."));
 	strbuf_release(&merge_msg);
 	strbuf_addbuf(&merge_msg, &msg);
-- 
2.11.0

