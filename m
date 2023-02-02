Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBAAC05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 09:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjBBJxs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbjBBJx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 04:53:28 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B5A15C97
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 01:53:07 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id n28-20020a05600c3b9c00b003ddca7a2bcbso898937wms.3
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 01:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BRz6X9PHYgefLRa/6Sx1Su7ZnsBell+RWhr9HOZec8=;
        b=Z2d2HgXY5Hn0S8iqi/O3Z1nJi8UFEw3h1AiEuxfRzR/N1Bery4Wf6KzPJyP49j5Zfn
         4lXsaW+8pBFQkYIH7UycAJLvOnWuv66nLWe/AAb/LO8KcURAjilVgNnAWIEk9iwYRnAn
         1cTiODHUG0C48q0EFEhePhqXdFzkXuaJA5VUpXBZ2SgLLmRhL+vRIF+c3+m70jTNDbBp
         GO8nnvA/KkeVozm6lWcq1zvhfWtDGL+WcSOP0gkynComBe0o8stkpwqXvLZf+LzHzObY
         rqyaIlOJAQTnF/bq5wAwqLPHwheNyqC3EOgCpkQS1Jxv+S8rCtDcPs0I9KHcAs5wTnTk
         yxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BRz6X9PHYgefLRa/6Sx1Su7ZnsBell+RWhr9HOZec8=;
        b=fk082oKSV1XESsGJ+SxHxxEilf/PnljbwxaTO09EsmixeIBWytFrRvBFVFPnRuB0jZ
         eMYiONB85VtGbNtkVbVVU1ibkIEGcyXjN/pDYZ2pObufBybr2YVXU9TPgeZXz7e2UY63
         RPxVeXGHPguvgyZogztgADW7CDNf7Dz/m9iSPB4HMJ6PNhWUd7mQ4MgcxZkItzOiCq69
         oOlKK4dKzkVwrmV87pjejLUI6ihekY2E1Gf5EDyXJVj/dMJ67i5Z5lec8+6+Ag6KhSc9
         tXyk89XufYJ0MCrryn8EWUeVafDQLVH6DQjJ0MpJ7wIol4GolK2TNeNfpDrhtgT15Ugp
         d3Dg==
X-Gm-Message-State: AO0yUKVskAa82wUAs/2gS+ykG1LJ21QdfXQgRweZ48Uey6a6n7ECb1Ll
        hF2NyHDqDe5/1vW3gjhUxroEk5ursbKkDFPN
X-Google-Smtp-Source: AK7set8jd/yF+yaxJsX6EdL4aGYgc3BKbVFp9qRocNrLGhXpc81O7htEBPZYVLuWyiVmyyg8b+YUHw==
X-Received: by 2002:a05:600c:1d86:b0:3da:1f6a:7b36 with SMTP id p6-20020a05600c1d8600b003da1f6a7b36mr5732752wms.0.1675331585829;
        Thu, 02 Feb 2023 01:53:05 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i13-20020a1c540d000000b003db03725e86sm4356234wmb.8.2023.02.02.01.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:53:05 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 09/19] http-backend.c: fix "dir" and "cmd_arg" leaks in cmd_main()
Date:   Thu,  2 Feb 2023 10:52:40 +0100
Message-Id: <patch-v6-09.19-e80a719913b-20230202T094704Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1392.g63e6d408230
In-Reply-To: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
References: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com> <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
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
2.39.1.1392.g63e6d408230

