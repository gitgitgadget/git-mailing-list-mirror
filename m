Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EB2A1F454
	for <e@80x24.org>; Tue, 16 Oct 2018 17:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbeJQBSe (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 21:18:34 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:38598 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbeJQBSe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 21:18:34 -0400
Received: by mail-io1-f74.google.com with SMTP id n10-v6so11207415iog.5
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 10:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PiYrKYd5JXSEs47f9s92pL0vlW9Cx2/TtVdCiqF1HdE=;
        b=qSBA6n1r5+Ji+m5hxiHZrD+duBrluRvN8dhVIcFs9QBsaJ6tieo8xmkp1h2JPnYVpw
         ivPj2jUxk9frIdr/yI/6B/pCqGmePBSxFseUoj6DOcHbB388Xux2IREcuF58KAslbnO8
         pk873tazCK5L2xxO79cLKbszfwLuveH3gsOMQ5IT9/ATB2nIBMgvKCWjfM8R6KjlF1h8
         yHOnBEopzb/qdYQiF/jm50rWn0IbO29hqNG87HnflY45VNxTiIX5msbTN9co/ywbVOJn
         6MJoi8xq8MhFYTaE8UxF7UltrGsWmoSMGJyROxOOl2/UdfaUAHJWMLb1mSSM2jkgNZ3V
         0T8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PiYrKYd5JXSEs47f9s92pL0vlW9Cx2/TtVdCiqF1HdE=;
        b=onWrbu9Ig3ibnBDL9LzqbWbazbh+wCIeC79N9RhBToVbTGBE0ELDQPLWgHJext9yTx
         CPVeeHxPHKU1Rk4cBtQNjHLVF54AjdLxPsr0qJIBdYZO9sompYfvTpL07vPK5x7+3vjV
         Dt4G/TzBL90BfKkuALiUN+r5APYJuKLoW6+WAclWPqXXgZEzLYfc43GDkymicNnT84Co
         sT+Xv9gL0e0IbM2G0u8tHNQCZ7Y6ckMAYMBVPUdYX8R3VcqaNGTbNswNubEDzOkv9vmY
         ujA40/9JFx8XiTU3z8LmlZw5KAiOq0k5WRTzWb867vnrS7pHlL/khlgYKOxG6rD+teGU
         8y9g==
X-Gm-Message-State: ABuFfois2Jrmi1+gUDjZWkidSGhbXiP+QYLuiZ16lIetQvfOXWpjEY3g
        vmmt10R31fqbgAL2FfZehfnUf6WWtSjE
X-Google-Smtp-Source: ACcGV62JXNP5CuKbpLi4MYhWeQ9+k84+0RzjkuVAT3PlQfdJ1g3dD3G/Oe9DlDPtyslHjpAlK3ZGlyjNXa57
X-Received: by 2002:a05:660c:b0c:: with SMTP id f12mr16535090itk.22.1539710826657;
 Tue, 16 Oct 2018 10:27:06 -0700 (PDT)
Date:   Tue, 16 Oct 2018 10:27:03 -0700
In-Reply-To: <xmqq4ldm1nh6.fsf@gitster-ct.c.googlers.com>
Message-Id: <20181016172703.134901-1-sbeller@google.com>
Mime-Version: 1.0
References: <xmqq4ldm1nh6.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH] submodule helper: convert relative URL to absolute URL if needed
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, jungjw@google.com,
        sbeller@google.com
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

When trying to obtain submodules that are set active this way, we'll
fallback to the URL found in the .gitmodules, which may be relative to the
superproject, but we do not resolve it, yet:

    git clone https://gerrit.googlesource.com/gerrit
    cd gerrit && grep url .gitmodules
	url = ../plugins/codemirror-editor
	...
    git config submodule.active .
    git submodule update
    fatal: repository '../plugins/codemirror-editor' does not exist
    fatal: clone of '../plugins/codemirror-editor' into submodule path '/tmp/gerrit/plugins/codemirror-editor' failed
    Failed to clone 'plugins/codemirror-editor'. Retry scheduled
    [...]
    fatal: clone of '../plugins/codemirror-editor' into submodule path '/tmp/gerrit/plugins/codemirror-editor' failed
    Failed to clone 'plugins/codemirror-editor' a second time, aborting
    [...]

To resolve the issue, factor out the function that resolves the relative
URLs in "git submodule init" (in the submodule helper in the init_submodule
function) and call it at the appropriate place in the update_clone helper.

Reported-by: Jaewoong Jung <jungjw@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 51 ++++++++++++++++++++++++-------------
 t/t7400-submodule-basic.sh  | 24 +++++++++++++++++
 2 files changed, 58 insertions(+), 17 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f6fb8991f3..13c2e4b556 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -584,6 +584,26 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static char *compute_submodule_clone_url(const char *rel_url)
+{
+	char *remoteurl, *relurl;
+	char *remote = get_default_remote();
+	struct strbuf remotesb = STRBUF_INIT;
+
+	strbuf_addf(&remotesb, "remote.%s.url", remote);
+	if (git_config_get_string(remotesb.buf, &remoteurl)) {
+		warning(_("could not look up configuration '%s'. Assuming this repository is its own authoritative upstream."), remotesb.buf);
+		remoteurl = xgetcwd();
+	}
+	relurl = relative_url(remoteurl, rel_url, NULL);
+
+	free(remote);
+	free(remoteurl);
+	strbuf_release(&remotesb);
+
+	return relurl;
+}
+
 struct init_cb {
 	const char *prefix;
 	unsigned int flags;
@@ -634,21 +654,9 @@ static void init_submodule(const char *path, const char *prefix,
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
+			char *oldurl = url;
+			url = compute_submodule_clone_url(oldurl);
+			free(oldurl);
 		}
 
 		if (git_config_set_gently(sb.buf, url))
@@ -1514,6 +1522,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	struct strbuf sb = STRBUF_INIT;
 	const char *displaypath = NULL;
 	int needs_cloning = 0;
+	int need_free_url = 0;
 
 	if (ce_stage(ce)) {
 		if (suc->recursive_prefix)
@@ -1562,8 +1571,14 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "submodule.%s.url", sub->name);
-	if (repo_config_get_string_const(the_repository, sb.buf, &url))
-		url = sub->url;
+	if (repo_config_get_string_const(the_repository, sb.buf, &url)) {
+		if (starts_with_dot_slash(sub->url) ||
+		    starts_with_dot_dot_slash(sub->url)) {
+			url = compute_submodule_clone_url(sub->url);
+			need_free_url = 1;
+		} else
+			url = sub->url;
+	}
 
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/.git", ce->name);
@@ -1608,6 +1623,8 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 cleanup:
 	strbuf_reset(&displaypath_sb);
 	strbuf_reset(&sb);
+	if (need_free_url)
+		free((void*)url);
 
 	return needs_cloning;
 }
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index c0ffc1022a..76a7cb0af7 100755
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
+		# do not pass --init flag, as the submodule is already active:
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

