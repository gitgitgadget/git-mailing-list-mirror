Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEA7C2D0C6
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 14:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A071420740
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 14:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtbDZXWQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfL0OvF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 09:51:05 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40343 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfL0OvF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 09:51:05 -0500
Received: by mail-qk1-f193.google.com with SMTP id c17so21654591qkg.7
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 06:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EoRrHsObG7JI/amRViqPlZ2pajDPjBzpBnIIYDzGT3A=;
        b=FtbDZXWQmChRNBf1CIxZVxbRu5Wm9dSu0UVKl/WLf1JoYVW3yzTJUvOHnIoYU/AJE9
         lXnala0USJl8NnQtfEC8PckQl5BV84UWfIRcZm7oOyoKmbB9ZLUghrNbRIFekXbYUKCZ
         z01uiTFG4Ojnc43Io3V46Cvepv1ZK4RB1q2mny6qRFyjK6NSXlrE1BoKgPaG4QMLcEyb
         CcTMJp1Lp/eAU2HjDDFYT6ODDzW5lj8cEvn6Ih9lHOhEPj99gixC9Asg2Z4GchRHklH/
         krHES6GS71wVB/aJuQ+eP0PPfUt6+Uo69p5w7zMf9a2UkG/J+6K+uxOVjoIilPmZSXKW
         7fMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EoRrHsObG7JI/amRViqPlZ2pajDPjBzpBnIIYDzGT3A=;
        b=F8Ws2zjq6UIrTdp13DyfM7IBcvbfdN5ZgaGhbBKgbOVzxfB0DIvG3pewrKhrv2nQ6G
         Fp8BJf0pM7wHs7QQkqKg2HxPAP7sfvdfW+qHrKPemMtKGkRJVoKoaX2agpr/oPJVl1H/
         92y31NeOsXtO2f8nnt53LcMSj1SY/htfdern8fImScIO8+gA2C8trL0Q445EjXXQ5TIE
         rQhN0tjAVy4LtDaa5+VkMvNghVd4ufZt58t1iLKGIAVmyPrFGlhCYnHVXYW5soL4Y6Xc
         WBuwEC2RkFWbKsieaTEMuHmDKweZarJTd8rBlYm/tahygrvHE7Sidqb6IUfwpzmNz8U2
         Ixsg==
X-Gm-Message-State: APjAAAUzOeqXpplsxpo58p4/nMaWLWnBnIMwUgGOl7kgEbdw9bxSUHoe
        w3TIC07wfvJcSZKL1UEqxXc=
X-Google-Smtp-Source: APXvYqwYPFisN6b3RWrqL0CBzZCYuqY0wKSyfXQ7x/ByvJlFM04zh2k5H+WrMaWI4xH25V92WwY3Yg==
X-Received: by 2002:ae9:f106:: with SMTP id k6mr45150861qkg.189.1577458264107;
        Fri, 27 Dec 2019 06:51:04 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:9d29:38a1:5885:e8b3? ([2001:4898:a800:1010:4e5f:38a1:5885:e8b3])
        by smtp.gmail.com with ESMTPSA id k22sm9837540qkg.80.2019.12.27.06.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Dec 2019 06:51:03 -0800 (PST)
Subject: Re: [PATCH 1/3] commit-graph: examine changed-path objects in pack
 order
To:     Jeff King <peff@peff.net>,
        Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com, me@ttaylorr.com,
        Junio C Hamano <gitster@pobox.com>
References: <20191222093036.GA3449072@coredump.intra.peff.net>
 <20191222093206.GA3460818@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8b331ef6-f431-56ef-37a9-1d6e263ea0fe@gmail.com>
Date:   Fri, 27 Dec 2019 09:51:02 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20191222093206.GA3460818@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/22/2019 4:32 AM, Jeff King wrote:
> Looking at the diff of commit objects in pack order is much faster than
> in sha1 order, as it gives locality to the access of tree deltas
> (whereas sha1 order is effectively random). Unfortunately the
> commit-graph code sorts the commits (several times, sometimes as an oid
> and sometimes a pointer-to-commit), and we ultimately traverse in sha1
> order.
> 
> Instead, let's remember the position at which we see each commit, and
> traverse in that order when looking at bloom filters. This drops my time
> for "git commit-graph write --changed-paths" in linux.git from ~4
> minutes to ~1.5 minutes.

I'm doing my own perf tests on these patches, and my copy of linux.git
has four packs of varying sizes (corresponding with my rare fetches and
lack of repacks). My time goes from 3m50s to 3m00s. I was confused at
first, but then realized that I used the "--reachable" flag. In that
case, we never run set_commit_pos(), so all positions are equal and the
sort is not helpful.

I thought that inserting some set_commit_pos() calls into close_reachable()
and add_missing_parents() would give some amount of time-order to the
commits as we compute the filters. However, the time did not change at
all.

I've included the patch below for reference, anyway.

Thanks,
-Stolee

-->8--

From e7c63d8db09be81ce213ba7f112bb3d2f537bf4a Mon Sep 17 00:00:00 2001
From: Derrick Stolee <dstolee@microsoft.com>
Date: Fri, 27 Dec 2019 09:47:49 -0500
Subject: [PATCH] commit-graph: set commit positions for --reachable

When running 'git commit-graph write --changed-paths', we sort the
commits by pack-order to save time when computing the changed-paths
bloom filters. This does not help when finding the commits via the
--reachable flag.

Add calls to set_commit_pos() when walking the reachable commits,
which provides an ordering similar to a topological ordering.

Unfortunately, the performance did not improve with this change.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index bf6c663772..a6c4ab401e 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1126,6 +1126,8 @@ static void add_missing_parents(struct write_commit_graph_context *ctx, struct c
 			oidcpy(&ctx->oids.list[ctx->oids.nr], &(parent->item->object.oid));
 			ctx->oids.nr++;
 			parent->item->object.flags |= REACHABLE;
+
+			set_commit_pos(ctx->r, &parent->item->object.oid);
 		}
 	}
 }
@@ -1142,8 +1144,10 @@ static void close_reachable(struct write_commit_graph_context *ctx)
 	for (i = 0; i < ctx->oids.nr; i++) {
 		display_progress(ctx->progress, i + 1);
 		commit = lookup_commit(ctx->r, &ctx->oids.list[i]);
-		if (commit)
+		if (commit) {
 			commit->object.flags |= REACHABLE;
+			set_commit_pos(ctx->r, &commit->object.oid);
+		}
 	}
 	stop_progress(&ctx->progress);
 
-- 
2.25.0.rc0

