Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3875CC433FE
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbiCUXYe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbiCUXYS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:24:18 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2EB309B30
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 16:17:52 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m30so12864572wrb.1
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 16:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=exnyaHsDjteyZjXb1TCEQzrcU6CA7VXMSpYM+Hd+zho=;
        b=bPdbsUwZHnllyWFncnX1sdbvW1gIKyP1NBUjvok11TFJFXe2il5KwkKPksT7IjOsDf
         5FDJs2YU6SsDF/95JkUXr6OUEZzOYLkeiutNROUO32PYlgjZYQvjFDeiD3N1zO8cw4Jc
         PAWwQOqB4rXDUeMRo/Qi7P2m3Hz4yxbMZ5juGi1svuD9NpriQMA1Srm9DmKxi0qacCI3
         vwhFBsIMAGaztdg007AwgG5h/YcpQNfpmuFp/PeYH2LH3uQV/ikkNgir/R1p6i0KTGYU
         EIOykvqE70E/9246Trm7DfKC8moeZ061zPRgeS+Zy0H2g7HDPi4ze96fDB4vL6OHdTvW
         hk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=exnyaHsDjteyZjXb1TCEQzrcU6CA7VXMSpYM+Hd+zho=;
        b=h16Y2V+BITTYhs+RsAJNClCMB3KgsOeRS9qASipbqZFBS7vPZTLJZBi9jKVucHkHOE
         PpIBOnfqIPKkaBbS4BtV96aqTXy0mydomltgiqvDO+pKFYjAdagHbeskdF7Ti4FWVMi+
         yogRvacxsdBuNzKyTbFBLdV/fkGFBggeYC54yI397U4lCYhLo4w1lRfqeRUYv18c13gD
         HHV6+15pqZvxHWpvCJL1k8g8WqW2j5DaRray/Hu47KiWNUf3FqxJmIfTo2KZDsuFq1Wd
         ZLC/euq7D9OodZzXfCkf/CFDGFC0VTuPzwaEQNCwerhtqOPOLvvUTJuBgiUDccRvd9gz
         OE7Q==
X-Gm-Message-State: AOAM532yKoMWBPHqYuHY6pVTbdlXrmKiJvfjdowlc3cOha8KzWnCONxO
        KV8wcVALA3+0hZU1Njv5jBGfP0mGIeMIYA==
X-Google-Smtp-Source: ABdhPJwcG9vJPhPOHnGkqL8Ad0cYrF3DuOw991QRKYxD+yQkCyyHLKDmCNRcaDaD1lYFB+utnOJfAQ==
X-Received: by 2002:a05:6000:1689:b0:204:19f5:541f with SMTP id y9-20020a056000168900b0020419f5541fmr3937259wrd.704.1647904670446;
        Mon, 21 Mar 2022 16:17:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d4e08000000b002054b5437f2sm21831wrt.115.2022.03.21.16.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 16:17:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] hooks: fix "invoked hook" regression in a8cc5943338
Date:   Tue, 22 Mar 2022 00:15:13 +0100
Message-Id: <patch-1.1-d0c9b430b2c-20220321T230933Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1441.g1e9a595f48f
In-Reply-To: <0220321203019.2614799-1-jonathantanmy@google.com>
References: <0220321203019.2614799-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a regression in a8cc5943338 (hooks: fix an obscure TOCTOU "did we
just run a hook?" race, 2022-03-07): The "invoked_hook" variable
passed to run_commit_hook() wasn't passed forward to run_hooks_opt(),
as push_to_checkout() in that commit correctly did.

Whether we ran the code contingent on having run the hook or not was
thus undefined, but in practice on most (all?) modern platforms we'd
have run it (almost?) all the time, since stack variables will get
initialized to some random value, which most of the time isn't "0".

This bug was revealed by running e.g. "t5537-fetch-shallow.sh" with
the --valgrind option. Unfortunately running the whole test suite with
--valgrind is really slow, so we didn't have a CI job that spotted
this. The --valgrind output was:

    ==31275== Conditional jump or move depends on uninitialised value(s)
    ==31275==    at 0x43C63F: prepare_to_commit (commit.c:1058)
    ==31275==    by 0x4396A5: cmd_commit (commit.c:1722)
    ==31275==    by 0x407C8A: run_builtin (git.c:465)
    ==31275==    by 0x406741: handle_builtin (git.c:718)
    ==31275==    by 0x407665: run_argv (git.c:785)
    ==31275==    by 0x406500: cmd_main (git.c:916)
    ==31275==    by 0x510839: main (common-main.c:56)
    ==31275==  Uninitialised value was created by a stack allocation
    ==31275==    at 0x43B344: prepare_to_commit (commit.c:719)

Reported-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Mon, Mar 21 2022, Jonathan Tan wrote:

> This commit causes Git to fail Valgrind (tested using "cd t && sh
> t5537*.sh -i -v --valgrind-only=10"). You can see here that a caller of
> run_commit_hook() expects invoked_hook to be set, but...

That's a really stupid bug, sorry :( This fixes it.

 commit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/commit.c b/commit.c
index 98b2e556653..ec1207ebef4 100644
--- a/commit.c
+++ b/commit.c
@@ -1732,5 +1732,6 @@ int run_commit_hook(int editor_is_used, const char *index_file,
 		strvec_push(&opt.args, arg);
 	va_end(args);
 
+	opt.invoked_hook = invoked_hook;
 	return run_hooks_opt(name, &opt);
 }
-- 
2.35.1.1441.g1e9a595f48f

