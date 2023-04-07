Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4BCC76196
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 02:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjDGChl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 22:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjDGChk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 22:37:40 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86114696
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 19:37:38 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-17fcc07d6c4so30304377fac.8
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 19:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680835058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1kvEtbLxNyvMnXaZpYewDorJCyW6qY4ZdNkXk0Y56Ik=;
        b=RMS4hoh3ImYUn9SWm6WdunEKxVZebGZPGbT4c1dSEgyBrLdM31LukwN0HUUHUd3ioF
         7x71NEfhmNyC0QgNJnhDfR2gGrRKv3zbC7xKPJ2i62F6YISSLH45i+LYQ30DLEv0NPgL
         TCQgzp0f6UlgHrfAkv7iQiI4jymZcpC8NJmhdEekCqo5bp1DIAdhR5RzOiG3BHJgIxD8
         ubRWlFhD86uyCzOKoKO977dJY4kPU9SwYvX8Fc2bLIY2fwbcSzOcjiBRD12V6UDVEOUh
         Zg7NGP3aoZ6e4UxoAbiwL+LWAs8vfV2poGY7nPhfth9bCh8GWeL+ZYdREFpxQlqJ5lG/
         WroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680835058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1kvEtbLxNyvMnXaZpYewDorJCyW6qY4ZdNkXk0Y56Ik=;
        b=ZhqdMORjHiSXmKvgOLAmFDMe/KKYQTFWD3DZW9QS4ZDaJCYc7vU0nYPM/ReJStKWPg
         tzVukAvY95dqvQky1bQgHAo1FDU8NN8b5R2K4llp9Can1SnmmS7HxI3BYh/dqG9K88A1
         GG1gl3pNyocWBTGHnKw8x8YdGp/QVcMfVfLZRY6SkCpgJmOu8nnR98rJ3kXUmJD4kSf6
         H1fydVpWF6psK0C1iSgST06YhLnpI3wdTwSx/ARynduXkmIwR77T15iDxo967bow6rQw
         4cmSceBQQEneeRlx+gbgNGdvjTG6mALdb3Z2HSmoahzxoOW8ERrRDpJR9xzeGuR+z+5y
         GC0Q==
X-Gm-Message-State: AAQBX9cJ1AcuXzWsc+emS5rbF4eNRfeqlRV7fz/GzzrDTenleEWrOvX0
        T7cnHzKSVrvZc7PuHW822pvX2xXC3v0=
X-Google-Smtp-Source: AKy350Y5RBCFoOfeASRAqCFyVa241C1OhdqGTZ2Nm9Gcsbh++yA7W/yk5H+i3iB8gTu0aIRbWUO6Vw==
X-Received: by 2002:a05:6870:6303:b0:177:9040:d243 with SMTP id s3-20020a056870630300b001779040d243mr801867oao.37.1680835057848;
        Thu, 06 Apr 2023 19:37:37 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id yg21-20020a05687c009500b0016a37572d17sm1329592oab.2.2023.04.06.19.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 19:37:37 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/2] Add fetch.updateHead option
Date:   Thu,  6 Apr 2023 20:37:34 -0600
Message-Id: <20230407023736.49190-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's surprising that `git clone` and `git init && git remote add -f` don't
create the same remote state.

Fix this by introducing a new configuration: `fetch.updateHead` which updates
the remote `HEAD` when it's not present with "missing", or always with
"always".

By default it's "never", which retains the current behavior.

This has already been discussed before [1].

Changes since v1:

1. Make `fetch_update_head` a named enum as suggested by Ævar
2. Remove `need_update_head`: use switch case instead, per Ævar
3. Make `update_head` receive `fetch_missing` boolean, instead of enum,
   per Ævar
4. Make `update_head` receive an unconsted `struct remote`: worse, but
   simplifies the review process

[1] https://lore.kernel.org/git/20201118091219.3341585-1-felipe.contreras@gmail.com/

Felipe Contreras (2):
  Add fetch.updateHead option
  fetch: add support for HEAD update on mirrors

 Documentation/config/fetch.txt  |  4 ++
 Documentation/config/remote.txt |  3 ++
 builtin/fetch.c                 | 76 ++++++++++++++++++++++++++++++++-
 remote.c                        | 20 +++++++++
 remote.h                        | 12 ++++++
 t/t5510-fetch.sh                | 49 +++++++++++++++++++++
 6 files changed, 163 insertions(+), 1 deletion(-)

