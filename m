Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46167C433E8
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 16:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 275596195D
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 16:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhCUQ7R (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 12:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhCUQ6p (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 12:58:45 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B826C061574
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 09:58:45 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 12so8163381wmf.5
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 09:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=w6qLCctNTv8MpxBrRJRL/C5eJlKxXD1cvuh1dptgELc=;
        b=uDd7vnOVrM79wSEqnIPcff8JrS1lvbMBAr6OXgz0Twzs+tLohuki3af8QOz5n92nwg
         g6BXZOKPHneK/AKj7dh1EzCvy54zAni/dX2S67wK5xIBRWMaDrCrM1SsYmilMGKDP1oi
         kUxhi/eCcF4gxHOvmK9IHDg/W/gYnG8Zmd93R29diVHl1ZjnzJbxtIyedfUmSRaoZU/Q
         E4ACw4SPjx2r5WdhxwPiTZBI59H5cD2V+uY6rLIthQ1TeEfliQxf4IAUrl2vRnOuCHC0
         hZn3ioysJuMgH4katLRSGmnxlqs+84A28u7Hz8lIpVdBZQ3Eg8Otk8YjeFZ0OL80Yzo7
         IG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=w6qLCctNTv8MpxBrRJRL/C5eJlKxXD1cvuh1dptgELc=;
        b=e35+KiypLE6kDrPbAz314YCAxp1KWh9aAAQne0/LsohfjAZ67OZNKLq5k4wJPjMorA
         B9vbBJYgo2z0nkeML4v09nqaZsV8STdsr7z5ow+yhOeV/Qjl6FSTUAw2rA4ZGvjnDpED
         feAY/T+d3g07hqWfDJbo3FSspLSA7iKPY63avQqryioCf5jRPEmsMs5jdwMjth+B+JxI
         RIa+AVj+Y1D2sB/EeuzPmTUp3ZFNzDbeRylUPob+KG9cRNt0ck/o0dbYd6uSXbW3Ri3M
         rVzYBgjXveKJnEAo5V2JsJvZ8FnkiUphCRsNIEREAHFt6wb6EfB+fxGlfK6XP7ju+1m7
         Jzyw==
X-Gm-Message-State: AOAM533mXy80DcSDlDx2Wghu4xgSqZZqfnpDd5i11ZKXna5WLS6nTh3u
        neilVj5uBocfhtaA9lVIXHV6RKf/C74=
X-Google-Smtp-Source: ABdhPJzYk3soMqWfeAMFbMrTSkIKFlNBG29cWzrlVQNeJk++wC7F+X82kzXkOUiONWzLJ7GuahhnHg==
X-Received: by 2002:a05:600c:203:: with SMTP id 3mr12299995wmi.88.1616345923867;
        Sun, 21 Mar 2021 09:58:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x6sm13891891wmj.32.2021.03.21.09.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 09:58:43 -0700 (PDT)
Message-Id: <50a2b9693aa37b0907452054cb2ad98f8ecdc910.1616345918.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.899.v3.git.1616345918.gitgitgadget@gmail.com>
References: <pull.899.v2.git.1615747662.gitgitgadget@gmail.com>
        <pull.899.v3.git.1616345918.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 21 Mar 2021 16:58:37 +0000
Subject: [PATCH v3 9/9] transport: also free remote_refs in
 transport_disconnect()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

transport_get_remote_refs() can populate the transport struct's
remote_refs. transport_disconnect() is already responsible for most of
transport's cleanup - therefore we also take care of freeing remote_refs
there.

There are 2 locations where transport_disconnect() is called before
we're done using the returned remote_refs. This patch changes those
callsites to only call transport_disconnect() after the returned refs
are no longer being used - which is necessary to safely be able to
free remote_refs during transport_disconnect().

This commit fixes the following leak which was found while running
t0000, but is expected to also fix the same pattern of leak in all
locations that use transport_get_remote_refs():

Direct leak of 165 byte(s) in 1 object(s) allocated from:
    #0 0x49a6b2 in calloc /home/abuild/rpmbuild/BUILD/llvm-11.0.0.src/build/../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:154:3
    #1 0x9a72f2 in xcalloc /home/ahunt/oss-fuzz/git/wrapper.c:140:8
    #2 0x8ce203 in alloc_ref_with_prefix /home/ahunt/oss-fuzz/git/remote.c:867:20
    #3 0x8ce1a2 in alloc_ref /home/ahunt/oss-fuzz/git/remote.c:875:9
    #4 0x72f63e in process_ref_v2 /home/ahunt/oss-fuzz/git/connect.c:426:8
    #5 0x72f21a in get_remote_refs /home/ahunt/oss-fuzz/git/connect.c:525:8
    #6 0x979ab7 in handshake /home/ahunt/oss-fuzz/git/transport.c:305:4
    #7 0x97872d in get_refs_via_connect /home/ahunt/oss-fuzz/git/transport.c:339:9
    #8 0x9774b5 in transport_get_remote_refs /home/ahunt/oss-fuzz/git/transport.c:1388:4
    #9 0x51cf80 in cmd_clone /home/ahunt/oss-fuzz/git/builtin/clone.c:1271:9
    #10 0x4cd60d in run_builtin /home/ahunt/oss-fuzz/git/git.c:453:11
    #11 0x4cb2da in handle_builtin /home/ahunt/oss-fuzz/git/git.c:704:3
    #12 0x4ccc37 in run_argv /home/ahunt/oss-fuzz/git/git.c:771:4
    #13 0x4cac29 in cmd_main /home/ahunt/oss-fuzz/git/git.c:902:19
    #14 0x69c45e in main /home/ahunt/oss-fuzz/git/common-main.c:52:11
    #15 0x7f6a459d5349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
---
 builtin/ls-remote.c | 4 ++--
 builtin/remote.c    | 8 ++++----
 transport.c         | 2 ++
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index abfa9847374f..1794548c7117 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -124,8 +124,6 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
 		repo_set_hash_algo(the_repository, hash_algo);
 	}
-	if (transport_disconnect(transport))
-		return 1;
 
 	if (!dest && !quiet)
 		fprintf(stderr, "From %s\n", *remote->url);
@@ -151,5 +149,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	}
 
 	ref_array_clear(&ref_array);
