Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85CB71F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752507AbeBFAc0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:32:26 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38500 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751514AbeBFAcZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:32:25 -0500
Received: by mail-pg0-f65.google.com with SMTP id l18so187986pgc.5
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+t8x/dWGcxzAKES2gLwK4hE6BBleQm0ki16SVIi0tMU=;
        b=m2TAyJNMm24xVIDyPPY4y9HMDFC8Fiq6FN5Iuer4kSy4o27OOR+uG2qQYiJbLktPV8
         3yY8LI4yZ/yeQ1GAa2Wr0/RRFBP+MffYlqtMoB76CtgfNbV8MMH58gndWx2prD8sCTme
         WN9x/iK4WzibhewygtO5iXKBMaeFTBfc7ENHhZn45AIydN5i2J27KyuQEjbNPUtiiFRT
         HuslOSi6i8w5St3H3jFg+54ouaYhx1jO+7pXdtnM0MUuqeTLfG55rGYnEEW2h1z7QTg7
         04wgkpoHGDUUp/8/899bJYaKnfDaNqboGkuGUYOFPbKdEXfMvhBcKH5/WAWGgMuObLd1
         iM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+t8x/dWGcxzAKES2gLwK4hE6BBleQm0ki16SVIi0tMU=;
        b=jCxE10tp47OaZqEnkg/VoGrLYBG+6molDEDhnO0bKwGIcbeD9tr2uhT0QNiS0egdL5
         +30xIqzC/AFMlExqK2x7UY741Zmo8igQhuM6llI4jHtFdmbKxGm2ueRoKJP72AXhzWE1
         vsBh2FJfFScAimXrIF8gnZGYr4zL8fTBAvT6B3h2EFeiIQLlmgsN1mUNZg7PPR5mfxlI
         bR08hc6H8owNOKYloB6HAQiFMQ6+qsBrg7zIdcXPCSWf2to79pjkXrPgD8SNTD71PCja
         KjXSScVxbQ7RGc+ACAf+Fo3iOykSeiIiNua0U0LKQGFM6As2D3367dyPvcDVNkLU+PGx
         mCIw==
X-Gm-Message-State: APf1xPDt45ZqAL6CGrFFwE4Jz5Tego6/tAZJ3IYCjhsvOr5wHbiaLqn4
        rcJPZbTXlma7SOKovqUl2ozbqsnacHY=
X-Google-Smtp-Source: AH8x224NEGuj87UweIVdA1V7o1U+tIjkIaQDKOMN14sPM9/Pocb8FzZQe9Riv9CoVeAO7P7s7DfUbg==
X-Received: by 10.101.78.1 with SMTP id r1mr471226pgt.322.1517877144630;
        Mon, 05 Feb 2018 16:32:24 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id 184sm17871993pfd.156.2018.02.05.16.32.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:32:24 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 189/194] commit: allow in_merge_bases_many to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:17:44 -0800
Message-Id: <20180206001749.218943-91-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 8 ++++----
 commit.h | 3 +--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/commit.c b/commit.c
index 900ecf84b8..a14933b208 100644
--- a/commit.c
+++ b/commit.c
@@ -1049,18 +1049,18 @@ int is_descendant_of(struct commit *commit, struct commit_list *with_commit)
 /*
  * Is "commit" an ancestor of one of the "references"?
  */
-int in_merge_bases_many_the_repository(struct commit *commit, int nr_reference, struct commit **reference)
+int in_merge_bases_many(struct repository *r, struct commit *commit, int nr_reference, struct commit **reference)
 {
 	struct commit_list *bases;
 	int ret = 0, i;
 
-	if (parse_commit(the_repository, commit))
+	if (parse_commit(r, commit))
 		return ret;
 	for (i = 0; i < nr_reference; i++)
-		if (parse_commit(the_repository, reference[i]))
+		if (parse_commit(r, reference[i]))
 			return ret;
 
-	bases = paint_down_to_common(the_repository, commit, nr_reference, reference);
+	bases = paint_down_to_common(r, commit, nr_reference, reference);
 	if (commit->object.flags & PARENT2)
 		ret = 1;
 	clear_commit_marks(commit, all_flags);
diff --git a/commit.h b/commit.h
index 0f3cdc6375..36412a5a9e 100644
--- a/commit.h
+++ b/commit.h
@@ -234,8 +234,7 @@ extern struct trace_key trace_shallow;
 int is_descendant_of(struct commit *, struct commit_list *);
 #define in_merge_bases(r, c1, c2) in_merge_bases_##r(c1, c2)
 int in_merge_bases_the_repository(struct commit *, struct commit *);
-#define in_merge_bases_many(r, c, n, co) in_merge_bases_many_##r(c, n, co)
-int in_merge_bases_many_the_repository(struct commit *, int, struct commit **);
+int in_merge_bases_many(struct repository *r, struct commit *, int, struct commit **);
 
 extern int interactive_add(int argc, const char **argv, const char *prefix, int patch);
 extern int run_add_interactive(const char *revision, const char *patch_mode,
-- 
2.15.1.433.g936d1b9894.dirty

