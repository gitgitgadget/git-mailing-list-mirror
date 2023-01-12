Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B363C61DB3
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 12:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjALMqo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 07:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjALMqP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 07:46:15 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF5217E19
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 04:46:14 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id vm8so44459638ejc.2
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 04:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=su2b20tJPkNBsJYxXc4+4zXQMn19sbEWgsfF+5lVhB8=;
        b=qNHtrKlEQDTwnaDImebrHWaX5ITaiYQzhumjwqqJcUXKkB3D7KtgU4sjWUfOc9bd7/
         h3a533KkkcLeQzdddzJbYl78oBpZ9chS5hIp/jlPpTkzLfzC1s/cms9qRBMh69/2pH/I
         nSDxjf6H0HoqQ0yAXGrGC1c/4M4F0awIU1nJaxnCWD8dcmPjLAOwIfTYE3/DCTAkNR4l
         9UELIiDxbBPUyK9P26rkRvCww4t84Jq2NJgiMWpBxP0YAwfQo/z4ajcPbqjNJbJsImuS
         BD7isf+UN0sYA/GgNjanpMYyVP3TDSCQVfcPrueTudul6Qo3NlsrlUzun8uGh4yJksvq
         V+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=su2b20tJPkNBsJYxXc4+4zXQMn19sbEWgsfF+5lVhB8=;
        b=QdavG+MjiBG8lNL86Hks2QFn3mn3wGgT/J31L+YDpKmYaaflv+T1BMM/Xh6pXzCP4j
         a8jinw9i3w5WJqOmmVsZFQkkTELu0FLiW3aoWMjiS52T+TgyT7mSzfXxF6xeYBN9QYHd
         MXoeA8L9JRjPyaQhbuHO07qe2yI4quPrhqpPI4dMFSax7NqQaMoWHDaoJFZI8CgsATMf
         zndD+1cRRoeSmfg3tKjf747RQdhQTswDVK8VF4FyKriUL4oXjIkxczozf2nXQIpHwzVf
         bX4yy5gVP1ulatS4q0BlMwXHF2gfFTKzIhHOY64aeOiT7Cmvw1p3gfvqJUmzGEsPV7uv
         NewA==
X-Gm-Message-State: AFqh2krwgjWIwluVyfK1YnEzEaIRcMDoMS7d8qEAJ1Cl6ylz/dWFZd2K
        W8bbiReh+u8bOgXTOfYaTIWFDuinPdE/Ag==
X-Google-Smtp-Source: AMrXdXsyi3HE7T1hqFuQKe3TOvRLN5HbpVL7C7m5jtOmefm3X2gxKwnCx/InkoM0j7ouKHSMcksI6g==
X-Received: by 2002:a17:906:6881:b0:84d:4d6c:a462 with SMTP id n1-20020a170906688100b0084d4d6ca462mr11195890ejr.25.1673527572783;
        Thu, 12 Jan 2023 04:46:12 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v17-20020a170906293100b007be301a1d51sm7373523ejd.211.2023.01.12.04.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 04:46:12 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 8/9] builtin/rebase.c: free() "options.strategy_opts"
Date:   Thu, 12 Jan 2023 13:46:00 +0100
Message-Id: <patch-v2-8.9-d4b0e2a5c83-20230112T124201Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1205.g2ca064edc27
In-Reply-To: <cover-v2-0.9-00000000000-20230112T124201Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20230112T124201Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the "strategy_opts" member was added in ba1905a5fef (builtin
rebase: add support for custom merge strategies, 2018-09-04) the
corresponding free() for it at the end of cmd_rebase() wasn't added,
let's do so.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/rebase.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index b4857b89f19..4a5a34de6e2 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1835,6 +1835,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	free(options.gpg_sign_opt);
 	free(options.cmd);
 	free(options.strategy);
+	free(options.strategy_opts);
 	strbuf_release(&options.git_format_patch_opt);
 	free(to_free);
 	string_list_clear(&exec, 0);
-- 
2.39.0.1205.g2ca064edc27

