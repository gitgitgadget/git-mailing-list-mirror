Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43887208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbeHHR6h (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:58:37 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:35878 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbeHHR6h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 13:58:37 -0400
Received: by mail-ed1-f52.google.com with SMTP id k15-v6so1481169edr.3
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7BovAKAwAf0aNmEGwNWpS2llrtN45xFWy1wLIg8lnKY=;
        b=NJyqB4JTIINk9X9Q05O9OAv9xRQlcU1g3o36MWdsu0DeXEDsS/e+mJxU0gqbtrno8U
         TJ4eSapx3S0OkFYL9BxM7aUzDtvWSnqWBWgq2CDdUDwfXIuqaRvGrvpj4Z7a1l6AOXNw
         c1zwY7vLLPmx1ZS85kaX2A/AasacHQXmWHBIW4S/jx0mOdjEOjyagDskymSQNJ/+OsM/
         F/76hktA7UaOpJttP5abCUPw1YqBkHCdUJlKuVRn2wPI2pqdlHO8wsqGWHLx9OJc4G76
         saAA0P30MOr52C4AN5D4XoAniGJwv1CI/Y4Mk6VlK7mJQzDZnEFr+pBpsB1BOAObQbvU
         2KRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7BovAKAwAf0aNmEGwNWpS2llrtN45xFWy1wLIg8lnKY=;
        b=jDEH16fqHiJdshsPKC5Z9y05fDN/M5TI9+W61w+1yDdPPjtqEOkzs7MOzcEQTOGXdr
         Mrp8it01Tg08LXcMlcFiI2aKUs+oRfOXumU4FWy9KFL89bRRwAIVOvq8JlsMRs6x16IC
         ncRg1D1xwMSwXVYEW0XbX7TTkA+kkR4SHHVLI5RcVvRRtds2V5lPythr0c5UCyklgavJ
         58D+DY+hsw4RcZUh8zKSUlFNsqMitnxGeJ1UUcU5qJjAGOEIpLED4LyUPGhgO8EnlVwq
         2KfKX5Z3REiWvpmQmhMd/xuhzQkKxQD8nnNl15eNepJtCLO82IosCB3mH6a4Oro5MYS4
         aYJw==
X-Gm-Message-State: AOUpUlHOEHA1YhhHPuGtZbGrY8rsvB8hrINbBZCq0K620RJh1iwaVj7K
        XwO470KGvE0r2EXgxdjOuKFWZcuh
X-Google-Smtp-Source: AA+uWPwJqIid2UL8wZmeyrAIquWxOQURM9pXMCle5Shm9biweT5vOUIhDNXw88Jo34fKlvBbd4cZfg==
X-Received: by 2002:a50:f31a:: with SMTP id p26-v6mr3960423edm.68.1533742703266;
        Wed, 08 Aug 2018 08:38:23 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id d11-v6sm1904876edo.39.2018.08.08.08.38.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:38:22 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 2/6] builtin rebase: optionally pass custom reflogs to reset_head()
Date:   Wed,  8 Aug 2018 21:21:31 +0545
Message-Id: <20180808153635.19944-3-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808153635.19944-1-predatoramigo@gmail.com>
References: <20180808153635.19944-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the next patch, we will make use of that in the code that
fast-forwards to `onto` whenever possible.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index c5b2534717..c51b9d288a 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -431,7 +431,8 @@ static int run_specific_rebase(struct rebase_options *opts)
 #define GIT_REFLOG_ACTION_ENVIRONMENT "GIT_REFLOG_ACTION"
 
 static int reset_head(struct object_id *oid, const char *action,
-		      const char *switch_to_branch, int detach_head)
+		      const char *switch_to_branch, int detach_head,
+		      const char *reflog_orig_head, const char *reflog_head)
 {
 	struct object_id head_oid;
 	struct tree_desc desc;
@@ -506,20 +507,26 @@ static int reset_head(struct object_id *oid, const char *action,
 		old_orig = &oid_old_orig;
 	if (!get_oid("HEAD", &oid_orig)) {
 		orig = &oid_orig;
-		strbuf_addstr(&msg, "updating ORIG_HEAD");
-		update_ref(msg.buf, "ORIG_HEAD", orig, old_orig, 0,
+		if (!reflog_orig_head) {
+			strbuf_addstr(&msg, "updating ORIG_HEAD");
+			reflog_orig_head = msg.buf;
+		}
+		update_ref(reflog_orig_head, "ORIG_HEAD", orig, old_orig, 0,
 			   UPDATE_REFS_MSG_ON_ERR);
 	} else if (old_orig)
 		delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
-	strbuf_setlen(&msg, prefix_len);
-	strbuf_addstr(&msg, "updating HEAD");
+	if (!reflog_head) {
+		strbuf_setlen(&msg, prefix_len);
+		strbuf_addstr(&msg, "updating HEAD");
+		reflog_head = msg.buf;
+	}
 	if (!switch_to_branch)
-		ret = update_ref(msg.buf, "HEAD", oid, orig, REF_NO_DEREF,
+		ret = update_ref(reflog_head, "HEAD", oid, orig, REF_NO_DEREF,
 				 UPDATE_REFS_MSG_ON_ERR);
 	else {
 		ret = create_symref("HEAD", switch_to_branch, msg.buf);
 		if (!ret)
-			ret = update_ref(msg.buf, "HEAD", oid, NULL, 0,
+			ret = update_ref(reflog_head, "HEAD", oid, NULL, 0,
 					 UPDATE_REFS_MSG_ON_ERR);
 	}
 
@@ -899,7 +906,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		rerere_clear(&merge_rr);
 		string_list_clear(&merge_rr, 1);
 
-		if (reset_head(NULL, "reset", NULL, 0) < 0)
+		if (reset_head(NULL, "reset", NULL, 0, NULL, NULL) < 0)
 			die(_("could not discard worktree changes"));
 		if (read_basic_state(&options))
 			exit(1);
@@ -915,7 +922,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		if (read_basic_state(&options))
 			exit(1);
 		if (reset_head(&options.orig_head, "reset",
-			       options.head_name, 0) < 0)
+			       options.head_name, 0, NULL, NULL) < 0)
 			die(_("could not move back to %s"),
 			    oid_to_hex(&options.orig_head));
 		ret = finish_rebase(&options);
@@ -1235,7 +1242,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			write_file(autostash, "%s", buf.buf);
 			printf(_("Created autostash: %s\n"), buf.buf);
 			if (reset_head(&head->object.oid, "reset --hard",
-				       NULL, 0) < 0)
+				       NULL, 0, NULL, NULL) < 0)
 				die(_("could not reset --hard"));
 			printf(_("HEAD is now at %s"),
 			       find_unique_abbrev(&head->object.oid,
@@ -1289,7 +1296,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				strbuf_addf(&buf, "rebase: checkout %s",
 					    options.switch_to);
 				if (reset_head(&oid, "checkout",
-					       options.head_name, 0) < 0) {
+					       options.head_name, 0,
+					       NULL, NULL) < 0) {
 					ret = !!error(_("could not switch to "
 							"%s"),
 						      options.switch_to);
@@ -1354,7 +1362,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			 "it...\n"));
 
 	strbuf_addf(&msg, "rebase: checkout %s", options.onto_name);
-	if (reset_head(&options.onto->object.oid, "checkout", NULL, 1))
+	if (reset_head(&options.onto->object.oid, "checkout", NULL, 1,
+	    NULL, msg.buf))
 		die(_("Could not detach HEAD"));
 	strbuf_release(&msg);
 
-- 
2.18.0

