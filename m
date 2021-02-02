Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D122C433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 02:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 252EE64EE5
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 02:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhBBCPw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 21:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhBBCPt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 21:15:49 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288A8C061573
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 18:15:09 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id z3so12097364pfj.3
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 18:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Q/8GUgQgKmfTzT7lUGr179SbvVw/jnuOHzHP8UgV6xg=;
        b=dV6+vYp5kLBZeu5IMqcCc4oGHMgSo1HFMFCjemYlUtXufSMz0lW68+uECtqIZ9ZJk4
         m1lO9UqdVQKujnBrnyGFofZscD2QYwFWiJyBX4H5AKesD6sSynTf+b0rq3Piq5lbF//u
         0m64vDxPfRzTh2ee0/pz8JURyTV47ylZiRFXgNbF0S1FtkgyRmg7YF3isSX+9d9jl38y
         e8LuPMQ072TvlEh64pps6Kkt5OJLTb9+iDbwaBk22Pu7Yp9MywwVb+1dQoL+Zlyv+rQz
         hABar2y7Fd4O2QSWO+2T3+fWcqW6O4Qe8VJeUBBhE5vSqqbVXlrrEjabyh7AG4yHD3KN
         7lQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Q/8GUgQgKmfTzT7lUGr179SbvVw/jnuOHzHP8UgV6xg=;
        b=VQwLCYStu6oj+nAG8uSBkBZwzfXx1aZL+rZK+JXO4zoQ9XvNOGi8V5+aJRxNuik2MF
         FQoM6LOzkIYIWPzzDSVe/YCtCfoFItYUz68WnqSO2qQworkfLrbGWoZBRXDpCTpb2bC0
         7ST+FNvYJNej385xZl9JrMfhTLSOciBXAs3UwJPaWtPbczBgF4a5mzrZNI9FKkLJNXso
         ZXhjwSgoQ/hFLxktmId+bYwtM0FrtYznu8LfgFYaRvLN0NfSwnqCF+uFmpHpsqXcTPMG
         SnDnF7YHUSqPSy8FC9+puavc3/+rJmBO3x8wT5d0Bq/cNldib3tYDFO7ZTYBQUbqRnsj
         lxZw==
X-Gm-Message-State: AOAM5307DRAox7NMCnL1z3CskfTk9yKex7DVFhiSZ2yLlE31+d6VWel1
        LoXqFQcJzff5j6rZ7ynmDqlxvsjv6KIZIbdu1PCqiFd7NoMswsr3WayhW/ljN5FYYXDCGPV04O3
        SaIk+9IM+OrsURUVqB4J5fnTjEHihxiPwGAxODIRg8er6lkCFo6oEfsrM8v3M/NoS7uARg8xvlh
        s4
X-Google-Smtp-Source: ABdhPJwRgJ8TwKZMtKxgWCBmt+rcm1DxHa8N1e8oEKlRJyD9XEymgifzSImkR8oz76yZNKKtvhb0GYhB6kui9k+6KQBW
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:5344:0:b029:1c7:eeea:8bad with
 SMTP id h65-20020a6253440000b02901c7eeea8badmr19011186pfb.1.1612232108288;
 Mon, 01 Feb 2021 18:15:08 -0800 (PST)
Date:   Mon,  1 Feb 2021 18:14:58 -0800
In-Reply-To: <20201208013121.677494-1-jonathantanmy@google.com>
Message-Id: <cover.1612231707.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20201208013121.677494-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v6 0/3] Cloning with remote unborn HEAD
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I don't think we have consensus on whether the "unborn" config should be
advertise/allow/ignore or allow/ignore, so I have left that the same as
in version 5.

But as Junio suggested, I have isolated the reading of config into a
function and some global variables (so that one part can "leave a note"
to the other), so we could have advertise/allow/ignore (if we want)
without making the rest of the code much more complicated.

