Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F04801F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 19:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732399AbeGLT7O (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 15:59:14 -0400
Received: from mail-yb0-f202.google.com ([209.85.213.202]:51125 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732373AbeGLT7O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 15:59:14 -0400
Received: by mail-yb0-f202.google.com with SMTP id x13-v6so26780317ybl.17
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 12:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=NG7ID0myn141RVkG4i89dUF6diIO4kdcmAfRcFzNp0A=;
        b=GBTuCBjm9hkQdzpJla+9F8FXl+Pj5MDhoXYRTPbF0WFAs15m3fjrt/7VtL7otNkcfL
         dN5HqhMuLYseS+p3mmDE6LcWqTaqxrRJeH/9SfIZN/Pk1U3MkbaBjuJ+nqNUqkoIAhhQ
         70vMTCPjjAn1OuT5qh9BbwVSDiOfcwY6L0Wfka7F1jdcluZFpc/e8XYmNWQKpq8G3/Vj
         uuxpyUDYyGkxkqj5SCawgmSppCFzq8tKmIPGtPMRd0w/7snZyAqSA34TFsyx8OCBlHk9
         8LeEg51Gl5Ql97eFswupiBAzh747X16hxnu2xeBKir45j4baXhwtLuw0FMwzRXvlBz73
         f2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=NG7ID0myn141RVkG4i89dUF6diIO4kdcmAfRcFzNp0A=;
        b=oofaDBnAqQ4URk5pMYWBz8pvconbcL85Fc22xylRveiG+ubfA2F4yHXOhIrUWHSXHa
         bsN3Ji2OGFsqgbGgzdknOnTjKYf4gVCC1pAIgS0IO5dFw/1qrQ9I4bnaqmDvLChBiNxV
         2ALB14JexN8Ny7scI6hWDRcCF/embo/eA+INpAUmZAgGv4AjlTGtuLVDH7CDLlpvbtYf
         FHrYMfLMVIM82hQFjcPwGOMYyEfjJ2IRxPW3AaV1WW5WNDIb42b/28D57NkWLGs7KKS3
         ilQJPpADSuXUUaiufX/3B8cQTjPN90lFpuB4mrCt6t/HH6gKqHgeMyA7Y6Djm10hTZKD
         F/UQ==
X-Gm-Message-State: AOUpUlEeUXqQQSAiuSuSyqUZxDBNjPFDO2aemoGA1La3lnc9MEXXWxGY
        kdtR9WqtGvv+B/wxWLdZcubf3U4TD4uvQQn/YVFQr1zSMTgb5GvQJLgaw07XNVbBrFpoZOv/3WK
        NgvP8noObk+pL1qtv7zinPjdPijwSEk9Y0g3Lr8tWxGPSGwu97xAZbz1yOoad
X-Google-Smtp-Source: AAOMgpe7/2bsoqZm1/n0kIPNXDPOJ+6YeR540oD0T3Gm50IBq4mADGeTKWtVwuXrEnTQ/mE0GHeTfJFoo0Um
MIME-Version: 1.0
X-Received: by 2002:a81:3788:: with SMTP id e130-v6mr1170435ywa.172.1531424891950;
 Thu, 12 Jul 2018 12:48:11 -0700 (PDT)
Date:   Thu, 12 Jul 2018 12:47:54 -0700
In-Reply-To: <20180712194754.71979-1-sbeller@google.com>
Message-Id: <20180712194754.71979-7-sbeller@google.com>
References: <20180712194754.71979-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH 6/6] submodule--helper: introduce new update-module-mode helper
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This chews off a bit of the shell part of the update command in
git-submodule.sh. When writing the C code, keep in mind that the
submodule--helper part will go away eventually and we want to have
a C function that is able to determine the submodule update strategy,
it as a nicety, make determine_submodule_update_strategy accessible
for arbitrary repositories.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 61 +++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 16 +---------
 2 files changed, 62 insertions(+), 15 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4bbf580df79..e53231cf286 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1444,6 +1444,66 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static void determine_submodule_update_strategy(struct repository *r,
+						int just_cloned,
+						const char *path,
+						const char *update,
+						struct submodule_update_strategy *out)
+{
+	const struct submodule *sub = submodule_from_path(r, &null_oid, path);
+	char *key;
+	const char *val;
+
+	key = xstrfmt("submodule.%s.update", sub->name);
+
+	if (update) {
+		trace_printf("parsing update");
+		if (parse_submodule_update_strategy(update, out) < 0)
+			die(_("Invalid update mode '%s' for submodule path '%s'"),
+				update, path);
+	} else if (!repo_config_get_string_const(r, key, &val)) {
+		if (parse_submodule_update_strategy(val, out) < 0)
+			die(_("Invalid update mode '%s' configured for submodule path '%s'"),
+				val, path);
+	} else if (sub->update_strategy.type != SM_UPDATE_UNSPECIFIED) {
+		trace_printf("loaded thing");
+		out->type = sub->update_strategy.type;
+		out->command = sub->update_strategy.command;
+	} else
+		out->type = SM_UPDATE_CHECKOUT;
+
+	if (just_cloned &&
+	    (out->type == SM_UPDATE_MERGE ||
+	     out->type == SM_UPDATE_REBASE ||
+	     out->type == SM_UPDATE_NONE))
+		out->type = SM_UPDATE_CHECKOUT;
+
+	free(key);
+}
+
+static int module_update_module_mode(int argc, const char **argv, const char *prefix)
+{
+	const char *path, *update = NULL;
+	int just_cloned;
+	struct submodule_update_strategy update_strategy = { .type = SM_UPDATE_CHECKOUT };
+
+	if (argc < 3 || argc > 4)
+		die("submodule--helper update-module-clone expects <just-cloned> <path> [<update>]");
+
+	just_cloned = git_config_int("just_cloned", argv[1]);
+	path = argv[2];
+
+	if (argc == 4)
+		update = argv[3];
+
+	determine_submodule_update_strategy(the_repository,
+					    just_cloned, path, update,
+					    &update_strategy);
+	fprintf(stdout, submodule_strategy_to_string(&update_strategy));
+
+	return 0;
+}
+
 struct submodule_update_clone_information {
 	const struct submodule *sub;
 	struct object_id oid;
@@ -2039,6 +2099,7 @@ static struct cmd_struct commands[] = {
 	{"list", module_list, 0},
 	{"name", module_name, 0},
 	{"clone", module_clone, 0},
+	{"update-module-mode", module_update_module_mode, 0},
 	{"update-clone", update_clone, 0},
 	{"relative-path", resolve_relative_path, 0},
 	{"resolve-relative-url", resolve_relative_url, 0},
diff --git a/git-submodule.sh b/git-submodule.sh
index 56588aa304d..215760898ce 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -535,27 +535,13 @@ cmd_update()
 	do
 		die_if_unmatched "$quickabort" "$sha1"
 
-		name=$(git submodule--helper name "$sm_path") || exit
-		if ! test -z "$update"
-		then
-			update_module=$update
-		else
-			update_module=$(git config submodule."$name".update)
-			if test -z "$update_module"
-			then
-				update_module="checkout"
-			fi
-		fi
+		update_module=$(git submodule--helper update-module-mode $just_cloned "$sm_path" $update)
 
 		displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
 
 		if test $just_cloned -eq 1
 		then
 			subsha1=
-			case "$update_module" in
-			merge | rebase | none)
-				update_module=checkout ;;
-			esac
 		else
 			subsha1=$(sanitize_submodule_env; cd "$sm_path" &&
 				git rev-parse --verify HEAD) ||
-- 
2.18.0.203.gfac676dfb9-goog

