Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41627C4332F
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 02:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbiL3CTP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 21:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbiL3CSv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 21:18:51 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594561707D
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:49 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id i9so28881115edj.4
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UhFr1CSb/9yv6NlmxFi4aysJq20IKGEdJxGQGezW9A=;
        b=IajM3YkWt/ZmMf9GrEyK8nafa0oVqHh504XoYjDjlQFibl/J4RMGZfzR3wK/qC2WfT
         PyppwXZO+OXy/W1U5jQxum+KrbfkZqmHOtS49U4oaa9YrxTBIViClmeEwWErk1r3tAhM
         9+1lPLFGsCUFXBhe5yAbOIvQHBLKT7SbJrK5lgk06UGhyRzmQ4dJIg39FhAkdSqCn8Ax
         DAVU3Gn0PRWozmsuivx8tCMJQQVStbDV60bxO00V4GCeH5YDJpURNsri5/Q8KB5vzaNR
         82uSCUTL6hohigL5UTewAshqCwoNFNMIaEofnjwmIyNkOnnWaemX4CYxoEUWUzROlCj8
         2ePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/UhFr1CSb/9yv6NlmxFi4aysJq20IKGEdJxGQGezW9A=;
        b=ew5Jp+NrYEI3ofm0nwx/2igp/tbHLLdsAEUoLn/rsrhlzh76ueeVS2QgkWpebMDM0D
         C7v63gl92fRHyzjYFA8L5iihUaK2kfbmoD7+yhXVcSVaI9a8TPQqarvr+X3/i99rYrfQ
         VXGuApBUSJ32wteGPY3sTwm82kCn38vhCARG0teXa4R+sr76FsockSShk1H8kqeg3F2r
         S+fgmzgnnIL+5x+FPebUxUQbKxwdn4ud74hedwojIfOZlvjVxneB7LwASw4NTNjgn530
         WMCp6OqLY+KAZ911G1Box/RwKqLEXOJH18Rxg8bBQUvsz47xfZgYoQpvr5APDiww2Nxj
         M4sg==
X-Gm-Message-State: AFqh2krImvMQE/K6Jtxx+s0sZzQ7UVHN6vGQiKVayqgZ/NDVqwoH9OY8
        T3hTz5SijqU3TOBBVBu2NtAvA+Y6CnuKBA==
X-Google-Smtp-Source: AMrXdXvgr8I82plT60g+IZ9b+zEKSFW0AEBEpuRRZ4CpMUlScyvCxyH7pwEVj0gVTo3XQEG6EyRavA==
X-Received: by 2002:a05:6402:2a08:b0:470:4d71:6d43 with SMTP id ey8-20020a0564022a0800b004704d716d43mr28308621edb.25.1672366727572;
        Thu, 29 Dec 2022 18:18:47 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay15-20020a056402202f00b0046dd0c2a08esm8861991edb.36.2022.12.29.18.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 18:18:46 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 09/20] http-backend.c: fix "dir" and "cmd_arg" leaks in cmd_main()
Date:   Fri, 30 Dec 2022 03:18:24 +0100
Message-Id: <patch-v2-09.20-8c5c964d872-20221230T020341Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.g589e4efe9dc
In-Reply-To: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com> <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Free the "dir" variable after we're done with it. Before
917adc03608 (http-backend: add GIT_PROJECT_ROOT environment var,
2009-10-30) there was no leak here, as we'd get it via getenv(), but
since 917adc03608 we've xstrdup()'d it (or the equivalent), so we need
to free() it.

We also need to free the "cmd_arg" variable, which has been leaked
ever since it was added in 2f4038ab337 (Git-aware CGI to provide dumb
HTTP transport, 2009-10-30).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 http-backend.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/http-backend.c b/http-backend.c
index 6eb3b2fe51c..67819d931ce 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -786,6 +786,7 @@ int cmd_main(int argc, const char **argv)
 	if (!getenv("GIT_HTTP_EXPORT_ALL") &&
 	    access("git-daemon-export-ok", F_OK) )
 		not_found(&hdr, "Repository not exported: '%s'", dir);
+	free(dir);
 
 	http_config();
 	max_request_buffer = git_env_ulong("GIT_HTTP_MAX_REQUEST_BUFFER",
@@ -795,5 +796,6 @@ int cmd_main(int argc, const char **argv)
 		setenv(GIT_PROTOCOL_ENVIRONMENT, proto_header, 0);
 
 	cmd->imp(&hdr, cmd_arg);
+	free(cmd_arg);
 	return 0;
 }
-- 
2.39.0.1153.g589e4efe9dc

