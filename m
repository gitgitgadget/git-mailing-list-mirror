Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D38C32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 12:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjARMrP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 07:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjARMqV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 07:46:21 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62178C908
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 04:08:43 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id vm8so82680329ejc.2
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 04:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1S66g0/FOvoaQegikCviNJQ9JeEQ/H1N+dWenM7mios=;
        b=m5I+RU169L1uXGvDpzfcQjyzRkf7hVcIaYnYz+yByzM36sg35g8v+wvwZ0NjVTpsNL
         Z6NnZsqVeUs99usHdQ7ZfJ+OCTvA/ckqPcMpufwZfOWxM8h5udIjPoKySG5nld3PEtBo
         kNkIh9fh6B/yRUrk5gOA4C2KGpJME9szs6jn7Z7HkM2bwFHyu1+Eh9XuUtjyhO0R6Skw
         Ull+AxN4kLOSF3F1QlXsBzjVtVfJ45UUhk/A2u95FSmFl+YyU4SEhP6Lr139rJRG3s7n
         eJt+TU0yYwdQm5+alE1sK/WDNFWs4cn/5HH7xHDjQrZHNxSDOe6sVjdwk2yFEw0AIMzg
         HqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1S66g0/FOvoaQegikCviNJQ9JeEQ/H1N+dWenM7mios=;
        b=0Dt5vEiBo0+mqqsNUEqeBgEmaZEYMjYVIxtCMfjx6d1NLridsxVDBOvW+coa5gGy+b
         srPvj/BzMkT4w/QNmsw9SqOkJErcrzdxY17YZLWg97JsPjvuTbRFkbi0KfcJbsZsSykm
         4M2AThHerkN6C+CFXzHxquqxWK7oubtmq5XL+lzEPKiHatyTJ9JvtaUrW44Bf0wgxacV
         PWGHNhUlGvzg8EfY9v29jAccPSSWf4TZKRUej40HMKhEHqWincm1pufMnjWBF7rigIj0
         nFOorl+Jhn+HY7zCmyyVN7mB4kx5sKgPd0mk7Z3M8/YMFKL1tjSIflJPXOPyagT7cucz
         HCyg==
X-Gm-Message-State: AFqh2ko8gc+U459+/jSLdkxmNKDTzXTpaMNjH3LMns/necn/SZNpsDJ2
        +X+oLf0Sj6Xl8pfXTLbylmBV18olL7udIw==
X-Google-Smtp-Source: AMrXdXvwHm/Mjq/D8OrbmEAO5sT8By58cb2zDFfH8l/KvI1GwTD/PY4Xl082URDsPESr1+Ors47Lqw==
X-Received: by 2002:a17:907:8b97:b0:84d:39ba:368b with SMTP id tb23-20020a1709078b9700b0084d39ba368bmr7866146ejc.75.1674043722227;
        Wed, 18 Jan 2023 04:08:42 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b15-20020aa7c90f000000b004615f7495e0sm14120053edt.8.2023.01.18.04.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 04:08:41 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 09/19] http-backend.c: fix "dir" and "cmd_arg" leaks in cmd_main()
Date:   Wed, 18 Jan 2023 13:08:22 +0100
Message-Id: <patch-v5-09.19-b39d6d29dd5-20230118T120334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
References: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com> <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
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
2.39.0.1225.g30a3d88132d

