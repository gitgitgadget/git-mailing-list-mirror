Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29CD5208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbeHHRnB (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:43:01 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:37773 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeHHRnB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 13:43:01 -0400
Received: by mail-ed1-f47.google.com with SMTP id b10-v6so1458698eds.4
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jySO6oWr/ifVImkGdY6KF1JjCx1mjkoDeD6NdXNIvUk=;
        b=qQC6hvR00v+TCXqWq4DTgrIEa6B01UmzVxrqvSLyc2MlNdgtqh1xOSqhh2YxnDW/X5
         gAhiajIVUqj9S3rzW2t8TXABXBKlnzi0TbCESnKdKwWDVZwFLXArkjVWIob0Tas6IiaZ
         PWqmkpagCKVcwehB/HP1NjajsA45RPGA9uCGlgxv0zoIEcWgiNf5bGsy8fB/cinq0Htd
         9rND6p7DcS3yi0NZKzpwXVPTf7X8285xOrUM8BRerfW+cbx2HwHx4Zk9v9IrZWzd/vaT
         fSY81yqJjb9p3vIZUd9xTPnA+A2xrTE5Ku1rIzVe7i5Egt3K7dyhCGolY96iJ7BxL+uL
         8e8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jySO6oWr/ifVImkGdY6KF1JjCx1mjkoDeD6NdXNIvUk=;
        b=j2b95wDFpcC85EjI36iReQNsjlZ+CDT3Ot+DMT+yy95tcZnPsNHIV08ot9DKK4dkPv
         y5G+NKaBNPli+lB6bBNc3NnQB2F0UHUzI6DKUW6on3r/m7Td0GSvwAmh9cRgdPtVXLN2
         4+k+pk5VedaBdhtvruG3Nb27eupXVHQj4is//G+K+1ba2SkaQszIodp+QogSb4X/iNjL
         qT711pVqkzX3GyW0dqDFSEsEL7VnG0qc0MHVbGPT24Ul1lq70gmUyJqF23JvTpFObv7P
         xmcrihnzA8T47iZatsIAOQL4RPJcsMWddWom7uxYx6jjK9afAnrTq4RW1T4OkmolBQ8/
         clRQ==
X-Gm-Message-State: AOUpUlEUsDllbmXhGgpDYIuajwBtyM7ycVL3FGNV+52PV/ea2rqKy4R5
        iFyyk104C1XtpTb4KpAqi+834MUx
X-Google-Smtp-Source: AA+uWPzy2g6XVNCtGz6lhweeoQ/I5c5jVqQuwHgR9dtNXI7F1L1OgOZp+2EMgaB+WTUCRTiz8lt5QQ==
X-Received: by 2002:a50:ef09:: with SMTP id m9-v6mr3803551eds.136.1533741772157;
        Wed, 08 Aug 2018 08:22:52 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id v56-v6sm6058572edm.97.2018.08.08.08.22.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:22:51 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 04/18] builtin rebase: support --committer-date-is-author-date
Date:   Wed,  8 Aug 2018 21:06:26 +0545
Message-Id: <20180808152140.14585-5-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808152140.14585-1-predatoramigo@gmail.com>
References: <20180808152140.14585-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This option is simply handed down to `git am` by way of setting the
`git_am_opt` variable that is handled by the `git-rebase--am` backend.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 1729d2d9e2..eef16206c2 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -526,6 +526,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		ACTION_EDIT_TODO,
 		ACTION_SHOW_CURRENT_PATCH,
 	} action = NO_ACTION;
+	int committer_date_is_author_date = 0;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -543,6 +544,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
 		OPT_BOOL(0, "signoff", &options.signoff,
 			 N_("add a Signed-off-by: line to each commit")),
+		OPT_BOOL(0, "committer-date-is-author-date",
+			 &committer_date_is_author_date,
+			 N_("passed to 'git am'")),
 		OPT_BIT('f', "force-rebase", &options.flags,
 			N_("cherry-pick all commits, even if unchanged"),
 			REBASE_FORCE),
@@ -763,6 +767,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (!(options.flags & REBASE_NO_QUIET))
 		strbuf_addstr(&options.git_am_opt, " -q");
 
+	if (committer_date_is_author_date) {
+		strbuf_addstr(&options.git_am_opt,
+			      " --committer-date-is-author-date");
+		options.flags |= REBASE_FORCE;
+	}
+
 	switch (options.type) {
 	case REBASE_MERGE:
 	case REBASE_INTERACTIVE:
-- 
2.18.0

