Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D246C3DA78
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 17:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjAQRMI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 12:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbjAQRLg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 12:11:36 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5F73A857
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 09:11:35 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z11so46042718ede.1
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 09:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1S66g0/FOvoaQegikCviNJQ9JeEQ/H1N+dWenM7mios=;
        b=ENVlE6bRorXlj5wHdv5s4iw+fb2hXoFuIoldcEWSKgt3m5ka/gdSBDcbz7ODcayl45
         UIsU4tlqRFLXge5lscUHbaYI+kc1HYKTf+x1h352JLqBKcYFhXta/U7kGDwGRCbFPKou
         pHP541pMUB4FSf+QFLwP2FlZq71CnXLIzGDW5Wn3mo6rmLc3bN0ou0wjLo/xIWOBlzVO
         Kp3qzsbvuTQA3eH+Fpickqx67/Bh9kNb3z+Bixn074KTBwmxep8KqNuAx88X0bKXe4VI
         kHHwH8qTYgEWwf0XE5na15Ffohby9uvq4WvXdwxgawj/G2hrilIUV63PGYvz6KqJkT4L
         e0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1S66g0/FOvoaQegikCviNJQ9JeEQ/H1N+dWenM7mios=;
        b=EU4/XIAlbtW5eyV873aeICWywHgG98wqeQZ2ZVDisW9+O4rw2ss7ZwjL+lXpTnyGNW
         fVXEOX5Wfe5geUgsgoFexcdhZP3VZBk5tzlINz5HydakHGibwQxoMcyQzp70WIRuS65q
         OsGzhblJCqNf2m1lvBeVEIL39fZ1sjENYK15MtigZB7GMolU5zLqAED37ci/UG2WcQXc
         glv5yj6yCy3KSKq2m1BfJ6cfcHQw6b4WzAX0379mrDYwE6qxqjFOIsKzgZ0vmeis3aO6
         e/odtbHECtriEQxEnAT+FTXXVCXY7tQ9RQAeuYDlOrkoqHnmTgdKSoA3CVp92fPexNmO
         dUhw==
X-Gm-Message-State: AFqh2kphtxB2b0puKYVt4wM3A3Hcm1Nq3zEpEsRj6l67qfy7Nw+48yJ8
        1nGN6OtS63XEzg1b74zcLi2MKBGWihYkHA==
X-Google-Smtp-Source: AMrXdXtdRFLfHtU3u6qsL1Cfwf44IngePPi8BaXP8LE4D8sdH5SZolsipi6IXLgbCIRNCZr+e0VeOg==
X-Received: by 2002:a05:6402:500d:b0:499:b604:4de6 with SMTP id p13-20020a056402500d00b00499b6044de6mr16561746eda.25.1673975493807;
        Tue, 17 Jan 2023 09:11:33 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m2-20020a509302000000b0046892e493dcsm13191268eda.26.2023.01.17.09.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 09:11:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 09/19] http-backend.c: fix "dir" and "cmd_arg" leaks in cmd_main()
Date:   Tue, 17 Jan 2023 18:11:14 +0100
Message-Id: <patch-v4-09.19-6b3dd9b15f0-20230117T151202Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
References: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com> <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
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

