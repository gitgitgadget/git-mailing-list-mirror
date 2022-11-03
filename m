Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C79C4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 17:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbiKCRHr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 13:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiKCRHN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 13:07:13 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB411E70B
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 10:06:30 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id b2so7033197eja.6
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 10:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w56S/o3RdnYgXLgDvvymXTKgCYGkN2TM4AeXlHeAAZQ=;
        b=d9RtmOMF9UaLsCfWWFuOAjQuF7I3in5hLs0JnyGvewX4KLTRo59HkFPCFs0FGOttVB
         pcPVo9k55sv5baFx2wau/2EEG/Sz+vdjdYuvegt2Y6CWrtCHhI/Vj53VccuhXoEZcGl1
         AYct5vPrSeAMHuusz2yuqGIOLAaR82V/r+2c38m3hA3Ski9phkY2WFo42QtfDKgiW+eT
         8D+spxWD2EcAqFKPeQSf6/IgNj46pyzg2UZg7Zw2ONzuSnww+iQtesfNBqKXCGuK0Of4
         22/ZrRxQtXcno1ybiywTUFApHYDhXiafjO9sCOfBR9lSg7ouMr+9VzRfeRdwH1hxTgFI
         mI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w56S/o3RdnYgXLgDvvymXTKgCYGkN2TM4AeXlHeAAZQ=;
        b=AA1dwBpzD4GTLxFknCGxkfh6E444Q1iU27smou5OrPmrNaKgTLZIX6+zBNsDp1s/Hn
         oue2kzxUCYjpSZ3FMCvxiEM9t19FYtB1ujucunSWNzaq7RlV2CMpux9FQbGykBjtMu7l
         XpOz86mYERN66qmEJbjsqtVlHzjNUukODXtJbz9A++Wdy8levQFBmw8o7RhtyHu3nEyS
         drcn5428i/uMdwed0rgvVRf5PesLnopQXTdJtxYJEc5frtWsZWcIvfy7PgpKrnFyWYwF
         WIVovSRqRZrnl3pWtT6/weaINRFbaP53lo0kUxSGascKQRC+XhlzD65vnbjcyoC7Hi/W
         Ixhg==
X-Gm-Message-State: ACrzQf0q6QBghMHW2oj6ENreJT3PcWaaw+rkndAuVvebFdrx6chQYB5/
        sisXm3aGyihxqCPOj0xX2+dwrRCMDi31qg==
X-Google-Smtp-Source: AMsMyM6mnTXfPwWn/hCRgjlZ/Gr1DWGTznUEpadWXDAiuT0zrWDpCoBZ040vDb31AeO0zxz0Uz39Vw==
X-Received: by 2002:a17:907:1dd1:b0:7ae:1075:202 with SMTP id og17-20020a1709071dd100b007ae10750202mr5674518ejc.118.1667495188993;
        Thu, 03 Nov 2022 10:06:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v4-20020aa7d644000000b0044e01e2533asm741882edr.43.2022.11.03.10.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:06:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/17] sequencer.c: fix "opts->strategy" leak in read_strategy_opts()
Date:   Thu,  3 Nov 2022 18:06:09 +0100
Message-Id: <patch-10.17-9c70bfa334e-20221103T164632Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1451.g86b35f4140a
In-Reply-To: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When "read_strategy_opts()" is called we may have populated the
"opts->strategy" before, so we'll need to free() it to avoid leaking
memory. Along with the preceding commit this change various
rebase-related tests pass.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sequencer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sequencer.c b/sequencer.c
index e658df7e8ff..07d7062bfb8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2894,6 +2894,7 @@ static void read_strategy_opts(struct replay_opts *opts, struct strbuf *buf)
 	strbuf_reset(buf);
 	if (!read_oneliner(buf, rebase_path_strategy(), 0))
 		return;
+	free(opts->strategy);
 	opts->strategy = strbuf_detach(buf, NULL);
 	if (!read_oneliner(buf, rebase_path_strategy_opts(), 0))
 		return;
-- 
2.38.0.1451.g86b35f4140a

