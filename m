Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F365C433E1
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 16:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19801207DA
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 16:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbvlGLiI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgGIQyx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 12:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgGIQyw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 12:54:52 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3954C08C5CE
        for <git@vger.kernel.org>; Thu,  9 Jul 2020 09:54:51 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id y10so3058993eje.1
        for <git@vger.kernel.org>; Thu, 09 Jul 2020 09:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zSGh7YhUUR9YJk1Nt+PcgaYa6TxQj8swLD1rX3f9098=;
        b=kbvlGLiIjJagukwaS2YFyAlVN09UQWvNU6uKX6MAEFVOZJ3iKxRHnwnkT5JYJFqdxc
         EXeTYmnRrh23nhzpAm8hgdrSrwE2uorLD0t1J+ptqXRA8vYbUdgZRsN0A1gn1p39n8/t
         esRZwWE5/v+reqKDZOpT0iSGAtbzoqC2OC9h3gEl4jVN9fdxBr0lC1NOI97mr/owKcbh
         YPnm/WzmpRPMXKJbovN8mZuQYcNdPgMXU9r6qe/vY1H4TY5xRcrJS5LLs51n1v88lD1U
         7ryq7G0WTIpj0aOfZw4Hom91PjAL/J78iteI34R9oE2Sp6kpD76gaNhnSqi6zrICBsFX
         MLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zSGh7YhUUR9YJk1Nt+PcgaYa6TxQj8swLD1rX3f9098=;
        b=pXpo8VdDa69qZWwQ6RRh/LOC+eZBw+cbpGKQ8sjUBEos48M2PIgiB8wv1BhXAbRurG
         BUZAEB8Dtv5LUiKhDld6my+vfV6KELf9nrSw4VpwDolDiIemmBkuk64l9vsMqzWCQzCo
         KKtEdXGyK2eJU3hvx9aMnImHr+V0W/49MaaXdB67u2jyXl7qbKu2J2lF+L8n9iJjPEFg
         Ye7zKrIdLf/f47I7gyPxoeHD+c+0F6o/Hs60XDtESQcKEUZg0VB+Ab6C1MsBUPqWgtUz
         7uo1q7ZyTHtlw91onITy6a377I8qRDJwUNn3+dy92tGMJe7caxvF9PQZWn1kQj88aX1B
         P7cw==
X-Gm-Message-State: AOAM531vZ8kMMPaycoLn88UkoGd7d0KsyUpBN1wqQAtwssakJGQCXqMD
        mYFfu+E0E7HJIF5lPllJbuM=
X-Google-Smtp-Source: ABdhPJy9qU2CKvJCGFUfbuYzR1611jIcemk+7VClr0YIJZEEM7+jSImF3PAwuycG6Xt58B46OgBskA==
X-Received: by 2002:a17:906:7005:: with SMTP id n5mr38374500ejj.130.1594313690391;
        Thu, 09 Jul 2020 09:54:50 -0700 (PDT)
Received: from localhost.localdomain (78-131-17-27.pool.digikabel.hu. [78.131.17.27])
        by smtp.gmail.com with ESMTPSA id h15sm2094177eja.44.2020.07.09.09.54.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2020 09:54:49 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, dstolee@microsoft.com,
        peff@peff.net, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] commit-graph: fix progress of reachable commits
Date:   Thu,  9 Jul 2020 18:54:32 +0200
Message-Id: <20200709165432.2688-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.27.0.547.g4ba2d26563
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To display a progress line while iterating over all refs,
d335ce8f24 (commit-graph.c: show progress of finding reachable
commits, 2020-05-13) should have added a pair of
start_delayed_progress() and stop_progress() calls around a
for_each_ref() invocation.  Alas, the stop_progress() call ended up at
the wrong place, after write_commit_graph(), which does all the
commit-graph computation and writing, and has several progress lines
of its own.  Consequently, that new

  Collecting referenced commits: 123

progress line is overwritten by the first progress line shown by
write_commit_graph(), and its final "done" line is shown last, after
everything is finished:

  Expanding reachable commits in commit graph: 344786, done.
  Computing commit changed paths Bloom filters: 100% (344786/344786), done.
  Collecting referenced commits: 154, done.

Move that stop_progress() call to the right place.

While at it, drop the unnecessary 'if (data.progress)' condition
protecting the stop_progress() call, because that function is prepared
to handle a NULL progress struct.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 commit-graph.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 5df3e08718..aaf3327ede 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1354,12 +1354,13 @@ int write_commit_graph_reachable(struct object_directory *odb,
 			_("Collecting referenced commits"), 0);
 
 	for_each_ref(add_ref_to_set, &data);
+
+	stop_progress(&data.progress);
+
 	result = write_commit_graph(odb, NULL, &commits,
 				    flags, split_opts);
 
 	oidset_clear(&commits);
-	if (data.progress)
-		stop_progress(&data.progress);
 	return result;
 }
 
-- 
2.27.0.547.g4ba2d26563

