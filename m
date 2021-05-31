Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B91C47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98017610A6
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhEaTe0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 15:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbhEaTeY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 15:34:24 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB08BC061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:32:42 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so11996980oth.8
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GT8tfy0AQyCshFG0vvn7WcqzZhxyDS38+V18voQEWQs=;
        b=BtoMhlGCvaV7yFsuq5vSFiiy+rh1Vildg1PKo97urWiNK2hsYIPbIIfGd10XDtKCGA
         u3efHZ7TpB1PoyHfooNbE5Nr4pL8/no/natHAczTHeQMJNvL+pDAbFQrvO3SccmZnCGq
         7mYVOlcd+L8vTUwCFHcNuCouWYOp35Vm797NRav/pgdMS06Vp79TKX8NT96sl2noD3Dt
         2/sIXgN+sSsgmIVwGxXl7V27NAt1uK3Q5d8txnBJZEqPgSHzbfzcEOx8SpW8+jKYXWP8
         H94/F+N6XFFqLGgRDLmCf2sMWgci0O0mNoRLf5VDnyknWJ3G/wTr0nlnQYdvnX7tDeF/
         DYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GT8tfy0AQyCshFG0vvn7WcqzZhxyDS38+V18voQEWQs=;
        b=tzjq71OnFarnRCu6a8g9x/KBqmnnelikAKE2471y0dFogwYAge/s4lGiPda0SXdDtC
         VBFjdu/m0ND175SfXgsLPRBfIOqCsXdrZoXSSFebMh8nB+YQ9cDa9Q3CY9Y/EuBtm9GC
         ZU5a79OVd2ZmOc64bbre4rlSNOlnJhT4it/NSosm+QWVHcYASiFPMQOrsoGJ6jJYBOEl
         Im3NJaPOp4YlsIorIk3smESoMV2/3sefOnaiJ9jWumFfg+XHECeKOgzYWmjdr+JmdqvP
         WZ9c02lh7IaA2j6QkHME19aSLtOInKbOskKPjVP8naF6zQiQFinPRcoFLd12wSQLmn5a
         7Wbw==
X-Gm-Message-State: AOAM533j6VjdOVrLSZaX9bTpN0U5IWoaJVQqclPdFE1aEkl/t2/VIbeF
        cUWbVeth4+Jk+NF7bdOb4fQ9jPoshPMnMg==
X-Google-Smtp-Source: ABdhPJye5tlTlwEWDvdtCHJE7gzQdi3Bmbh32gKv1IVft57qcYuyne9TJyle9QRYJooc2CTUVJL/jw==
X-Received: by 2002:a05:6830:10c9:: with SMTP id z9mr18869362oto.275.1622489561721;
        Mon, 31 May 2021 12:32:41 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id k18sm3469190otj.42.2021.05.31.12.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 12:32:38 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 0/7] Unconvolutize push.default=simple
Date:   Mon, 31 May 2021 14:32:30 -0500
Message-Id: <20210531193237.216726-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tired of jumping through hoops trying to understand what the "simple"
mode does, I decided to reorganize it up for good so it's crystal
clear.

There are no functional changes.

Basically the simple mode pushes the current branch with the same name
on the remote.

Except... when there's no upstream branch configured with the same name.

Now the code and the documentation are clear.

The difference from v2 is that now triangular is renamed to same_remote in the very first patch.
That way the rest of both series are easier to digest.

Unfortunately the first patch is a little noisy, and the same with the rangediff. That might be a
small price to pay to make the rest easier.

The result of this series is in short this function:

