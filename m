Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72681C433E9
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 02:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 403B422B51
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 02:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbhAXCfX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 21:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbhAXCfT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 21:35:19 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B94C061788
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 18:34:39 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 26so5841980pgl.2
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 18:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=RPJ3i+iJP0I/CGazHQ7sdb+EtTxh6LvmX8o5+0li5/E=;
        b=dChiFjrL8K0dZTHJCu4IO5ftiqLTp8XoTCdd2eaozvIdYP+OlHSpqpXbRFsMauqhVE
         KIgELECB60bumhJ2dqxAsq9+8bwt1/iGG/TuIKzlqIRzDw5uSi+pLlJp4KNH/8krgKZh
         /FgplscftupNPksTytujXImw17CSKdbY/zGywznZqKqtSFOd2YeDt8bmjdOwixLNLfLv
         oFE6Exkqj3BGBWE1SWlXMSxKno9UPUEHKOgp9lNc8jmqfBBQxwXEthaTpQ1yh7hSUli5
         5tOdq9z7AVXImN5gT8OnwNOg9wBxgDAckOoK0wCESsW6jZyiUDGoInla8Wb+VsnVpl8W
         Iubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RPJ3i+iJP0I/CGazHQ7sdb+EtTxh6LvmX8o5+0li5/E=;
        b=sS0YeERrWAgjmUVFz7OGjz3m9bE6D4UA8ojeAOs9Q4YdFMLnu6D8MxlKiJy/eVjrPI
         40My69Ftbj3yg77+AjsMUhU4yk8/9A6quFd87wviV/rIengn4uO7aRRRu55iNZyRy9Q9
         clpMAbLk5APZ1w4cRuvX30v8u0qJaa5jGhF0uAcKlHgAtmDKvIMvt670E6b5VdDrpocu
         Imh6zHXjd2nqvRBwQQrUK/66LEPw/wqslHyV1CyENawDWznYoU+t1X7k5Hb/s7cAULfn
         RKuyLIFIjrdIA8MjzS6zMpTgYDjhck0deeoeveSHeFOoXI4fyv3RJQz+PCP32TqkvzkJ
         KYqQ==
X-Gm-Message-State: AOAM533ETQVSVNI0KNgy9P/RExT0rWwyzi97kpag7tobewosVeRamFkH
        rTjJWAffyr3ZZkM6kx/X/D3hjQEPufhJLFTeakdNAx8FGnxSoiyj9RWiuc3CDsYiw1uYcR7RBQD
        T44m4nbl6ndNXPCuOArjc02rvjHDcBPslnCAsEY+c/IOl28kuosOnq09rxbkZAYkpHowNHfBBam
        u6
X-Google-Smtp-Source: ABdhPJxj48OgDVgMX/ytCcJDQMMlQQG7L2j4udnrMiexpnaS6yEpN10oLbCHjGn6XjMEwOpU4DVHY667WEJ1/ClVsUaM
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:cd49:0:b029:1b5:4e48:6f1a with
 SMTP id o70-20020a62cd490000b02901b54e486f1amr5461011pfg.14.1611455678370;
 Sat, 23 Jan 2021 18:34:38 -0800 (PST)
Date:   Sat, 23 Jan 2021 18:34:28 -0800
In-Reply-To: <cover.1611455251.git.jonathantanmy@google.com>
Message-Id: <3032117ee747e72f6208eab7f960737d25f8a82a.1611455251.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20210115234300.350442-1-jonathantanmy@google.com> <cover.1611455251.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH 2/4] http-fetch: allow custom index-pack args
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the next step in teaching fetch-pack to pass its index-pack
arguments when processing packfiles referenced by URIs.

The "--keep" in fetch-pack.c will be replaced with a full message in a
subsequent commit.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/git-http-fetch.txt |  9 ++++++--
 fetch-pack.c                     |  1 +
 http-fetch.c                     | 35 +++++++++++++++++++++++++++-----
 t/t5550-http-fetch-dumb.sh       |  3 ++-
 4 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.txt
index 4deb4893f5..aa171088e8 100644
--- a/Documentation/git-http-fetch.txt
+++ b/Documentation/git-http-fetch.txt
@@ -41,11 +41,16 @@ commit-id::
 		<commit-id>['\t'<filename-as-in--w>]
 
 --packfile=<hash>::
-	Instead of a commit id on the command line (which is not expected in
+	For internal use only. Instead of a commit id on the command line (which is not expected in
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
index 876f90c759..274ae602f7 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1645,6 +1645,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		strvec_pushf(&cmd.args, "--packfile=%.*s",
 			     (int) the_hash_algo->hexsz,
 			     packfile_uris.items[i].string);
+		strvec_push(&cmd.args, "--index-pack-args=index-pack --stdin --keep");
 		strvec_push(&cmd.args, uri);
 		cmd.git_cmd = 1;
 		cmd.no_stdin = 1;
diff --git a/http-fetch.c b/http-fetch.c
index 2d1d9d054f..12feb84e71 100644
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
+	const char *index_pack_args = NULL;
 
 	setup_git_directory_gently(&nongit);
 
@@ -116,6 +116,8 @@ int cmd_main(int argc, const char **argv)
 			packfile = 1;
 			if (parse_oid_hex(p, &packfile_hash, &end) || *end)
 				die(_("argument to --packfile must be a valid hash (got '%s')"), p);
+		} else if (skip_prefix(argv[arg], "--index-pack-args=", &p)) {
+			index_pack_args = p;
 		}
 		arg++;
 	}
@@ -128,10 +130,33 @@ int cmd_main(int argc, const char **argv)
 	git_config(git_default_config, NULL);
 
 	if (packfile) {
-		fetch_single_packfile(&packfile_hash, argv[arg]);
+		struct strvec encoded = STRVEC_INIT;
+		char **raw;
+		int i;
+
+		if (!index_pack_args)
+			die(_("--packfile requires --index-pack-args"));
+
+		strvec_split(&encoded, index_pack_args);
+
+		CALLOC_ARRAY(raw, encoded.nr + 1);
+		for (i = 0; i < encoded.nr; i++)
+			raw[i] = url_percent_decode(encoded.v[i]);
+
+		fetch_single_packfile(&packfile_hash, argv[arg],
+				      (const char **) raw);
+
+		for (i = 0; i < encoded.nr; i++)
+			free(raw[i]);
+		free(raw);
+		strvec_clear(&encoded);
+
 		return 0;
 	}
 
+	if (index_pack_args)
+		die(_("--index-pack-args can only be used with --packfile"));
+
 	if (commits_on_stdin) {
 		commits = walker_targets_stdin(&commit_id, &write_ref);
 	} else {
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 483578b2d7..af90e7efed 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -224,7 +224,8 @@ test_expect_success 'http-fetch --packfile' '
 
 	git init packfileclient &&
 	p=$(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git && ls objects/pack/pack-*.pack) &&
-	git -C packfileclient http-fetch --packfile=$ARBITRARY "$HTTPD_URL"/dumb/repo_pack.git/$p >out &&
+	git -C packfileclient http-fetch --packfile=$ARBITRARY \
+		--index-pack-args="index-pack --stdin --keep" "$HTTPD_URL"/dumb/repo_pack.git/$p >out &&
 
 	grep "^keep.[0-9a-f]\{16,\}$" out &&
 	cut -c6- out >packhash &&
-- 
2.30.0.280.ga3ce27912f-goog

