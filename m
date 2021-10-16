Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDDAC433FE
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AB4A61073
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244146AbhJPJnY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 05:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244004AbhJPJlz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 05:41:55 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C0DC061766
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:45 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id y3so30851001wrl.1
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EDJMqoeaZ+ObsmXQ+Y2NpaFOPm9lLqHvyM9KrsPHNks=;
        b=Hoz4WUCysHRYiLNUMUAlNErKuuJR3PruzFDUHpmZVVjdJ5Pt9dfb8xFlYn74jUO3j7
         7/2pPpW7AqSCFfynBkJ2EEfuhOGzh1NFWk9Yf9Dy7EHIH5vHUcBDLFWKbIUXgsf+3/bf
         xfMICAkfNGyFpAMiGCa1VA6e97MiznzqhDpBGN0WtWLMhG87H/AviV+Ncp8HshC3n47n
         nbXkUgEl0ep5A8/L9BttMoRRGEbIijfgaQxEd+dviITt5uvWZ26sis5vMRRYUKQ7Fc8L
         hETTYjItjHWdqnewG5UAhNyn3sHHXM9o/UwXnCkBDN9LIRX1kp/8eE/ivOCmxrgETdKO
         ldvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EDJMqoeaZ+ObsmXQ+Y2NpaFOPm9lLqHvyM9KrsPHNks=;
        b=2pmn/2EtRT+Pr+ktZNTums/O/6UrxojJZafh2tTCGkPHAq0LFZVL3UPMJy0iXRpOr1
         LJ3cnsPysqQuINZ41GoAboyLD0IrVNH76QK/R3ViOpKy4cOEUm5v19VDqB+7wSkJmZns
         JAP/pllIxXeGQEzHBzJ5qBJhN5Hh5BKDVLje4YRGqZV23T7b9vsvcjF9eueDDmV6Ohhd
         8O/Y9iEioi/elY0cSEFmQHVgKjIsr/NBM7viO7a0dRqxpBJJpPrmQ8NZ6TFMViJeGqsL
         NLPGAvmQk8YwQDln4Ou/nwP8eNzLUWPMACr+71WNxH5hWkczvK63oaG9dzZCzqrD1Au6
         dSAA==
X-Gm-Message-State: AOAM53294IGEMS2h/H72jb+CM3VTQvC4eeHEGFd8EGaXZQgnc+Pr4OQC
        d8qPM43+1VHpi6jHu0qc/OpNMaQnCn1k5A==
X-Google-Smtp-Source: ABdhPJwchhbt63S+CaEOk+LO9G9BsmqTrAMNpPVYaFaWzorDcLRXO4ewIPTsxMrQa0gNHozipOBkVw==
X-Received: by 2002:a5d:4d0f:: with SMTP id z15mr21068260wrt.334.1634377184395;
        Sat, 16 Oct 2021 02:39:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k22sm6993492wrd.59.2021.10.16.02.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 02:39:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 19/21] refs API: don't expose "errno" in run_transaction_hook()
Date:   Sat, 16 Oct 2021 11:39:25 +0200
Message-Id: <patch-v2-19.21-3d630872aff-20211016T093845Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com> <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In run_transaction_hook() we've checked errno since 67541597670 (refs:
implement reference transaction hook, 2020-06-19), let's reset errno
afterwards to make sure nobody using refs.c directly or indirectly
relies on it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 43fe9e6d89d..e90c59539b4 100644
--- a/refs.c
+++ b/refs.c
@@ -2096,8 +2096,11 @@ static int run_transaction_hook(struct ref_transaction *transaction,
 			    update->refname);
 
 		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
-			if (errno != EPIPE)
+			if (errno != EPIPE) {
+				/* Don't leak errno outside this API */
+				errno = 0;
 				ret = -1;
+			}
 			break;
 		}
 	}
-- 
2.33.1.1338.g20da966911a

