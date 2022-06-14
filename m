Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3ABC433EF
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 00:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbiFNAc4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 20:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbiFNAcz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 20:32:55 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC31127FE7
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 17:32:53 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id bo5so7201974pfb.4
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 17:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4nPZDErWMpFDBFYp2dkjh3Rxjt8jDq4D4va7YP0GrB8=;
        b=VraTjF7WQ6Lhg+St85ELh+0AEpBoxfCNTwpkocLbWrWmpD8jj1be2Mb+tNrXV8nkBs
         rmA+5+JSXlPhbf5ly4C3yLE3rUR79/FcuO9jmiL9jrcT5COBM98VriSG/o17mPKtTRGO
         Ijxh8os/f9PEh6QCRcJG5UNtAIPZI3AfU+Ub5S2NJPlvHV8eMZKVRYc7CwGBmz8T34UP
         Edv/3+twm4RGChbY8WlYj+ZihWXW/Eu8su31kbJ1lWU7t3hjJkkaB9/n98Abt2WJgdBm
         aaW3a+q6SiTey+kDgvG8IbALjYBDnJN0qgozoE4nBJPGPswBWFAUUxEz++cWfmLiW/Q+
         On+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4nPZDErWMpFDBFYp2dkjh3Rxjt8jDq4D4va7YP0GrB8=;
        b=6pglsv6lAChHxCD84P1yk/sa1Sr5/NyH2zlIy5NmrhZCBLHoXFBaMugAo3M7Z/BtbK
         Hp0JbUn3HPPhp0p+fTQyPDtseAIY8Yb8EN/gcLbkrvr7QmcOBFX5YVJZfXxLUgziZBVf
         +TCLaZLLIrH/wFEkjhavYWK3m3zr0tF8qQO/+3QRKLulIrRjO19B7oEesbziN+hiLkAy
         kVLJb5bkuCd+yQxhae045oTO1Rg79jHhispqzk6uLKTAKzrXLisFg4a2JlfoIIJ1wNXx
         gkAn9GNyZb356+T5p3P3LsDnsWDMFppH9QRjIUneJtXAZi2HW3G3TJmgSWQ+cEPbiqpO
         KPfw==
X-Gm-Message-State: AOAM532BRC7P/D8JoS/7B/AX7spH1ejg7c0E8+kZbTi/6E535o10+RtT
        GoSAjqaw0fi600TpPY86RzZ8XBW3ACE=
X-Google-Smtp-Source: ABdhPJwqsxMQqwj9D87kYNn3NRhp/36mQgT8ztjkIYCQ4xW4j8OW5BK6b5FG1U9Lf4CvIO9Mfo506w==
X-Received: by 2002:a65:4c44:0:b0:39c:e0b5:cd2a with SMTP id l4-20020a654c44000000b0039ce0b5cd2amr1956402pgr.481.1655166773004;
        Mon, 13 Jun 2022 17:32:53 -0700 (PDT)
Received: from JEKELLER-HOME.localdomain ([50.39.231.65])
        by smtp.gmail.com with ESMTPSA id ji22-20020a170903325600b0016403cae7desm5689229plb.276.2022.06.13.17.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 17:32:52 -0700 (PDT)
From:   Jacob Keller <jacob.keller@gmail.com>
X-Google-Original-From: Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Pavel Rappo <pavel.rappo@gmail.com>
Subject: [PATCH] remote: handle negative refspecs in git remote show
Date:   Mon, 13 Jun 2022 17:32:51 -0700
Message-Id: <20220614003251.16765-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By default, the git remote show command will query data from remotes to
show data about what might be done on a future git fetch. This process
currently does not handle negative refspecs. This can be confusing,
because the show command will list refs as if they would be fetched. For
example if the fetch refspec "^refs/heads/pr/*", it still displays the
following:

  * remote jdk19
    Fetch URL: git@github.com:openjdk/jdk19.git
    Push  URL: git@github.com:openjdk/jdk19.git
    HEAD branch: master
    Remote branches:
      master tracked
      pr/1   new (next fetch will store in remotes/jdk19)
      pr/2   new (next fetch will store in remotes/jdk19)
      pr/3   new (next fetch will store in remotes/jdk19)
    Local ref configured for 'git push':
      master pushes to master (fast-forwardable)

Fix this by checking negative refspecs inside of get_ref_states. For
each ref which matches a negative refspec, copy it into a "skipped" list
and remove it from the fetch map. This allows us to show the following
output instead:

  * remote jdk19
    Fetch URL: git@github.com:openjdk/jdk19.git
    Push  URL: git@github.com:openjdk/jdk19.git
    HEAD branch: master
    Remote branches:
      master tracked
      pr/1   skipped
      pr/2   skipped
      pr/3   skipped
    Local ref configured for 'git push':
      master pushes to master (fast-forwardable)

By showing the refs as skipped, it helps clarify that these references
won't actually be fetched. Alternatively, we could simply remove them
entirely.

Add a new test case to cover this functionality.

Reported-by: Pavel Rappo <pavel.rappo@gmail.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 builtin/remote.c  | 28 ++++++++++++++++++++++++++--
 remote.c          |  2 +-
 remote.h          |  6 ++++++
 t/t5505-remote.sh | 27 +++++++++++++++++++++++++++
 4 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index d4b69fe77898..243e60e19bdb 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -344,12 +344,13 @@ static void read_branches(void)
 
 struct ref_states {
 	struct remote *remote;
-	struct string_list new_refs, stale, tracked, heads, push;
+	struct string_list new_refs, skipped, stale, tracked, heads, push;
 	int queried;
 };
 
 #define REF_STATES_INIT { \
 	.new_refs = STRING_LIST_INIT_DUP, \
