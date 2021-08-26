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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6486FC432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 12:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B40E61076
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 12:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240969AbhHZMXY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 08:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhHZMXT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 08:23:19 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6B5C061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 05:22:31 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u16so4767491wrn.5
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 05:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jVBc9m+pKFl85MWW/GR/1EUtWa8NrEEVi49uYQ9jQlk=;
        b=jD5mxmhO6A+xy9xofqNgRmDMtr4Evb1hh+bM0X+GUXg4eKGPNXv4Vl9Dci3/OeKa8T
         wg45BTVnoEmDmzvDUvNAWROqEy0aiB+N3BSGaAxe2KNa+tdjjDfdYGn2n6raXXUhdlMh
         Gzbl6j/VrDIGjs4TpEhTk6jklPh2t74HI5h8CLMD8AV2uzwctxS53q4mwb0JDDlHtSmI
         xJ6Dq6dCNsPaQsk3PW68826uGun1ixv+T1yApjWlrp5xk2p+hafgxUxfuoMaAkDqQTUb
         sbQg4BOJdlLdrccSrZXAL1qHvCgMGpDDKrQ6+hWaxCTwvcUgbnmt8tsydrAbVX7RAvQR
         3ijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jVBc9m+pKFl85MWW/GR/1EUtWa8NrEEVi49uYQ9jQlk=;
        b=QGccCViGJQeZZB5PjXdUCS779fWtKTIDyby0ElNM4rKjMIicGlZHE4Ys9Er6wNhrlC
         XrEHdn8gC9RjjUcZWmdqvLIy+2mBve9+70JfIfxSW7l3tFn2pq4Ru+rCENHoUgrMGAUT
         1Yfg0pYNOlh6hN35v5iYQCbdJj94iMDa95pOei394cXZy3lCEDAVzzGSPVlqm+xnBWXn
         vZVcQiKeRROiNKk6mJeITfBSLtGkioRnuY2gCOtOa/JQiGEkF+xUhSPq9S0cWg/8L4Lw
         HYXaYR08ISecAug8a40hJYPeYvhNIPZpZ7WW3pIIJutD8hGvgxNuZaAwsG1CpCInW/Ne
         2HIw==
X-Gm-Message-State: AOAM530ZYiEn3ChIkzjLBRSKBDCR+NYmUFwkDfc0V6Dlhtwbl8kU/mo5
        QXYjbJje84NWBYWmfbuAoqVjTbYy1x7zXw==
X-Google-Smtp-Source: ABdhPJwvRBLMhyxEYSGyC12WF7vOHJJN0762aYqGKt6BOykILO5+jhAn7hWiGcklO/fdoV6fZc4nVg==
X-Received: by 2002:adf:c405:: with SMTP id v5mr3616630wrf.183.1629980550122;
        Thu, 26 Aug 2021 05:22:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z17sm2969885wrr.66.2021.08.26.05.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 05:22:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/6] tr2: fix memory leak & logic error in 2f732bf15e6
Date:   Thu, 26 Aug 2021 14:22:22 +0200
Message-Id: <patch-v2-4.6-1aa0dbc394e-20210826T121820Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.733.ga72a4f1c2e1
In-Reply-To: <cover-v2-0.6-00000000000-20210826T121820Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210825T231400Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20210826T121820Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a subsequent commit I'll be replacing most of this code to log N
parents, but let's first fix bugs introduced in the recent
2f732bf15e6 (tr2: log parent process name, 2021-07-21).

It was using the strbuf_read_file() in the wrong way, its return value
is either a length or a negative value on error. If we didn't have a
procfs, or otherwise couldn't access it we'd end up pushing an empty
string to the trace2 ancestry array.

It was also using the strvec_push() API the wrong way. That API always
does an xstrdup(), so by detaching the strbuf here we'd leak
memory. Let's instead pass in our pointer for strvec_push() to
xstrdup(), and then free our own strbuf. I do have some WIP changes to
make strvec_push_nodup() non-static, which makes this and some other
callsites nicer, but let's just follow the prevailing pattern of using
strvec_push() for now.

We'll also need to free that "procfs_path" strbuf whether or not
strbuf_read_file() succeeds, which was another source of memory leaks
in 2f732bf15e6, i.e. we'd leak that memory as well if we weren't on a
system where we could read the file from procfs.

Let's move all the freeing of the memory to the end of the
function. If we're still at STRBUF_INIT with "name" due to not haven
taken the branch where the strbuf_read_file() succeeds freeing it is
redundant, so we could move it into the body of the "if", but just
handling freeing the same way for all branches of the function makes
it more readable.

In combination with the preceding commit this makes all of
t[0-9]*trace2*.sh pass under SANITIZE=leak on Linux.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 compat/linux/procinfo.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/compat/linux/procinfo.c b/compat/linux/procinfo.c
index 62f8aaed4cc..bd01f017bc7 100644
--- a/compat/linux/procinfo.c
+++ b/compat/linux/procinfo.c
@@ -18,12 +18,14 @@ static void get_ancestry_names(struct strvec *names)
 
 	/* try to use procfs if it's present. */
 	strbuf_addf(&procfs_path, "/proc/%d/comm", getppid());
-	if (strbuf_read_file(&name, procfs_path.buf, 0)) {
-		strbuf_release(&procfs_path);
+	if (strbuf_read_file(&name, procfs_path.buf, 0) > 0) {
 		strbuf_trim_trailing_newline(&name);
-		strvec_push(names, strbuf_detach(&name, NULL));
+		strvec_push(names, name.buf);
 	}
 
+	strbuf_release(&procfs_path);
+	strbuf_release(&name);
+
 	return;
 }
 
-- 
2.33.0.733.ga72a4f1c2e1