Other changes:
 - Updated the if/else cascade that parses the input to ls-refs to
   follow Junio's suggestion - "else if (!strcmp("unborn", arg)) {".
 - Moved create_symref() to cover the exact case it's needed.
 - Squashed Ramsay Jones's and Peff's patches.

Jonathan Tan (3):
  ls-refs: report unborn targets of symrefs
  connect, transport: encapsulate arg in struct
  clone: respect remote unborn HEAD

 Documentation/config.txt                |  2 +
 Documentation/config/init.txt           |  2 +-
 Documentation/config/lsrefs.txt         |  3 ++
 Documentation/technical/protocol-v2.txt | 10 ++++-
 builtin/clone.c                         | 34 ++++++++++----
 builtin/fetch-pack.c                    |  3 +-
 builtin/fetch.c                         | 18 +++++---
 builtin/ls-remote.c                     |  9 ++--
 connect.c                               | 32 ++++++++++++--
 ls-refs.c                               | 59 +++++++++++++++++++++++--
 ls-refs.h                               |  1 +
 remote.h                                |  4 +-
 serve.c                                 |  2 +-
 t/t5606-clone-options.sh                |  8 ++--
 t/t5701-git-serve.sh                    |  2 +-
 t/t5702-protocol-v2.sh                  | 25 +++++++++++
 transport-helper.c                      |  5 ++-
 transport-internal.h                    | 10 +----
 transport.c                             | 23 +++++-----
 transport.h                             | 29 +++++++++---
 20 files changed, 218 insertions(+), 63 deletions(-)
 create mode 100644 Documentation/config/lsrefs.txt

