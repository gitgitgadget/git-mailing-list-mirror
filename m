Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41428C47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1943B61057
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhEaTxJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 15:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhEaTxH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 15:53:07 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BF7C061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:51:27 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso12036535otu.10
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8BMvOdCpnFxx2zm79TYtKr81BVe7Hzd24oILIHJCBJ4=;
        b=iteKooGu7jFeiwuUY6gcOCfV0oJhMgoVyioS/pMqfdN6BzV0wo1rN9/W5H6cKri0aF
         K54NNIZJ+zmMLIe5CiL08R/CtE3E5MwanUelUvLE/dlOXQY3okwWkPaO9f/PWZISsdlF
         q+CeVE5m/EFMriPvomuzfgouKOFsq8Tl6//RYGlOfI3KlgMhNU//SNJz7QxybpjvkYLh
         1GeoJSPSlzSoqwBkjEEFX8dfX9/LacHpZRntPHAzNPLD35odl5/er+yxJaPPP1flCV9D
         GaNvT/8Tbv/Sn319R3b6er47UyAmLTFOsHlBWYNHptKNlGqZmQilwKsVAuuGG6KvxzsR
         y+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8BMvOdCpnFxx2zm79TYtKr81BVe7Hzd24oILIHJCBJ4=;
        b=XAeXdh/650qOW/wLfmGlXGJdRDLbKIRKb7fgkwPpip6oL0rROCrorlDHoUwX+ChYer
         0MkHHP1nNuqOLUsoU+fhXZBTLDrGf7ryhAGpvHe6vJPLBzIK2ZNOJM/4iD1cqJ8h+hnE
         2D0Ezu30EWxAULT0tL44WAPgEu5l+xS3Dbsxtn3zuk1wFn7S4/x6FitCSF0dzS18H8xA
         EhnvYxBV851V0liCjOWRw3JaGoZyk9ovOsAD+btuT8UhgMllidzxV3xScxS+OKA5l92+
         xghQ/GJEU4CfyUb/b+LUcbGhqW/vE4rQEj5uzX8vPj6v6GqZqY0JDQ0F751TNiaTs9J5
         lBsg==
X-Gm-Message-State: AOAM530YoQvzLI/46+uwNlysZMqSVSnYhsf4CTP30xwYrIsDBf0Dbu7n
        yW60LeMqy6GhUqgFkQuvX4Ud38K1mr20+Q==
X-Google-Smtp-Source: ABdhPJyjidNYbXLsFbna3Dp7CWS1ls3acC8e4+oL+dmQOY1cyigrksM2xFdjirk+pMnByCmZ0eOqrw==
X-Received: by 2002:a05:6830:1155:: with SMTP id x21mr18127889otq.303.1622490686557;
        Mon, 31 May 2021 12:51:26 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id s6sm3233177otk.71.2021.05.31.12.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 12:51:26 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 00/13] push: revamp push.default
Date:   Mon, 31 May 2021 14:51:11 -0500
Message-Id: <20210531195124.218325-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210531193237.216726-1-felipe.contreras@gmail.com>
References: <20210531193237.216726-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series is the new second part of [1] and it's mostly a ton of
cleanups.

In theory there should be no functional changes.

Most of the changes since v1 are due to the fact that
s/!triangular/same_remote/ was done early in the previous series. Other
than that there's a few changes to the code and commit messages
suggested by Junio C Hamano.

