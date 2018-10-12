Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F0331F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 21:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbeJMF1p (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 01:27:45 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:39260 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbeJMF1p (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Oct 2018 01:27:45 -0400
Received: by mail-oi1-f201.google.com with SMTP id d23-v6so9252384oib.6
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 14:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VlcrZrJru+9UiGoxpOWMLUUxImgOr46z4+xoeFdt3KQ=;
        b=a+pD4SKrdoNkXSSqj0Sk4iuRVJ0QlqACgOqgG+S2OsO4e1LWU8qaulC9Jz4sfHgk0p
         gIVXVuFvrmk9MAyRqH7t2SqEmdjZiQ7lgydsTwhwJvsbtxTRHx7GjE6fND7Y7R7mwddm
         Bgp+Dqq7VXOyJ5Sb+NeKIiq0e2h6ktuTrMpt2dr5eOz+BA1JYJDIgMf9TarvMeckPVD/
         4L7r9UTJSWoQmnxFwRn8skEbFLN+GT0m/B+dJu0Vr9GphrnTzV02yNTFq6mChg/3Ig95
         YSkm0oqRe7HN02pGSfp2XFN6HE96WlGExsqz3cufJ8v4Xa/7yHty1uyaCP8h/IHtz7Tt
         /cKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VlcrZrJru+9UiGoxpOWMLUUxImgOr46z4+xoeFdt3KQ=;
        b=BDHcg8kiRlMOpuikVWet8TO3jx6mRkThbxpeQKGKZPdNAR66o0bTUgpe+0Df2zuAIU
         ZCJRe/NrqknMpBPQ7Je5PwY2j4gAFpMTen1z0I52JkjxBFSRQEJ8RYnLgI3Tb4M2VgkW
         OqRgircQwxwrx8kZF2DlR85dTxiTroNFyzzwIGRE4ezvz5MctztSIdDEUSfohX5hD+ku
         nJO91teu7h1wlR2mLHn1cjU/h7QY3X/des6XFzU2b3aJ9lhE5Y2yTOvFbU3DR+YaaPHf
         x8hFkqTBVH6QrJFOBJ+df87JjFScr68jd99XCRrjxJHxwwsIY9z8qxEwCvcBa+ZmxXrL
         nkGA==
X-Gm-Message-State: ABuFfog1quaQoM27Uf+YX3IJfnUBnZ+B4pclBT2tjTg/zWPgUL/QGriC
        YoaHsFHGcTt8YVd4X/zCkf31nycDol0U88zr0+rBl/Xqe7R1BOaTkuRYCiLrCshT1Rc4nFYUil4
        c0ki7U6OmJ41LKGPv6BXSGWlFpkTLTPC1npyxT0nyyU50w7NAgDaFm6hDW9hd
X-Google-Smtp-Source: ACcGV61vOhnhXxJwihzmNwFI4V52Q+CNRJr6ZCRLQzaf/zU8OXnR1+ZVhK+lnMpAhe2GduiJLESL+g8XqUfE
X-Received: by 2002:aca:4747:: with SMTP id u68-v6mr7026341oia.9.1539381197631;
 Fri, 12 Oct 2018 14:53:17 -0700 (PDT)
Date:   Fri, 12 Oct 2018 14:53:14 -0700
Message-Id: <20181012215314.44266-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0
Subject: [PATCH] submodule helper: convert relative URL to absolute URL if needed
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The submodule helper update_clone called by "git submodule update",
clones submodules if needed. As submodules used to have the URL indicating
if they were active, the step to resolve relative URLs was done in the
"submodule init" step. Nowadays submodules can be configured active without
calling an explicit init, e.g. via configuring submodule.active.

Then we'll fallback to the URL found in the .gitmodules, which may be
relative to the superproject, but we do not resolve it, yet.

To do so, factor out the function that resolves the relative URLs in
"git submodule init" (in the submodule helper in the init_submodule
function) and cal it at the appropriate place in the update_clone helper.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 48 ++++++++++++++++++++++++-------------
 t/t7400-submodule-basic.sh  | 24 +++++++++++++++++++
 2 files changed, 55 insertions(+), 17 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f6fb8991f3..a9a3ac38be 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -584,6 +584,27 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+
+char *compute_submodule_clone_url(const char *rel_url)
+{
+	char *remoteurl, *relurl;
+	char *remote = get_default_remote();
+	struct strbuf remotesb = STRBUF_INIT;
+
+	strbuf_addf(&remotesb, "remote.%s.url", remote);
+	free(remote);
+
+	if (git_config_get_string(remotesb.buf, &remoteurl)) {
+		warning(_("could not lookup configuration '%s'. Assuming this repository is its own authoritative upstream."), remotesb.buf);
+		remoteurl = xgetcwd();
+	}
+	relurl = relative_url(remoteurl, rel_url, NULL);
+	strbuf_release(&remotesb);
+	free(remoteurl);
+
+	return relurl;
+}
+
 struct init_cb {
 	const char *prefix;
 	unsigned int flags;
@@ -634,21 +655,9 @@ static void init_submodule(const char *path, const char *prefix,
 		/* Possibly a url relative to parent */
 		if (starts_with_dot_dot_slash(url) ||
 		    starts_with_dot_slash(url)) {
-			char *remoteurl, *relurl;
-			char *remote = get_default_remote();
-			struct strbuf remotesb = STRBUF_INIT;
-			strbuf_addf(&remotesb, "remote.%s.url", remote);
-			free(remote);
-
-			if (git_config_get_string(remotesb.buf, &remoteurl)) {
-				warning(_("could not lookup configuration '%s'. Assuming this repository is its own authoritative upstream."), remotesb.buf);
-				remoteurl = xgetcwd();
-			}
-			relurl = relative_url(remoteurl, url, NULL);
-			strbuf_release(&remotesb);
-			free(remoteurl);
-			free(url);
-			url = relurl;
+			char *to_free = url;
+			url = compute_submodule_clone_url(url);
+			free(to_free);
 		}
 
 		if (git_config_set_gently(sb.buf, url))
@@ -1562,8 +1571,13 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "submodule.%s.url", sub->name);
-	if (repo_config_get_string_const(the_repository, sb.buf, &url))
-		url = sub->url;
+	if (repo_config_get_string_const(the_repository, sb.buf, &url)) {
+		if (starts_with_dot_slash(sub->url) ||
+		    starts_with_dot_dot_slash(sub->url))
+			url = compute_submodule_clone_url(sub->url);
+		else
+			url = sub->url;
+	}
 
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/.git", ce->name);
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index c0ffc1022a..3f5dd5e4ef 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1224,6 +1224,30 @@ test_expect_success 'submodule update and setting submodule.<name>.active' '
 	test_cmp expect actual
 '
 
+test_expect_success 'clone active submodule without submodule url set' '
+	test_when_finished "rm -rf test/test" &&
+	mkdir test &&
+	# another dir breaks accidental relative paths still being correct
+	git clone file://"$pwd"/multisuper test/test &&
+	(
+		cd test/test &&
+		git config submodule.active "." &&
+
+		# do not pass --init flag, as it is already active:
+		git submodule update &&
+		git submodule status >actual_raw &&
+
+		cut -c 1,43- actual_raw >actual &&
+		cat >expect <<-\EOF &&
+		 sub0 (test2)
+		 sub1 (test2)
+		 sub2 (test2)
+		 sub3 (test2)
+		EOF
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'clone --recurse-submodules with a pathspec works' '
 	test_when_finished "rm -rf multisuper_clone" &&
 	cat >expected <<-\EOF &&
-- 
2.19.0