Range-diff against v1:
1:  1cb238c83d ! 1:  0b80baba39 Add fetch.updateHead option
    @@ Commit message
     
         For the next major version of Git, we might want to change this default.
     
    +    Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
     
      ## Documentation/config/fetch.txt ##
    @@ builtin/fetch.c: static int fetch_prune_tags_config = -1; /* unspecified */
      static int prune_tags = -1; /* unspecified */
      #define PRUNE_TAGS_BY_DEFAULT 0 /* do we prune tags by default? */
      
    -+static int fetch_update_head = FETCH_UPDATE_HEAD_DEFAULT;
    ++static enum fetch_update_head fetch_update_head = FETCH_UPDATE_HEAD_DEFAULT;
     +
      static int all, append, dry_run, force, keep, multiple, update_head_ok;
      static int write_fetch_head = 1;
    @@ builtin/fetch.c: static int backfill_tags(struct transport *transport,
      	return retcode;
      }
      
    -+static void update_head(int config, const struct ref *head, const struct remote *remote)
    ++static void update_head(int fetch_missing, const struct ref *head,
    ++			struct remote *remote)
     +{
     +	char *ref, *target;
     +	const char *r;
    @@ builtin/fetch.c: static int backfill_tags(struct transport *transport,
     +	if (!head || !head->symref || !remote)
     +		return;
     +
    -+	ref = apply_refspecs((struct refspec *)&remote->fetch, "refs/heads/HEAD");
    -+	target = apply_refspecs((struct refspec *)&remote->fetch, head->symref);
    ++	ref = apply_refspecs(&remote->fetch, "refs/heads/HEAD");
    ++	target = apply_refspecs(&remote->fetch, head->symref);
     +
     +	if (!ref || !target) {
     +		warning(_("could not update remote head"));
    @@ builtin/fetch.c: static int backfill_tags(struct transport *transport,
     +	r = resolve_ref_unsafe(ref, 0, NULL, &flags);
     +
     +	if (r) {
    -+		if (config == FETCH_UPDATE_HEAD_MISSING) {
    -+			if (flags & REF_ISSYMREF)
    -+				/* already present */
    -+				return;
    -+		} else if (config == FETCH_UPDATE_HEAD_ALWAYS) {
    ++		if (!fetch_missing) {
     +			if (!strcmp(r, target))
     +				/* already up-to-date */
     +				return;
    -+		} else
    -+			/* should never happen */
    ++		} else if (flags & REF_ISSYMREF)
    ++			/* already present */
     +			return;
     +	}
     +
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
      	int must_list_refs = 1;
      	struct fetch_head fetch_head = { 0 };
      	struct strbuf err = STRBUF_INIT;
    -+	int need_update_head = 0, update_head_config = 0;
    ++	enum fetch_update_head update_head_config = FETCH_UPDATE_HEAD_DEFAULT;
      
      	if (tags == TAGS_DEFAULT) {
      		if (transport->remote->fetch_tags == 2)
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
     +			else
     +				update_head_config = fetch_update_head;
     +
    -+			need_update_head = update_head_config && update_head_config != FETCH_UPDATE_HEAD_NEVER;
    -+
    -+			if (need_update_head)
    ++			switch (update_head_config) {
    ++			case FETCH_UPDATE_HEAD_MISSING:
    ++			case FETCH_UPDATE_HEAD_ALWAYS:
     +				strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
    ++			default:
    ++				break;
    ++			}
      			refspec_ref_prefixes(&transport->remote->fetch,
      					     &transport_ls_refs_options.ref_prefixes);
     +		}
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
      
      	commit_fetch_head(&fetch_head);
      
    -+	if (need_update_head)
    -+		update_head(update_head_config, find_ref_by_name(remote_refs, "HEAD"), transport->remote);
    ++	switch (update_head_config) {
    ++	case FETCH_UPDATE_HEAD_MISSING:
    ++	case FETCH_UPDATE_HEAD_ALWAYS:
    ++		update_head(update_head_config == FETCH_UPDATE_HEAD_MISSING,
    ++			    find_ref_by_name(remote_refs, "HEAD"),
    ++			    transport->remote);
    ++	default:
    ++		break;
    ++	}
     +
      	if (set_upstream) {
      		struct branch *branch = branch_get("HEAD");
    @@ remote.c: static void read_branches_file(struct remote_state *remote_state,
      	remote->fetch_tags = 1; /* always auto-follow */
      }
      
    -+int parse_update_head(int *r, const char *var, const char *value)
    ++int parse_update_head(enum fetch_update_head *r, const char *var,
    ++		      const char *value)
     +{
    -+	if (!r)
    -+		return -1;
    -+	else if (!value)
    ++	if (!value)
     +		return config_error_nonbool(var);
     +	else if (!strcmp(value, "never"))
     +		*r = FETCH_UPDATE_HEAD_NEVER;
    @@ remote.h: enum {
      	REMOTE_BRANCHES
      };
      
    -+enum {
    ++enum fetch_update_head {
     +	FETCH_UPDATE_HEAD_DEFAULT = 0,
     +	FETCH_UPDATE_HEAD_NEVER,
     +	FETCH_UPDATE_HEAD_MISSING,
    @@ remote.h: struct remote {
      	int prune;
      	int prune_tags;
      
    -+	int update_head;
    ++	enum fetch_update_head update_head;
     +
      	/**
      	 * The configured helper programs to run on the remote side, for
    @@ remote.h: void apply_push_cas(struct push_cas_option *, struct remote *, struct
      char *relative_url(const char *remote_url, const char *url,
      		   const char *up_path);
      
    -+int parse_update_head(int *r, const char *var, const char *value);
    ++int parse_update_head(enum fetch_update_head *r, const char *var,
    ++		      const char *value);
     +
      #endif
     
2:  fe6d62510b ! 2:  5c0f48b9cc fetch: add support for HEAD update on mirrors
    @@ Commit message
         Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
     
      ## builtin/fetch.c ##
    -@@ builtin/fetch.c: static void update_head(int config, const struct ref *head, const struct remote
    +@@ builtin/fetch.c: static void update_head(int fetch_missing, const struct ref *head,
      	if (!head || !head->symref || !remote)
      		return;
      
    --	ref = apply_refspecs((struct refspec *)&remote->fetch, "refs/heads/HEAD");
    --	target = apply_refspecs((struct refspec *)&remote->fetch, head->symref);
    +-	ref = apply_refspecs(&remote->fetch, "refs/heads/HEAD");
    +-	target = apply_refspecs(&remote->fetch, head->symref);
     +	if (!remote->mirror) {
    -+		ref = apply_refspecs((struct refspec *)&remote->fetch, "refs/heads/HEAD");
    -+		target = apply_refspecs((struct refspec *)&remote->fetch, head->symref);
    ++		ref = apply_refspecs(&remote->fetch, "refs/heads/HEAD");
    ++		target = apply_refspecs(&remote->fetch, head->symref);
      
     -	if (!ref || !target) {
     -		warning(_("could not update remote head"));
-- 
2.40.0+fc1

