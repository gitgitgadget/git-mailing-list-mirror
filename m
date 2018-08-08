Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99256208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbeHHRnZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:43:25 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:45463 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbeHHRnY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 13:43:24 -0400
Received: by mail-ed1-f53.google.com with SMTP id s16-v6so1429747edq.12
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QLqrvo+A/pm6fNm/BcS7LkAbityDSd12JRxRe3TrdSU=;
        b=JJ5cJbQUdMBBAueX5fYcMF61JpErqztxRO90AeBLC1Huu2huVzzZtSl+Ljbdkp2aUd
         S2f+cZsjG2LEX7AuSdtbZOV9v75yo5SVenbrG7PltPYGnDKh5lyr+DIZf3LpiXc8+FB9
         G56GQncASLGP07oyN7pWAbL1lip4CHTHB3Cz68LzXcxbEbGFl6WXG+AanU8YKvJ6+D8i
         lWF7+dEmOXM94PT8fE1iz/Z/LLejHtxYbz/iBU6RNuFg04QzShi0F2jf71DnsztuI2iH
         TUkjl2gDioid1VLR3h0So02CE2oY3qaNfsalpJL3uzUtg8SkwyhTi2B1Be1ddA6w+cHw
         gWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QLqrvo+A/pm6fNm/BcS7LkAbityDSd12JRxRe3TrdSU=;
        b=l9sLnVyB5Op2Bk3CwGvfGO/MgR1oNPnsnE6tQCAdy1rBT75YbZ0ytP3R4l9cnejWaH
         Ia4P+gBmIxEbcHTTOjKoQkysU3SyEy5yBRMYU9thLyQBaOG4TQvWt/rr2/KauqohFk2N
         J6RcSGG0XKBKsedetOK5q9R3QeX7GqNVpVkTpsXeIccnhsACAOwE2VbSjtVEUhdrgZbe
         c3C43QnKxQwWsI7sMA4nKNsBQQXeYH3Z53NK4RX9M7940/HD6Z8DLvgNADHdWz0CxrgB
         mKumejYCP3l7FOT29bJWl2hkk9vIQrZgI8nJ9COPrYGtAiPTz9Cd1xJ0nhTUCKJO5kwM
         1dwg==
X-Gm-Message-State: AOUpUlErrImoOAOUybMqaxXyuA9mBof0+UoyvPNBOP8cjx0HYAMYIS+A
        oP8a3eyzGiSakWtEMSClI0m7ol1V
X-Google-Smtp-Source: AA+uWPzFDFO0+j+drfy5bXJb2Reyg3AB2PeCwRmeL1XS1WGGAlAkDpspxGI6r5IS4xrcKvItJUIb6w==
X-Received: by 2002:a50:f18c:: with SMTP id x12-v6mr3974501edl.59.1533741794411;
        Wed, 08 Aug 2018 08:23:14 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id v56-v6sm6058572edm.97.2018.08.08.08.23.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:23:13 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 10/18] builtin rebase: support `-C` and `--whitespace=<type>`
Date:   Wed,  8 Aug 2018 21:06:32 +0545
Message-Id: <20180808152140.14585-11-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808152140.14585-1-predatoramigo@gmail.com>
References: <20180808152140.14585-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit converts more code from the shell script version to the
builtin rebase. In this instance, we just have to be careful to
keep support for passing multiple `--whitespace` options, as the
shell script version does so, too.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index cd9caf4841..4437c86513 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -574,6 +574,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	int ignore_date = 0;
 	int ignore_whitespace = 0;
 	const char *gpg_sign = NULL;
+	int opt_c = -1;
+	struct string_list whitespace = STRING_LIST_INIT_NODUP;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -640,6 +642,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			    "squash!/fixup! under -i")),
 		OPT_STRING('S', "gpg-sign", &gpg_sign,
 			   N_("gpg-sign?"), N_("GPG-sign commits")),
+		OPT_STRING_LIST(0, "whitespace", &whitespace,
+				N_("whitespace"), N_("passed to 'git apply'")),
+		OPT_SET_INT('C', 0, &opt_c, N_("passed to 'git apply'"),
+			    REBASE_AM),
 		OPT_END(),
 	};
 
@@ -847,6 +853,23 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		options.gpg_sign_opt = xstrfmt("-S%s", gpg_sign);
 	}
 
+	if (opt_c >= 0)
+		strbuf_addf(&options.git_am_opt, " -C%d", opt_c);
+
+	if (whitespace.nr) {
+		int i;
+
+		for (i = 0; i < whitespace.nr; i++) {
+			const char *item = whitespace.items[i].string;
+
+			strbuf_addf(&options.git_am_opt, " --whitespace=%s",
+				    item);
+
+			if ((!strcmp(item, "fix")) || (!strcmp(item, "strip")))
+				options.flags |= REBASE_FORCE;
+		}
+	}
+
 	switch (options.type) {
 	case REBASE_MERGE:
 	case REBASE_INTERACTIVE:
-- 
2.18.0

