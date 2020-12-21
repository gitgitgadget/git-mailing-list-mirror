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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF35C433DB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 22:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87F2D225AA
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 22:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgLUWbq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 17:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgLUWbq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 17:31:46 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D08C0613D3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 14:31:06 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id o6so7382382pgg.8
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 14:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=cwQTUranJHKvp0a1P8Jp3UZ5zXVPg0rcH8B6hxncQLc=;
        b=Iym/O0ceb/kXKyZiEH2mZkU/9u3872OmAHidyQb5iMwNnrli7+78Zyz7/h1lDGsc/E
         H5vTOalA1EUthNYXKjxFPu38GeWjcaWczvazukMkc0rYUPfzUND8Jsr5pmk/er2FoyCm
         lUVX6YYAmi3solUHMa+rPxrWJB2LCTN2eLWIOXFOtccEaW/V2PEb/hyQl1U0DZuERDni
         8kSHayzw3eReBCq0WM29MoiSF9uX3olXF2Jl1u7SiD9W/Ri8U8ThLqRkTrtVBdDuRBIT
         2Ig2aUyXLuEBDWLNdcCX4MW4aSqzhHEk/j5v1QpaLCcO2QVbpI22UHRP50CiGUvjMuii
         EqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cwQTUranJHKvp0a1P8Jp3UZ5zXVPg0rcH8B6hxncQLc=;
        b=jl2KNM7mW7DjBGCzwJQcjaYznlXqcbNxyjitQzv6a1YTKXWMlMGvXw8AyVtfGRphzj
         3tnti3dR+kABoOBl6THOVkj+XVOLEWCSHDydYVxcyg/QKF/qg0ChsYt86gc8SHXyMABf
         m1TLV6Xdcwlus5anQr6jvySiJbXwC4oxSSLcPD9cZyjyNfhmB+5Z2KZr4twqxtnBqeOi
         0dWAmUaqj4VzO9bDs0YZSPH36qmgQaLayrV1xjO7ZYhkU6zaLmuGg9VOfXiPJcjQ4VQF
         SklfYhenUcVIA7rR56oN8T6KbT3f/hCTR9jP7CG+KmRs4+kRQvmJHaFZVop45PKHCU0D
         +N1A==
X-Gm-Message-State: AOAM530LKP7StuhiVoMco6of7x51p7Ot/bY+C+ugO3Ntya/2MPPrublI
        YakqHfIbX300kCs76P6jumMNHclKcl3H3izdqgCQ8Pr4thZJ6eawGln46EgznEsQKmPtGhcwkZ6
        reWHzLiJYkgsZKTrwFQovHO4lOSPj/iuVON7P+dwp98Klpp2Z1pkxYhsHmjFk6H845HebpjOinX
        kU
X-Google-Smtp-Source: ABdhPJykTe+pPUGKg6LrBzYgAp7rWb4q98lAbUPJ2Vj8uFiaUrWbC3iIEnXPW7AZtx2eApwG67O+fCdqsDA0a6mHGxqh
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:467:b029:da:9ac2:24ee with
 SMTP id 94-20020a1709020467b02900da9ac224eemr18260941ple.22.1608589865671;
 Mon, 21 Dec 2020 14:31:05 -0800 (PST)
Date:   Mon, 21 Dec 2020 14:30:58 -0800
In-Reply-To: <20201211210508.2337494-1-jonathantanmy@google.com>
Message-Id: <cover.1608587839.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20201211210508.2337494-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH v3 0/3] Cloning with remote unborn HEAD
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks everyone for your comments. Changes from v2:

Patch 1:

 - I took a look at head_ref_namespaced() was hoping that it could be
   refactored to meet my new needs, but I don't think it's feasible.
   head_ref_namespaced() seems to have a precise use - for when we
   already have a callback that we're using with
   for_each_namespaced_ref(), and we want to use it with the HEAD ref as
   well. Instead what I did is to eliminate the use of
   head_ref_namespaced() here, and used send_possibly_unborn_head() for
   both the regular and the new unborn case.

 - Renamed null_oid to avoid shadowing, as pointed out by Junio.

 - Changed to a boolean lsrefs.allowUnborn, so no more advertise/allow
   distinction. Currently it still defaults to unallowed. Peff, what did
   you mean in [1] by the following:

> So I dunno. My biggest complaint is that the config option defaults to
> _off_.  So it's helping load-balanced rollouts, but creating complexity
> for everyone else who might want to enable the feature.

   So it seems like you're saying that it should default to "on", but at
   the same time you are talking about enabling the feature (which seems
   to imply switching it from "off" to "on"). (Also, note that this is a
   server-side thing; on the client-side, Git will always use what the
   server gives and there is no option to control this.)

 - Added documentation of lsrefs.allowUnborn, which I forgot.

