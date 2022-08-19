Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB46C32792
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 16:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349589AbiHSQdg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 12:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353053AbiHSQaa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 12:30:30 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AEF10AE20
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:04:47 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id j21so4260309ejs.0
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=la8cAA/aDkbwEKT5ppzCCVWF/u/pF2+B1hvuUvek9Tw=;
        b=cHUflPL6fiv3s1WPDJk/fOjbSHQnluIPFsLk8s0Nw9ExPVVgc6WTOo1OLjYTRXhATP
         Isw4Bz59KLu2gKZYdYD+bwk7Pi7Z73iH7ldcgCZDvJ8KM2A9D65MRo1NU3XDjxYOFTRZ
         e90bWVZSkU1JlkHDiXSAHKQ8hqdtv3QtJwrRhFrq7OB1n9AD1raE9iH/uS5DX6+bmpgA
         +KsOP4uxGqzcCR26P7CpP39WynkBk1aDZdixqNvT9NOXXhqhGlDt5h2G3iHutEInwav1
         dc8n7Wwaje/T5ZDYxDWRoKyUtQ0X8XgM+5poDxHELIxPldsQoNrr+UVFGwBPnjBI/SNn
         C7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=la8cAA/aDkbwEKT5ppzCCVWF/u/pF2+B1hvuUvek9Tw=;
        b=yGxbBdXV5oO0LkVkQ9ukAx/Mro2+3xU1vPCl8vxZZFN9AvO+dstoqMtSNAG0r2w+9k
         EWrSV/awQ7z1tuvlmzluRW65g+/W4tKcFadCQ3C/acv8IPqh6JYSK4GbQJMMsiazDG7G
         uCKzOOq4b8vMvegvEdQKowK9aRR6SxVaWWmadK9KQT1HzYmLYFupYSa5A0T8cMTfp1pd
         Po/XBXMo6kXWFdB04mu5I6UXqEs2GbmMSLpycgwaYEH1isg5lgYSLulHFoBGk0S+85kh
         dq/M2aDCMcJF6Cg3YF/xFlLZuhIcjFWM8cWH4bjGoN4MHDAIMOrriov8Ko0NbGZT4ftd
         77XA==
X-Gm-Message-State: ACgBeo0xQFAiKRk9vslvgr1KvRpZxr7w9tuOdp83FTIzFR2HWA20IeCM
        CJbQpKbXU/J1hRG17FQmU7e98L/z5rw=
X-Google-Smtp-Source: AA6agR44TxKNec+f4m4+9fLLnDkhnl+BdodSY/KDLbeibUhXFjSafYAlnJpPJoNJoH34kNcwUF1Tgg==
X-Received: by 2002:a17:907:16ab:b0:731:55c0:e7a1 with SMTP id hc43-20020a17090716ab00b0073155c0e7a1mr5266102ejc.154.1660925085146;
        Fri, 19 Aug 2022 09:04:45 -0700 (PDT)
Received: from localhost (84-236-78-250.pool.digikabel.hu. [84.236.78.250])
        by smtp.gmail.com with ESMTPSA id s15-20020a056402164f00b0043d1a9f6e4asm3334085edx.9.2022.08.19.09.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 09:04:44 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 07/20] parse-options: clarify the limitations of PARSE_OPT_NODASH
Date:   Fri, 19 Aug 2022 18:03:58 +0200
Message-Id: <20220819160411.1791200-8-szeder.dev@gmail.com>
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

Update the comment documenting 'struct option' to clarify that
PARSE_OPT_NODASH can only be an argumentless short option; see
51a9949eda (parseopt: add PARSE_OPT_NODASH, 2009-05-07).

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 parse-options.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/parse-options.h b/parse-options.h
index 591df64191..8cbfc7e8bf 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -109,7 +109,8 @@ typedef enum parse_opt_result parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
  *				is last on the command line. If the option is
  *				not last it will require an argument.
  *				Should not be used with PARSE_OPT_OPTARG.
- *   PARSE_OPT_NODASH: this option doesn't start with a dash.
+ *   PARSE_OPT_NODASH: this option doesn't start with a dash; can only be a
+ *		       short option and can't accept arguments.
  *   PARSE_OPT_LITERAL_ARGHELP: says that argh shouldn't be enclosed in brackets
  *				(i.e. '<argh>') in the help message.
  *				Useful for options with multiple parameters.
-- 
2.37.2.817.g36f84ce71d

