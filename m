Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAFF21F609
	for <e@80x24.org>; Thu, 29 Nov 2018 00:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbeK2Lbk (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 06:31:40 -0500
Received: from mail-yw1-f74.google.com ([209.85.161.74]:35355 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbeK2Lbk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 06:31:40 -0500
Received: by mail-yw1-f74.google.com with SMTP id d73so180495ywd.2
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 16:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=faUM1Nfot+zZxoWKIsgc+p5XMPnc5lROOZW+XfMYYhU=;
        b=VrIX23SvyxvNweoVtK9H9oEOYGHhoWRYAj1FXNjaSGu7vOQKLVGz3v2qwQOB5tzHy6
         x4n70mIHNpd4tvhuWyGe2ckP+m5t8iwGdiGfC06B/CZcXqGDYzGiHTN9Lf1XP+x5pP59
         QqKRxQ1MYgSJx2c4GVgjIAz3OLnu3ol43Xn99QB7Arp432jQOk1qQhJS7hFTuIRhPH91
         7Z8L3OZJNKvagRgLSf0ShPr3DOzqaEhBaZ0fPrZ4gXGgS907uMI33GZmJD5G+3GgnEy0
         OtH3sUZzqw51Zc1K3F9AeSl2ma5XpfWn7gF6EV0SeqzYe4kAYxjxvEOS0eWrufZJt7pP
         DGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=faUM1Nfot+zZxoWKIsgc+p5XMPnc5lROOZW+XfMYYhU=;
        b=SjbznrFjrMTb+AnN+P+9frsuvEmwQTNTROGGS4r3PkMak37hCyfHGqngW6Obl3dRkY
         0Nk9JSkIXG0HxBPLgra5yUP/390SJeeTW8Rhj3QP82NuoS9W/JQLZmP7GCJEMIN5SA4t
         G1LbRE2kjbZHksYChjGnHxdj+VGUCJb0mYLesdmbsgKdJzlbRBjSlBheYpEwexbVXi6l
         TYQ3iDB1ICk6kBPd6dGEkg2UutKFb/9e0kJOHR5HFzkr/pt0EQmRC8dGEGtIspawX5WX
         uvGkkPdClZBtlsXlFU+X9SNazCHXNXmOmvgAnYJm9JnVEhhrR1BNHUNfoC4OMiVMd0ck
         8fDw==
X-Gm-Message-State: AA+aEWZr3wt78qLNKovljdzEYUUH9kCRa/N8iF/SUsnyvX7hRKdKQlwK
        mUmtUSiM9Z0hKSZ6LB+B9SSH1fwCYWH1pNP5hhe02F1OKNwCd+7T4V26NkFWtVeQrkCvLjJ/Vx+
        8RjOZtf02u3q0rBJeajl6EXp9hff8UL0r2eYXpikLlMIAUU/mRkFI984B/QH8
X-Google-Smtp-Source: AFSGD/Uo1xdwbqsETq9ctHYAWqEo/xFdcQhTOiKHA0Udd/QgelLHFDPIInSlgdLlGKtCsopCvHRLEKTLqQc2
X-Received: by 2002:a25:4292:: with SMTP id p140-v6mr3510514yba.98.1543451292574;
 Wed, 28 Nov 2018 16:28:12 -0800 (PST)
Date:   Wed, 28 Nov 2018 16:27:52 -0800
In-Reply-To: <20181129002756.167615-1-sbeller@google.com>
Message-Id: <20181129002756.167615-6-sbeller@google.com>
Mime-Version: 1.0
References: <20181129002756.167615-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
Subject: [PATCH 5/9] submodule: store OIDs in changed_submodule_names
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'calculate_changed_submodule_paths' uses a local list to compute the
changed submodules, and then produces the result by copying appropriate
items into the result list.

Instead use the result list directly and prune items afterwards
using string_list_remove_empty_items.

By doing so we'll have access to the util pointer for longer that
contains the commits that we need to fetch, which will be
useful in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
---
 submodule.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/submodule.c b/submodule.c
index f93f0aff82..0c81aca6f2 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1139,8 +1139,7 @@ static void calculate_changed_submodule_paths(struct repository *r,
 		struct string_list *changed_submodule_names)
 {
 	struct argv_array argv = ARGV_ARRAY_INIT;
-	struct string_list changed_submodules = STRING_LIST_INIT_DUP;
-	const struct string_list_item *name;
+	struct string_list_item *name;
 
 	/* No need to check if there are no submodules configured */
 	if (!submodule_from_path(r, NULL, NULL))
@@ -1157,9 +1156,9 @@ static void calculate_changed_submodule_paths(struct repository *r,
 	 * Collect all submodules (whether checked out or not) for which new
 	 * commits have been recorded upstream in "changed_submodule_names".
 	 */
-	collect_changed_submodules(r, &changed_submodules, &argv);
+	collect_changed_submodules(r, changed_submodule_names, &argv);
 
-	for_each_string_list_item(name, &changed_submodules) {
+	for_each_string_list_item(name, changed_submodule_names) {
 		struct oid_array *commits = name->util;
 		const struct submodule *submodule;
 		const char *path = NULL;
@@ -1173,12 +1172,14 @@ static void calculate_changed_submodule_paths(struct repository *r,
 		if (!path)
 			continue;
 
-		if (!submodule_has_commits(r, path, commits))
-			string_list_append(changed_submodule_names,
-					   name->string);
+		if (submodule_has_commits(r, path, commits)) {
+			oid_array_clear(commits);
+			*name->string = '\0';
+		}
 	}
 
-	free_submodules_oids(&changed_submodules);
+	string_list_remove_empty_items(changed_submodule_names, 1);
+
 	argv_array_clear(&argv);
 	oid_array_clear(&ref_tips_before_fetch);
 	oid_array_clear(&ref_tips_after_fetch);
@@ -1389,7 +1390,7 @@ int fetch_populated_submodules(struct repository *r,
 
 	argv_array_clear(&spf.args);
 out:
-	string_list_clear(&spf.changed_submodule_names, 1);
+	free_submodules_oids(&spf.changed_submodule_names);
 	return spf.result;
 }
 
-- 
2.20.0.rc1.387.gf8505762e3-goog