+	if (transport_disconnect(transport))
+		return 1;
 	return status;
 }
diff --git a/builtin/remote.c b/builtin/remote.c
index d11a5589e49d..e31d9c99470e 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -938,9 +938,6 @@ static int get_remote_ref_states(const char *name,
 				 struct ref_states *states,
 				 int query)
 {
-	struct transport *transport;
-	const struct ref *remote_refs;
-
 	states->remote = remote_get(name);
 	if (!states->remote)
 		return error(_("No such remote: '%s'"), name);
@@ -948,10 +945,12 @@ static int get_remote_ref_states(const char *name,
 	read_branches();
 
 	if (query) {
+		struct transport *transport;
+		const struct ref *remote_refs;
+
 		transport = transport_get(states->remote, states->remote->url_nr > 0 ?
 			states->remote->url[0] : NULL);
 		remote_refs = transport_get_remote_refs(transport, NULL);
-		transport_disconnect(transport);
 
 		states->queried = 1;
 		if (query & GET_REF_STATES)
@@ -960,6 +959,7 @@ static int get_remote_ref_states(const char *name,
 			get_head_names(remote_refs, states);
 		if (query & GET_PUSH_REF_STATES)
 			get_push_ref_states(remote_refs, states);
+		transport_disconnect(transport);
 	} else {
 		for_each_ref(append_ref_to_tracked_list, states);
 		string_list_sort(&states->tracked);
diff --git a/transport.c b/transport.c
index 1c4ab676d1b1..eb4b2d4e475f 100644
--- a/transport.c
+++ b/transport.c
@@ -1452,6 +1452,8 @@ int transport_disconnect(struct transport *transport)
 	int ret = 0;
 	if (transport->vtable->disconnect)
 		ret = transport->vtable->disconnect(transport);
+	if (transport->got_remote_refs)
+		free_refs((void *)transport->remote_refs);
 	free(transport);
 	return ret;
 }
-- 
gitgitgadget
