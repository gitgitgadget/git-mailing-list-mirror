Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD08C433E6
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 18:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47DF320936
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 18:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="PQ6GT+GN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgH1SGd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 14:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgH1SGa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 14:06:30 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAD9C061264
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 11:06:30 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id z3so284179qkz.7
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 11:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=x7cbqPxRu7buigp5sxOpXj9FOyU9vp58e3viANUuGAY=;
        b=PQ6GT+GNyDuKZNnx5hwuMWOIKQVbASfHK/1A+zQ20cwOk0zKBsTK9nzwCfqlwi1aWo
         KOxfr4Qj+b0OrYoR8XaTCgzUnWBDzOA6G43K4NNQdJVtVIUDjMJpGkV9vGBv+x6iVeRO
         Ee7fX8H3VfI3Hf6XuJoHTlY1YO1ihGHSbyfGbFFv7JifCp8xXamH2N1oGY2ZMfb9Ah0r
         buwhQOCOYAQ3PNkpkrK4I6Kdm2ye98oFoK7n090zffL0JlFuBVJoCDdNs9zFTN4sIUt6
         UuOcQw1yD8K8U/WpzQ259MTBSA71h3FrgBLKzVJWdCfc9VqoaY1O97rw71xIfCcqm8gL
         5dIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=x7cbqPxRu7buigp5sxOpXj9FOyU9vp58e3viANUuGAY=;
        b=uK62+/XFw+YDjCslTTWU+DlXA072LRBuCEbBJjf/Q1CjmYy8N4L1Grq9mBDfR8YB6p
         qODMbNS7HcYNfe+kg6stv0eMnxqpugDWpY/g1Hk05YjaO/LUjGzedj+uv1x5SPcX2j8+
         GBBJrEv7p0mxBWGoujELckbHmeBos51P/wVYMUh5GzqJSJPOJpN9lXGfPIF6vqYal/4W
         KYS0Lw2hZ+LdDqwu3M9cU0dZW3XN/GitzLReN9hHhLkO/YyXOiYfgK2NXWv6jQ4e3565
         x18xYv21QM9ZL5B9MP0eBd0zgojQv6yJhy5rRojA3fujEZS0QqMLyTmLrlN3gP5ZhH5B
         QcDA==
X-Gm-Message-State: AOAM530r2/ucGY6EfJYwcA0X8uqhZ6gInJRKxf0qobNEjaC2KaJtayTl
        ZmyT0/RTmfziml+JmNuneJSPebR/oI4aV+uk
X-Google-Smtp-Source: ABdhPJycdumY8ZLCgYUsi6UC7ZXC2n6iFld72Hxy4Jtvv2hI/bZHR4qBljz0MSpdOCXX1kwTloFm0g==
X-Received: by 2002:a37:b307:: with SMTP id c7mr338398qkf.33.1598637987429;
        Fri, 28 Aug 2020 11:06:27 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:f08e:2c2d:3ae3:2fac])
        by smtp.gmail.com with ESMTPSA id s17sm1707188qte.50.2020.08.28.11.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 11:06:26 -0700 (PDT)
Date:   Fri, 28 Aug 2020 14:06:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH] midx: traverse the local MIDX first
Message-ID: <20200828180621.GA9036@nand.nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a repository has an alternate object directory configured, callers
can traverse through each alternate's MIDX by walking the '->next'
pointer.

But, when 'prepare_multi_pack_index_one()' loads multiple MIDXs, it
places the new ones at the front of this pointer chain, not at the end.
This can be confusing for callers such as 'git repack -ad', causing test
failures like in t7700.6 with 'GIT_TEST_MULTI_PACK_INDEX=1'.

The occurs when dropping a pack known to the local MIDX with alternates
configured that have their own MIDX. Since the alternate's MIDX is
returned via 'get_multi_pack_index()', 'midx_contains_pack()' returns
true (which is correct, since it traverses through the '->next' pointer
to find the MIDX in the chain that does contain the requested object).
But, we call 'clear_midx_file()' on 'the_repository', which drops the
MIDX at the path of the first MIDX in the chain, which (in the case of
t7700.6 is the one in the alternate).

This patch bandaids that situation by trying to place the local MIDX
first in the chain when calling 'prepare_multi_pack_index_one()'.
Specifically, it always inserts all MIDXs loads subsequent to the local
one as the head of the tail of the MIDX chain. This makes it so that we
don't have a quadratic insertion while still keeping the local MIDX at
the front of the list. Likewise, it avoids an 'O(m*n)' lookup in
'remove_redundant_pack()' where 'm' is the number of redundant packs and
'n' is the number of alternates.

Protect 'remove_redundant_pack()' against a case where alternates with
MIDXs exist, but no local MIDX exists by first checking that 'm->local'
before asking whether or not it contains the requested pack.

This invariant is only preserved by the insertion order in
'prepare_packed_git()', which traverses through the ODB's '->next'
pointer, meaning we visit the local object store first. This fragility
makes this an undesirable long-term solution, but it is acceptable for
now since this is the only caller.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
This is kind of a hack, but the order that we call
'prepare_multi_pack_index_one()' from 'prepare_packed_git()' makes it
acceptable, at least in my own assessment.

It is fixing a breakage in 'next', so I'd be inclined to merge this up.
But, if this is too gross, I'd just as soon revert what's in 'next' and
try again later.

 builtin/repack.c | 2 +-
 midx.c           | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 98fac03946..5661d69c16 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -135,7 +135,7 @@ static void remove_redundant_pack(const char *dir_name, const char *base_name)
 	struct strbuf buf = STRBUF_INIT;
 	struct multi_pack_index *m = get_multi_pack_index(the_repository);
 	strbuf_addf(&buf, "%s.pack", base_name);
-	if (m && midx_contains_pack(m, buf.buf))
+	if (m && m->local && midx_contains_pack(m, buf.buf))
 		clear_midx_file(the_repository);
 	strbuf_insertf(&buf, 0, "%s/", dir_name);
 	unlink_pack_path(buf.buf, 1);
diff --git a/midx.c b/midx.c
index e9b2e1253a..cc19b66152 100644
--- a/midx.c
+++ b/midx.c
@@ -416,8 +416,12 @@ int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, i
 	m = load_multi_pack_index(object_dir, local);

 	if (m) {
-		m->next = r->objects->multi_pack_index;
-		r->objects->multi_pack_index = m;
+		struct multi_pack_index *mp = r->objects->multi_pack_index;
+		if (mp) {
+			m->next = mp->next;
+			mp->next = m;
+		} else
+			r->objects->multi_pack_index = m;
 		return 1;
 	}

--
2.28.0.338.g87a3b7a5a2.dirty
