Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6385BC433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FE6361249
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240020AbhDLLJg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239971AbhDLLJd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 07:09:33 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287B7C06138D
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:09:15 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id p6so5759679wrn.9
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p/hvGIzGPDCKVC/OKdQxESjHYzzNU9xdyNR3xIBKbkA=;
        b=QOXfTUHpchVZSEFVVw1yzeRP3rutPSSsNiWj0T8L9ybel8EvZNylG/gFmHwBXT/DDf
         P65il2J1ffjVe9+djhHpL8nP8DlaygRaAS2AFt0ocGk8X7RXCa+tGPda/nCYbKWZT7Jl
         yTwnz5GQyeMeuKnt/F/6aKtr8T3O3+qhtZ6EdgBgDkbGcUS+r9xaur+Jh42oOvSP99Gu
         AnNwaiCRKjz4oMd38r5bFRGcPrZ16xqG/8HzR+ZWoQqZjcyx3HTgjUo4cFHzNSZs2SLD
         ogo5FWyROrsX0yK1be5cvGOY9wa6e0rXpXMtmyGKgpZlg9a8uEsftLu9KxDj1lm8SphH
         k4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p/hvGIzGPDCKVC/OKdQxESjHYzzNU9xdyNR3xIBKbkA=;
        b=P7NB5RFfHVVcjrJbMawYQrRj150oa+Fl5GUsSHJBLe00hxmI6fy4mFTtAopiY2RzpV
         uuw9HhPukt05Zp6Po2rPAIv5j4tS9a2zkMKidClxXOPdDF4b2Po+jwRrrYz81c1YQtPU
         eLNGGIqlx+iMSSP4W2HILzHmYCcrrhZO5balwO9LaWZYFsDafbCzx5lsxtdRnmUjVeaZ
         Z45UKAL/H4A7ypz3rW4DhxceB7KKZddMc4x9niphtwzfaUbi/i4GARc8NvCr8iqlOg/0
         jZaSSBchTd75F3eXFAyQb63qSswNxM1LSSS40s22vmeedpvbeuguDMYuZWSqe3uga01k
         yKYQ==
X-Gm-Message-State: AOAM530R4M037Y7+3hfcUXwO7GnF6ghQ7hR/u7MlRZVa+bHVPVpcJCou
        2q0nMo9cqbqr4XHIlgR6nQ01Ut/a4+0+ew==
X-Google-Smtp-Source: ABdhPJwkyyCbvYhEjtB9K3pRXW2D2DjnTX6Mvf4dLuostVJfbKFxL4J9PT95H2qDleYC7ExJXkIDaA==
X-Received: by 2002:adf:fdcd:: with SMTP id i13mr16232843wrs.185.1618225753685;
        Mon, 12 Apr 2021 04:09:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a8sm18158744wrh.91.2021.04.12.04.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:09:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/16] test-lib-functions: reword "test_commit --append" docs
Date:   Mon, 12 Apr 2021 13:08:53 +0200
Message-Id: <patch-04.16-4ecce153b99-20210412T110456Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.634.gb41287a30b0
In-Reply-To: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reword the documentation for "test_commit --append" added in my
3373518cc8 (test-lib functions: add an --append option to test_commit,
2021-01-12).

A follow-up commit will make the "echo" part of this configurable, and
in any case saying "echo >>" rather than ">>" was redundant.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 6348e8d7339..d169fb2f597 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -172,8 +172,7 @@ debug () {
 #   --notick
 #	Do not call test_tick before making a commit
 #   --append
-#	Use "echo >>" instead of "echo >" when writing "<contents>" to
-#	"<file>"
+#	Use ">>" instead of ">" when writing "<contents>" to "<file>"
 #   --signoff
 #	Invoke "git commit" with --signoff
 #   --author <author>
-- 
2.31.1.634.gb41287a30b0