Patch 2:

 - Used Junio's suggested commit message.

Patch 3:

 - No changes except what was necessary due to the config option change.

[1] https://lore.kernel.org/git/X9xJLWdFJfNJTn0p@coredump.intra.peff.net/

Jonathan Tan (3):
  ls-refs: report unborn targets of symrefs
  connect, transport: add no-op arg for future patch
  clone: respect remote unborn HEAD

 Documentation/config.txt                |  2 +
 Documentation/config/init.txt           |  2 +-
 Documentation/config/lsrefs.txt         |  3 ++
 Documentation/technical/protocol-v2.txt | 10 ++++-
 builtin/clone.c                         | 19 +++++++--
 builtin/fetch-pack.c                    |  3 +-
 builtin/fetch.c                         |  2 +-
 builtin/ls-remote.c                     |  2 +-
 builtin/remote.c                        |  2 +-
 connect.c                               | 29 ++++++++++++--
 ls-refs.c                               | 51 +++++++++++++++++++++++--
 ls-refs.h                               |  1 +
 remote.h                                |  3 +-
 serve.c                                 |  2 +-
 t/t5606-clone-options.sh                |  7 ++--
 t/t5702-protocol-v2.sh                  |  9 +++++
 transport-helper.c                      |  7 +++-
 transport-internal.h                    | 13 +++----
 transport.c                             | 29 ++++++++------
 transport.h                             |  7 +++-
 20 files changed, 160 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/config/lsrefs.txt

