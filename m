Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CAAC433F5
	for <git@archiver.kernel.org>; Sat,  5 Feb 2022 00:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378667AbiBEAIU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 19:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345660AbiBEAIT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 19:08:19 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC15DF8C1BC
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 16:08:18 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id s10so11517702wra.5
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 16:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8lW+z9wdh8Zom/O4AiHJ2vfbxMnb2X7IVylJle2a6uE=;
        b=UdrKgDpHTiNawbf75BADB0HEiDkLpUFY4ab13HTcu51UXs93Lj3O3gI8uomzzvDgk+
         WaXNjY+8LCbE4sqYkr5PC5mgJ0QJdS9zm0NYOQiuKwJnvgjEJYLgOBQFIVgJ7XmOd86C
         JppOLwwZnVu0Wzq+pHnzVKWEw5T+Da1bgaV4Pl8BG6XSlXJ6Hd/IJkQLFnimeDTpBx3z
         g8CVwhhBQmD9lcv2aKHwmf+QhEf2mmLb2ZryT9JWGikxxf9jFsuTTRjRlM0XDvgPwVcL
         qqEkoP/oToP5Nd+RH+dxrFx9ngQta602SMCvJO3h2I+SrNAU1b+j0OeJT2pJC+LcY1Yi
         LGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8lW+z9wdh8Zom/O4AiHJ2vfbxMnb2X7IVylJle2a6uE=;
        b=hb/OV6n3hFZx7oM8P29NxuSNUlsCmMY+VMien8bmmzCTP0Fck1e2ryBltVyJ96puEe
         up6o0IDI9mPTjCbjENg6IoudHFZUZmXzQv11CLAIpfmO9nsG/nRjE/CKnUewLgh2BLtV
         f6eMeCd3S1cIT4pzYpovc995Yq4qqiPSUL7bixucGXRT8xYvxlmhPwFdB1EeGL9A4hNp
         0KFuODO4up+bOMYHrrODhAbIQEPpzaPkEv1UoMW9lasvscs2Ei1v6OOKyeKGu9tjjl4b
         L+2+i5UuMQGAhCB0TvG/lXlRx/GRau0FWo/zy91f7zRvbv2FoqCX3y9Z0YKXMKr41Bhz
         qu4Q==
X-Gm-Message-State: AOAM533Ynrfr+SC9nsblK9cY3PQPYR+S2M7xrCb8p+7yXYtqnThw7vwS
        Ei+d2OyXfi55fyFT1UpZPr3umIJRN/yhlQ==
X-Google-Smtp-Source: ABdhPJyy1eIfYt6bfUDRW8QE2Z/s472xbWtDCAKHQrsNuGxJJnrYAoBkBnyOAVycRLDpUcxtpL44aQ==
X-Received: by 2002:a05:6000:168f:: with SMTP id y15mr1015514wrd.367.1644019696713;
        Fri, 04 Feb 2022 16:08:16 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x18sm3018269wrw.17.2022.02.04.16.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 16:08:16 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] ls-remote & transport API: release "struct transport_ls_refs_options"
Date:   Sat,  5 Feb 2022 01:08:14 +0100
Message-Id: <patch-1.1-e80e8f64eae-20220205T000809Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.945.g180f8b8dd92
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in codepaths that use the "struct
transport_ls_refs_options" API. Since the introduction of the struct
in 39835409d10 (connect, transport: encapsulate arg in struct,
2021-02-05) the caller has been responsible for freeing it.

That commit in turn migrated code originally added in
402c47d9391 (clone: send ref-prefixes when using protocol v2,
2018-07-20) and b4be74105fe (ls-remote: pass ref prefixes when
requesting a remote's refs, 2018-03-15). Only some of those codepaths
were releasing the allocated resources of the struct, now all of them
will.

Mark the "t/t5511-refspec.sh" test as passing when git is compiled
with SANITIZE=leak. They'll now be listed as running under the
"GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the "linux-leaks" CI
target). Previously 24/47 tests would fail.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/clone.c     | 13 ++++++-------
 builtin/fetch.c     |  2 +-
 builtin/ls-remote.c |  3 ++-
 connect.c           |  4 ++--
 t/t5511-refspec.sh  |  1 +
 transport.c         |  8 +++++++-
 transport.h         | 10 +++++++---
 7 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 727e16e0aea..8564e5f603f 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1233,7 +1233,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	}
 	else {
 		const char *branch;
-		char *ref;
+		const char *ref;
+		char *ref_free = NULL;
 
 		if (option_branch)
 			die(_("Remote branch %s not found in upstream %s"),
@@ -1250,17 +1251,16 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		    skip_prefix(transport_ls_refs_options.unborn_head_target,
 				"refs/heads/", &branch)) {
 			ref = transport_ls_refs_options.unborn_head_target;
-			transport_ls_refs_options.unborn_head_target = NULL;
 			create_symref("HEAD", ref, reflog_msg.buf);
 		} else {
 			branch = git_default_branch_name(0);
-			ref = xstrfmt("refs/heads/%s", branch);
+			ref_free = xstrfmt("refs/heads/%s", branch);
+			ref = ref_free;
 		}
 
 		if (!option_bare)
 			install_branch_config(0, branch, remote_name, ref);
-
-		free(ref);
+		free(ref_free);
 	}
 
 	write_refspec_config(src_ref_prefix, our_head_points_at,
@@ -1312,7 +1312,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	UNLEAK(repo);
 	junk_mode = JUNK_LEAVE_ALL;
 
-	strvec_clear(&transport_ls_refs_options.ref_prefixes);
-	free(transport_ls_refs_options.unborn_head_target);
+	transport_ls_refs_options_release(&transport_ls_refs_options);
 	return err;
 }
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5f06b21f8e9..a3ffab727eb 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1593,7 +1593,7 @@ static int do_fetch(struct transport *transport,
 	} else
 		remote_refs = NULL;
 
