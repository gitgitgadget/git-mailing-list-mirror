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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6607C4708F
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B1836124B
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhE2HM6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 03:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhE2HMz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 03:12:55 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DFAC061574
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:11:18 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id u11so6644408oiv.1
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=myVhw3X5zCCOIa0UGIMNhNiQtJGSZVe2usBMGm2PebY=;
        b=U1Fn5C4xZmJ1xhCRv5VyT9MOty1srkwCFztjQ/UK6QOd8Y7UlJk/xyk3Y17qdh4+nD
         wDx+l48sCgEQkuuvqXBk5xvzbWEeSzxgD3O+oz61g0+Npw3ea8pH13ty7MIOswFFaZO/
         AZKt18MnljzCniad1rPixzkk2Au8zCqGvFBCWEE5qPSl0AKgBsG5+fUS2Taj9syKA2oP
         V7z5yjsBCSrgUId+5WNrxE80SLHhJfjCwtXr8eR8SEDuG27wLqWry3siC6SlGspqa3Yo
         Q1yt7vLJ7BNWuD0Sra243L4SkiJ3ui67fUNuxhUYMqh75ZJ6htKauQhLQ7IWzfgj7UYz
         flcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=myVhw3X5zCCOIa0UGIMNhNiQtJGSZVe2usBMGm2PebY=;
        b=F5IEn7v9AQ03QzSzieHbi5mKrWJ/Xi9P+AQH8XVZj1zsvhvNRMON8+P9JINw4halYp
         w/Wr9uZp5bEP7Ce91rZPYdqiKFX10Lrw696Hsj7nWKqbPeidOBln4/GZWsznZ1ExpysN
         XA+Jnw7JEonKwztX4kjT5drnhq8y1qcqoJVX+ReP9+buKahuWvfMYCGdA4FsjJpJMVPp
         12I5U2uanClRZ6x9yT9mL4o7taAIOX+dtoogECuQ3RlMTTEZL5FovMpTdpTxLsMl6npU
         SjHMWrb2TPTDmJWXe5UyQMXLApfks+IKVkyxvWzdqMmyKlV4yy2L4ObGSdZwyg2l+eTE
         TIeQ==
X-Gm-Message-State: AOAM533HAL5o908nORcdByIrcnMyyGyKrxB04pvCfO4Ydir5rayJ/kR0
        r/JkBpABk6Uv78Vjl46VUe75ovoG8qyUEw==
X-Google-Smtp-Source: ABdhPJzHPDIH0c9VGB891TD47G79u8WUy+ZeD4IQ3lqkSGBk9zQSBlb+lPqozgmyRcUmo/ZvhEeJVg==
X-Received: by 2002:aca:1e07:: with SMTP id m7mr8343754oic.28.1622272277393;
        Sat, 29 May 2021 00:11:17 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id z28sm1338397ooz.45.2021.05.29.00.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 00:11:17 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Mathias Kunter <mathiaskunter@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/6] Unconvolutize push.default=simple
Date:   Sat, 29 May 2021 02:11:09 -0500
Message-Id: <20210529071115.1908310-1-felipe.contreras@gmail.com>
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

This is basically the same as v1, except I removed a bunch of patches which are now part of a
different series. Also, I updated some commit messages with suggestions from Elijah Newren.

The result of this series is in short this function:

static void setup_push_simple(struct remote *remote, struct branch *branch, int triangular)
{
	if (!branch)
		die(_(message_detached_head_die), remote->name);

	if (!triangular) {
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

Felipe Contreras (6):
  push: hedge code of default=simple
  push: move code to setup_push_simple()
  push: reorganize setup_push_simple()
  push: simplify setup_push_simple()
  push: remove unused code in setup_push_upstream()
  doc: push: explain default=simple correctly

 Documentation/config/push.txt | 13 ++++++------
 builtin/push.c                | 40 ++++++++++++++++++++++++-----------
 2 files changed, 34 insertions(+), 19 deletions(-)

Range-diff against v1:
 1:  2856711eb3 !  1:  f1f42bda32 push: hedge code of default=simple
    @@ Commit message
         `simple` is the most important mode so move the relevant code to its own
         function to make it easier to see what it's doing.
     
    +    Reviewed-by: Elijah Newren <newren@gmail.com>
         Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
     
      ## builtin/push.c ##
 2:  33acb09e82 !  2:  bb6d810011 push: move code to setup_push_simple()
    @@ Commit message
     
         The code is copied exactly as-is; no functional changes.
     
    +    Reviewed-by: Elijah Newren <newren@gmail.com>
         Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
     
      ## builtin/push.c ##
 3:  de1b621b7e !  3:  d66a442fba push: reorganize setup_push_simple()
    @@ Metadata
      ## Commit message ##
         push: reorganize setup_push_simple()
     
    -    Simply move the code around.
    +    Simply move the code around and remove dead code. In particular the
    +    'trivial' conditional is a no-op since that part of the code is the
    +    !trivial leg of the conditional beforehand.
     
         No functional changes.
     
    +    Suggestions-by: Elijah Newren <newren@gmail.com>
         Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
     
      ## builtin/push.c ##
 4:  83efcad143 !  4:  eaae6a826a push: simplify setup_push_simple()
    @@ Metadata
      ## Commit message ##
         push: simplify setup_push_simple()
     
    -    branch->refname can never be different from branch->merge[0]->src.
    +    There's a safety check to make sure branch->refname is not different
    +    from branch->merge[0]->src, otherwise we die().
     
    +    Therefore we always push to branch->refname.
    +
    +    Suggestions-by: Elijah Newren <newren@gmail.com>
         Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
     
      ## builtin/push.c ##
 5:  d7489e9545 =  5:  8d9ae5e552 push: remove unused code in setup_push_upstream()
 6:  e693341403 <  -:  ---------- push: merge current and simple
 7:  830a57c867 <  -:  ---------- push: remove redundant check
 8:  d2dded5998 <  -:  ---------- push: fix Yoda condition
 9:  7528738091 <  -:  ---------- push: remove trivial function
10:  1ae0546df6 <  -:  ---------- push: flip !triangular for centralized
11:  3acd42e385 !  6:  b35bdf14dc doc: push: explain default=simple correctly
    @@ Metadata
      ## Commit message ##
         doc: push: explain default=simple correctly
     
    -    Now that the code has been unconvolutized and it's clear what it's
    +    Now that the code has been simplified and it's clear what it's
         actually doing, update the documentation to reflect that.
     
         Namely; the simple mode only barfs when working on a centralized
-- 
2.32.0.rc0

