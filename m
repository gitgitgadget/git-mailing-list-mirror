Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA1DC433DF
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 23:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 503F020738
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 23:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MaEgP4Ob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgHRXgk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 19:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgHRXgj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 19:36:39 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9D3C061389
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 16:36:39 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id g17so13096334plg.10
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 16:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PT7WZrIO6ONR9Nz/uG2714G7miQm7qJUtZT4YZeN/zg=;
        b=MaEgP4Ob6/ro4Mub5t9YYcFRZuNwzejQcgyPJeUUmImP9z8X1/Rb9ystYa9SrksASF
         pMdlNeHQhrCN6gMdskHgcGLnFAWQVmkUSc0YL1GDZFutRvi33W576KOfoXFUehmnwk9g
         UyPtA5djYD2Pn4wuah2fioJTUqNrHpaXQoMJl+M54DckNH+B5gEvvS0oY1ipIubCX2R3
         w+WsUBqYiERgLg17vv6s2uD+Jwb3Peu+QQy0tasc7DhFpyj2p3wYgUAeg3t56umHTAih
         cJMom0GK4xBdYnVM+6eAXymVCld9SQpwbHw8peqoDYu2TmqokndVlereA8t2g/SgP+rf
         OI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PT7WZrIO6ONR9Nz/uG2714G7miQm7qJUtZT4YZeN/zg=;
        b=M9d0IdVoVv5sHKLx8JwEFU0f8QX+afgE5wqR/oMURq3LmjFEUD4BF3jA7UVK3DHiwn
         YwTya0IYjBv1DDO1lsi8bKFwvfNzQGYer/HtZBsfFLm5YnQWRAE4/amRwUgUnVjGTJu8
         NpTNYJapMqyvayvYGLimWOrGihGnlQ1e7UYL7DMk06tDFapbZ/1n8RQiAfJ35nlJPNOt
         VN850nDRXfcNefTHLFuXLDxLvPZIbpSpIeYKjqZV7LWQwbrajoEo3h/ms6Wc7k6IRrbg
         8evAo3WvfJR3gmkXTEi6vL70gu3kQztjjHDprKBT1xkbl6JrYa6d+ntCvzu2Eiwemmp0
         L5AA==
X-Gm-Message-State: AOAM533snXiUDAwGsP3Qo1xXnDYW51egGjcghqDr2dBGHiSHB+QkrIj+
        g9QWoDaUY9rzYgYcDC8NbgMVx4S/PsUMq7Fmc9+7umAzOlwFHEkRvvin/mTBDUqNOJ/siVQs0CI
        DjoMjQD8lcUtt0wTjmlJpfzyp4uEW2YUhhfvFEsROTppKJLB3Qv5vUNL2QbRHKTYVN88a3YZHvl
        75
X-Google-Smtp-Source: ABdhPJwjXLWK1k/3JiK55UaGh+LJHRhwCtRWWfIiO97/XlTXL5SXmz6z+QCYxvGEx+jcxyywjUhl21jSWoBotRgiEaqr
X-Received: by 2002:a17:902:6b05:: with SMTP id o5mr16853548plk.173.1597793798487;
 Tue, 18 Aug 2020 16:36:38 -0700 (PDT)
Date:   Tue, 18 Aug 2020 16:36:30 -0700
In-Reply-To: <xmqqk0xvwpob.fsf@gitster.c.googlers.com>
Message-Id: <20200818233630.2829739-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqk0xvwpob.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH] fixup! promisor-remote: lazy-fetch objects in subprocess
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
Ah, sorry about that - here's a fixup. I forgot to switch the name of
the negotiator in the patch (and also because of the change to a "fetch"
subprocess, the trace is reported as "fetch>", not "git>").

 promisor-remote.c      | 2 +-
 t/t5300-pack-object.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 56d6d4d821..6530e26f98 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -23,7 +23,7 @@ static int fetch_objects(const char *remote_name,
 
 	child.git_cmd = 1;
 	child.in = -1;
-	strvec_pushl(&child.args, "-c", "fetch.negotiationAlgorithm=null",
+	strvec_pushl(&child.args, "-c", "fetch.negotiationAlgorithm=noop",
 		     "fetch", remote_name, "--no-tags",
 		     "--no-write-fetch-head", "--recurse-submodules=no",
 		     "--filter=blob:none", "--stdin", NULL);
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 3d6a93343a..392201cabd 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -528,7 +528,7 @@ test_expect_success 'prefetch objects' '
 	TWO=$(git -C server rev-parse three_branch^) &&
 	git -C client fetch --filter=blob:none origin "$TWO" &&
 	GIT_TRACE_PACKET=$(pwd)/trace git -C client push origin "$TWO":refs/heads/two_branch &&
-	grep "git> done" trace >donelines &&
+	grep "fetch> done" trace >donelines &&
 	test_line_count = 1 donelines
 '
 
-- 
2.28.0.220.ged08abb693-goog

