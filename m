Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFF0120A93
	for <e@80x24.org>; Tue, 10 Jan 2017 01:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161969AbdAJBqF (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 20:46:05 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36291 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032480AbdAJBp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 20:45:57 -0500
Received: by mail-pf0-f170.google.com with SMTP id 189so24727615pfu.3
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 17:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dQEIldRUmr8julfTnl1lkSYTZ92gPlKzRtc9sicVIQ0=;
        b=cOcN6jtC/KWOgmyp2lxijiAKZlDjpMEdeQROcR8T6m5UfyG4V4B2dcw9QR0HBLfT0/
         SrqexKWo5IBRE54BOU5hGM4rWFjR9lxatdnrJMaU8dLrhViwqyQmkPWwFJnUwhZEZ9nW
         HjeRFNNlvl49XyUO+mFlyQz0Tf828WDWjCdyRwQV+9HP+QmHc4pFDMZmy5fArNDYRgeW
         lLXSek12LM9nJxY99OBOijkCtJTcRtCoyd5gRv+NgGH9XDida/yf4KEGpoJknBo9o++J
         +Md+nKrVDUhEqYlrsp5yUx9yG0oZpw7HUPAB6k56KqOAE/wxzafVgyoR2Gki5aAzcNgk
         ze2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dQEIldRUmr8julfTnl1lkSYTZ92gPlKzRtc9sicVIQ0=;
        b=V4stFIdUtDHPvW+gjyfGr3i9jCMLYafrtqwMaD+JwxUO8wVaBkfQ0PusJghoyQO9Vq
         zccPB4Vp5jwuEKLJOfmkI8O2Kfkkx9AH5xCpbxntRvu5ZqJISV4xRH/89WfzlQf1o6fo
         DsjY604Vzg5JpnUJ1NuGm5GH1CjmDSi55A8KNULt+63O+1WgFE0yk+AKeiteWDaHC26M
         Oq8EnrYkCfkgAEzyk/H2BZOhqQxaN1WjIfC/XiW5ZgRNfKREoDDg3vkNgkCydrxC2Fy2
         G1nn9Ou3gM4/Fp2FvgWGrzZg7SWOb/iVkiLFInvPS1LSKLwn0pDvYXPId0BC9Z3S/kXb
         7/nQ==
X-Gm-Message-State: AIkVDXLkci+10cu+SO9XIWY47dUwBrQ+NiXsj/ON0j2f+c/fD+rEYeUADHrfbcbJXzFtQlQb
X-Received: by 10.99.125.65 with SMTP id m1mr870592pgn.159.1484012756716;
        Mon, 09 Jan 2017 17:45:56 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:1e2:be00:4066:92e5])
        by smtp.gmail.com with ESMTPSA id y23sm373391pfi.66.2017.01.09.17.45.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Jan 2017 17:45:56 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, novalis@novalis.org
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/4] unpack-trees: support super-prefix option
Date:   Mon,  9 Jan 2017 17:45:42 -0800
Message-Id: <20170110014542.19352-5-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.30.g7c4be45.dirty
In-Reply-To: <20170110014542.19352-1-sbeller@google.com>
References: <20170110014542.19352-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add support for the super-prefix option for commands that unpack trees.
For testing purposes enable it in read-tree, which has no other path
related output.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git.c                       |  2 +-
 t/t1001-read-tree-m-2way.sh |  9 +++++++++
 unpack-trees.c              | 39 ++++++++++++++++++++++++++++++++++++---
 3 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/git.c b/git.c
index dce529fcbf..acbabd1298 100644
--- a/git.c
+++ b/git.c
@@ -471,7 +471,7 @@ static struct cmd_struct commands[] = {
 	{ "prune-packed", cmd_prune_packed, RUN_SETUP },
 	{ "pull", cmd_pull, RUN_SETUP | NEED_WORK_TREE },
 	{ "push", cmd_push, RUN_SETUP },
-	{ "read-tree", cmd_read_tree, RUN_SETUP },
+	{ "read-tree", cmd_read_tree, RUN_SETUP | SUPPORT_SUPER_PREFIX},
 	{ "receive-pack", cmd_receive_pack },
 	{ "reflog", cmd_reflog, RUN_SETUP },
 	{ "remote", cmd_remote, RUN_SETUP },
diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
index 7b70089705..014ba39420 100755
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -363,6 +363,15 @@ test_expect_success 'a/b (untracked) vs a, plus c/d case test.' '
 	test -f a/b
 '
 
+cat <<-EOF >expect &&
+	error: Updating 'fictional/a' would lose untracked files in it
+EOF
+
+test_expect_success 'read-tree supports the super-prefix' '
+	test_must_fail git --super-prefix fictional/ read-tree -u -m "$treeH" "$treeM" 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'a/b vs a, plus c/d case setup.' '
 	rm -f .git/index &&
 	rm -fr a &&
diff --git a/unpack-trees.c b/unpack-trees.c
index 7a6df99d10..bc56195e27 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -52,6 +52,37 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
 	  ? ((o)->msgs[(type)])      \
 	  : (unpack_plumbing_errors[(type)]) )
 
+static const char *super_prefixed(const char *path)
+{
+	/*
+	 * This is used for the error messages above.
+	 * We need to have exactly two buffer spaces.
+	 */
+	static struct strbuf buf[2] = {STRBUF_INIT, STRBUF_INIT};
+	static int super_prefix_len = -1;
+	static unsigned idx = 0;
+
+	if (!get_super_prefix())
+		return path;
+
+	if (super_prefix_len < 0) {
+		int i;
+
+		for (i = 0; i < ARRAY_SIZE(buf); i++)
+			strbuf_addstr(&buf[i], get_super_prefix());
+
+		super_prefix_len = strlen(get_super_prefix());
+	}
+
+	if (++idx >= ARRAY_SIZE(buf))
+		idx = 0;
+
+	strbuf_setlen(&buf[idx], super_prefix_len);
+	strbuf_addstr(&buf[idx], path);
+
+	return buf[idx].buf;
+}
+
 void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 				  const char *cmd)
 {
@@ -172,7 +203,7 @@ static int add_rejected_path(struct unpack_trees_options *o,
 			     const char *path)
 {
 	if (!o->show_all_errors)
-		return error(ERRORMSG(o, e), path);
+		return error(ERRORMSG(o, e), super_prefixed(path));
 
 	/*
 	 * Otherwise, insert in a list for future display by
@@ -196,7 +227,7 @@ static void display_error_msgs(struct unpack_trees_options *o)
 			something_displayed = 1;
 			for (i = 0; i < rejects->nr; i++)
 				strbuf_addf(&path, "\t%s\n", rejects->items[i].string);
-			error(ERRORMSG(o, e), path.buf);
+			error(ERRORMSG(o, e), super_prefixed(path.buf));
 			strbuf_release(&path);
 		}
 		string_list_clear(rejects, 0);
@@ -1918,7 +1949,9 @@ int bind_merge(const struct cache_entry * const *src,
 			     o->merge_size);
 	if (a && old)
 		return o->gently ? -1 :
-			error(ERRORMSG(o, ERROR_BIND_OVERLAP), a->name, old->name);
+			error(ERRORMSG(o, ERROR_BIND_OVERLAP),
+			      super_prefixed(a->name),
+			      super_prefixed(old->name));
 	if (!a)
 		return keep_entry(old, o);
 	else
-- 
2.11.0.rc2.30.g7c4be45.dirty

