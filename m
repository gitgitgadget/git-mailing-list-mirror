Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A950DC32772
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 16:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353115AbiHSQdQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 12:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353072AbiHSQae (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 12:30:34 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B7711C974
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:04:49 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id u6so1134755eda.12
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=0w3QJrc2uO384dX6CbYxlnH4w7urTVUUth0afnoUl8g=;
        b=o7W95yxG7JQtyD0Lsa/2jdSN8zBX64B4cq/guDLpGnek8RxYvavDhhfb+eXqRX82Lf
         zBFZ7BK9iiYd5+czz4tPUBuykKAEGLgnQUMJYPXD0HpVbkhRjwgD5ox6hWGykA1LdYrM
         ePLhtr9KYGmRjcfWHUcEW3XX3R/ASTTdSxzorBngFCSq9wQ8tGhnw1VhTfW8Y8uVQYl3
         akIfRmVl2pXEgERwn6RVk2Xejywv1vDwc+5Cj51vo2WerA2AyGtSjXpy2FcMGuSdbXkT
         c8JSs3CC+7wFn5JXi9f3Xb+SJVfppodGSPKqf2Lk5r8MuycRXV9F2da6o91uPNm4UiAv
         a5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=0w3QJrc2uO384dX6CbYxlnH4w7urTVUUth0afnoUl8g=;
        b=ep/ZDn7Dszm/rar9i0TzHgetLSdW7CkblmqUsTVAfoZ0SDveH05gvMmwqasXxNsl72
         qV6atMeJCFiXfJgy4Y/L+07AxVid/sOB9bQGO2qn9NzfRsMttui6EhGcXzo0DYkztpP9
         bCqxZ7BzSGuV09TM9aq1hhYBYjKWPe5h3vBCuJj8m5ONAcD5dLMqkI8+1gU5wmwwv55l
         ktG5nUs+CjShEUAcGjZqya3RedGhr9ZcTX9vsktnSgQDXq9dRrbbo6l2V+YlA8ph9ifu
         ua+pJBP/gifDc3NIyUQ9ubjt0hz4H3mKv/ru5hGSJHE54XjLktxFE5KNs2opXObi9BP/
         21Iw==
X-Gm-Message-State: ACgBeo1cCcjRidOsP9TM6Bc2ueEQLYgWn6HyTLSHnrj+zbr2W9ftcb5w
        9rMKOrMrKe6F5hkAPPUCHI1tlwwQ7Yw=
X-Google-Smtp-Source: AA6agR6LfeCod22GgTy+utfbm6tFlDGa1gz3FrQOLfPhw0nSSLGTTBmk5ih7jq99JrHwOZBfnSgghg==
X-Received: by 2002:a05:6402:2753:b0:43a:d6f2:9839 with SMTP id z19-20020a056402275300b0043ad6f29839mr6412709edd.73.1660925087309;
        Fri, 19 Aug 2022 09:04:47 -0700 (PDT)
Received: from localhost (84-236-78-250.pool.digikabel.hu. [84.236.78.250])
        by smtp.gmail.com with ESMTPSA id l13-20020aa7c30d000000b0044604ad8b41sm3270236edq.23.2022.08.19.09.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 09:04:46 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 08/20] parse-options: drop leading space from '--git-completion-helper' output
Date:   Fri, 19 Aug 2022 18:03:59 +0200
Message-Id: <20220819160411.1791200-9-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.2.817.g36f84ce71d
In-Reply-To: <20220819160411.1791200-1-szeder.dev@gmail.com>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220819160411.1791200-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The output of 'git <cmd> --git-completion-helper' always starts with a
space, e.g.:

  $ git config --git-completion-helper
   --global --system --local [...]

This doesn't matter for the completion script, because field splitting
discards that space anyway.

However, later patches in this series will teach parse-options to
handle subcommands, and subcommands will be included in the completion
helper output as well.  This will make the loop printing options (and
subcommands) a tad more complex, so I wanted to test the result.  The
test would have to account for the presence of that leading space,
which bugged my OCD, so let's get rid of it.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 parse-options.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/parse-options.c b/parse-options.c
index a0a2cf98fa..8748f88e6f 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -620,7 +620,8 @@ static int show_gitcomp(const struct option *opts, int show_all)
 			suffix = "=";
 		if (starts_with(opts->long_name, "no-"))
 			nr_noopts++;
-		printf(" --%s%s", opts->long_name, suffix);
+		printf("%s--%s%s", opts == original_opts ? "" : " ",
+		       opts->long_name, suffix);
 	}
 	show_negated_gitcomp(original_opts, show_all, -1);
 	show_negated_gitcomp(original_opts, show_all, nr_noopts);
-- 
2.37.2.817.g36f84ce71d

