Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7D112036D
	for <e@80x24.org>; Tue, 21 Nov 2017 19:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751316AbdKUTRy (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 14:17:54 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37580 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751281AbdKUTRx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 14:17:53 -0500
Received: by mail-pg0-f65.google.com with SMTP id m4so982604pgc.4
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 11:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=89OpioHJ2Na24XWgTrrRy7kzT9Kdcn9vuXFSW6KBfQk=;
        b=TbqlzM1mJcS58HDEM18MWPB/AjrmX04c4fULrGtjKzq5Ssk0YULKQ6nnDKJOJmi9eE
         J0vb1zcE1t7j2mSblg9hIWPtr3USVXILZpQHce7dQIAwFeZM5SbYIkjM9nkVpAApxt2V
         GlEhhdhZSuo8JC9e9LOMgkrtKlSzOQ/RXEi8b4AweIb3lWxbxue5ZWCZa2hTIVrSaNyj
         sehAJiqIc5fI0Db2pD0G8/4w/58MVh3nReTJBzB4HKqixyHAls6ZD/uEYb7zYLtJxvZ+
         vHkDf0rssUM7cvE2CoIZd8hjhh0iLNbBywoVyfm0BAJoKaPwGPnB8P9/LNHLwzWWNA1o
         cHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=89OpioHJ2Na24XWgTrrRy7kzT9Kdcn9vuXFSW6KBfQk=;
        b=aWT/aelkv9NwRQ0kFrOP4VAew9nOibazyBTRn8GUYjrTZpMEJnVv8rwhT6rG1ZcG41
         zyW17IsHs4MHL3YO5N/sUIKqVhzTbJgpwzgA4mdT6Yo1xEcvKfK5DH+BQuYlonGt9hZp
         9guKUxaOy5A6J0ShH66A2Z+ZhEunanP+u1G8IJqq/c52P+ZlfQrx3j8IUhiHPasrYame
         IQgP9eV8UFd+QZGSS3PJLLY4pVhEOV+veuWfqnn0RMR8VZGFJVW77nZPz/m/g7qs7LrR
         ZQ8hYU+eFc1qJqLnVoRhMwvVUqbLJK/2gKZIFE/ienNBNR+PbcEtPGfxW1InmVKCPubQ
         AO5w==
X-Gm-Message-State: AJaThX5SEg8mEeNBwg77+HaAGW0numr7/zWgGnZdXPvg8RD1ZWWVP1f1
        WNL9VVSdJAzzyjbXmvKdWE8UD65F
X-Google-Smtp-Source: AGs4zMa5dc3oFXrJlKttjgFQfqZZefEiCiwCnF0tSXwachcPP81G7HnSV5JOH/2wjsAmR8LPPtHwVg==
X-Received: by 10.84.246.201 with SMTP id j9mr6824792plt.333.1511291873195;
        Tue, 21 Nov 2017 11:17:53 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7280:849f:7a33:ea78:e714:400])
        by smtp.gmail.com with ESMTPSA id a13sm21092120pgq.10.2017.11.21.11.17.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Nov 2017 11:17:52 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v3 4/4] builtin/branch: strip refs/heads/ using skip_prefix
Date:   Wed, 22 Nov 2017 00:47:08 +0530
Message-Id: <20171121191708.7662-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.345.gf926f18f3
In-Reply-To: <CAPig+cSGu-+6Bw3YBzMwzxO8vKt7jdf9xgtr9FUdOAQpXzi2rQ@mail.gmail.com>
References: <CAPig+cSGu-+6Bw3YBzMwzxO8vKt7jdf9xgtr9FUdOAQpXzi2rQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of hard-coding the offset strlen("refs/heads/") to skip
the prefix "refs/heads/" use the skip_prefix() function which
is more communicative and verifies that the string actually
starts with that prefix.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 Changes in v3:

  - Update commit message

  - Removed superfluous comment

 builtin/branch.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index ca9d8abd0..4ad3b228b 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -462,6 +462,8 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 {
 	struct strbuf oldref = STRBUF_INIT, newref = STRBUF_INIT, logmsg = STRBUF_INIT;
 	struct strbuf oldsection = STRBUF_INIT, newsection = STRBUF_INIT;
+	const char *interpreted_oldname = NULL;
+	const char *interpreted_newname = NULL;
 	int recovery = 0;
 	int clobber_head_ok;
 
@@ -493,6 +495,9 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 
 	reject_rebase_or_bisect_branch(oldref.buf);
 
+	skip_prefix(oldref.buf, "refs/heads/", &interpreted_oldname);
+	skip_prefix(newref.buf, "refs/heads/", &interpreted_newname);
+
 	if (copy)
 		strbuf_addf(&logmsg, "Branch: copied %s to %s",
 			    oldref.buf, newref.buf);
@@ -508,10 +513,10 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	if (recovery) {
 		if (copy)
 			warning(_("Created a copy of a misnamed branch '%s'"),
-				oldref.buf + 11);
+				interpreted_oldname);
 		else
 			warning(_("Renamed a misnamed branch '%s' away"),
-				oldref.buf + 11);
+				interpreted_oldname);
 	}
 
 	if (!copy &&
@@ -520,9 +525,9 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 
 	strbuf_release(&logmsg);
 
-	strbuf_addf(&oldsection, "branch.%s", oldref.buf + 11);
+	strbuf_addf(&oldsection, "branch.%s", interpreted_oldname);
 	strbuf_release(&oldref);
-	strbuf_addf(&newsection, "branch.%s", newref.buf + 11);
+	strbuf_addf(&newsection, "branch.%s", interpreted_newname);
 	strbuf_release(&newref);
 	if (!copy && git_config_rename_section(oldsection.buf, newsection.buf) < 0)
 		die(_("Branch is renamed, but update of config-file failed"));
-- 
2.15.0.345.gf926f18f3

