Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59DEC433E6
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 19:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7786364DB1
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 19:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbhBVT0M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 14:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbhBVTU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 14:20:59 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06802C0617A7
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 11:20:18 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id o9so17449187yba.18
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 11:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=2KDCcKW0fwfWkW20Is9cUgfK+oTUu8kLssxVdaq2Tsg=;
        b=dq53jb7EO4g+qDjUo96wFaQBm7riCwI0o0rOs1h5/ieopMywGnAzgTV4rnDmjdzyhx
         9hdYE0Omi4bQfsLaVT+jFoYKx84G0HKnquN5EryDBOS1DBhwnhmk26eJ0cqnEd4rjo89
         fq/ltqgrhsEwOeBkSwXoLaW81JN9AQH6Fb63SLhIw7sPrqNKeT4T3qcAFgLXWHX4LiBV
         q+e60yMHsNCkWwkclFgGgLJsBJ8laFm/zkUIzoYmlDQEmSJp23eMB9hPhDJ4ioqqJDKP
         UfLaLFDmRFmxdIYASE0tndZrz1MSt4T5cVNV/kWqiH7lcT/5e5RzbVym+FdYxabojReU
         Hp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2KDCcKW0fwfWkW20Is9cUgfK+oTUu8kLssxVdaq2Tsg=;
        b=NRYo8BKdbtAh+yMivf3CE/Sf9+XPgKU53/o+GN4Wz214XwOUPx0rfEF4cQrrjEdnnG
         qVzmJOItTlkLcvtSVp3GA8FEI5h+4mPJij5J89tBh9vj3mJyF/QHu/4+decYQ5G9amjX
         FdLBwfAXDxfvc/krPVOjt7uAiZy3Sn1Vjt1HT+bavj8CBPlfZPH2BbIkTN9iisA5c2uK
         j3NYAFJmj0G0xGfJgR/DBzzamSm/hzo+JfyzSsKqix2hIBW1Y0n8RKU5kyuamydXs6Xx
         I3W0vDa4g6Cmp97lBrL91iBAs82Cx1XvxVvioAeFZ2VeDQkG6DQxTWiV53HRiag3QA8/
         RdZg==
X-Gm-Message-State: AOAM5313BLkqH/HoV5gLZu87i/awh0mwNjOq56DlBjkxWK44+SjH7ABf
        QwguiZrHaMGnfNhJmbOQoyzHJSvm92tipsA/GIyZd6+rbD5fXB7POb6/GxUqEewISUsjzUqFJhN
        DliK5+jg6BH6fSXvJfvTYqwZCxYtOMdS3KL5g0/I0LIoDasdIPzO9qqF3jWu/QW6o2MSjRer4T6
        gf
X-Google-Smtp-Source: ABdhPJz69XeEwed89HTMPiKARt6YJC4yakXjychXBLRjwmTitx1ywd00eiASZ7ftnBkPTaXh8eAU8r+P/aRnFQ6cbEmJ
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:8b8b:: with SMTP id
 j11mr36860148ybl.305.1614021617184; Mon, 22 Feb 2021 11:20:17 -0800 (PST)
Date:   Mon, 22 Feb 2021 11:20:07 -0800
In-Reply-To: <cover.1614021092.git.jonathantanmy@google.com>
Message-Id: <57220ceb841056aade08705ca0ac73ccc69f05ab.1614021093.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20210115234300.350442-1-jonathantanmy@google.com> <cover.1614021092.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH v2 2/4] http-fetch: allow custom index-pack args
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, avarab@gmail.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the next step in teaching fetch-pack to pass its index-pack
arguments when processing packfiles referenced by URIs.

The "--keep" in fetch-pack.c will be replaced with a full message in a
subsequent commit.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-http-fetch.txt | 10 ++++++++--
 fetch-pack.c                     |  3 +++
 http-fetch.c                     | 20 +++++++++++++++-----
 t/t5550-http-fetch-dumb.sh       |  5 ++++-
 4 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.txt
index 4deb4893f5..9fa17b60e4 100644
--- a/Documentation/git-http-fetch.txt
+++ b/Documentation/git-http-fetch.txt
@@ -41,11 +41,17 @@ commit-id::
 		<commit-id>['\t'<filename-as-in--w>]
 
 --packfile=<hash>::