Range-diff against v2:
1:  7f5b50c7b2 ! 1:  7d20ec323a ls-refs: report unborn targets of symrefs
    @@ Commit message
     
         Currently, symrefs that have unborn targets (such as in this case) are
         not communicated by the protocol. Teach Git to advertise and support the
    -    "unborn" feature in "ls-refs" (guarded by the lsrefs.unborn config).
    -    This feature indicates that "ls-refs" supports the "unborn" argument;
    -    when it is specified, "ls-refs" will send the HEAD symref with the name
    -    of its unborn target.
    +    "unborn" feature in "ls-refs" (guarded by the lsrefs.allowunborn
    +    config). This feature indicates that "ls-refs" supports the "unborn"
    +    argument; when it is specified, "ls-refs" will send the HEAD symref with
    +    the name of its unborn target.
     
         This change is only for protocol v2. A similar change for protocol v0
         would require independent protocol design (there being no analogous
    @@ Commit message
     
         Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
     
    + ## Documentation/config.txt ##
    +@@ Documentation/config.txt: include::config/interactive.txt[]
    + 
    + include::config/log.txt[]
    + 
    ++include::config/lsrefs.txt[]
    ++
    + include::config/mailinfo.txt[]
    + 
    + include::config/mailmap.txt[]
    +
    + ## Documentation/config/lsrefs.txt (new) ##
    +@@
    ++lsrefs.allowUnborn::
    ++	Allow the server to send information about unborn symrefs during the
    ++	protocol v2 ref advertisement.
    +
      ## Documentation/technical/protocol-v2.txt ##
     @@ Documentation/technical/protocol-v2.txt: ls-refs takes in the following arguments:
      	When specified, only references having a prefix matching one of
    @@ ls-refs.c: static int send_ref(const char *refname, const struct object_id *oid,
     +	struct strbuf namespaced = STRBUF_INIT;
     +	struct object_id oid;
     +	int flag;
    -+	int null_oid;
    ++	int oid_is_null;
     +
     +	strbuf_addf(&namespaced, "%sHEAD", get_git_namespace());
     +	resolve_ref_unsafe(namespaced.buf, 0, &oid, &flag);
    -+	null_oid = is_null_oid(&oid);
    -+	if (!null_oid || (data->symrefs && (flag & REF_ISSYMREF)))
    -+		send_ref(namespaced.buf, null_oid ? NULL : &oid, flag, data);
    ++	oid_is_null = is_null_oid(&oid);
    ++	if (!oid_is_null ||
    ++	    (data->unborn && data->symrefs && (flag & REF_ISSYMREF)))
    ++		send_ref(namespaced.buf, oid_is_null ? NULL : &oid, flag, data);
     +	strbuf_release(&namespaced);
     +}
     +
    @@ ls-refs.c: static int send_ref(const char *refname, const struct object_id *oid,
     +{
     +	struct ls_refs_data *data = cb_data;
     +
    -+	if (!strcmp("lsrefs.unborn", var))
    -+		data->allow_unborn = !strcmp(value, "allow") ||
    -+			!strcmp(value, "advertise");
    ++	if (!strcmp("lsrefs.allowunborn", var))
    ++		data->allow_unborn = git_config_bool(var, value);
    ++
      	/*
      	 * We only serve fetches over v2 for now, so respect only "uploadpack"
      	 * config. This may need to eventually be expanded to "receive", but we
    @@ ls-refs.c: int ls_refs(struct repository *r, struct strvec *keys,
      		die(_("expected flush after ls-refs arguments"));
      
     -	head_ref_namespaced(send_ref, &data);
    -+	if (data.unborn)
    -+		send_possibly_unborn_head(&data);
    -+	else
    -+		head_ref_namespaced(send_ref, &data);
    ++	send_possibly_unborn_head(&data);
      	for_each_namespaced_ref(send_ref, &data);
      	packet_flush(1);
      	strvec_clear(&data.prefixes);
    @@ ls-refs.c: int ls_refs(struct repository *r, struct strvec *keys,
     +int ls_refs_advertise(struct repository *r, struct strbuf *value)
     +{
     +	if (value) {
    -+		char *str = NULL;
    ++		int allow_unborn_value;
     +
    -+		if (!repo_config_get_string(the_repository, "lsrefs.unborn",
    -+					    &str) &&
    -+		    !strcmp("advertise", str)) {
    ++		if (!repo_config_get_bool(the_repository,
    ++					 "lsrefs.allowunborn",
    ++					 &allow_unborn_value) &&
    ++		    allow_unborn_value)
     +			strbuf_addstr(value, "unborn");
    -+			free(str);
    -+		}
     +	}
     +
     +	return 1;
2:  e24fb6d746 ! 2:  b5a78857eb connect, transport: add no-op arg for future patch
    @@ Metadata
      ## Commit message ##
         connect, transport: add no-op arg for future patch
     
    -    A future patch will require transport_get_remote_refs() and
    -    get_remote_refs() to gain a new argument. Add the argument in this
    -    patch, with no effect on execution, so that the future patch only needs
    -    to concern itself with new logic.
    +    In a future patch we plan to return the name of an unborn current branch
    +    from deep in the callchain to a caller via a new pointer parameter that
    +    points at a variable in the caller when the caller calls
    +    get_remote_refs() and transport_get_remote_refs(). Add the parameter to
    +    functions involved in the callchain, but no caller passes an actual
    +    argument yet in this step. Thus, the future patch only needs to concern
    +    itself with new logic.
     
         Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
     
3:  6fcb3b16ce ! 3:  c2303dc976 clone: respect remote unborn HEAD
    @@ t/t5606-clone-options.sh: test_expect_success 'redirected clone -v does show pro
      test_expect_success 'chooses correct default initial branch name' '
     -	git init --bare empty &&
     +	git -c init.defaultBranch=foo init --bare empty &&
    -+	test_config -C empty lsrefs.unborn advertise &&
    ++	test_config -C empty lsrefs.allowUnborn true &&
      	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
      	git -c init.defaultBranch=up clone empty whats-up &&
     -	test refs/heads/up = $(git -C whats-up symbolic-ref HEAD) &&
    @@ t/t5702-protocol-v2.sh: test_expect_success 'clone with file:// using protocol v
      
     +test_expect_success 'clone of empty repo propagates name of default branch' '
     +	git -c init.defaultBranch=mydefaultbranch init file_empty_parent &&
    -+	test_config -C file_empty_parent lsrefs.unborn advertise &&
    ++	test_config -C file_empty_parent lsrefs.allowUnborn true &&
     +
     +	git -c init.defaultBranch=main -c protocol.version=2 \
     +		clone "file://$(pwd)/file_empty_parent" file_empty_child &&
     +	grep "refs/heads/mydefaultbranch" file_empty_child/.git/HEAD
     +'
    -+
    -+test_expect_success '...but not if it is not advertised' '
    -+	test_config -C file_empty_parent lsrefs.unborn none &&
    -+
    -+	git -c init.defaultBranch=main -c protocol.version=2 \
    -+		clone "file://$(pwd)/file_empty_parent" file_empty_child_2 &&
    -+	grep "refs/heads/main" file_empty_child_2/.git/HEAD
    -+'
     +
      test_expect_success 'fetch with file:// using protocol v2' '
      	test_when_finished "rm -f log" &&
-- 
2.29.2.729.g45daf8777d-goog

