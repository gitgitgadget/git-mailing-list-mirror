Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DC3ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 20:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiHaU6S (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 16:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiHaU6J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 16:58:09 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFE6EA171
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:58:05 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id c7so13140031wrp.11
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=whP68Gd/EiQj+TzRQqsLhcuwk4nFviheC/Zx1O4SZQI=;
        b=THFcQyhyAr1i41FaxWsUGlhJAaDORZ4zhopOzlY9cyeIynNOK9tuvwAbgUbuByC7cu
         KhaiyOj/5CLZUsc5TGelv0ZdgcR2nePZJ4pp10s/l6jPR3Euv0CIho9lO1Jz3Nq3uGBY
         nrpNJD6PTOoU0GVRAV1SJbn7nv7G2a6IvKqY5xmxQkzORU9BzL79RPaCbVmapxdmn9pa
         aZakteSG7kA9dNB4RBH4I0VWEmie9NaKrEes8479i8pSALAkJAivUbFs53suhUeLXtoW
         Ty2TDy1oNru4giUE47KqHjdLLm9ygwGWbm/Vq8lmzmb+Gfg0QlppDYy6C0zxMGBDxs9Y
         Wp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=whP68Gd/EiQj+TzRQqsLhcuwk4nFviheC/Zx1O4SZQI=;
        b=CvtBO0Z+tBwhtOWP5Oa3RkQah8dchsf2Qs13PA55bA7bNjxqpqgcTXOnbJsxM+jgBP
         RyLuRnXxsQlRJ8ry+S7muFm2qFi7DBx8r5PEyLdOsSMQ6Y6JJo4eWy/ZDK9yCxfIEGzg
         jUANVOf3nwu8feWZZTEXKIvgsqYEofhDybtvZE2JEo+fS2Y+F0IeESqf3dCZjvczcfn8
         N/NOeWqlJfnee/TCSg5qFQHCZJs7KhR7CfkohSJlWnBmUpyH8wzpMhgFfzq8/RyJUdb1
         mOs9zRQE021zH0/Sx+2oAtm61nd2boMOPTpSTfqLhwHeZCjuw51P7EboYyObu/s2rPk3
         AIWg==
X-Gm-Message-State: ACgBeo0/l+6665lculSQmfqaxEsmXDeza5uPbQLQZHRKFivCsctNMkEf
        +xn39Dr+fJt1WKJAK9/Rg820mT7XRxQ9vw==
X-Google-Smtp-Source: AA6agR5gqugSutnYGEDwsfxMYbBsWhoDR0Z0BaTfscN4zX2NfSHgG5SNrlcjgtf6kH1/yXJulcGanQ==
X-Received: by 2002:a5d:64c9:0:b0:226:dfa0:3fa7 with SMTP id f9-20020a5d64c9000000b00226dfa03fa7mr7569322wri.350.1661979483173;
        Wed, 31 Aug 2022 13:58:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i16-20020adffc10000000b002253af82fa7sm15766955wrr.9.2022.08.31.13.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 13:58:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/9] cocci rules: remove unused "F" metavariable from pending rule
Date:   Wed, 31 Aug 2022 22:57:48 +0200
Message-Id: <patch-v2-1.9-72b6a8e4e0b-20220831T205130Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220825T141212Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix an issue with a rule added in 9b45f499818 (object-store: prepare
has_{sha1, object}_file to handle any repo, 2018-11-13). We've been
spewing out this warning into our $@.log since that rule was added:

	warning: rule starting on line 21: metavariable F not used in the - or context code

We should do a better job of scouring our coccinelle log files for
such issues, but for now let's fix this as a one-off.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/coccinelle/the_repository.pending.cocci | 1 -
 1 file changed, 1 deletion(-)

diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index 072ea0d9228..747d382ff5f 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -20,7 +20,6 @@ expression E;
 
 @@
 expression E;
-expression F;
 @@
 - has_object_file_with_flags(
 + repo_has_object_file_with_flags(the_repository,
-- 
2.37.3.1420.g76f8a3d556c

