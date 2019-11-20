Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B50FC432C3
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 09:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E883621939
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 09:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipvSBMHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfKTJwq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 04:52:46 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:47054 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbfKTJwq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 04:52:46 -0500
Received: by mail-wr1-f67.google.com with SMTP id b3so27334596wrs.13
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 01:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZfFvpUw2wJMHpOt7jJazpu4wgsjJD6CKb2rP/zyEb5A=;
        b=ipvSBMHU/xRDkyxcjOdthk5qHawPKqaZtkCnUPg1ewZT6zUI9orA2yR4YxQNBOrCid
         h17qzLN5aLeU9NAoTmOVINeyyfqtcQomVdlmhGCMlhwU2+udc+ZP0Rrlq55gitabDMaj
         +ETdZROnEp7POsw4+KE+RZ8m7g3ayV/5Q3YfXTHn8f5w7WgSN+BprzAd9mPMsHjuLgJY
         HqUtTjA/cFh+90ynD3HaQ+vim7HVRt7399JTF2Y+XZ7YHyaB8PG6JwUiJj/1AipEoeCS
         TNJJlujynIp7dsPSJj8VnD66FcgMfcJKdtfGFBwHpNqW0QDzDpbSJ2kQw+EEltCTlPNV
         tnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZfFvpUw2wJMHpOt7jJazpu4wgsjJD6CKb2rP/zyEb5A=;
        b=qHmVB2Z8oEZwVlC4RS/8qdfjy+p9J6r5iB4kS33vG45OoLXyOnzviJV3nUwCimT3h3
         so8F4m49wvSqgDM5kg8AK4bMwl+Ajg8W5GYOf6CmK/6d0WdpZLO6slE9SwePfsntIaoo
         378I8J9TXqWAAfaXqzfPYo4b1P8h1Au8/mqFPt4n/OPLPeoysGP9AO9bCQ1tGWe2aRIP
         dITx9n098259rGUFL3S/OewVX67w261Y47cOYnEG/H2t/dC1Oeq/x2qKxn8P/gZaF0LN
         W3lygk5MprYtWetRecn3IDrYKqjV9uODomFsoNZk78H74ijRdNObjFin/4R3yxzVYvyq
         1Bdw==
X-Gm-Message-State: APjAAAXtIv9SkpUVrTb85U6b+Kpq1/MUISFib0O8hhTiTOmXDIXr7TKI
        iOosoCrRh7DfOFpnUg2Zhj/xlOMD6B/gGQ==
X-Google-Smtp-Source: APXvYqwVF3aCPzrzeI+oaOmDwziDJNvbv72gxa0UPcRGdYrxQRjHGE6hkZXWPtRmcaL55cJrYjim5w==
X-Received: by 2002:adf:82c6:: with SMTP id 64mr2033757wrc.151.1574243563834;
        Wed, 20 Nov 2019 01:52:43 -0800 (PST)
Received: from rybak.office.devexperts.com ([185.79.217.61])
        by smtp.googlemail.com with ESMTPSA id p25sm5992516wma.20.2019.11.20.01.52.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 01:52:43 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        predatoramigo@gmail.com
Subject: [RFC PATCH v2 2/4] rebase: prepare cmd before choosing action
Date:   Wed, 20 Nov 2019 10:52:36 +0100
Message-Id: <20191120095238.4349-3-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.24.0.windows.2
In-Reply-To: <20191114163549.7648-1-rybak.a.v@gmail.com>
References: <20191114163549.7648-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When git rebase is started with option --exec, its arguments are parsed
into string_list exec and then converted into options.cmd.

In following commits, action --edit-todo will be taught to use arguments
passed with --exec option.  Prepare options.cmd before switch (action)
to make it available for the ACTION_EDIT_TODO branch of the switch.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 builtin/rebase.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 793cac1386..fa27f7b439 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1595,6 +1595,19 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			trace2_cmd_mode(action_names[action]);
 	}
 
+	for (i = 0; i < exec.nr; i++)
+		if (check_exec_cmd(exec.items[i].string))
+			exit(1);
+
+	if (exec.nr) {
+		imply_interactive(&options, "--exec");
+
+		strbuf_reset(&buf);
+		for (i = 0; i < exec.nr; i++)
+			strbuf_addf(&buf, "exec %s\n", exec.items[i].string);
+		options.cmd = xstrdup(buf.buf);
+	}
+
 	switch (action) {
 	case ACTION_CONTINUE: {
 		struct object_id head;
@@ -1731,10 +1744,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	for (i = 0; i < exec.nr; i++)
-		if (check_exec_cmd(exec.items[i].string))
-			exit(1);
-
 	if (!(options.flags & REBASE_NO_QUIET))
 		argv_array_push(&options.git_am_opts, "-q");
 
@@ -1746,15 +1755,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		options.gpg_sign_opt = xstrfmt("-S%s", gpg_sign);
 	}
 
-	if (exec.nr) {
-		imply_interactive(&options, "--exec");
-
-		strbuf_reset(&buf);
-		for (i = 0; i < exec.nr; i++)
-			strbuf_addf(&buf, "exec %s\n", exec.items[i].string);
-		options.cmd = xstrdup(buf.buf);
-	}
-
 	if (rebase_merges) {
 		if (!*rebase_merges)
 			; /* default mode; do nothing */
-- 
2.24.0.windows.2

