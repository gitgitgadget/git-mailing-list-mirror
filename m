Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C59971F406
	for <e@80x24.org>; Mon, 14 May 2018 21:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbeENV6G (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 17:58:06 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:56733 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752621AbeENV6F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 17:58:05 -0400
Received: by mail-yw0-f202.google.com with SMTP id w205-v6so5756223ywd.23
        for <git@vger.kernel.org>; Mon, 14 May 2018 14:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=hYI7p7LLkl2KsjsIehXPK3qJYp22ToeYMOMSwpIrdJY=;
        b=E8POb7GnJHAU7l1aL0IEhpvjRHSM441MIXjD86T2zczdl3jLnXHp1PQGFiVIM+aQuy
         ictNPP2cC/dEBlAwNVrMBZDEYiczynMhcyqOpx7eZuO0BS/q36gf/k4oolONZzEuUlBg
         qMhnsWLldzALzCmYtLDLVVbZn/awsC6P36L2wrrPLQsYnUk6Vge/NoJEts/H3YneUK9l
         gswlp9fuo9IO9r+uWnGtoCRkbR1bYHPCQOwyKVmZZBTSjYh96xI7oQw1sgY2VLgsGcKZ
         xP3CqAsT7QrUbUqWjxhRQUkJn6InTmGR3/qZ1MMQS26SXbr3ySJae/qvt+WCY9BjJ6BX
         fhrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=hYI7p7LLkl2KsjsIehXPK3qJYp22ToeYMOMSwpIrdJY=;
        b=T8gqWGsTbY+aIZMty3s2HtDUxos5gEsBkoGDtQcMdgnr3z8soVMMQZvGwUl6Oj6BkY
         LYakzfi01rOUOLM93x+sC83gLcLJ4jrc4dlXHES1dmDPFpsjESuKv+nkBcNoKBnZkXWn
         YTyLK8rLdQLIJnN+FSqUtaZqJRY5Q5hT8rRtuWNzJBysOYYjj6fbWJs0RBxrhwl47A6i
         rVzvFE8AiBYd0ppKJdC468nnzvLhx/hnGpbOoHQ6CkOiphKgTTwOW77BsbEEOVIVb3Wd
         JAk02HBOVJZQUgePp2SOUqJdx8iyxlv7NKWH/C8xncMMZPPEqJ/7gLK/TkEHPpr844vA
         oGSw==
X-Gm-Message-State: ALKqPwdiMHiTVrURVaKu5Cr01Ug1Spl/2h33gdp8GPw2mQPWDpecJpVd
        uzqSRKpgjveSrWsxU3Cv807xpKMf1lEV+GKuyUqBLX5eO0DrDkl5YvOYRfdS3ixP09pqUJHgVeo
        URr3ooqgp7zPN7YcITC/ssKhTksn6++H1I2RDdsu25C8FoQd8iVQtk2LpdA==
X-Google-Smtp-Source: AB8JxZoKfOpRpyDl8SJ8VjjLb2vEksXuVU1rW0dJ4WOQ3dt4oPPGvAHJR/c3by23igxGFyLhY6bM8T/hKwY=
MIME-Version: 1.0
X-Received: by 2002:a81:6f54:: with SMTP id k81-v6mr3386098ywc.71.1526335084362;
 Mon, 14 May 2018 14:58:04 -0700 (PDT)
Date:   Mon, 14 May 2018 14:56:26 -0700
In-Reply-To: <20180514215626.164960-1-bmwill@google.com>
Message-Id: <20180514215626.164960-36-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 35/35] submodule: convert push_unpushed_submodules to take a
 struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'push_unpushed_submodules()' to take a 'struct refspec' as a
