Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D833AC433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 00:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC2C622573
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 00:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbhAEAMC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 19:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbhAEAMB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 19:12:01 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E964C061793
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 16:11:19 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id h4so25200565qkk.4
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 16:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=67ErFAUVYfzNV7YJX81Q7yw8UCKK4jPp8Vr37hkfGdo=;
        b=HfN0lUlX0SItsPy5+NcX1eDO0fXn6JTSr4wFrBHCBIeW1fKXGZ2ASuBvqqJl6PwJuf
         ODl7zjFHjQ2JkRp6AN+GCCC0KHpniatSZWr4WC27sC7E8XB80t48AeZGXZpitVLAStL2
         RZR4HFmw3DLGjc/syaimvdMVVxaAnPMNHu2Pgw/CgAb8sD9GY/5qIpn2fVwhTgTquyl5
         jBVAcJyAiX+onVStA/d25+BKv1ZSdLvL/y/kbPgJliyOY0jlnMaOSyKChepJN9aDMVDE
         cBWWhTq6S9S13sqn8nQ9xU74bMHhl0mxHe8PB23HlupV5dVvKSD0agOh69Mpj0VnWIqg
         ceng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=67ErFAUVYfzNV7YJX81Q7yw8UCKK4jPp8Vr37hkfGdo=;
        b=n2TiDr82zZuBFsFaALUTqB5DdwiCFTdMK3wUw6b/FztHpxflhE9eshaSvfUJipGEcF
         Tt0NpzDZxa8JCfIDkKo6z+d0A40dtMG1F8mqa434lQwNDo0neNKObJNp9+PIbK+BNm+X
         T2BEy4KhKi/ktdrgvxB2Eed7SSKTHXTyC+CCepQXLartH62UVerWXMeL4AGFYCOEC7/y
         CPFs/k6Bh5ry70/Kb9/7jns4UkPOXQiSrYdtWvosnIdGtBzrX6lVf6nJatlYR6MZeBPg
         czzRdit007jHatZQFdvtRiMIflnQZRoSrW52p3Uez5iOlIHrFilCRtIl6mEizjpUTzYE
         ojdw==
X-Gm-Message-State: AOAM532faYimLw1tmVxP2aFao0iU27L+KOJkuXPZKpApQnIp+kw5Iusn
        Ii/xO81vuLcxwYTOak2zrls8lFZYOVKyyg==
X-Google-Smtp-Source: ABdhPJzwRvm/5Py9rvskfCM1JZflP1ymeFCQzSfwTfCx3Skmd3sbwauj/xLi+l/EClbrNOj05N8NHw==
X-Received: by 2002:ac8:4615:: with SMTP id p21mr70168182qtn.45.1609796142031;
        Mon, 04 Jan 2021 13:35:42 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:84a:48e0:d854:cd])
        by smtp.gmail.com with ESMTPSA id n188sm38464314qke.17.2021.01.04.13.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 13:35:41 -0800 (PST)
Date:   Mon, 4 Jan 2021 16:35:37 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     nipunn@dropbox.com, gitster@pobox.com
Subject: [PATCH] p7519: allow running without watchman prereq
Message-ID: <46b2e5af59c451b816973ba3f2c32a68639298b3.1609796006.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

p7519 measures the performance of the fsmonitor code. To do this, it
uses the installed copy of Watchman. If Watchman isn't installed, a noop
integration script is installed in its place.

When in the latter mode, it is expected that the script should not write
a "last update token": in fact, it doesn't write anything at all since
the script is blank.

Commit 33226af42b (t/perf/fsmonitor: improve error message if typoing
hook name, 2020-10-26) made sure that running 'git update-index
--fsmonitor' did not write anything to stderr, but this is not the case
when using the empty Watchman script, since Git will complain that:

    $ which watchman
    watchman not found
    $ cat .git/hooks/fsmonitor-empty
    $ git -c core.fsmonitor=.git/hooks/fsmonitor-empty update-index --fsmonitor
    warning: Empty last update token.

Prior to 33226af42b, the output wasn't checked at all, which allowed
this noop mode to work. But, 33226af42b breaks p7519 when running it
without a 'watchman(1)' on your system.

Handle this by only checking that the stderr is empty only when running
with a real watchman executable. Otherwise, assert that the error
message is the expected one when running in the noop mode.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
Noticed while running the perf tests on v2.30.0 on a system that happens
to not have Watchman installed.

I could do without the 'else' block here, but it seems straightforward
enough. Likewise, the "ensure no silent error" comment could certainly
be removed (since 'test_must_be_empty error' makes what is happening
quite clear), but the fix pursued here is minimal.

 t/perf/p7519-fsmonitor.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index 9b43342806..1e20a184c7 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -129,7 +129,12 @@ setup_for_fsmonitor() {

 	git config core.fsmonitor "$INTEGRATION_SCRIPT" &&
 	git update-index --fsmonitor 2>error &&
-	test_must_be_empty error  # ensure no silent error
+	if test_have_prereq WATCHMAN
+	then
+		test_must_be_empty error  # ensure no silent error
+	else
+		grep "Empty last update token" error
+	fi
 }

 test_perf_w_drop_caches () {
--
2.29.2.533.g07db1f5344
