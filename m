Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3E8D1F406
	for <e@80x24.org>; Wed, 16 May 2018 23:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752416AbeEPXAJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 19:00:09 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:47960 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752395AbeEPXAE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 19:00:04 -0400
Received: by mail-ua0-f202.google.com with SMTP id 100-v6so2241789uac.14
        for <git@vger.kernel.org>; Wed, 16 May 2018 16:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=hYI7p7LLkl2KsjsIehXPK3qJYp22ToeYMOMSwpIrdJY=;
        b=rthRv6+fCdGRf6nYwm19xoqNGbb56lC2g+wuT9dJPuBo0/0+vOr/wVdvOhm/kOsBcN
         VWJ5rqxGbPr7yeeOvyki+tRdajOHtv0AtLYVkOaDsWxP7NxMQUo8D9iuArb9ty48rjZB
         4RM58i5FKTmJuTI+hwPnImTyuGkSaafTNGRVw9EoTHy1cmeNvpe5yfQOXmlXZ8WM/ZTe
         HMBi7SEAOM/Z/V2wqj0+Vr1DwZjzyGL1wROM0hUQOYOc7rlB3I39gLu5OeEmjzrNp0hi
         TcYOCpXwbpw+c+SPTADCOHHWINeEYrBklTpewbKkm3Ym4aLhiht2fvfVMLX6MzNAd6zz
         UfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=hYI7p7LLkl2KsjsIehXPK3qJYp22ToeYMOMSwpIrdJY=;
        b=t2ChGnF2KsR39hYFMCn9WDJBGGecf/3mSQq35sxOYiAuBrwp0XaX7pI1d9IIpDm/XZ
         ANb60c3HpiLVy16iocsTGSesRxAb7Q9i0uaqRkHZaN63ZV7//4HdSC6jCJ9no5NQMIv5
         OI88EQkIRQQZvzlFKDi2BM2YVxlQKda8RhzKBVXIAAyIzZS4kjxaCXRBCtpw+ZHMk2CK
         8NTQNZUOFHkPic/VmYk7Nn+lmHaZVT//Nz9gh13ZmiNASc/0CZlaeGY7MhOV3zdTK1b5
         HODN+XAoO5iEJ7XvNo7kcp1Eh8SHY90w4kslLwgj4ql56DDv0MXLFscbfNAM7HuW92pP
         +3Yw==
X-Gm-Message-State: ALKqPwfT7iwUQGQ1o+ucVYkg2tmbXObp69FdRDzDsya5o7CvsV6V7azK
        Ddbi8i5/7PTnSPPPuYa0Dvj1l4Fki05tBRXIjldRMzKJijWg+iA+BOjM3q8vBCg9GvfjH8+WCHw
        tiNy6NSlV5mNik4gWIGQS9MYuhgWjFQ7Zfje10XJJLETnluwP1ZFFrFzyiw==
X-Google-Smtp-Source: AB8JxZptXWhLp7gqRCKuIpag2HJ1cuYpZY1lBIdnL2JQDgwsSwNvm0icQXd1OjIZ9XejD+LsR5u8tVUEejk=
MIME-Version: 1.0
X-Received: by 2002:a1f:9d03:: with SMTP id g3-v6mr2471036vke.0.1526511603290;
 Wed, 16 May 2018 16:00:03 -0700 (PDT)
Date:   Wed, 16 May 2018 15:58:23 -0700
In-Reply-To: <20180516225823.235426-1-bmwill@google.com>
Message-Id: <20180516225823.235426-37-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com> <20180516225823.235426-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH v2 36/36] submodule: convert push_unpushed_submodules to take
 a struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        sbeller@google.com, bmwill@google.com
Cc:     avarab@gmail.com, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
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

