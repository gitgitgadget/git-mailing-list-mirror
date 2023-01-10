Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012A3C46467
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 05:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjAJFor (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 00:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjAJFoG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 00:44:06 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822C441A60
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 21:44:00 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id vm8so25800789ejc.2
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 21:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+yNTeOcfOqu3TBJBLGoZmsttx8g2gxlzpL4rYp8WM8=;
        b=gl/MVB0Fx16dfa1oCCpZZzEURk6cK/ygj3CXxwU0bNZcgxVUOwXuUurDGFKOe8A74r
         7QLT4w2h8lZgX5pfX6LoF58RxVJXX/hZZw5G6ePXdNa4XYlIMVUJSEWJNG0J+NeYZ+7F
         97lLy3QynI3IbJ3p4Dtc6+v+gVv3jTRL97Rn2TJWXwL/zwU0B/0UgmQvm6eJp7+94vPA
         J8vVaBNZXchLw56HHXXd6QxKERp+88BgUD23ubPyHJcHoO7SxVHMLEEm9oCctnh6HIrR
         ik9MByfIpKIY/1u5TZOsE/CMarXmjhGc7NaLJx3MQLTkInbqqmFJfVgBejHE9LxI91c7
         V+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+yNTeOcfOqu3TBJBLGoZmsttx8g2gxlzpL4rYp8WM8=;
        b=CTIqh9aGqlGJYR0/lrzruWG7ec5s0XudQQh5vJaziCEJjpUt28NWvZLOGvJljXelIC
         HBjHfUCCF2ekLSQMwg4X9f5vEB27yPJlu1ahfRAlc1uwXO2MFfV/4ckHAYMhildBnEB4
         k0rq0JTtfLpI3bvQsgSJBq3vYkl9LgiWWsNQs4VVvs+9EGAfz/+LxY9gv5Ffl6wdFh27
         nlnCQDfPfgvJCZWwkMdjwdERUMUl9y5KJ+UZT+fBvmy1gOe601V67WB/I+6oqDhszlfC
         dXNMjvdI7g6ThEhG8zpLkVqM4A4FdgSmzhTdimIKRy+QqmdOtezsI3TX29xW9iDsI5rP
         KkoQ==
X-Gm-Message-State: AFqh2kq4nSn8uq/LS3uRqUIpe4YkeEspXnHvZBTotrQbQ2Q8SoqbBC/P
        TGCKBrHV4e0+S152hCkPS5/aSH7Onn9RKg==
X-Google-Smtp-Source: AMrXdXs53bKlWpHvHpZ79O84SMYy0IS5NrX1URWrfaYJFN2GS3NfU6Q9lQoK7vAI6QYNUBshl/hJHw==
X-Received: by 2002:a17:907:6d85:b0:83f:748a:5c6e with SMTP id sb5-20020a1709076d8500b0083f748a5c6emr94008107ejc.71.1673329438806;
        Mon, 09 Jan 2023 21:43:58 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906869500b0084d36fd208esm3428423ejx.18.2023.01.09.21.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 21:43:58 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 09/19] http-backend.c: fix "dir" and "cmd_arg" leaks in cmd_main()
Date:   Tue, 10 Jan 2023 06:43:29 +0100
Message-Id: <patch-v3-09.19-56204806dfd-20230110T054138Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1195.gabc92c078c4
In-Reply-To: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
References: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com> <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
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
2.39.0.1195.gabc92c078c4

