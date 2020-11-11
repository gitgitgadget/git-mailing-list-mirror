Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46960C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 12:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E344B207BB
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 12:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLJ4my2b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgKKM2w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 07:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgKKM23 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 07:28:29 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C658FC0613D6
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 04:28:28 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id d12so2306018wrr.13
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 04:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dpll76Bt0FuWoTL59TONqXQ0KGL2T+WUdIsjig1jOUg=;
        b=SLJ4my2ba994nD76xmDnmA999YufP9qjgNUBCrSTalSmlVtPwGpkttbKY5Phb8B3gC
         mE560W7aRMeRuw3SminCxsZ0Gj2+70NiJMClotzJJGWrMki2epoa8nFXE7ZTz6gk8/Iq
         lyE75wfAj80F3+flyJMdl7fk7ICsPGQRmsTrcrm3xTEJa9OS6dGhJGdR1IT7/D1JNN4V
         2JE7iRbjyq8mUIyLhJeL5E0pw8FI5VAanybfvE8Qb7zUJKntqqM60vUvwua1zyzNtYtl
         otXkP47zONMAcZzN+6svRqZa8q4E4yB/NyJl+JtpgiRzw5SbWUxp5hQMhqAy/PYneZWU
         TE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dpll76Bt0FuWoTL59TONqXQ0KGL2T+WUdIsjig1jOUg=;
        b=n/2qWgntibF+swDtSnub5s7oBKU6gMnLl56SAwkWPKLiqza114So1HzP6MrimSEgzw
         0Aa9icPEHaAvHOvDKCAZVXZLbsQhCc7p97gWpX1iR4QwsIzDOqj4cRuCmJ798C+5TVdG
         I320ICWhHFJ8XKvHzdpyYz3GgCISA8V5C2rfIgLUoMii3bHciHYDzjs/h+UpoI3uqDEm
         9vfwRiERpc6liYUYjhw+O0Z12U4gZtqoeRk3EzHZLLgJ4+OxRSrhG1+cBn13C8S6fJQE
         uSg1kqzP1LzIMii+2YlEmyqI63Vi3lR3H9wTroDYXWoumyEyZcm3zZSAm/Mr72uVMQ/D
         y3RQ==
X-Gm-Message-State: AOAM5307UyL5lVe9HevBL8f6DqA5MPCOpqVo3Jl3V6CK1JwSt8RO4zpq
        kW32b2sBBlU+8u8O2wMK7LLuWfD4Ai4=
X-Google-Smtp-Source: ABdhPJyhhD6t4F6BS43eLmO/jVhjUu+nINcxZP2QC85XP3SZnQHgeWWLULrF698ajXRigdb4XL9stw==
X-Received: by 2002:a5d:6447:: with SMTP id d7mr28906118wrw.96.1605097707402;
        Wed, 11 Nov 2020 04:28:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a12sm2344695wrr.31.2020.11.11.04.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 04:28:27 -0800 (PST)
Message-Id: <068813912b9e5133f9d9bbacb239f7954788bf53.1605097704.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com>
        <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Nov 2020 12:28:15 +0000
Subject: [PATCH v2 02/11] add -i (built-in): send error messages to stderr
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The Perl version of that command already does that since a301973641f
(add -p: print errors in separate color, 2009-02-05). The built-in
version's development started by reimplementing the initial version from
5cde71d64af (git-add --interactive, 2006-12-10) for simplicity, though,
which still printed error messages to stdout.

Let's fix that by imitating the Perl version's behavior in the built-in
version of that command.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/add-interactive.c b/add-interactive.c
index 8ca503d803..0f24992ca4 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -365,7 +365,7 @@ static ssize_t list_and_choose(struct add_i_state *s,
 
 			if (from < 0 || from >= items->items.nr ||
 			    (singleton && from + 1 != to)) {
-				color_fprintf_ln(stdout, s->error_color,
+				color_fprintf_ln(stderr, s->error_color,
 						 _("Huh (%s)?"), p);
 				break;
 			} else if (singleton) {
-- 
gitgitgadget

