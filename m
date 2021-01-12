Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A0FC4360C
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4B5523123
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438022AbhALVhJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 16:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436850AbhALUTC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 15:19:02 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30FFC0617A2
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:21 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id y23so3320447wmi.1
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LFiOH14qRqgdLE9TAnn/adGrxlaOUH80pCvXvDHdJWU=;
        b=re/LsWxityNbvYKmcRmvdXIYmuKTyLVpMmqbBIuDYkbAgAtYS2oXGhXB6fkVpDj6Fs
         ePZCA3O54BGgUP84IGLd8mKwd9uI1/MoNT5Z8IGFMNZxHeVUNGTB815xrVOFK37N4FCB
         SixzYKEUZ5jTCqXe1broN5iv0IfxgJtcyT+pv6cW2LrF2i6Bz5RJaX08pQWWWt3yog3K
         M5BomiD9Dn5Wr4xWP4XlynC/HMzUotHCPQ36jGB2l7cypqZsoHDILo8EMGomxbPyEzMX
         mG0Gfpew/gChuEvnr4MeCDqJ9FEaeP4DvOLtLQSyYozR1TYMzJhMfAiX+PsfzfPNxIqx
         0nnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LFiOH14qRqgdLE9TAnn/adGrxlaOUH80pCvXvDHdJWU=;
        b=QifhmGE0chbeifiLLk1P6ULPuCQUUQKFtSdnwkkkF6plpe0TtZp6yZGbln4qMIECrH
         Z9DHL0HqQjT9zmkDUeTQvkEoUg2SJeVNkxDtuyxEgKKqQLGM+ew/29eU066uVkpkfL79
         jFNQWgg58fyCQ2krTLA0iTJk2qmCDitmtk5J9jk4zU6mPFagWq7pc4o5bgwuMgWF+W6o
         LsfWM0y4Tk/TjfZsNFR2LVTjumo6QFu3Da71MMq6KlJcqgZWWps+SlfJuGSwSVtxic99
         UlsU1BbwM522te3ONbbZFyED0xTeKDQR+JV4X3hhlhPMRs1O50rsM6aBjzNBHaH4lOk4
         rqig==
X-Gm-Message-State: AOAM531Mbu3RvaMBn7FFo0nN0RJOXsv/A08hMeAIXvZ7XOKR3VXZuUmE
        jLZ83kAYDMH7QqCJXczeKE+uZ3mu+slNjQ==
X-Google-Smtp-Source: ABdhPJxrbPASpQsQatrgGd6c5ukGG4Cy/lVLwrovCxSsvtYg07/5WJCGDTjOBzPcCrPJ7NGOzhYADw==
X-Received: by 2002:a7b:c45a:: with SMTP id l26mr860405wmi.91.1610482699167;
        Tue, 12 Jan 2021 12:18:19 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c10sm7095374wrb.92.2021.01.12.12.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 12:18:18 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/22] mailmap doc: start by mentioning the comment syntax
Date:   Tue, 12 Jan 2021 21:17:48 +0100
Message-Id: <20210112201806.13284-5-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210105130359.21139-1-avarab@gmail.com>
References: <20210105130359.21139-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mentioning the comment syntax and blank line support first is in line
with how "git help config" describes its format. See
b8936cf060 (config.txt grammar, typo, and asciidoc fixes, 2006-06-08)
for the paragraph I'm copying & amending from its documentation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/gitmailmap.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitmailmap.txt b/Documentation/gitmailmap.txt
index e75eadde63..4e4677018b 100644
--- a/Documentation/gitmailmap.txt
+++ b/Documentation/gitmailmap.txt
@@ -23,6 +23,9 @@ canonical real names and email addresses.
 SYNTAX
 ------
 
+The '#' character begins a comment to the end of line, blank lines
+are ignored.
+
 In the simple form, each line in the file consists of the canonical
 real name of an author, whitespace, and an email address used in the
 commit (enclosed by '<' and '>') to map to the name. For example:
@@ -94,8 +97,6 @@ Other Author <other@author.xx>         <nick2@company.xx>
 Santa Claus <santa.claus@northpole.xx> <me@company.xx>
 ------------
 
-Use hash '#' for comments that are either on their own line, or after
-the email address.
 
 
 SEE ALSO
-- 
2.29.2.222.g5d2a92d10f8

