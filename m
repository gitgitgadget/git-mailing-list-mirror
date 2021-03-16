Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3871C433E0
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FAB764F9F
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbhCPCxs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 22:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbhCPCxk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 22:53:40 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BA6C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:53:39 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r15-20020a05600c35cfb029010e639ca09eso560253wmq.1
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=FlNeQ/8aFJJEu9Hg5gsRCv1Hp9Ej+RgUvVAI7wAUwv0=;
        b=OMZQkJLXsNrBml1DTB6OVroHKNcoHL2BjtEnpoAs40f73TyMUvVpeQkzzQuVJ4ZRFd
         53HrhrMssC3TP68S34zEE0UcKE4Uot9PBoTLRBAee8zlViC9Si+nYrS2QsxCbbr2afvb
         enSj2cMrlAJf7G0hppxb7s5sRhvofeiySaZ2u+Jw63a35Kkh1F4EgFXTzcaXuwXscU7E
         D4nmWguqSwg3dqpFwLx3azs162qsddM6z7WRUKbd3ol64ngJs5YY5tIs33TrkqSwlcZG
         qAYv+9fhc5ZKnCw+OF8BjDgx4sFyDSBR8vylRKbtNTbgRJaAd8IRzd74OS23tRqxeBzc
         ywlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FlNeQ/8aFJJEu9Hg5gsRCv1Hp9Ej+RgUvVAI7wAUwv0=;
        b=E1KqCCH8v6khAch0A7gWSJusd4a0EE04+1ciIzZ6eqNw4of6wGf6NKuKFDDeL1sR08
         NxLmcj9Ef31asvvgfL1Xw4oIfatGSCKIz6IbqGfqQ6XheNEZHGP+Gn7VrXJX6wJ76jil
         tbJLuy7+FtZXmVVal/hwL1PrFuvlKjSiFS+VhXCuVjURBf3uRb78Llg9mTQufCSITmHd
         +lfZJa77hlj+Sw9YiZOBdcR70A7/39bEevvcqChM6MG+WiDoZL2VHo1ZmX/P/Q3wmdbg
         tVShiI03g2Mb+qAH4o/uaxlM1Xd1utQpTxsLaszoHBVAf0F9PUS3+Zl3iosnscdyExyz
         6lwQ==
X-Gm-Message-State: AOAM5311j0VlkqgynNt37Ga/p1RO/KdzRuFGGG7R3SS3qmJ+RB6GFApD
        knmUaKe2P87oXsOYDkR5N68PefcttSk=
X-Google-Smtp-Source: ABdhPJzmKlaWNdhKKX8HmAYRpB2EXlRDYLAzZDdi4/SKZM57hr9VyZ51eONk3yRFCNskr5ciy7Lwew==
X-Received: by 2002:a1c:600a:: with SMTP id u10mr2338101wmb.139.1615863218383;
        Mon, 15 Mar 2021 19:53:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p16sm24486245wrt.54.2021.03.15.19.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 19:53:38 -0700 (PDT)
Message-Id: <pull.890.git.1615863217226.gitgitgadget@gmail.com>
From:   "SURA via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 02:53:36 +0000
Subject: [PATCH] builtin/fetch.c: clean tmp pack after receive signal
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     SURA <sura907@hotmail.com>, SURA <sura907@hotmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: SURA <sura907@hotmail.com>

In Gitee.com, I often use scripts to start a time-limited
"git fetch". When the execution time of'git fetch' is too
long, send a signal (such as SIGINT) to the'git fetch' process

But I found that after the process exits, there are some
files in the format of 'objects/pack/tmp_pack_XXXXXX' on the disk.
They are usually very large (some of them exceed 5G), and'git gc'
has no effect on them.

These fetch_tmp_pack files will gradually fill up the disk.
For a long time, I set F_WRLCK to the file to confirm whether the
file is opened by other processes, and delete the file if it is not opened