parameter instead of an array of 'const char *'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule.c | 19 +++++++++----------
 submodule.h |  3 ++-
 transport.c |  2 +-
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/submodule.c b/submodule.c
index 74d35b257..cdeadd80e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -968,7 +968,7 @@ int find_unpushed_submodules(struct oid_array *commits,
 
 static int push_submodule(const char *path,
 			  const struct remote *remote,
-			  const char **refspec, int refspec_nr,
+			  const struct refspec *rs,
 			  const struct string_list *push_options,
 			  int dry_run)
 {
@@ -991,8 +991,8 @@ static int push_submodule(const char *path,
 		if (remote->origin != REMOTE_UNCONFIGURED) {
 			int i;
 			argv_array_push(&cp.args, remote->name);
-			for (i = 0; i < refspec_nr; i++)
-				argv_array_push(&cp.args, refspec[i]);
+			for (i = 0; i < rs->raw_nr; i++)
+				argv_array_push(&cp.args, rs->raw[i]);
 		}
 
 		prepare_submodule_repo_env(&cp.env_array);
@@ -1013,7 +1013,7 @@ static int push_submodule(const char *path,
  */
 static void submodule_push_check(const char *path, const char *head,
 				 const struct remote *remote,
-				 const char **refspec, int refspec_nr)
+				 const struct refspec *rs)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	int i;
@@ -1023,8 +1023,8 @@ static void submodule_push_check(const char *path, const char *head,
 	argv_array_push(&cp.args, head);
 	argv_array_push(&cp.args, remote->name);
 
-	for (i = 0; i < refspec_nr; i++)
-		argv_array_push(&cp.args, refspec[i]);
+	for (i = 0; i < rs->raw_nr; i++)
+		argv_array_push(&cp.args, rs->raw[i]);
 
 	prepare_submodule_repo_env(&cp.env_array);
 	cp.git_cmd = 1;
@@ -1043,7 +1043,7 @@ static void submodule_push_check(const char *path, const char *head,
 
 int push_unpushed_submodules(struct oid_array *commits,
 			     const struct remote *remote,
-			     const char **refspec, int refspec_nr,
+			     const struct refspec *rs,
 			     const struct string_list *push_options,
 			     int dry_run)
 {
@@ -1069,8 +1069,7 @@ int push_unpushed_submodules(struct oid_array *commits,
 
 		for (i = 0; i < needs_pushing.nr; i++)
 			submodule_push_check(needs_pushing.items[i].string,
-					     head, remote,
-					     refspec, refspec_nr);
+					     head, remote, rs);
 		free(head);
 	}
 
@@ -1078,7 +1077,7 @@ int push_unpushed_submodules(struct oid_array *commits,
 	for (i = 0; i < needs_pushing.nr; i++) {
 		const char *path = needs_pushing.items[i].string;
 		fprintf(stderr, "Pushing submodule '%s'\n", path);
-		if (!push_submodule(path, remote, refspec, refspec_nr,
+		if (!push_submodule(path, remote, rs,
 				    push_options, dry_run)) {
 			fprintf(stderr, "Unable to push submodule '%s'\n", path);
 			ret = 0;
diff --git a/submodule.h b/submodule.h
index e5526f6aa..aae0c9c8f 100644
--- a/submodule.h
+++ b/submodule.h
@@ -100,9 +100,10 @@ extern int submodule_touches_in_range(struct object_id *a,
 extern int find_unpushed_submodules(struct oid_array *commits,
 				    const char *remotes_name,
 				    struct string_list *needs_pushing);
+struct refspec;
 extern int push_unpushed_submodules(struct oid_array *commits,
 				    const struct remote *remote,
-				    const char **refspec, int refspec_nr,
+				    const struct refspec *rs,
 				    const struct string_list *push_options,
 				    int dry_run);
 /*
diff --git a/transport.c b/transport.c
index e32bc320c..7e0b9abba 100644
--- a/transport.c
+++ b/transport.c
@@ -1157,7 +1157,7 @@ int transport_push(struct transport *transport,
 
 			if (!push_unpushed_submodules(&commits,
 						      transport->remote,
-						      rs->raw, rs->raw_nr,
+						      rs,
 						      transport->push_options,
 						      pretend)) {
 				oid_array_clear(&commits);
-- 
2.17.0.441.gb46fe60e1d-goog