-	strvec_clear(&transport_ls_refs_options.ref_prefixes);
+	transport_ls_refs_options_release(&transport_ls_refs_options);
 
 	ref_map = get_ref_map(transport->remote, remote_refs, rs,
 			      tags, &autotags);
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 44448fa61d1..d856085e941 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -155,6 +155,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 
 	ref_array_clear(&ref_array);
 	if (transport_disconnect(transport))
-		return 1;
+		status = 1;
+	transport_ls_refs_options_release(&transport_options);
 	return status;
 }
diff --git a/connect.c b/connect.c
index eaf7d6d2618..afc79a6236e 100644
--- a/connect.c
+++ b/connect.c
@@ -379,7 +379,7 @@ struct ref **get_remote_heads(struct packet_reader *reader,
 
 /* Returns 1 when a valid ref has been added to `list`, 0 otherwise */
 static int process_ref_v2(struct packet_reader *reader, struct ref ***list,
-			  char **unborn_head_target)
+			  const char **unborn_head_target)
 {
 	int ret = 1;
 	int i = 0;
@@ -483,7 +483,7 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 	const char *hash_name;
 	struct strvec *ref_prefixes = transport_options ?
 		&transport_options->ref_prefixes : NULL;
-	char **unborn_head_target = transport_options ?
+	const char **unborn_head_target = transport_options ?
 		&transport_options->unborn_head_target : NULL;
 	*list = NULL;
 
diff --git a/t/t5511-refspec.sh b/t/t5511-refspec.sh
index be025b90f98..fc55681a3f2 100755
--- a/t/t5511-refspec.sh
+++ b/t/t5511-refspec.sh
@@ -2,6 +2,7 @@
 
 test_description='refspec parsing'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_refspec () {
diff --git a/transport.c b/transport.c
index 2a3e3241545..253d6671b1f 100644
--- a/transport.c
+++ b/transport.c
@@ -1292,7 +1292,7 @@ int transport_push(struct repository *r,
 							       &transport_options);
 		trace2_region_leave("transport_push", "get_refs_list", r);
 
-		strvec_clear(&transport_options.ref_prefixes);
+		transport_ls_refs_options_release(&transport_options);
 
 		if (flags & TRANSPORT_PUSH_ALL)
 			match_flags |= MATCH_REFS_ALL;
@@ -1420,6 +1420,12 @@ const struct ref *transport_get_remote_refs(struct transport *transport,
 	return transport->remote_refs;
 }
 
+void transport_ls_refs_options_release(struct transport_ls_refs_options *opts)
+{
+	strvec_clear(&opts->ref_prefixes);
+	free((char *)opts->unborn_head_target);
+}
+
 int transport_fetch_refs(struct transport *transport, struct ref *refs)
 {
 	int rc;
diff --git a/transport.h b/transport.h
index 3f16e50c196..a0bc6a1e9eb 100644
--- a/transport.h
+++ b/transport.h
@@ -257,15 +257,19 @@ struct transport_ls_refs_options {
 	/*
 	 * If unborn_head_target is not NULL, and the remote reports HEAD as
 	 * pointing to an unborn branch, transport_get_remote_refs() stores the
-	 * unborn branch in unborn_head_target. It should be freed by the
-	 * caller.
+	 * unborn branch in unborn_head_target.
 	 */
-	char *unborn_head_target;
+	const char *unborn_head_target;
 };
 #define TRANSPORT_LS_REFS_OPTIONS_INIT { \
 	.ref_prefixes = STRVEC_INIT, \
 }
 
+/**
+ * Release the "struct transport_ls_refs_options".
+ */
+void transport_ls_refs_options_release(struct transport_ls_refs_options *opts);
+
 /*
  * Retrieve refs from a remote.
  */
-- 
2.35.1.945.g180f8b8dd92