Obviously this is only a temporary solution, I think it should be fixed from git

I found fetch will start a 'index-pack' sub-process, this sub-process
create the tmp_pack
  1. make 'index-pack' unlink tmp_pack when get signal
  2. make 'fetch' send signal to 'index-pack' when get signal

Signed-off-by: SURA <sura907@hotmail.com>
---
    builtin/fetch.c: clean tmp pack after receive signal
    
    Clean tmp-pack after 'git fetch' process get signal(SIGINT, SIGHUP,
    SIGTERM, SIGQUIT or SIGPIPE)
    
    Only for operations using ‘wire protocol version 2’ and ssh
    
    Signed-off-by: SURA sura907@hotmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-890%2FSURA907%2Fgit-fetch-tmp-pack-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-890/SURA907/git-fetch-tmp-pack-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/890

 builtin/fetch-pack.c |  3 ++-
 builtin/fetch.c      | 10 ++++++++++
 builtin/index-pack.c | 18 ++++++++++++++++++
 fetch-pack.c         |  7 +++++--
 fetch-pack.h         |  3 ++-
 transport.c          |  3 ++-
 transport.h          |  6 ++++++
 7 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index c2d96f4c89ab..49a3e0bf2ae3 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -56,6 +56,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	struct string_list deepen_not = STRING_LIST_INIT_DUP;
 	struct packet_reader reader;
 	enum protocol_version version;
+	pid_t index_pack_pid = -1;
 
 	fetch_if_missing = 0;
 
@@ -232,7 +233,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	}
 
 	ref = fetch_pack(&args, fd, ref, sought, nr_sought,
-			 &shallow, pack_lockfiles_ptr, version);
+			 &shallow, pack_lockfiles_ptr, version, &index_pack_pid);
 	if (pack_lockfiles.nr) {
 		int i;
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 0b90de87c7a2..a87efa23ceb5 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -224,8 +224,18 @@ static void unlock_pack(void)
 		transport_unlock_pack(gsecondary);
 }
 
