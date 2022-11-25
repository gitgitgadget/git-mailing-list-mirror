Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2ECFC4167B
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 10:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiKYKAD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 05:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiKYKAA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 05:00:00 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1034CBB5
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 02:00:00 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso1263080pjb.1
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 02:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxH1/XmBrYsTzEudaDun1sRbh0Ptu4jfoYysmH8ZBY0=;
        b=CQPOufb64gCluZDDkXUMgaEUXp6NG2vPQ2FqqCGZDTAW8152iu/2QNTdLmm+7xk+1a
         L6J2NsLw7z/Zwi1701nUB/hv5sY+BkGcg2Rl67MuC4TXWM3JD6oGnrTAS/O5vZML+XaO
         Swa/9EqWqRCkszPpODPJa3DNNQHhDdbpdD8g+E7ig1GZoFxbp/1D8fCdYMeHkML7tnhB
         hEbXbPXU4TDhQtjDArkDTL4bmbqCHGeeDsD3rr941RnhbufKTCeDGZyi5OFNgKDT9wHt
         ktkFx80siJlfSyIdDFwgvZmAk1RRmknOesUpMZCmqEX7A+yoj1F4Q9PLWmjQi3hP9syO
         pJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxH1/XmBrYsTzEudaDun1sRbh0Ptu4jfoYysmH8ZBY0=;
        b=gPjrwkvU8S9wdO1N11lTs8ENMiejN5/gthOo1ON0tzbghlBAGydsQid5uqHEyTEI4g
         +07a54hLeb9TqdRI7XrtMkv7tThsbC6qz6uQ93p5e9IyOm76KfMFH0jQPuEk3JrIY5RV
         +bn6NRqPNmmR9q/HQaPBrpGvaNaE+Ryw6VvTKJJdhe+fGRJrZyCm0HfR/EOiDx9rkP+2
         oyclfR48Se29mO71yZb2fI2MKc5gy+CWW4BbVAka5g/nCwCuC3oLc8UavWBTGNvT3A9o
         QH0urDoAvRAYkj6IIIf95Ba2seJwLf22Oc7VcLT+T15q2BrRwyyNyh3/kjswlNvaNYa4
         Bkfw==
X-Gm-Message-State: ANoB5pnV7Fu7R7MK3EF8bajoDu5g5MtAISXleHYAK7yQiHkIeus50qTS
        Z23m3M6BDRwhqEBBabRN1NvJ9hQAE/4=
X-Google-Smtp-Source: AA0mqf5S+gnOpNrxOm7rpxwasdygYeHvVRX4L9FOglMpdkhu/Gt2ZadWbbZ1FscAubyiA4MGJ7S78g==
X-Received: by 2002:a17:902:f313:b0:186:59e9:20f6 with SMTP id c19-20020a170902f31300b0018659e920f6mr22630011ple.39.1669370399357;
        Fri, 25 Nov 2022 01:59:59 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id bd12-20020a170902830c00b00186b0ac12c5sm2904514plb.172.2022.11.25.01.59.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Nov 2022 01:59:59 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v4 2/4] ci: remove the pipe after "p4 -V" to cache errors
Date:   Fri, 25 Nov 2022 17:59:52 +0800
Message-Id: <20221125095954.4826-3-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20221124153934.12470-1-worldhello.net@gmail.com>
References: <20221124153934.12470-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

When installing p4 as a dependency, we used to pipe output of "p4 -V"
and "p4d -V" to validate the installation and output a condensed version
information. But this would hide potential errors of p4 and would stop
with an empty output. E.g.: p4d version 16.2 running on ubuntu 22.04
causes sigfaults.

By removing the pipe after "p4 -V" and "p4d -V", we may get a verbose
output, and stop immediately on errors becuase we have "set -e" in
"ci/lib.sh". Since we won't look at these trace logs unless something
fails, so just including the raw output seems most sensible.

Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 ci/install-dependencies.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index feefd6e9bb..97a1a1f574 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -83,9 +83,9 @@ esac
 if type p4d >/dev/null 2>&1 && type p4 >/dev/null 2>&1
 then
 	echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
-	p4d -V | grep Rev.
+	p4d -V
 	echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
-	p4 -V | grep Rev.
+	p4 -V
 else
 	echo >&2 "WARNING: perforce wasn't installed, see above for clues why"
 fi
-- 
2.39.0.rc0

