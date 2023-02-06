Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93A7C61DA4
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 23:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjBFXIf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 18:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjBFXIU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 18:08:20 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA77A30EA0
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 15:08:18 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id e22so9426233ejb.1
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 15:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8mRbRkuojhf/gN9c7/0s8do/Iwdi7TUUbli2Iwy+Ug=;
        b=m1SXSgAe6zv5nuWpqGvKuC5W739Cc7SM6HCHecUYXw9NofTDOi+Y282CU/r0mvOAfF
         dhMAv1WaLSyYvNB7YeJwmamV+uQhbP/2cc2pjRSjqxyWpSH4WWV1jI5EWHMiK1ngYtXe
         vSK+MDFYZUX9XJFIvk6kAo1mhANFjgVcOS5nJhOBpyaClU/pmxwaxxDyaXutDe+q2O0d
         PUQAy5e8CssWub4PVB9W9oy3FwQo7C0lNYTyKYkbxmvrDa7QBmZpIDdCSjOqlb9FaUzI
         1h7DYrEVbPuJR2K7yoL/4S3SnmpWdaJa/FHcKAQUvX0zIEiUszxJDXxsLH3lSOlrrIPz
         8RMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8mRbRkuojhf/gN9c7/0s8do/Iwdi7TUUbli2Iwy+Ug=;
        b=hpZmuqNfrhLNB30cQH6NnHqAi6D+NIte1tPr7BCsDCLcjdoomb5qWDouONP5oG4uWu
         kcBAdER6CpVphpPFlCGqBUqBNbp0ssp4SIDVbI6bMFar/Re/soJooVB646E5XwmiVw7Y
         P9A1XhhZYifC/R9jrehYiJBI4vkdMvHgK5Nfb7rRow1jQgC5WEJ8KWrcdpV5423HhwyK
         sBb9ailo/I0IUkMncLokzdrEJll5EUxgYYuvE5YgOTaZ9wd2EqBxunI/vC8e2JO4GBGX
         qY3IG/tHSwuSiHp9tqMDkdaqpKh8z7pgpyNNWE2nQiCXVY8FvKNZ3gqFcNp5C8FTMrPQ
         OSbQ==
X-Gm-Message-State: AO0yUKXJahC9BF0tQYm2PoJvUzMrEulT/KVhdPpI4OjzxjuwUj7OcFak
        1EkftNvoRruD0Nk9oKNb92+ZUngwSNFXgIhI
X-Google-Smtp-Source: AK7set94LPC9W6Q4UMhPy7oqKWAPaXUgLgI6AIwFa4ozc8oTyKrAnevnb+PAlqukaDFDe+H+GOXO6Q==
X-Received: by 2002:a17:906:824c:b0:859:1d78:765 with SMTP id f12-20020a170906824c00b008591d780765mr1130589ejx.11.1675724898208;
        Mon, 06 Feb 2023 15:08:18 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906a18f00b0089d5aaf85besm2673586ejy.219.2023.02.06.15.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 15:08:17 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 09/19] http-backend.c: fix "dir" and "cmd_arg" leaks in cmd_main()
Date:   Tue,  7 Feb 2023 00:07:44 +0100
Message-Id: <patch-v7-09.19-e657992ad14-20230206T230142Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1425.gac85d95d48c
In-Reply-To: <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
References: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com> <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
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
2.39.1.1425.gac85d95d48c