+static void send_signo_to_index_pack(int signo)
+{
+	if (gtransport && gtransport->index_pack_pid > 0)
+		kill(gtransport->index_pack_pid, signo);
+
+	if (gsecondary && gsecondary->index_pack_pid > 0)
+		kill(gsecondary->index_pack_pid, signo);
+}
+
 static void unlock_pack_on_signal(int signo)
 {
+	send_signo_to_index_pack(signo);
 	unlock_pack();
 	sigchain_pop(signo);
 	raise(signo);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index bad57488079c..27d1ebba746e 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -15,10 +15,13 @@
 #include "packfile.h"
 #include "object-store.h"
 #include "promisor-remote.h"
+#include "sigchain.h"
 
 static const char index_pack_usage[] =
 "git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--[no-]rev-index] [--verify] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
 
+static const char *tmp_pack_name;
+
 struct object_entry {
 	struct pack_idx_entry idx;
 	unsigned long size;
@@ -336,6 +339,7 @@ static const char *open_pack_file(const char *pack_name)
 			output_fd = odb_mkstemp(&tmp_file,
 						"pack/tmp_pack_XXXXXX");
 			pack_name = strbuf_detach(&tmp_file, NULL);
+			tmp_pack_name = pack_name;
 		} else {
 			output_fd = open(pack_name, O_CREAT|O_EXCL|O_RDWR, 0600);
 			if (output_fd < 0)
@@ -353,6 +357,19 @@ static const char *open_pack_file(const char *pack_name)
 	return pack_name;
 }
 
+static void remove_tmp_pack(void)
+{
+	if (tmp_pack_name) 
+		unlink_or_warn(tmp_pack_name);
+}
+
+static void remove_tmp_pack_on_signal(int signo)
+{
+	remove_tmp_pack();
+	sigchain_pop(signo);
+	raise(signo);
+}
+
 static void parse_pack_header(void)
 {
 	struct pack_header *hdr = fill(sizeof(struct pack_header));
@@ -1911,6 +1928,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	}
 
 	curr_pack = open_pack_file(pack_name);
+	sigchain_push_common(remove_tmp_pack_on_signal);
 	parse_pack_header();
 	objects = xcalloc(st_add(nr_objects, 1), sizeof(struct object_entry));
 	if (show_stat)
diff --git a/fetch-pack.c b/fetch-pack.c
index 6a61a464283e..bedbf69710f6 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -40,6 +40,7 @@ static struct shallow_lock shallow_lock;
 static const char *alternate_shallow_file;
 static struct strbuf fsck_msg_types = STRBUF_INIT;
 static struct string_list uri_protocols = STRING_LIST_INIT_DUP;
+static pid_t *curr_index_pack_pid;
 
 /* Remember to update object flag allocation in object.h */
 #define COMPLETE	(1U << 0)
@@ -944,6 +945,7 @@ static int get_pack(struct fetch_pack_args *args,
 	cmd.git_cmd = 1;
 	if (start_command(&cmd))
 		die(_("fetch-pack: unable to fork off %s"), cmd_name);
+	*curr_index_pack_pid = cmd.pid;
 	if (do_keep && (pack_lockfiles || fsck_objects)) {
 		int is_well_formed;
 		char *pack_lockfile = index_pack_lockfile(cmd.out, &is_well_formed);
@@ -1945,12 +1947,13 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		       struct ref **sought, int nr_sought,
 		       struct oid_array *shallow,
 		       struct string_list *pack_lockfiles,
-		       enum protocol_version version)
+		       enum protocol_version version,
+		       pid_t *index_pack_pid)
 {
 	struct ref *ref_cpy;
 	struct shallow_info si;
 	struct oid_array shallows_scratch = OID_ARRAY_INIT;
-
+	curr_index_pack_pid = index_pack_pid;
 	fetch_pack_setup();
 	if (nr_sought)
 		nr_sought = remove_duplicates_in_refs(sought, nr_sought);
diff --git a/fetch-pack.h b/fetch-pack.h
index 736a3dae467a..c05a2544bb06 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -78,7 +78,8 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		       int nr_sought,
 		       struct oid_array *shallow,
 		       struct string_list *pack_lockfiles,
-		       enum protocol_version version);
+		       enum protocol_version version,
+			   pid_t *index_pack_pid);
 
 /*
  * Print an appropriate error message for each sought ref that wasn't
diff --git a/transport.c b/transport.c
index b13fab5dc3b1..b18f62e6bd23 100644
--- a/transport.c
+++ b/transport.c
@@ -391,7 +391,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	refs = fetch_pack(&args, data->fd,
 			  refs_tmp ? refs_tmp : transport->remote_refs,
 			  to_fetch, nr_heads, &data->shallow,
-			  &transport->pack_lockfiles, data->version);
+			  &transport->pack_lockfiles, data->version, &transport->index_pack_pid);
 
 	close(data->fd[0]);
 	close(data->fd[1]);
@@ -1095,6 +1095,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	}
 
 	ret->hash_algo = &hash_algos[GIT_HASH_SHA1];
+	ret->index_pack_pid = -1;
 
 	return ret;
 }
diff --git a/transport.h b/transport.h
index 24e15799e714..d25d76125784 100644
--- a/transport.h
+++ b/transport.h
@@ -118,6 +118,12 @@ struct transport {
 	enum transport_family family;
 
 	const struct git_hash_algo *hash_algo;
+
+	/*
+	 * Record the pid of the index_pack sub-process
+	 * used to send the signal to this sub-process after the main fetch process receives the signal
+	 */
+	pid_t index_pack_pid;
 };
 
 #define TRANSPORT_PUSH_ALL			(1<<0)

base-commit: 13d7ab6b5d7929825b626f050b62a11241ea4945
-- 
gitgitgadget
