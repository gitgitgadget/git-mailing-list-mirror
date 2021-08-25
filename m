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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58586C43214
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39049610C8
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbhHYXUo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 19:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbhHYXUk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 19:20:40 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B208BC061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:19:53 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id i3so609267wmq.3
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rER/T7vWiDjs7HDuaPNNLB9+cgOXtIJCrKDBo7eCxsM=;
        b=m6zG87/d5bDl9wUFZERUbaxE0ugG86u5Moa8lzA9Mx8mO94KF0dmOoYfVmbZh6xDPM
         WC0zH7ONdsnndvE19bZOw3lCrB7iPfFzEQtphEgAuEe9ev4TBCgxce1wtoGNpay+MNDp
         ZRFFmmgHsZ7gNorwuL/EvwT5wnXUbtAg1LXeDmg+syl+0ZiyBXUYHfQL4kVz6snI3iV+
         A3QJayHdobo4tBWmqvtadQ+n+Wc813UigCC6ja34rV5y+xCJtwSUyC3kH5ICPt8OoNL+
         zdFXoirctfoWXP6o3IEcrmcATmTJOnLuKOyTDJQCki+3WV22cMoMxGlRWXe0DiJdsAPn
         jKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rER/T7vWiDjs7HDuaPNNLB9+cgOXtIJCrKDBo7eCxsM=;
        b=MCv8T8epFABNY6Hnkf4Hsvq3JFPOnrw9ABk0axtNySpj45MvsoMRovsHnRDdEKjDK9
         t9JEDsTvUhmQcZHovxX6VBf3CBiAoyjtpt3+aOzmJXwK6ajZn5FZ/TvAr1ER6S1yT9Q3
         PkPRaVddcPZlhKKnm5V0xzpJZVZAm1Du1vhOy1CabHLJaOg4y0kq2HnkR1IX4+jmEF5F
         m04KyH/r4wqfjBZom5JtlmFAiDvF0SG8EHrnvVZghkhn5kXWpBOIvvho8UfYPNvorax+
         3QdA+5GhKpGi001deuEpF7+U5QfWvbBlGUqxphYisS+vA4Gw+SaGrgyD52ZwDOmD3DCN
         /qPg==
X-Gm-Message-State: AOAM533ECAXS3bc9PdJCFAxSXRyIRSutm6vjtApULkFVOzGCVpP96cJ8
        o3LHNmJu8eVjOf1ghpkQRkfxaDQK2wpmhQ==
X-Google-Smtp-Source: ABdhPJzRxWKYmQFEf9xPF8bD9tB/WzqlSF7Z71QKe6R2Tyxi2DKoYfRDNi/cSC+1UQ3y5t2HPIEb0w==
X-Received: by 2002:a1c:9d4e:: with SMTP id g75mr766807wme.72.1629933592085;
        Wed, 25 Aug 2021 16:19:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u23sm6327166wmc.24.2021.08.25.16.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 16:19:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/6] tr2: fix memory leak & logic error in 2f732bf15e6
Date:   Thu, 26 Aug 2021 01:19:22 +0200
Message-Id: <patch-4.6-73e7d4eb6ac-20210825T231400Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.733.ga72a4f1c2e1
In-Reply-To: <cover-0.6-00000000000-20210825T231400Z-avarab@gmail.com>
References: <87o8agp29o.fsf@evledraar.gmail.com> <cover-0.6-00000000000-20210825T231400Z-avarab@gmail.com>
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
xstrdup(), and then free our own strbuf.

Furthermore we need to free that "procfs_path" strbuf whether or not
strbuf_read_file() succeeds, which was another source of memory leaks
in 2f732bf15e6, i.e. we'd leak that memory as well if we weren't on a
system where we could read the file from procfs.

In combination with the preceding commit this makes all of
t[0-9]*trace2*.sh pass under SANITIZE=leak on Linux.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 compat/linux/procinfo.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/compat/linux/procinfo.c b/compat/linux/procinfo.c
index 62f8aaed4cc..c86daff2b26 100644
--- a/compat/linux/procinfo.c
+++ b/compat/linux/procinfo.c
@@ -18,12 +18,13 @@ static void get_ancestry_names(struct strvec *names)
 
 	/* try to use procfs if it's present. */
 	strbuf_addf(&procfs_path, "/proc/%d/comm", getppid());
-	if (strbuf_read_file(&name, procfs_path.buf, 0)) {
-		strbuf_release(&procfs_path);
+	if (strbuf_read_file(&name, procfs_path.buf, 0) > 0) {
 		strbuf_trim_trailing_newline(&name);
-		strvec_push(names, strbuf_detach(&name, NULL));
+		strvec_push(names, name.buf);
+		strbuf_release(&name);
 	}
 
+	strbuf_release(&procfs_path);
 	return;
 }
 
-- 
2.33.0.733.ga72a4f1c2e1

