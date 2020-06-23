Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD4DC433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 10:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE3C42072E
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 10:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLlzEDvk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732201AbgFWK2V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 06:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732076AbgFWK2U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 06:28:20 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82228C061755
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 03:28:19 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b4so18233613qkn.11
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 03:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=03T/1SBccsrL8MxzlNoP+D0VvWFvUBc8YCfO8LcdObA=;
        b=PLlzEDvkZlSUB243tCHTa2y8+j1owYMDxiq4g6pN8NtlhBY0wIgTL3mGW6aYN0wqeE
         FXGNBPGFp2YUg2CTxlU0mTrV1sl/rvAmb2h1aKQkLe348gObOLdw7XDOPpucSuXPBD3o
         yifP76cpB0JipruDVqMN2q7bjGyfEQPifFZLlFYiqyzm2NASl1fThgiLXnDS8CCnRyk6
         08thEgQ0zKAx3bcWOIFx+lVZkSaHFs1DOqwinHIAXeCCmltvEBkzxxvHs3O1Q6JrEEbc
         I/JputkHq2+fsraP7ePNkkb7fMJLiSbqtK6OhkE+io3aSoS8fGLTBYfZqkEAm+I0zI92
         GNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=03T/1SBccsrL8MxzlNoP+D0VvWFvUBc8YCfO8LcdObA=;
        b=buacEUpL96TRUqDKW4ZSjNJNuYum2TMmIMEYfaXB+XriDXf88kh6eBmYRwyLNvY59Z
         b8swwTeKT3XpKCiZrxiT6gkFaaPrXgU43Xe0hjxTsnRqttqFlAab6561shPgiPdFTSDT
         3Dnu+DEOildRDBpJw6f+0lyVLUCZU5l0uN1fktqiJS4/FfZkpHjxS7wxvM/1fo3CfVAO
         eNDDU7/ksRy0dHayGwXDziULpgd1NndNt4cQTE0WGTlUpw7KbvGLZDdjZGm55xF6usLS
         kL38fj++Y30gnlihT6jJOlakUehxka5jKOI07ET6Kuy3c146YEUdKd4Ulo0MiDOMnI+h
         ly5w==
X-Gm-Message-State: AOAM530wdGB9cZwDnZ8iAEyV6S+dqMUltzAGy9YJa7Uve/KLGuz2+QMP
        Y47ZqrKZdyky8Hew8xwn9EOx1ivtzy8=
X-Google-Smtp-Source: ABdhPJzUVZ86RP8m/M0AQZvLmXwqkjeivYRxAeE/0ykjgZmJktAEykO1wCodMaIDTPwnw8HRG5DtcA==
X-Received: by 2002:a37:8946:: with SMTP id l67mr17169016qkd.457.1592908098550;
        Tue, 23 Jun 2020 03:28:18 -0700 (PDT)
Received: from archbookpro.phub.net.cable.rogers.com (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id a126sm153795qkc.82.2020.06.23.03.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 03:28:17 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v5 1/4] lib-submodule-update: add space after function name
Date:   Tue, 23 Jun 2020 06:28:02 -0400
Message-Id: <ba2f642e0f505730d5d740207128036448787c8c.1592907663.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.132.g321788e831
In-Reply-To: <cover.1592907663.git.liu.denton@gmail.com>
References: <cover.1592470068.git.liu.denton@gmail.com> <cover.1592907663.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the shell scripts in this codebase, the usual style is to include a
space between the function name and the (). Add these missing spaces to
conform to the usual style of the code.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/lib-submodule-update.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 1dd17fc03e..122554acd6 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -183,7 +183,7 @@ test_git_directory_is_unchanged () {
 	)
 }
 
-test_git_directory_exists() {
+test_git_directory_exists () {
 	test -e ".git/modules/$1" &&
 	if test -f sub1/.git
 	then
@@ -309,7 +309,7 @@ test_submodule_content () {
 
 # Internal function; use test_submodule_switch() or
 # test_submodule_forced_switch() instead.
-test_submodule_switch_common() {
+test_submodule_switch_common () {
 	command="$1"
 	######################### Appearing submodule #########################
 	# Switching to a commit letting a submodule appear creates empty dir ...
@@ -629,7 +629,7 @@ test_submodule_forced_switch () {
 
 # Internal function; use test_submodule_switch_recursing_with_args() or
 # test_submodule_forced_switch_recursing_with_args() instead.
-test_submodule_recursing_with_args_common() {
+test_submodule_recursing_with_args_common () {
 	command="$1"
 
 	######################### Appearing submodule #########################
-- 
2.27.0.132.g321788e831

