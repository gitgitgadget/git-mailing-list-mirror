Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1CBC5479D
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 23:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjAKXc4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 18:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234951AbjAKXcu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 18:32:50 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D8E37245
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 15:32:49 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id t5so12129008wrq.1
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 15:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sXbcH64KXpaIto/069xqUxvkcKj3MsUYqnuXX2r+Xw=;
        b=YYnEiZBOjRxf3WzW27DrAbryVBjN9DYlJy3mWxDoL4gvB4roUcyF8CSflRgTEX0gBN
         V83DM2IwdGtxgiQP2aVi0q6XsYYpU6RWqQzkVk7i2TUwuyt9xMszg2uE9eN594rAIL3q
         JQQ5C8GiMO23w3bVV+oBZkKU80IyaCakL+50Zshbl1u3lomNm7XqwIB1DgK70PPkKU1g
         FOd39R95CRoCoNh19dsuNy1N7dhAtoNDpr7yRq819lYhHOYRojG2iTiNsYzrCuaEhBBY
         NwSE7j4WatuUJvNJPj+731XPWqMNAgfEY25cuHCJaxRC1FVqE+v9X+AyEmXJe90m6ICH
         rhig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7sXbcH64KXpaIto/069xqUxvkcKj3MsUYqnuXX2r+Xw=;
        b=GKHU82KDtBy54jLfW69RqFy1vEByjMcVWsG7hjz8F9RiOtWLa9KM29mu4P46tzcYZj
         0Z7aFEXoupMcuLugo1j7zXQ4PNwYrU9X4My30wb1LHRbCM3/220jb8d4Y1Pm1AX/N7Y2
         Ta5Gq6Ki41MdCIny8ulSyDJ7cAzYuVw36UFmnwYnJm+1XCLBDx1WD0T9EmEAQmRrfHRJ
         2lJAN8dlwh7iSbO9uwOM5hEV37FIBJgTVXZ9TqmQIkbJc3Nih35eDU/j4M+MCqZUgEWK
         6+MQl9ddlXuOR55k0W390nqRaHsclxJbPAqtGUBDquiiIDnG8BaWDXbrCx90Ww1DPqJZ
         5rUw==
X-Gm-Message-State: AFqh2kr0DduIt+2B5QaIlAiYWX9AQPVGFCwv5tWn1hGavoSsDzTkZOCn
        rdF0GAFKZUtd4JfhtFKPfq91aBh0JZHD+7dHi9Y=
X-Google-Smtp-Source: AMrXdXv0sp3ahcL8gKO+yjMOfPCd/U9ZVkxn/l5h8JzvMhFxQ+jT+YwPhyHfQpOd2HgH8SfU6Avcsw==
X-Received: by 2002:adf:e303:0:b0:242:1926:783c with SMTP id b3-20020adfe303000000b002421926783cmr46592217wrj.58.1673479967502;
        Wed, 11 Jan 2023 15:32:47 -0800 (PST)
Received: from titov.fritz.box ([212.102.57.19])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d67c1000000b002bc7f64efa3sm7679308wrw.29.2023.01.11.15.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 15:32:46 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1 3/3] t7527: use test_when_finished in 'case insensitive+preserving'
Date:   Thu, 12 Jan 2023 00:32:42 +0100
Message-Id: <20230111233242.16870-4-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111233242.16870-1-rybak.a.v@gmail.com>
References: <20230111233242.16870-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most tests in t7527-builtin-fsmonitor.sh that start a daemon, use the
helper function test_when_finished with stop_daemon_delete_repo.
Function stop_daemon_delete_repo explicitly stops the daemon.  Calling
it via test_when_finished is needed for tests that don't check daemon's
automatic shutdown logic [1] and it is needed to avoid daemons being
left running in case of breakage of the logic of automatic shutdown of
the daemon.

Unlike these tests, test 'case insensitive+preserving' added in [2] has
a call to function test_when_finished commented out.  It was commented
out in all versions of the patch [2] during development [3].  This seems
to not be intentional, because neither commit message in [2], nor the
comment above the test mention this line being commented out.  Compare
it, for example, to "# unicode_debug=true" which is explicitly described
by a documentation comment above it.

Uncomment test_when_finished for stop_daemon_delete_repo in test 'case
insensitive+preserving' to ensure that daemons are not left running in
cases when automatic shutdown logic of daemon itself is broken.

[1] See documentation in "fsmonitor--daemon.h" for details.
[2] caa9c37ec0 (t7527: test FSMonitor on case insensitive+preserving
    file system, 2022-05-26)
[3] See mailing list thread
    https://lore.kernel.org/git/41f8cbc2ae45cb86e299eb230ad3cb0319256c37.1653601644.git.gitgitgadget@gmail.com/T/#t

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t7527-builtin-fsmonitor.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 76d0220daa..2c271b4d7e 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -910,7 +910,7 @@ test_expect_success "submodule absorbgitdirs implicitly starts daemon" '
 # the file/directory.
 #
 test_expect_success CASE_INSENSITIVE_FS 'case insensitive+preserving' '
-#	test_when_finished "stop_daemon_delete_repo test_insensitive" &&
+	test_when_finished "stop_daemon_delete_repo test_insensitive" &&
 
 	git init test_insensitive &&
 
-- 
2.39.0

