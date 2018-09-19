Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 739F61F453
	for <e@80x24.org>; Wed, 19 Sep 2018 14:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731704AbeISTse (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 15:48:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40650 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbeISTse (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 15:48:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id y8-v6so2314648wrh.7
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 07:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lQH1jxe4hCAa/hRlXy6WzGfvdrHX07ed3kEnYYBne1Q=;
        b=NMqz8px2MnxJKJ8BLtIKRrWWKLB+8ZaUujWItXF/tFHy8da4X5PG7rHXh2rULqcf3D
         eB39CdFsxHkzsS3Rtpcj67Ohn7oNXvaEd1O79+yCSh4nsyCzttsh5vnbJ+LUvqcuXZuD
         3OHm8CQfF067HWuwlLBuRcR3MYlcvb8DORGbSqXZFLtk7xAD3nQeuOew3UvMLk7cm2iI
         6a22gFiDJ8FhjEevBjsK+K0iQNkg2Tu60MdZA/+k1ejkP3MxDMf0I9YU25Z1POqIna/w
         +Fk3oWVN9lKGBTi2Dg8Qsv+WIkPZVEGDzAfBjDzYdagDLNPy3Ubshz7EuL0gPaKFRQNo
         WFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lQH1jxe4hCAa/hRlXy6WzGfvdrHX07ed3kEnYYBne1Q=;
        b=F7IjSNenBg7fQsAC++cKZqjNMF44KJlWlWzmZmUm47hChdjAw3e+FO2dy+/q7ub1sV
         s6s4B2q9u/FesQpTpdVcq4K/VX3Hy3nsVkfYuKn3elP7CE8FxOGU5nGcNeuPBlV7A4dA
         YHlKLdsfhUOdnv86izBG48dzpKzC5lLZn2AERmWOGqWr6yt4VpImJS8WYgoJav6vWZUO
         xeTyTz9MtTjwH9SsqzoTg7dSaq23w1kP3pxWgdtNDBf3Bt+9BYSeWBakHbkmWlULMXPU
         Z2o2olgCnA3+30ihK4ZoV6mS3PxbKP5XaCvFu68Mnds65EUCEBGn+RIa9DsRafb2R95N
         AKMg==
X-Gm-Message-State: APzg51CnlncJg/1rqqTDrL2pia3R+wR0uuQvanyv2v30BGuL49PVOwxR
        NF4FFXLU6s1NSwXtsTgBJ83VNvwBdZ0=
X-Google-Smtp-Source: ANB0VdaXdZDurF9r06h46bxpYUXh9gdRWwrOnv3k3sNqzEOG9X+EHlOzHnKHUMHIq2DPCL+eh9FfNw==
X-Received: by 2002:adf:ec05:: with SMTP id x5-v6mr28565342wrn.266.1537366226693;
        Wed, 19 Sep 2018 07:10:26 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 184-v6sm7794262wmv.6.2018.09.19.07.10.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 07:10:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] reflog expire: add progress output
Date:   Wed, 19 Sep 2018 14:10:16 +0000
Message-Id: <20180919141016.27930-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before this change the "git reflog expire" command didn't report any
progress. This is the second command (after "pack-refs --all --prune")
that the "gc" command will run.

On small repositories like this command won't take long to run, my
test system it takes just under 1 second to run on git.git, but just
around 8 seconds on linux.git, and much longer on the
2015-04-03-1M-git.git[1] large test repository.

Taking so long means that "gc" will appear to hang at the beginning of
its run. It might still do so after this change if the earlier
"pack-refs" command takes a really long time to run, but that'll only
impact repositories with a really large set of refs to pack, and can
be addressed in some future change.

One thing that's bad about this change is that we might *in theory*
print a "Marking unreachable commits in reflog for expiry" message for
each ref with a reflog. This is because the abbreviated callstack
looks like this:

    0  mark_reachable at builtin/reflog.c:227
    1  in unreachable at builtin/reflog.c:290
    2  in should_expire_reflog_ent at builtin/reflog.c:317
    3  in expire_reflog_ent at refs/files-backend.c:2956
    4  in show_one_reflog_ent at refs/files-backend.c:1879
    # This is the last function that has the refname (e.g. "HEAD") available
    5  in files_for_each_reflog_ent at refs/files-backend.c:2025
    6  in refs_for_each_reflog_ent at refs.c:2066
    7  in files_reflog_expire at refs/files-backend.c:3043
    8  in refs_reflog_expire at refs.c:2117
    9  in reflog_expire at refs.c:2129
    # Here's where we collect reflogs to expire, and expire each one
    10 in cmd_reflog_expire  at builtin/reflog.c:595

I.e. this progress is being reported for each expired reflog. So if
start_progress() were used instead of start_delayed_progress() we'd
print (e.g. on my git.git) hundreds of these lines.

In practice I haven't been able to make it print anything except one
line. This is because validating the reflogs for these other
branches (not "HEAD") takes such a short amount of time.

That may just be some artifact of the repositories I've tested, but I
suspect It'll be true in general. As the callstack above shows, in
order to guarantee that we don't do that we'd need to pass some
"progress" variable through 10 levels of functions, many of which are
"for_each" callback functions with void* cb_data.

1. https://github.com/avar/2015-04-03-1M-git

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/reflog.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 3acef5a0ab..d3075ee75a 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -10,6 +10,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "reachable.h"
+#include "progress.h"
 
 /* NEEDSWORK: switch to using parse_options */
 static const char reflog_expire_usage[] =
@@ -225,14 +226,20 @@ static void mark_reachable(struct expire_reflog_policy_cb *cb)
 	struct commit_list *pending;
 	timestamp_t expire_limit = cb->mark_limit;
 	struct commit_list *leftover = NULL;
+	struct progress *progress = NULL;
+	int i = 0;
 
 	for (pending = cb->mark_list; pending; pending = pending->next)
 		pending->item->object.flags &= ~REACHABLE;
 
 	pending = cb->mark_list;
+	progress = start_delayed_progress(
+		_("Marking unreachable commits in reflog for expiry"), 0);
 	while (pending) {
 		struct commit_list *parent;
 		struct commit *commit = pop_commit(&pending);
+
+		display_progress(progress, ++i);
 		if (commit->object.flags & REACHABLE)
 			continue;
 		if (parse_commit(commit))
@@ -253,6 +260,7 @@ static void mark_reachable(struct expire_reflog_policy_cb *cb)
 		}
 	}
 	cb->mark_list = leftover;
+	stop_progress(&progress);
 }
 
 static int unreachable(struct expire_reflog_policy_cb *cb, struct commit *commit, struct object_id *oid)
-- 
2.19.0.444.g18242da7ef

