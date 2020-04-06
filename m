Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970F0C2BA17
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 17:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7229C20753
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 17:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n/wllWZv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgDFR5X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:57:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52871 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgDFR5W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 13:57:22 -0400
Received: by mail-wm1-f65.google.com with SMTP id t203so322465wmt.2
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 10:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sZS83iOYxjgyY02d4Q32PJ4wfqfG1MypzwVQGLyPijs=;
        b=n/wllWZvkrebmtGHAIdOIMMAwE59e1itC/qNYa8SVbSn+38eSrI3oUx30KP6cnCFuT
         Bb52L8EQHYla6fX2yF/rEsIuEcKPnirJ+suKgQzZ4EU5t4XUXHvaVZbOwz4XsvZ9sqr6
         Q7l1u7uwpISXiQEe8poPCN7H8FbvzUgu9hrUUs1xqoUvx1imrkuGVnEQos2ZFNAGNLlk
         sBYJ8NPLyGEKAQ9LDT3lq52mLmYh4Z1z3knvAljA0rZY0+9lTSTjMe4sfrWYg+/oqEPx
         nmIjyTQOQIdK4zeS4WeL6xI5L8kLTxo0TvWXo2ezz9eD600fM+NA4v5phi7iNJnK9GfR
         Kcnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sZS83iOYxjgyY02d4Q32PJ4wfqfG1MypzwVQGLyPijs=;
        b=bZTl4Hq348rQXo3xuTpKTR2VXg/YXmvvoraszbWC17qN9anPs6BhxOxlmcGYP79RdO
         Gx7eGP6CJhowd8k6pOxjLRuMFi5KaNgzviSXx+DYaNhR46/daQzhhogVY1qdGWl65Gng
         6EYLNeUWPGh/eQq4QnoGqBNQylrWXIWj+ImiGt8dIwcswiUrSNife9w5ptG67hC5mSlP
         x1NtQOHPH0UMUADjWEcV/i0aJ3uqa7rSSfVS1r6FsJ0gdm0ThnVlPeWpNHVeX+Yi0LMP
         WCtsAz6EjGVSOMIWkYmItA6y/qb6wmcx7XUUy3SCru6qRLkxm0gk3rDfXU6UbS/PoOU2
         vl3A==
X-Gm-Message-State: AGi0Pube4QnQuQkNAcr2KdCtnB7/PcWM+eWh6oIoczs3nezoPVBSNXaw
        seQAWYmYgesdpv/lkLfJrmTaqgoSzHk=
X-Google-Smtp-Source: APiQypIZUHt3WDh1OyLsuWZO8U3bAXXEAjoeG2/yhNFuxFgCeYdLs5ZNUBZ1YlwbAVb3Yu1vCYHL+w==
X-Received: by 2002:a05:600c:2a52:: with SMTP id x18mr192542wme.37.1586195838974;
        Mon, 06 Apr 2020 10:57:18 -0700 (PDT)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id j10sm10465041wru.85.2020.04.06.10.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 10:57:18 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [RFC PATCH v4 0/2] %(push) and %(push:remoteref) bug fixes
Date:   Mon,  6 Apr 2020 19:56:46 +0200
Message-Id: <20200406175648.25737-1-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200312164558.2388589-1-damien.olivier.robert+git@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fix several bugs in for-each-ref for %(push) and %(push:remoteref), as
explained in the commit messages.

Note that there are still several bugs:
- the memory leak mentioned by Jeff in
  https://public-inbox.org/git/20200328131553.GA643242@coredump.intra.peff.net/

- in my patch, to detect if the workflow is triangular, I use:

static int is_workflow_triangular(struct branch *branch)
{
	struct remote *fetch_remote = remote_get(remote_for_branch(branch, NULL));
	struct remote *push_remote = remote_get(pushremote_for_branch(branch, NULL));
	return (fetch_remote && push_remote && fetch_remote != push_remote);
}

But remote_get will always fallback to 'origin'. So this means that if we
set up a pushRemote="foobar" and no 'remote', the workflow is detected as
triangular.

Whereas in `git push`, this workflow will not be detected as triangular.

=> So I can check that by looking at *explicit, but I actually have a
question about what constitutes a triangular workflow, hence the RFC.

Furthermore, the upstream (and simple in non triangular workflow) case of
%(push) and (push:remoteref) are essentially via `branch_get_upstream`, which
is also used for %(upstream):

	branch && branch->merge && branch->merge[0] &&
		    	    branch->merge[0]->dst)

but `git push` does different checks:

	if (!branch->merge_nr || !branch->merge || !branch->remote_name)
		die(_("The current branch %s has no upstream branch.\n"...
	if (branch->merge_nr != 1)
		die(_("The current branch %s has multiple upstream branches, "
		    "refusing to push."), branch->name);

in particular git push fails if merge_nr !=1 or if branch has no remote,
whereas %(push) will still indicates a push branch (assuming I fix
is_workflow_triangular).

So I'll need to add a `branch_get_push` with these checks instead.

So I first send this patch as an RFC, and I'll see how to proceed
afterwards to handle these remaining corner cases.
Luckily, having a pushRemote but no remote, or several merge in the branch
config are probably not too common.

=> So one question I have first is about the case when we do have a
branch.pushRemote but not a branch.remote.
Should this still be considered a triangular workflow?

According to git-push, no:

	static int is_workflow_triangular(struct remote *remote)
	{
		struct remote *fetch_remote = remote_get(NULL);
		return (fetch_remote && fetch_remote != remote);
	}

but I would argue that we should.

This would change nothing for push.default=upstream, since currently we
check that `branch` has a remote_name in `setup_push_upstream` so it fails
anyway even if the workflow is not explicitly triangular, but this would
make push.default=simple behave as current, exactly as when branch.remote
is different from branch.pushRemote (and I would argue that no
branch.remote is a particular case of this situation).


PS: the first patch has no tests because I add them in the second patch, it
is more convenient to add them at once and test both patches.

PPS: v4 and v5 are intermediate versions I made but did not send to the ML.


Damien Robert (2):
  remote.c: fix %(push) for triangular workflows
  remote.c: fix handling of %(push:remoteref)

 remote.c                | 139 ++++++++++++++++++++++++++++++----------
 t/t6300-for-each-ref.sh |  81 +++++++++++++++++++++--
 2 files changed, 180 insertions(+), 40 deletions(-)

-- 
Patched on top of v2.26.0-106-g9fadedd637 (git version 2.26.0)

