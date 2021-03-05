Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377F3C43332
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 17:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D79065094
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 17:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhCERHy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 12:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbhCERHq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 12:07:46 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A23C061574
        for <git@vger.kernel.org>; Fri,  5 Mar 2021 09:07:45 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id l22so2087683wme.1
        for <git@vger.kernel.org>; Fri, 05 Mar 2021 09:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C8E2PK7+SrZZjDhlBRMGUCZd7jdq6n99b5VyzNRE4LM=;
        b=N1hgc3ldfioG79Wd1QrAp2nhUS3kw3wT9G+NKDNtzpeotcIkm1hgyHktTM4W2WIUrL
         TrzCYqeew0kMsEaqu7/Pn9TxyHIzh+OirHrWEI2QB/rCOh2111PFRuVF4jkDsmP1tPB3
         O3iKcqECmA+4DFBwjIK1FoRxc2hOk7MNSKK2nmruI6+OAmfTHk8puXV4389vVH6hP/Rd
         Dt+Y/FGuVEMrRveaXk/VbLaLA05DqNTslkUgX3d8OEVqTiICEtAwCgDiD1JlEb+d1s5E
         P+01Th3h6ClAHrJJDh72cdEGvy8Oh8mOauHERk8nGvwE971lBIpSRu3Cp7EdTsn0E4qL
         PXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C8E2PK7+SrZZjDhlBRMGUCZd7jdq6n99b5VyzNRE4LM=;
        b=kv2i5wrZ+POu8hZmaMFBHwJ7tA7Qt0dEItkPWLZzCETfTtX4vvKOfpT7phqx2F/+kJ
         Um6QJ1gi0ChkUQC9Spddgbpr7NsniRcXhISzpJHxfKZBVE5sM7aotXGevtJxvMoGuri8
         W58/rgepeMfN1HeJD1nc71+5eydRdmW1bpEnvskgdP0MEX88YWVSZFZPNoQ/2nhcNt7q
         u2SsSK+Hi+kLKJ/cqJ8vQ0ckxJtHTgKX5xwQcCObObwxZQ0ZITYqfj3VrfvP5ShxuIV6
         mYcuKxNqnW7qtf5vhGg0pAxk2UH7wPxD73J4rTM+iCs/sw2kOF7l1N3uHcOqrHSCoKV5
         U7Lw==
X-Gm-Message-State: AOAM5316zj4lbyBHw5aTFHd05hsh9jM2x7xbus3mIizxpxUHDPs3BSiE
        vCNxOdzNeXllL6w/RLA+rFwpR9iFZO7CPA==
X-Google-Smtp-Source: ABdhPJzVkqHLWfxdVYSpzlyAVRxQRNSl+Fn7ZOEeelEaNEqZ3jqniJk8oPpOPo4IdMzGJz8+AGqDTQ==
X-Received: by 2002:a7b:cf2f:: with SMTP id m15mr9677760wmg.177.1614964064028;
        Fri, 05 Mar 2021 09:07:44 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4sm5115328wmq.12.2021.03.05.09.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 09:07:43 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>, Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/4] Makefile/coccicheck: speed up and fix bug with duplicate hunks
Date:   Fri,  5 Mar 2021 18:07:22 +0100
Message-Id: <20210305170724.23859-3-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210302205103.12230-1-avarab@gmail.com>
References: <20210302205103.12230-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the coccicheck target to run on all of our *.c and *.h files
with --no-includes, instead of only on the *.c files with
--all-includes.

This speeds it up significantly and reduces its memory usage, since it
doesn't need to parse N includes for every file it visits.

See [1] for a discussion thread about this commit with some timings
for details, but briefly: This change speeds it up by ~2x and makes it
use much less memory. Or a reduction of a max of around ~2GB
per-process (under the old SPATCH_BATCH_SIZE=0) to around ~200MB.

Looking at the history of the coccicheck target I think we've always
been running it in the wrong mode for what we wanted to achieve:

 - When it was added in 63f0a758a06 (add coccicheck make target,
   2016-09-15) it explicitly processed only the %.c files.

 - Then in a9a884aea57 (coccicheck: use --all-includes by default,
   2016-09-30) it started processing the %.h files by looking around for
   its own includes.

Let's instead just point it to both our *.c and *.h files, then
there's no need to have it recursively look around for included files
to change.

Setting --no-includes would not work if we expected to set
COCCI_SOURCES to a subset of our source files, but that's not what
we're doing here. If anyone manually tweaks COCCI_SOURCES they'll now
need to tweak SPATCH_FLAGS too. The speed and correctness we gain is
worth that small trade-off.

Using --no-includes also fixes a subtle bug introduced in
960154b9c17 (coccicheck: optionally batch spatch invocations,
2019-05-06) with duplicate hunks being written to the
generated *.patch files.

This is because that change altered a file-at-a-time for-loop to an
invocation of "xargs -n X". This would not matter for most other
programs, but it matters for spatch.

This is because each spatch invocation will maintain shared lock files
in /tmp, check if files being parsed were changed etc. I haven't dug
into why exactly, but it's easy to reproduce the issue[2]. The issue
goes away entirely if we just use --no-includes, which as noted above
would have made sense even without that issue.

1. https://lore.kernel.org/git/20210302205103.12230-1-avarab@gmail.com/
2. A session showing racy spatch under xargs -n X:

    $ cat test.cocci
    @@
    expression E1;
    @@
    - strbuf_avail(E1)
    + strbuf_has(E1)
    $ for i in 1 2 4 16 64 128 512
    do
        echo with xargs -n $i: &&
	echo *.c | xargs -n $i spatch --sp-file \
            test.cocci --all-includes --patch . 2>/dev/null | \
	grep -F +++ | sort | uniq -c
    done
    with xargs -n 1:
          1 +++ b/convert.c
          1 +++ b/strbuf.c
    with xargs -n 2:
          1 +++ b/convert.c
          1 +++ b/strbuf.c
    with xargs -n 4:
          1 +++ b/convert.c
          1 +++ b/strbuf.c
    with xargs -n 16:
          1 +++ b/convert.c
          1 +++ b/strbuf.c
          2 +++ b/strbuf.h
    with xargs -n 64:
          1 +++ b/convert.c
          1 +++ b/strbuf.c
          2 +++ b/strbuf.h
    with xargs -n 128:
          1 +++ b/convert.c
          1 +++ b/strbuf.c
          2 +++ b/strbuf.h
    with xargs -n 512:
          1 +++ b/convert.c
          1 +++ b/strbuf.c
          1 +++ b/strbuf.h

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index f881b558c44..798a0517131 100644
--- a/Makefile
+++ b/Makefile
@@ -1196,7 +1196,8 @@ SPARSE_FLAGS ?=
 SP_EXTRA_FLAGS = -Wno-universal-initializer
 
 # For the 'coccicheck' target
-SPATCH_FLAGS = --all-includes --patch .
+SPATCH_FLAGS = --no-includes --patch .
+
 # For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
 # usually result in less CPU usage at the cost of higher peak memory.
 # Setting it to 0 will feed all files in a single spatch invocation.
@@ -2853,7 +2854,7 @@ check: config-list.h command-list.h
 		exit 1; \
 	fi
 
-FOUND_C_SOURCES = $(filter %.c,$(shell $(FIND_SOURCE_FILES)))
+FOUND_C_SOURCES = $(filter %.c %.h,$(shell $(FIND_SOURCE_FILES)))
 COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FOUND_C_SOURCES))
 
 %.cocci.patch: %.cocci $(COCCI_SOURCES)
-- 
2.31.0.rc0.126.g04f22c5b82