static void setup_push_simple(struct remote *remote, struct branch *branch, int same_remote)
{
	if (!branch)
		die(_(message_detached_head_die), remote->name);

	if (same_remote) {
		if (!branch->merge_nr || !branch->merge || !branch->remote_name)
			die(_("The current branch %s has no upstream branch.\n"
			    "To push the current branch and set the remote as upstream, use\n"
			    "\n"
			    "    git push --set-upstream %s %s\n"),
			    branch->name,
			    remote->name,
			    branch->name);
		if (branch->merge_nr != 1)
			die(_("The current branch %s has multiple upstream branches, "
			    "refusing to push."), branch->name);

		/* Additional safety */
		if (strcmp(branch->refname, branch->merge[0]->src))
			die_push_simple(branch, remote);
	}
	refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);
}

Felipe Contreras (7):
  push: rename !triangular to same_remote
  push: hedge code of default=simple
  push: copy code to setup_push_simple()
  push: reorganize setup_push_simple()
  push: simplify setup_push_simple()
  push: remove unused code in setup_push_upstream()
  doc: push: explain default=simple correctly

 Documentation/config/push.txt | 13 +++++-----
 builtin/push.c                | 48 +++++++++++++++++++++++------------
 2 files changed, 38 insertions(+), 23 deletions(-)

