Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A619F206FB
	for <e@80x24.org>; Fri,  8 Jul 2016 22:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756418AbcGHWgf (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 18:36:35 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35803 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756356AbcGHWge (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 18:36:34 -0400
Received: by mail-wm0-f65.google.com with SMTP id k123so9780958wme.2
        for <git@vger.kernel.org>; Fri, 08 Jul 2016 15:36:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=QbLQrJZUOhzHjoygXulYn5wXk38WcMUIXVkWW7S+Yjo=;
        b=BzmUEIyGIMyHjgMCeFTYuUDiIokqnfXVdYRlJPvCPW8ppzOriuRyx0dMctJ2qgQ6i2
         VF5PrfbD3cmxEQd5gIIjcesukv+JUhj6Aq+loBbLUuGPITW5MxrnjS7CtU0HtuUNdVl6
         kHlBSlswocQsntVBNNekkmRgq4XyWhW253Vs/0ijRsZ5lQ3yJxnupy9XGfyhi+/GSdRU
         VSwOvKq5unhAYyTEAU5laJtLSeqMRTGyqHZijyzRtFxXGPaEX0UrhRUEgm9shIpwoYDi
         RpFUFtO6L094bC7t6OADTa1LoenDPCC3wboB99CFQvUbGCAYInSkdpWqu93FDVhWC8O9
         Zzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QbLQrJZUOhzHjoygXulYn5wXk38WcMUIXVkWW7S+Yjo=;
        b=PFrAaxdMv+7nfk1m8K+PS5+c/JwKFnDGYHbr34MeNoFKvQ5qzR0ASaUCDrWQW59qxe
         vNsn11E1k61hzcm7XF/zcBm3VgGs4TWxPm/4qzcrx3hguGXX/BK0jTuPTBHpHSXimjLz
         EO5aGT9TYyAOEpSDMJmTx1nXrOy6PgveXubcHnfesQC3mdi6+fc6nt0/52965WQ6s7K6
         Ijc3MSmk1axaKLDFhFSbAXG3obF5rq+cu/f7qEFlbCqW175EX6Hw8DxvL7JaRV0RQ5gn
         /rSdzhB9aDfPul7fMmpJVb1MqAseG4wBqqQ3Xvm6c/aqRsQFWTRxcJfZSAIV5ICnN4d7
         2hZA==
X-Gm-Message-State: ALyK8tLlT+kSeK59tXVH5OHNNDVctPdmpCPIVXpjXCKiBqRK5nFuYBh8xAOHGK26ntXIiQ==
X-Received: by 10.194.104.134 with SMTP id ge6mr8137340wjb.157.1468017392270;
        Fri, 08 Jul 2016 15:36:32 -0700 (PDT)
Received: from localhost.localdomain (2a01cb0400731300021e65fffe6ec532.ipv6.abo.wanadoo.fr. [2a01:cb04:73:1300:21e:65ff:fe6e:c532])
        by smtp.gmail.com with ESMTPSA id l1sm5419709wjy.17.2016.07.08.15.36.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jul 2016 15:36:31 -0700 (PDT)
From:	Nicolas Cornu <nicolac76@gmail.com>
X-Google-Original-From:	Nicolas Cornu <nicolac76@yahoo.fr>
To:	git@vger.kernel.org
Cc:	Nicolas Cornu <nicolac76@yahoo.fr>
Subject: [PATCH/RFC] archive: allow archiving of reachable sha1
Date:	Sat,  9 Jul 2016 00:32:50 +0200
Message-Id: <20160708223250.18238-1-nicolac76@yahoo.fr>
X-Mailer: git-send-email 2.9.0
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Remotely specify a tree-ish by a sha1 is now valid even if
uploadarchive.allowunreachable is false only if this sha1 is reachable
from a branch or a tag reference. We consider those last one to be
public.

Signed-off-by: Nicolas Cornu <nicolac76@yahoo.fr>
---
Do you think this patch is too much "computationnally expensive"?
Maybe we need an option to disable such a a feature.
If we want an option I think it's better to have an option disabling this feature.
This way server will accept such archiving by default.

 Documentation/git-upload-archive.txt | 19 ++++++-------------
 archive.c                            | 15 +++++++++++++--
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-upload-archive.txt b/Documentation/git-upload-archive.txt
index fba0f1c..59d9b65 100644
--- a/Documentation/git-upload-archive.txt
+++ b/Documentation/git-upload-archive.txt
@@ -26,25 +26,18 @@ SECURITY
 In order to protect the privacy of objects that have been removed from
 history but may not yet have been pruned, `git-upload-archive` avoids
 serving archives for commits and trees that are not reachable from the
-repository's refs.  However, because calculating object reachability is
-computationally expensive, `git-upload-archive` implements a stricter
-but easier-to-check set of rules:
+repository's refs. `git-upload-archive` implements a stricter but
+easier-to-check set of rules:
 
   1. Clients may request a commit or tree that is pointed to directly by
-     a ref. E.g., `git archive --remote=origin v1.0`.
+     a ref or is an ancestor of a branch or tag ref.
+     E.g., `git archive --remote=origin v1.0`.
 
   2. Clients may request a sub-tree within a commit or tree using the
      `ref:path` syntax. E.g., `git archive --remote=origin v1.0:Documentation`.
 
-  3. Clients may _not_ use other sha1 expressions, even if the end
-     result is reachable. E.g., neither a relative commit like `master^`
-     nor a literal sha1 like `abcd1234` is allowed, even if the result
-     is reachable from the refs.
-
-Note that rule 3 disallows many cases that do not have any privacy
-implications. These rules are subject to change in future versions of
-git, and the server accessed by `git archive --remote` may or may not
-follow these exact rules.
+These rules are subject to change in future versions of git, and the server
+accessed by `git archive --remote` may or may not follow these exact rules.
 
 If the config option `uploadArchive.allowUnreachable` is true, these
 rules are ignored, and clients may use arbitrary sha1 expressions.
diff --git a/archive.c b/archive.c
index 42df974..d99c195 100644
--- a/archive.c
+++ b/archive.c
@@ -347,6 +347,12 @@ static void parse_pathspec_arg(const char **pathspec,
 	}
 }
 
+static int is_reachable(const char *refname, const struct object_id *oid, int flags, void *cb_data)
+{
+	const unsigned char *sha1 = (unsigned char *)cb_data;
+	return in_merge_bases(lookup_commit(sha1), lookup_commit(oid->hash));
+}
+
 static void parse_treeish_arg(const char **argv,
 		struct archiver_args *ar_args, const char *prefix,
 		int remote)
@@ -364,8 +370,13 @@ static void parse_treeish_arg(const char **argv,
 		const char *colon = strchrnul(name, ':');
 		int refnamelen = colon - name;
 
-		if (!dwim_ref(name, refnamelen, oid.hash, &ref))
-			die("no such ref: %.*s", refnamelen, name);
+		if (!dwim_ref(name, refnamelen, oid.hash, &ref)) {
+			if (get_sha1(name, oid.hash))
+				die("Not a valid object name");
+			if (!for_each_branch_ref(&is_reachable, oid.hash) &&
+			    !for_each_tag_ref(&is_reachable, oid.hash))
+				die("no such ref: %.*s", refnamelen, name);
+		}
 		free(ref);
 	}
 
-- 
2.9.0