Range-diff against v5:
1:  cb033f9abc ! 1:  411bbafe25 ls-refs: report unborn targets of symrefs
    @@ Documentation/technical/protocol-v2.txt: ls-refs takes in the following argument
          peeled = "peeled:" obj-id
     
      ## ls-refs.c ##
    +@@
    + #include "pkt-line.h"
    + #include "config.h"
    + 
    ++static int config_read;
    ++static int allow_unborn;
    ++
    ++static void ensure_config_read(void)
    ++{
    ++	if (config_read)
    ++		return;
    ++
    ++	if (repo_config_get_bool(the_repository, "lsrefs.allowunborn",
    ++				 &allow_unborn))
    ++		/*
    ++		 * If there is no such config, set it to 1 to allow it by
    ++		 * default.
    ++		 */
    ++		allow_unborn = 1;
    ++	config_read = 1;
    ++}
    ++
    + /*
    +  * Check if one of the prefixes is a prefix of the ref.
    +  * If no prefixes were provided, all refs match.
     @@ ls-refs.c: struct ls_refs_data {
      	unsigned peel;
      	unsigned symrefs;
      	struct strvec prefixes;
    -+	unsigned allow_unborn : 1;
     +	unsigned unborn : 1;
      };
      
    @@ ls-refs.c: static int send_ref(const char *refname, const struct object_id *oid,
      	if (data->symrefs && flag & REF_ISSYMREF) {
      		struct object_id unused;
      		const char *symref_target = resolve_ref_unsafe(refname, 0,
    +@@ ls-refs.c: static int send_ref(const char *refname, const struct object_id *oid,
    + 			    strip_namespace(symref_target));
    + 	}
    + 
    +-	if (data->peel) {
    ++	if (data->peel && oid) {
    + 		struct object_id peeled;
    + 		if (!peel_ref(refname, &peeled))
    + 			strbuf_addf(&refline, " peeled:%s", oid_to_hex(&peeled));
     @@ ls-refs.c: static int send_ref(const char *refname, const struct object_id *oid,
      	return 0;
      }
      
    --static int ls_refs_config(const char *var, const char *value, void *data)
     +static void send_possibly_unborn_head(struct ls_refs_data *data)
    - {
    ++{
     +	struct strbuf namespaced = STRBUF_INIT;
     +	struct object_id oid;
     +	int flag;
    @@ ls-refs.c: static int send_ref(const char *refname, const struct object_id *oid,
     +	strbuf_release(&namespaced);
     +}
     +
    -+static int ls_refs_config(const char *var, const char *value, void *cb_data)
    -+{
    -+	struct ls_refs_data *data = cb_data;
    -+
    -+	if (!strcmp("lsrefs.allowunborn", var))
    -+		data->allow_unborn = git_config_bool(var, value);
    -+
    + static int ls_refs_config(const char *var, const char *value, void *data)
    + {
      	/*
    - 	 * We only serve fetches over v2 for now, so respect only "uploadpack"
    - 	 * config. This may need to eventually be expanded to "receive", but we
     @@ ls-refs.c: int ls_refs(struct repository *r, struct strvec *keys,
      
      	memset(&data, 0, sizeof(data));
      
    --	git_config(ls_refs_config, NULL);
    -+	data.allow_unborn = 1;
    -+	git_config(ls_refs_config, &data);
    ++	ensure_config_read();
    + 	git_config(ls_refs_config, NULL);
      
      	while (packet_reader_read(request) == PACKET_READ_NORMAL) {
    - 		const char *arg = request->line;
     @@ ls-refs.c: int ls_refs(struct repository *r, struct strvec *keys,
      			data.symrefs = 1;
      		else if (skip_prefix(arg, "ref-prefix ", &out))
      			strvec_push(&data.prefixes, out);
    -+		else if (data.allow_unborn && !strcmp("unborn", arg))
    -+			data.unborn = 1;
    ++		else if (!strcmp("unborn", arg))
    ++			data.unborn = allow_unborn;
      	}
      
      	if (request->status != PACKET_READ_FLUSH)
    @@ ls-refs.c: int ls_refs(struct repository *r, struct strvec *keys,
     +int ls_refs_advertise(struct repository *r, struct strbuf *value)
     +{
     +	if (value) {
    -+		int allow_unborn_value;
    -+
    -+		if (repo_config_get_bool(the_repository,
    -+					 "lsrefs.allowunborn",
    -+					 &allow_unborn_value) ||
    -+		    allow_unborn_value)
    ++		ensure_config_read();
    ++		if (allow_unborn)
     +			strbuf_addstr(value, "unborn");
     +	}
     +
2:  0c7ab71872 ! 2:  fad1ebe6b6 connect, transport: encapsulate arg in struct
    @@ transport-helper.c: static int has_attribute(const char *attrs, const char *attr
      	return get_refs_list_using_list(transport, for_push);
     
      ## transport-internal.h ##
    +@@
    + struct ref;
    + struct transport;
    + struct strvec;
    ++struct transport_ls_refs_options;
    + 
    + struct transport_vtable {
    + 	/**
     @@ transport-internal.h: struct transport_vtable {
      	 * the transport to try to share connections, for_push is a
      	 * hint as to whether the ultimate operation is a push or a fetch.
3:  8015415c79 ! 3:  45a48ccc0d clone: respect remote unborn HEAD
    @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
     +					"refs/heads/", &branch)) {
     +				ref = transport_ls_refs_options.unborn_head_target;
     +				transport_ls_refs_options.unborn_head_target = NULL;
    ++				create_symref("HEAD", ref, reflog_msg.buf);
     +			} else {
     +				branch = git_default_branch_name();
     +				ref = xstrfmt("refs/heads/%s", branch);
     +			}
      
      			install_branch_config(0, branch, remote_name, ref);
    -+			create_symref("HEAD", ref, "");
      			free(ref);
    - 		}
    - 	}
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
      	junk_mode = JUNK_LEAVE_ALL;
      
4:  1c06db6494 < -:  ---------- ls-refs: don't peel NULL oid
5:  30d83a9dfa < -:  ---------- transport-internal.h: fix a 'hdr-check' warning
-- 
2.30.0.365.g02bc693789-goog