+	.skipped = STRING_LIST_INIT_DUP, \
 	.stale = STRING_LIST_INIT_DUP, \
 	.tracked = STRING_LIST_INIT_DUP, \
 	.heads = STRING_LIST_INIT_DUP, \
@@ -367,6 +368,24 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 			die(_("Could not get fetch map for refspec %s"),
 				states->remote->fetch.raw[i]);
 
+	/* handle negative refspecs first */
+	for (tail = &fetch_map; *tail; ) {
+		ref = *tail;
+
+		if (omit_name_by_refspec(ref->name, &states->remote->fetch)) {
+			string_list_append(&states->skipped, abbrev_branch(ref->name));
+
+			/* Matched a negative refspec, so remove this ref from
+			 * consideration for being a new or tracked ref.
+			 */
+			*tail = ref->next;
+			free(ref->peer_ref);
+			free(ref);
+		} else {
+			tail = &ref->next;
+		}
+	}
+
 	for (ref = fetch_map; ref; ref = ref->next) {
 		if (!ref->peer_ref || !ref_exists(ref->peer_ref->name))
 			string_list_append(&states->new_refs, abbrev_branch(ref->name));
@@ -383,6 +402,7 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 	free_refs(fetch_map);
 
 	string_list_sort(&states->new_refs);
+	string_list_sort(&states->skipped);
 	string_list_sort(&states->tracked);
 	string_list_sort(&states->stale);
 
@@ -941,6 +961,7 @@ static void clear_push_info(void *util, const char *string)
 static void free_remote_ref_states(struct ref_states *states)
 {
 	string_list_clear(&states->new_refs, 0);
+	string_list_clear(&states->skipped, 0);
 	string_list_clear(&states->stale, 1);
 	string_list_clear(&states->tracked, 0);
 	string_list_clear(&states->heads, 0);
@@ -1033,7 +1054,9 @@ static int show_remote_info_item(struct string_list_item *item, void *cb_data)
 		if (string_list_has_string(&states->new_refs, name)) {
 			fmt = _(" new (next fetch will store in remotes/%s)");
 			arg = states->remote->name;
-		} else if (string_list_has_string(&states->tracked, name))
+		} else if (string_list_has_string(&states->skipped, name))
+			arg = _(" skipped");
+		else if (string_list_has_string(&states->tracked, name))
 			arg = _(" tracked");
 		else if (string_list_has_string(&states->stale, name))
 			arg = _(" stale (use 'git remote prune' to remove)");
@@ -1308,6 +1331,7 @@ static int show(int argc, const char **argv)
 		/* remote branch info */
 		info.width = 0;
 		for_each_string_list(&info.states.new_refs, add_remote_to_show_info, &info);
+		for_each_string_list(&info.states.skipped, add_remote_to_show_info, &info);
 		for_each_string_list(&info.states.tracked, add_remote_to_show_info, &info);
 		for_each_string_list(&info.states.stale, add_remote_to_show_info, &info);
 		if (info.list.nr)
diff --git a/remote.c b/remote.c
index 404e1e0a0ddb..7d68b5632bb5 100644
--- a/remote.c
+++ b/remote.c
@@ -804,7 +804,7 @@ static int refspec_match(const struct refspec_item *refspec,
 	return !strcmp(refspec->src, name);
 }
 
-static int omit_name_by_refspec(const char *name, struct refspec *rs)
+int omit_name_by_refspec(const char *name, struct refspec *rs)
 {
 	int i;
 
diff --git a/remote.h b/remote.h
index dd4402436f1f..448675e11259 100644
--- a/remote.h
+++ b/remote.h
@@ -247,6 +247,12 @@ int resolve_remote_symref(struct ref *ref, struct ref *list);
  */
 struct ref *ref_remove_duplicates(struct ref *ref_map);
 
+/*
+ * Check whether a name matches any negative refspec in rs. Returns 1 if the
+ * name matches at least one negative refspec, and 0 otherwise.
+ */
+int omit_name_by_refspec(const char *name, struct refspec *rs);
+
 /*
  * Remove all entries in the input list which match any negative refspec in
  * the refspec list.
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index fff14e13ed43..e19b8d666c73 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -302,6 +302,33 @@ test_expect_success 'show' '
 	)
 '
 
+cat >test/expect <<EOF
+* remote origin
+  Fetch URL: $(pwd)/one
+  Push  URL: $(pwd)/one
+  HEAD branch: main
+  Remote branches:
+    main     skipped
+    side     tracked
+    upstream stale (use 'git remote prune' to remove)
+  Local branches configured for 'git pull':
+    ahead merges with remote main
+    main  merges with remote main
+  Local refs configured for 'git push':
+    main pushes to main     (local out of date)
+    main pushes to upstream (create)
+EOF
+
+test_expect_success 'show with negative refspecs' '
+	test_when_finished "git -C test config --fixed-value --unset remote.origin.fetch ^refs/heads/main" &&
+	(
+		cd test &&
+		git config --add remote.origin.fetch ^refs/heads/main &&
+		git remote show origin >output &&
+		test_cmp expect output
+	)
+'
+
 cat >test/expect <<EOF
 * remote origin
   Fetch URL: $(pwd)/one
-- 
2.36.1

