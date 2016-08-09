Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3BFF2018E
	for <e@80x24.org>; Tue,  9 Aug 2016 04:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbcHIENg (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 00:13:36 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33102 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbcHIENg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 00:13:36 -0400
Received: by mail-pf0-f178.google.com with SMTP id y134so749604pfg.0
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 21:13:35 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L75qKxtBDTpWWeQkra4eecILf30MbDhPSAw//+TFuI4=;
        b=b89bhMPFxkKLyT2kJDSOO/kC/EgQDmuSj7koqdCruBxejgeV3errMlHMP9xMEvh58i
         nrGP8MZ90C+rm+y9HAPS18RkvYPlMqyppAb1hq5b1F8WEjO9Si3LvvpFOE7f0eYBU7ze
         btxrDvedF7V7PRilQidPvLlc10Xwih53SP2qxhRs+jMxDl67mhzBNfziCU2CC1UDfV0m
         3OKtpjDJSPSly0VpDe6WNpUS7gtrzUD//lRG6sFi3C0dZJDbweBvv6yUXcyjWF+0aU0F
         91z8VephfYqgSF7ol1gZlXKX67SGHZTPBaJd2lVYdWOiYRFoFyEIKAtb+li44+7hkzhg
         EBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L75qKxtBDTpWWeQkra4eecILf30MbDhPSAw//+TFuI4=;
        b=AiFyodolQNYIc1xlZFhmBt1uZBHmKtGX+ob9V3znhpFFvusko4LY47r4mWghIMHRXT
         tCnrWEmccYFhvLfsWVU/LLZVf8pRpC9lEGTH86Cwy1Lr8JEZghjkOPUp06q52FgPGoXX
         Jh8CoVw0WZ0hRYLQ50O8J1pIsFjmTLq1C39pqbmsLIGm8ZwYHXxnVvnAmoMo+QkYOb50
         lEKtjQwPOb6lJtz4/wB2ZFoj2saUFgqQTJnPY0qB29EUuc2NWiycQ8mWqLXtY9W+XQ+2
         YUN3LtUT4swE9wiuwpsDIlLu80vluw324Vy4HPgv1jAkGsyQVS7wTuE37OWf3rpLnXUz
         kJSQ==
X-Gm-Message-State: AEkoouuAiUERY+fPyi1HwJ+V4VJsptlceCoEJX5RbAsa4ZW8QTo2uZA87fybYz+OtFJFpsAA
X-Received: by 10.98.16.75 with SMTP id y72mr168021050pfi.50.1470715713679;
        Mon, 08 Aug 2016 21:08:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:ad25:78d3:1e25:67ef])
        by smtp.gmail.com with ESMTPSA id d9sm51676779pan.7.2016.08.08.21.08.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 21:08:33 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, mst@redhat.com,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 7/9] submodule helper: pass through --reference-if-able
Date:	Mon,  8 Aug 2016 21:08:09 -0700
Message-Id: <20160809040811.21408-10-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.583.gd6329be.dirty
In-Reply-To: <20160809040811.21408-1-sbeller@google.com>
References: <20160809040811.21408-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

In a later patch we need to pass optional references
through to git clone, so add the capability for it.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 7096848..f360473 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -442,7 +442,8 @@ static int module_name(int argc, const char **argv, const char *prefix)
 }
 
 static int clone_submodule(const char *path, const char *gitdir, const char *url,
-			   const char *depth, struct string_list *reference, int quiet)
+			   const char *depth, struct string_list *reference,
+			   struct string_list *reference_if_able, int quiet)
 {
 	struct child_process cp;
 	child_process_init(&cp);
@@ -459,6 +460,12 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
 			argv_array_pushl(&cp.args, "--reference",
 					 item->string, NULL);
 	}
+	if (reference_if_able->nr) {
+		struct string_list_item *item;
+		for_each_string_list_item(item, reference_if_able)
+			argv_array_pushl(&cp.args, "--reference-if-able",
+					 item->string, NULL);
+	}
 	if (gitdir && *gitdir)
 		argv_array_pushl(&cp.args, "--separate-git-dir", gitdir, NULL);
 
@@ -481,6 +488,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	struct strbuf rel_path = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	struct string_list reference = STRING_LIST_INIT_NODUP;
+	struct string_list reference_if_able = STRING_LIST_INIT_NODUP;
 
 	struct option module_clone_options[] = {
 		OPT_STRING(0, "prefix", &prefix,
@@ -498,6 +506,9 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		OPT_STRING_LIST(0, "reference", &reference,
 			   N_("repo"),
 			   N_("reference repository")),
+		OPT_STRING_LIST(0, "reference-if-able", &reference_if_able,
+			   N_("repo"),
+			   N_("reference repository")),
 		OPT_STRING(0, "depth", &depth,
 			   N_("string"),
 			   N_("depth for shallow clones")),
@@ -507,8 +518,8 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 
 	const char *const git_submodule_helper_usage[] = {
 		N_("git submodule--helper clone [--prefix=<path>] [--quiet] "
-		   "[--reference <repository>] [--name <name>] [--depth <depth>] "
-		   "--url <url> --path <path>"),
+		   "[--reference[-if-able] <repository>] [--name <name>] "
+		   "[--depth <depth>] --url <url> --path <path>"),
 		NULL
 	};
 
@@ -532,7 +543,8 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	if (!file_exists(sm_gitdir)) {
 		if (safe_create_leading_directories_const(sm_gitdir) < 0)
 			die(_("could not create directory '%s'"), sm_gitdir);
-		if (clone_submodule(path, sm_gitdir, url, depth, &reference, quiet))
+		if (clone_submodule(path, sm_gitdir, url, depth, &reference,
+		    &reference_if_able, quiet))
 			die(_("clone of '%s' into submodule path '%s' failed"),
 			    url, path);
 	} else {
-- 
2.9.2.583.gd6329be.dirty