-	Instead of a commit id on the command line (which is not expected in
+	For internal use only. Instead of a commit id on the command
+	line (which is not expected in
 	this case), 'git http-fetch' fetches the packfile directly at the given
 	URL and uses index-pack to generate corresponding .idx and .keep files.
 	The hash is used to determine the name of the temporary file and is
-	arbitrary. The output of index-pack is printed to stdout.
+	arbitrary. The output of index-pack is printed to stdout. Requires
+	--index-pack-args.
+
+--index-pack-args=<args>::
+	For internal use only. The command to run on the contents of the
+	downloaded pack. Arguments are URL-encoded separated by spaces.
 
 --recover::
 	Verify that everything reachable from target is fetched.  Used after
diff --git a/fetch-pack.c b/fetch-pack.c
index 876f90c759..aeac010b0b 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1645,6 +1645,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		strvec_pushf(&cmd.args, "--packfile=%.*s",
 			     (int) the_hash_algo->hexsz,
 			     packfile_uris.items[i].string);
+		strvec_push(&cmd.args, "--index-pack-arg=index-pack");
+		strvec_push(&cmd.args, "--index-pack-arg=--stdin");
+		strvec_push(&cmd.args, "--index-pack-arg=--keep");
 		strvec_push(&cmd.args, uri);
 		cmd.git_cmd = 1;
 		cmd.no_stdin = 1;
diff --git a/http-fetch.c b/http-fetch.c
index 2d1d9d054f..fa642462a9 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -3,6 +3,7 @@
 #include "exec-cmd.h"
 #include "http.h"
 #include "walker.h"
+#include "strvec.h"
 
 static const char http_fetch_usage[] = "git http-fetch "
 "[-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin | --packfile=hash | commit-id] url";
@@ -43,11 +44,9 @@ static int fetch_using_walker(const char *raw_url, int get_verbosely,
 	return rc;
 }
 
-static const char *index_pack_args[] =
-	{"index-pack", "--stdin", "--keep", NULL};
-
 static void fetch_single_packfile(struct object_id *packfile_hash,
-				  const char *url) {
+				  const char *url,
+				  const char **index_pack_args) {
 	struct http_pack_request *preq;
 	struct slot_results results;
 	int ret;
@@ -90,6 +89,7 @@ int cmd_main(int argc, const char **argv)
 	int packfile = 0;
 	int nongit;
 	struct object_id packfile_hash;
+	struct strvec index_pack_args = STRVEC_INIT;
 
 	setup_git_directory_gently(&nongit);
 
@@ -116,6 +116,8 @@ int cmd_main(int argc, const char **argv)
 			packfile = 1;
 			if (parse_oid_hex(p, &packfile_hash, &end) || *end)
 				die(_("argument to --packfile must be a valid hash (got '%s')"), p);
+		} else if (skip_prefix(argv[arg], "--index-pack-arg=", &p)) {
+			strvec_push(&index_pack_args, p);
 		}
 		arg++;
 	}
@@ -128,10 +130,18 @@ int cmd_main(int argc, const char **argv)
 	git_config(git_default_config, NULL);
 
 	if (packfile) {
-		fetch_single_packfile(&packfile_hash, argv[arg]);
+		if (!index_pack_args.nr)
+			die(_("--packfile requires --index-pack-args"));
+
+		fetch_single_packfile(&packfile_hash, argv[arg],
+				      index_pack_args.v);
+
 		return 0;
 	}
 
+	if (index_pack_args.nr)
+		die(_("--index-pack-args can only be used with --packfile"));
+
 	if (commits_on_stdin) {
 		commits = walker_targets_stdin(&commit_id, &write_ref);
 	} else {
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 483578b2d7..358b322e05 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -224,7 +224,10 @@ test_expect_success 'http-fetch --packfile' '
 
 	git init packfileclient &&
 	p=$(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git && ls objects/pack/pack-*.pack) &&
-	git -C packfileclient http-fetch --packfile=$ARBITRARY "$HTTPD_URL"/dumb/repo_pack.git/$p >out &&
+	git -C packfileclient http-fetch --packfile=$ARBITRARY \
+		--index-pack-arg=index-pack --index-pack-arg=--stdin \
+		--index-pack-arg=--keep \
+		"$HTTPD_URL"/dumb/repo_pack.git/$p >out &&
 
 	grep "^keep.[0-9a-f]\{16,\}$" out &&
 	cut -c6- out >packhash &&
-- 
2.30.0.617.g56c4b15f3c-goog

