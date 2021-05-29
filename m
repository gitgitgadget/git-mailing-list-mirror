Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E249C4708E
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E89D61222
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhE2Hqj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 03:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhE2Hqi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 03:46:38 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2FFC061574
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:45:01 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id t24so6698256oiw.3
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3KBxarlnhisGQT6GQ+zEcV9Liq3IxjOXf25xZpuOH2I=;
        b=CZddDkSX3gnzXO83gKWkE0VLiV0bnxu4o++Z75zhJNruCKJ+rhR4rt2YcKX+CG94IL
         IWX12dS6ojtxicFW0Q1YEUQLuly+6jnudhSxYzpVSQ0GDblywB8IeqPV7gSvqSAENcP2
         WtlEWsGNGWz4s1RcqU0tLPEA585odleapAYF9vNLv71EoiEV2hI5C20p/HCpHv6Idhor
         2THvx+XWbSqD5rKhNG3+8ewNYueTcMXJlrSYr3TFEZNEJ1ARJxpCEL41A8H8uSTlokuu
         +zVOCP8tGvXTUknR6Z6KK0MBZ0XSkkEd117DHO3BvUcKXPSHG50ILX63dCLxE/grnXge
         mZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3KBxarlnhisGQT6GQ+zEcV9Liq3IxjOXf25xZpuOH2I=;
        b=P0VDpct9Z+dlTmWk4T68sNEYD+KQ1RtWNbQ2wPMw7saMu40WwlZbXvvzGPAaJu9iW8
         yV9HfaNo1OhH4c0A29wHoPACXFq75t1e4+8W0Xd0sCglMTcseJEuAG4udshcuVV3fWam
         pgcRsbuiHXlSdERTkCTmvQutxhPBux+4mfNX1it3Syp9zManfH9420zgdlwUwdTOpzHm
         NsvzwJVjxxjB9r2+BQJbKo5W029vB7oZek28ZIMF3t8bs5tvZnjzMZ4nxWSaJ6fxikh4
         KJshmK5NeV/cPUmsN1RlEYX8t//5IITpGU1qsm5/xhTxGxlzARhWuBlX6gE9kTQNRriA
         XU2Q==
X-Gm-Message-State: AOAM531wUGrJIHsZeH4kVmoDqMvKAfBDPUGi76E+vLY795b0Ysek8NdJ
        VzFAE7+qDutH0holMZBmApEolO05BmqmtQ==
X-Google-Smtp-Source: ABdhPJwq/ObpzeEX2FTk5dsCvt8XOj/bTW8LFeeJrZSVZWhiiwWVs5CHfxsfX61T9KUbGfi58ikSWA==
X-Received: by 2002:aca:d409:: with SMTP id l9mr8544947oig.77.1622274299985;
        Sat, 29 May 2021 00:44:59 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id f2sm1627763otp.77.2021.05.29.00.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 00:44:59 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 00/15] push: revamp push.default
Date:   Sat, 29 May 2021 02:44:43 -0500
Message-Id: <20210529074458.1916817-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210529071115.1908310-1-felipe.contreras@gmail.com>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series is the new second part of [1].

It borrows a few patches from v1, but it's mostly a ton of cleanups.

In theory there should be no functional changes.

There's too many changes to list them all, it's much easier to see the result:


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

[1] https://lore.kernel.org/git/20210529071115.1908310-1-felipe.contreras@gmail.com/

Felipe Contreras (15):
  push: create new get_upstream_ref() helper
  push: return immediately in trivial switch case
  push: reorder switch cases
  push: factor out null branch check
  push: only get the branch when needed
  push: make setup_push_* return the dst
  push: trivial simplifications
  push: get rid of all the setup_push_* functions
  push: factor out the typical case
  push: remove redundant check
  push: fix Yoda condition
  push: remove trivial function
  push: only get triangular when needed
  push: don't get a full remote object
  push: rename !triangular to same_remote

 builtin/push.c | 92 ++++++++++++++++++--------------------------------
 1 file changed, 33 insertions(+), 59 deletions(-)

-- 
2.32.0.rc0