Range-diff against v2:
1:  f1f42bda32 < -:  ---------- push: hedge code of default=simple
-:  ---------- > 1:  e8efe0d844 push: rename !triangular to same_remote
-:  ---------- > 2:  f84aa09a93 push: hedge code of default=simple
2:  bb6d810011 ! 3:  7d04af5b2c push: move code to setup_push_simple()
    @@ Metadata
     Author: Felipe Contreras <felipe.contreras@gmail.com>
     
      ## Commit message ##
    -    push: move code to setup_push_simple()
    +    push: copy code to setup_push_simple()
     
         In order to avoid doing unnecessary things and simplify it in further
    -    patches.
    +    patches. In particular moving the additional name safety out of
    +    setup_push_upstream() and into setup_push_simple() and thus making both
    +    more straightforward.
     
         The code is copied exactly as-is; no functional changes.
     
    @@ Commit message
      ## builtin/push.c ##
     @@ builtin/push.c: static void setup_push_current(struct remote *remote, struct branch *branch)
      
    - static void setup_push_simple(struct remote *remote, struct branch *branch, int triangular)
    + static void setup_push_simple(struct remote *remote, struct branch *branch, int same_remote)
      {
    --	if (triangular)
    +-	if (!same_remote)
     -		setup_push_current(remote, branch);
     -	else
    --		setup_push_upstream(remote, branch, triangular, 1);
    -+	if (triangular) {
    +-		setup_push_upstream(remote, branch, same_remote, 1);
    ++	if (!same_remote) {
     +		if (!branch)
     +			die(_(message_detached_head_die), remote->name);
     +		refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);
    @@ builtin/push.c: static void setup_push_current(struct remote *remote, struct bra
     +		if (branch->merge_nr != 1)
     +			die(_("The current branch %s has multiple upstream branches, "
     +			    "refusing to push."), branch->name);
    -+		if (triangular)
    ++		if (!same_remote)
     +			die(_("You are pushing to remote '%s', which is not the upstream of\n"
     +			      "your current branch '%s', without telling me what to push\n"
     +			      "to update which remote branch."),
    @@ builtin/push.c: static void setup_push_current(struct remote *remote, struct bra
     +	}
      }
      
    - static int is_workflow_triangular(struct remote *remote)
    + static int is_same_remote(struct remote *remote)
3:  d66a442fba ! 4:  5e0e09bc7a push: reorganize setup_push_simple()
    @@ Commit message
         push: reorganize setup_push_simple()
     
         Simply move the code around and remove dead code. In particular the
    -    'trivial' conditional is a no-op since that part of the code is the
    -    !trivial leg of the conditional beforehand.
    +    '!same_remote' conditional is a no-op since that part of the code is the
    +    same_remote leg of the conditional beforehand.
     
         No functional changes.
     
    @@ Commit message
      ## builtin/push.c ##
     @@ builtin/push.c: static void setup_push_current(struct remote *remote, struct branch *branch)
      
    - static void setup_push_simple(struct remote *remote, struct branch *branch, int triangular)
    + static void setup_push_simple(struct remote *remote, struct branch *branch, int same_remote)
      {
     +	const char *dst;
     +
     +	if (!branch)
     +		die(_(message_detached_head_die), remote->name);
     +
    - 	if (triangular) {
    + 	if (!same_remote) {
     -		if (!branch)
     -			die(_(message_detached_head_die), remote->name);
     -		refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);
    @@ builtin/push.c: static void setup_push_simple(struct remote *remote, struct bran
      		if (branch->merge_nr != 1)
      			die(_("The current branch %s has multiple upstream branches, "
      			    "refusing to push."), branch->name);
    --		if (triangular)
    +-		if (!same_remote)
     -			die(_("You are pushing to remote '%s', which is not the upstream of\n"
     -			      "your current branch '%s', without telling me what to push\n"
     -			      "to update which remote branch."),
    @@ builtin/push.c: static void setup_push_simple(struct remote *remote, struct bran
     +	refspec_appendf(&rs, "%s:%s", branch->refname, dst);
      }
      
    - static int is_workflow_triangular(struct remote *remote)
    + static int is_same_remote(struct remote *remote)
4:  eaae6a826a ! 5:  723d95b572 push: simplify setup_push_simple()
    @@ Metadata
      ## Commit message ##
         push: simplify setup_push_simple()
     
    -    There's a safety check to make sure branch->refname is not different
    +    There's a safety check to make sure branch->refname isn't different
         from branch->merge[0]->src, otherwise we die().
     
         Therefore we always push to branch->refname.
    @@ Commit message
      ## builtin/push.c ##
     @@ builtin/push.c: static void setup_push_current(struct remote *remote, struct branch *branch)
      
    - static void setup_push_simple(struct remote *remote, struct branch *branch, int triangular)
    + static void setup_push_simple(struct remote *remote, struct branch *branch, int same_remote)
      {
     -	const char *dst;
     -
      	if (!branch)
      		die(_(message_detached_head_die), remote->name);
      
    --	if (triangular) {
    +-	if (!same_remote) {
     -		dst = branch->refname;
     -	} else {
    -+	if (!triangular) {
    ++	if (same_remote) {
      		if (!branch->merge_nr || !branch->merge || !branch->remote_name)
      			die(_("The current branch %s has no upstream branch.\n"
      			    "To push the current branch and set the remote as upstream, use\n"
    @@ builtin/push.c: static void setup_push_simple(struct remote *remote, struct bran
     +	refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);
      }
      
    - static int is_workflow_triangular(struct remote *remote)
    + static int is_same_remote(struct remote *remote)
5:  8d9ae5e552 ! 6:  8ffaacd0db push: remove unused code in setup_push_upstream()
    @@ builtin/push.c: static const char message_detached_head_die[] =
      	   "    git push %s HEAD:<name-of-remote-branch>\n");
      
      static void setup_push_upstream(struct remote *remote, struct branch *branch,
    --				int triangular, int simple)
    -+				int triangular)
    +-				int same_remote, int simple)
    ++				int same_remote)
      {
      	if (!branch)
      		die(_(message_detached_head_die), remote->name);
    @@ builtin/push.c: static void setup_default_push_refspecs(struct remote *remote)
      		break;
      
      	case PUSH_DEFAULT_UPSTREAM:
    --		setup_push_upstream(remote, branch, triangular, 0);
    -+		setup_push_upstream(remote, branch, triangular);
    +-		setup_push_upstream(remote, branch, same_remote, 0);
    ++		setup_push_upstream(remote, branch, same_remote);
      		break;
      
      	case PUSH_DEFAULT_CURRENT:
6:  b35bdf14dc = 7:  3cc20c876f doc: push: explain default=simple correctly
-- 
2.32.0.rc0