The end result is almost identical to v1, only the way we get there
changes (plus there's an extra cosmetic break).

There's too many changes to list them all, it's much easier to see the
end result:

static const char *get_upstream_ref(struct branch *branch, const char *remote_name)
{
	if (!branch->merge_nr || !branch->merge || !branch->remote_name)
		die(_("The current branch %s has no upstream branch.\n"
		    "To push the current branch and set the remote as upstream, use\n"
		    "\n"
		    "    git push --set-upstream %s %s\n"),
		    branch->name,
		    remote_name,
		    branch->name);
	if (branch->merge_nr != 1)
		die(_("The current branch %s has multiple upstream branches, "
		    "refusing to push."), branch->name);

	return branch->merge[0]->src;
}

static void setup_default_push_refspecs(struct remote *remote)
{
	struct branch *branch;
	const char *dst;
	int same_remote;

	switch (push_default) {
	case PUSH_DEFAULT_MATCHING:
		refspec_append(&rs, ":");
		return;

	case PUSH_DEFAULT_NOTHING:
		die(_("You didn't specify any refspecs to push, and "
		    "push.default is \"nothing\"."));
		return;
	default:
		break;
	}

	branch = branch_get(NULL);
	if (!branch)
		die(_(message_detached_head_die), remote->name);

	dst = branch->refname;
	same_remote = !strcmp(remote->name, remote_for_branch(branch, NULL));

	switch (push_default) {
	default:
	case PUSH_DEFAULT_UNSPECIFIED:
	case PUSH_DEFAULT_SIMPLE:
		if (!same_remote)
			break;
		if (strcmp(branch->refname, get_upstream_ref(branch, remote->name)))
			die_push_simple(branch, remote);
		break;

	case PUSH_DEFAULT_UPSTREAM:
		if (!same_remote)
			die(_("You are pushing to remote '%s', which is not the upstream of\n"
			      "your current branch '%s', without telling me what to push\n"
			      "to update which remote branch."),
			    remote->name, branch->name);
		dst = get_upstream_ref(branch, remote->name);
		break;

	case PUSH_DEFAULT_CURRENT:
		break;
	}

	refspec_appendf(&rs, "%s:%s", branch->refname, dst);
}

[1] https://lore.kernel.org/git/20210531193237.216726-1-felipe.contreras@gmail.com

Felipe Contreras (13):
  push: create new get_upstream_ref() helper
  push: return immediately in trivial switch case
  push: split switch cases
  push: factor out null branch check
  push: only get the branch when needed
  push: make setup_push_* return the dst
  push: trivial simplifications
  push: get rid of all the setup_push_* functions
  push: factor out the typical case
  push: remove redundant check
  push: remove trivial function
  push: only check same_remote when needed
  push: don't get a full remote object

 builtin/push.c | 93 ++++++++++++++++++--------------------------------
 1 file changed, 34 insertions(+), 59 deletions(-)

Range-diff against v1:
 1:  9d9d800b11 !  1:  675528cf7a push: create new get_upstream_ref() helper
    @@ builtin/push.c: static const char message_detached_head_die[] =
      	   "    git push %s HEAD:<name-of-remote-branch>\n");
      
     -static void setup_push_upstream(struct remote *remote, struct branch *branch,
    --				int triangular)
    +-				int same_remote)
     +static const char *get_upstream_ref(struct branch *branch, const char *remote_name)
      {
     -	if (!branch)
    @@ builtin/push.c: static const char message_detached_head_die[] =
     +}
     +
     +static void setup_push_upstream(struct remote *remote, struct branch *branch,
    -+				int triangular)
    ++				int same_remote)
     +{
     +	const char *upstream_ref;
     +	if (!branch)
     +		die(_(message_detached_head_die), remote->name);
     +	upstream_ref = get_upstream_ref(branch, remote->name);
    - 	if (triangular)
    + 	if (!same_remote)
      		die(_("You are pushing to remote '%s', which is not the upstream of\n"
      		      "your current branch '%s', without telling me what to push\n"
      		      "to update which remote branch."),
    @@ builtin/push.c: static const char message_detached_head_die[] =
     @@ builtin/push.c: static void setup_push_simple(struct remote *remote, struct branch *branch, int
      		die(_(message_detached_head_die), remote->name);
      
    - 	if (!triangular) {
    + 	if (same_remote) {
     -		if (!branch->merge_nr || !branch->merge || !branch->remote_name)
     -			die(_("The current branch %s has no upstream branch.\n"
     -			    "To push the current branch and set the remote as upstream, use\n"
 2:  9d24821512 !  2:  dcbe8c53b5 push: return immediately in trivial switch case
    @@ builtin/push.c: static void setup_default_push_refspecs(struct remote *remote)
      
      	case PUSH_DEFAULT_UNSPECIFIED:
      	case PUSH_DEFAULT_SIMPLE:
    - 		setup_push_simple(remote, branch, triangular);
    + 		setup_push_simple(remote, branch, same_remote);
     -		break;
     +		return;
      
      	case PUSH_DEFAULT_UPSTREAM:
    - 		setup_push_upstream(remote, branch, triangular);
    + 		setup_push_upstream(remote, branch, same_remote);
     -		break;
     +		return;
      
 3:  160b8bee93 !  3:  55b227151f push: reorder switch cases
    @@ Metadata
     Author: Felipe Contreras <felipe.contreras@gmail.com>
     
      ## Commit message ##
    -    push: reorder switch cases
    +    push: split switch cases
     
         We want all the cases that don't do anything with a branch first, and
    -    then the rest.
    -
    -    Will help further patches.
    +    then the rest. That way we will be able to get the branch and die if
    +    there's a problem in the parent function, instead of inside the function
    +    of each mode.
     
         Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
     
      ## builtin/push.c ##
     @@ builtin/push.c: static void setup_default_push_refspecs(struct remote *remote)
    - 	int triangular = is_workflow_triangular(remote);
    + 	int same_remote = is_same_remote(remote);
      
      	switch (push_default) {
     -	default:
    @@ builtin/push.c: static void setup_default_push_refspecs(struct remote *remote)
     +		    "push.default is \"nothing\"."));
     +		return;
     +	default:
    ++		break;
     +	}
     +
     +	switch (push_default) {
     +	default:
      	case PUSH_DEFAULT_UNSPECIFIED:
      	case PUSH_DEFAULT_SIMPLE:
    - 		setup_push_simple(remote, branch, triangular);
    + 		setup_push_simple(remote, branch, same_remote);
     @@ builtin/push.c: static void setup_default_push_refspecs(struct remote *remote)
      	case PUSH_DEFAULT_CURRENT:
      		setup_push_current(remote, branch);
 4:  2b299e2e5a !  4:  4ea0ee4631 push: factor out null branch check
    @@ Commit message
     
      ## builtin/push.c ##
     @@ builtin/push.c: static void setup_push_upstream(struct remote *remote, struct branch *branch,
    - 				int triangular)
    + 				int same_remote)
      {
      	const char *upstream_ref;
     -	if (!branch)
     -		die(_(message_detached_head_die), remote->name);
      	upstream_ref = get_upstream_ref(branch, remote->name);
    - 	if (triangular)
    + 	if (!same_remote)
      		die(_("You are pushing to remote '%s', which is not the upstream of\n"
     @@ builtin/push.c: static void setup_push_upstream(struct remote *remote, struct branch *branch,
      
    @@ builtin/push.c: static void setup_push_upstream(struct remote *remote, struct br
      	refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);
      }
      
    - static void setup_push_simple(struct remote *remote, struct branch *branch, int triangular)
    + static void setup_push_simple(struct remote *remote, struct branch *branch, int same_remote)
      {
     -	if (!branch)
     -		die(_(message_detached_head_die), remote->name);
     -
    - 	if (!triangular) {
    + 	if (same_remote) {
      		const char *upstream_ref;
      
     @@ builtin/push.c: static void setup_default_push_refspecs(struct remote *remote)
    - 	default:
    + 		break;
      	}
      
     +	if (!branch)
 5:  4a721c99f1 !  5:  ae3d0dfdfe push: only get the branch when needed
    @@ Commit message
         Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
     
      ## builtin/push.c ##
    -@@ builtin/push.c: static int is_workflow_triangular(struct remote *remote)
    +@@ builtin/push.c: static int is_same_remote(struct remote *remote)
      
      static void setup_default_push_refspecs(struct remote *remote)
      {
     -	struct branch *branch = branch_get(NULL);
     +	struct branch *branch;
    - 	int triangular = is_workflow_triangular(remote);
    + 	int same_remote = is_same_remote(remote);
      
      	switch (push_default) {
     @@ builtin/push.c: static void setup_default_push_refspecs(struct remote *remote)
    - 	default:
    + 		break;
      	}
      
     +	branch = branch_get(NULL);
 6:  30d5c43c28 !  6:  9d9a9ebfbe push: make setup_push_* return the dst
    @@ Commit message
         push: make setup_push_* return the dst
     
         All of the setup_push_* functions are appending a refspec. Do this only
    -    once in the parent function.
    +    once on the parent function.
     
         Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
     
    @@ builtin/push.c: static const char *get_upstream_ref(struct branch *branch, const
      }
      
     -static void setup_push_upstream(struct remote *remote, struct branch *branch,
    --				int triangular)
    +-				int same_remote)
     +static const char *setup_push_upstream(struct remote *remote, struct branch *branch,
    -+	int triangular)
    ++	int same_remote)
      {
      	const char *upstream_ref;
      	upstream_ref = get_upstream_ref(branch, remote->name);
    @@ builtin/push.c: static void setup_push_upstream(struct remote *remote, struct br
     +	return branch->refname;
      }
      
    --static void setup_push_simple(struct remote *remote, struct branch *branch, int triangular)
    -+static const char *setup_push_simple(struct remote *remote, struct branch *branch, int triangular)
    +-static void setup_push_simple(struct remote *remote, struct branch *branch, int same_remote)
    ++static const char *setup_push_simple(struct remote *remote, struct branch *branch, int same_remote)
      {
    - 	if (!triangular) {
    + 	if (same_remote) {
      		const char *upstream_ref;
     @@ builtin/push.c: static void setup_push_simple(struct remote *remote, struct branch *branch, int
      		if (strcmp(branch->refname, upstream_ref))
    @@ builtin/push.c: static void setup_push_simple(struct remote *remote, struct bran
     +	return branch->refname;
      }
      
    - static int is_workflow_triangular(struct remote *remote)
    + static int is_same_remote(struct remote *remote)
     @@ builtin/push.c: static void setup_default_push_refspecs(struct remote *remote)
      {
      	struct branch *branch;
    - 	int triangular = is_workflow_triangular(remote);
    + 	int same_remote = is_same_remote(remote);
     +	const char *dst;
      
      	switch (push_default) {
    @@ builtin/push.c: static void setup_default_push_refspecs(struct remote *remote)
      	default:
      	case PUSH_DEFAULT_UNSPECIFIED:
      	case PUSH_DEFAULT_SIMPLE:
    --		setup_push_simple(remote, branch, triangular);
    +-		setup_push_simple(remote, branch, same_remote);
     -		return;
    -+		dst = setup_push_simple(remote, branch, triangular);
    ++		dst = setup_push_simple(remote, branch, same_remote);
     +		break;
      
      	case PUSH_DEFAULT_UPSTREAM:
    --		setup_push_upstream(remote, branch, triangular);
    +-		setup_push_upstream(remote, branch, same_remote);
     -		return;
    -+		dst = setup_push_upstream(remote, branch, triangular);
    ++		dst = setup_push_upstream(remote, branch, same_remote);
     +		break;
      
      	case PUSH_DEFAULT_CURRENT:
 7:  88cd2572a3 !  7:  f96581291a push: trivial simplifications
    @@ Commit message
      ## builtin/push.c ##
     @@ builtin/push.c: static const char *get_upstream_ref(struct branch *branch, const char *remote_na
      static const char *setup_push_upstream(struct remote *remote, struct branch *branch,
    - 	int triangular)
    + 	int same_remote)
      {
     -	const char *upstream_ref;
     -	upstream_ref = get_upstream_ref(branch, remote->name);
    - 	if (triangular)
    + 	if (!same_remote)
      		die(_("You are pushing to remote '%s', which is not the upstream of\n"
      		      "your current branch '%s', without telling me what to push\n"
      		      "to update which remote branch."),
    @@ builtin/push.c: static const char *get_upstream_ref(struct branch *branch, const
      static const char *setup_push_current(struct remote *remote, struct branch *branch)
     @@ builtin/push.c: static const char *setup_push_current(struct remote *remote, struct branch *bran
      
    - static const char *setup_push_simple(struct remote *remote, struct branch *branch, int triangular)
    + static const char *setup_push_simple(struct remote *remote, struct branch *branch, int same_remote)
      {
    --	if (!triangular) {
    +-	if (same_remote) {
     -		const char *upstream_ref;
     -
     -		upstream_ref = get_upstream_ref(branch, remote->name);
     -
     -		/* Additional safety */
     -		if (strcmp(branch->refname, upstream_ref))
    -+	if (!triangular)
    ++	if (same_remote)
     +		if (strcmp(branch->refname, get_upstream_ref(branch, remote->name)))
      			die_push_simple(branch, remote);
     -	}
 8:  e31eba87d8 !  8:  d0cedd5c81 push: get rid of all the setup_push_* functions
    @@ builtin/push.c: static const char *get_upstream_ref(struct branch *branch, const
      }
      
     -static const char *setup_push_upstream(struct remote *remote, struct branch *branch,
    --	int triangular)
    +-	int same_remote)
     -{
    --	if (triangular)
    +-	if (!same_remote)
     -		die(_("You are pushing to remote '%s', which is not the upstream of\n"
     -		      "your current branch '%s', without telling me what to push\n"
     -		      "to update which remote branch."),
    @@ builtin/push.c: static const char *get_upstream_ref(struct branch *branch, const
     -	return branch->refname;
     -}
     -
    --static const char *setup_push_simple(struct remote *remote, struct branch *branch, int triangular)
    +-static const char *setup_push_simple(struct remote *remote, struct branch *branch, int same_remote)
     -{
    --	if (!triangular)
    +-	if (same_remote)
     -		if (strcmp(branch->refname, get_upstream_ref(branch, remote->name)))
     -			die_push_simple(branch, remote);
     -	return branch->refname;
     -}
     -
    - static int is_workflow_triangular(struct remote *remote)
    + static int is_same_remote(struct remote *remote)
      {
      	struct remote *fetch_remote = remote_get(NULL);
     @@ builtin/push.c: static void setup_default_push_refspecs(struct remote *remote)
      	default:
      	case PUSH_DEFAULT_UNSPECIFIED:
      	case PUSH_DEFAULT_SIMPLE:
    --		dst = setup_push_simple(remote, branch, triangular);
    -+		if (!triangular)
    +-		dst = setup_push_simple(remote, branch, same_remote);
    ++		if (same_remote)
     +			if (strcmp(branch->refname, get_upstream_ref(branch, remote->name)))
     +				die_push_simple(branch, remote);
     +		dst = branch->refname;
      		break;
      
      	case PUSH_DEFAULT_UPSTREAM:
    --		dst = setup_push_upstream(remote, branch, triangular);
    -+		if (triangular)
    +-		dst = setup_push_upstream(remote, branch, same_remote);
    ++		if (!same_remote)
     +			die(_("You are pushing to remote '%s', which is not the upstream of\n"
     +			      "your current branch '%s', without telling me what to push\n"
     +			      "to update which remote branch."),
 9:  d5f60ad791 !  9:  47bbad5a47 push: factor out the typical case
    @@ builtin/push.c: static void setup_default_push_refspecs(struct remote *remote)
      	default:
      	case PUSH_DEFAULT_UNSPECIFIED:
      	case PUSH_DEFAULT_SIMPLE:
    --		if (!triangular)
    +-		if (same_remote)
     -			if (strcmp(branch->refname, get_upstream_ref(branch, remote->name)))
     -				die_push_simple(branch, remote);
     -		dst = branch->refname;
    -+		if (triangular)
    ++		if (!same_remote)
     +			break;
     +		if (strcmp(branch->refname, get_upstream_ref(branch, remote->name)))
     +			die_push_simple(branch, remote);
10:  e1945bb451 <  -:  ---------- push: remove redundant check
11:  93f8b38364 <  -:  ---------- push: fix Yoda condition
12:  cdf961d231 <  -:  ---------- push: remove trivial function
 -:  ---------- > 10:  6a8e30bf38 push: remove redundant check
 -:  ---------- > 11:  976d7b9f3a push: remove trivial function
13:  e5e55c00e7 ! 12:  d9df139855 push: only get triangular when needed
    @@ Metadata
     Author: Felipe Contreras <felipe.contreras@gmail.com>
     
      ## Commit message ##
    -    push: only get triangular when needed
    +    push: only check same_remote when needed
     
         Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
     
    @@ builtin/push.c: static const char *get_upstream_ref(struct branch *branch, const
      static void setup_default_push_refspecs(struct remote *remote)
      {
      	struct branch *branch;
    --	int triangular = remote != remote_get(NULL);
    +-	int same_remote = remote == remote_get(NULL);
      	const char *dst;
    -+	int triangular;
    ++	int same_remote;
      
      	switch (push_default) {
      	case PUSH_DEFAULT_MATCHING:
    @@ builtin/push.c: static void setup_default_push_refspecs(struct remote *remote)
      		die(_(message_detached_head_die), remote->name);
      
      	dst = branch->refname;
    -+	triangular = remote != remote_get(NULL);
    ++	same_remote = remote == remote_get(NULL);
      
      	switch (push_default) {
      	default:
14:  2fd84a4312 ! 13:  ffc52d649c push: don't get a full remote object
    @@ Metadata
      ## Commit message ##
         push: don't get a full remote object
     
    -    All we need to know is that their names are different.
    +    All we need to know is that their names are the same.
    +
    +    Additionally this might be easier to parse for some since
    +    remote_for_branch is more descriptive than remote_get(NULL).
     
         Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
     
    @@ builtin/push.c: static void setup_default_push_refspecs(struct remote *remote)
      		die(_(message_detached_head_die), remote->name);
      
      	dst = branch->refname;
    --	triangular = remote != remote_get(NULL);
    -+	triangular = strcmp(remote->name, remote_for_branch(branch, NULL));
    +-	same_remote = remote == remote_get(NULL);
    ++	same_remote = !strcmp(remote->name, remote_for_branch(branch, NULL));
      
      	switch (push_default) {
      	default:
15:  2a203239e4 <  -:  ---------- push: rename !triangular to same_remote
-- 
2.32.0.rc0

