Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0911B1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 05:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbfA2FWF (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 00:22:05 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37990 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfA2FWF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 00:22:05 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so20521190wrw.5
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 21:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vWc5/f532QW6EynJZlIY671NQMxy3PpskJg8B9OXVE8=;
        b=Ct9QKkDBO0araE752ISaO9X7bJOAv3KUVsgKcctH3mTj6680DtfdH4eL8XMiEQC03v
         XQiLLnElXcuupXEukcIey7G10krVGe6Nc27NpNdPVsclgOINPEBYi2WOKueDirZvFwWd
         j7XbkiVD4Ggi61/oDa/+GW1xnlyNY8eteMVYhtx92o1K3x5MClVxsQeG1I+kVpYUpWdI
         dc4C+gIZ5v+wPB6m+SlQ69RqYttyYy0x3/VQRyDdjg7Rdi2AfqThbEUWbqCZIjgRzZrR
         kzXSmMLn+c/1bPafzNKxgvQ0ievFqYSOZBvbKn/+qAKRem24CKZH7+ve1spnxBskiQva
         +MYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vWc5/f532QW6EynJZlIY671NQMxy3PpskJg8B9OXVE8=;
        b=WfXk/IC14PCskM5ECW2mQonUBVdUq+Nqqbnf03QgHKDzkoZqBjVEk0SAV/TKssHzA4
         viU6vvWC0K6lLXAtUkZ6D+bQ+BicQF/yd9yr556udZ/E1Kev5TkuTUvz+sxzIqcKglE3
         Hvr2BPQjfxkuxe5wrQ0Qlyo9DnSiiiVZFitJAGeYmWTVCOdL43OFzBaqLM2xsQUcgeWN
         gSuQA8yaAPUGYy3PrG/AyRB2j4leVt80yHpCGxcyBmCKcmaAAoMQAZLfo/mqAns34tw6
         ER8+FHdKSpOrU57QixR9I1ZE52h2Y6o0Iga6Gsh1R4wiUvAge+1aSYdFjYtgw+JzaucB
         sB5Q==
X-Gm-Message-State: AJcUukd+zpABiKiUMkDfw4Z8ZvTiqNtTwruZEUx12Z6cHDX8YTlNfmg+
        3O9cwu6NsETsTMs5UENyc/jrTm3sGMM=
X-Google-Smtp-Source: ALg8bN5CqmmhAXUhHNGIlRE+1TjclzcmRODtl9okm45UUKaYC0rw0KwGtSSVv/JVK9pA1MMOrd1z4g==
X-Received: by 2002:adf:f785:: with SMTP id q5mr25557207wrp.9.1548739323321;
        Mon, 28 Jan 2019 21:22:03 -0800 (PST)
Received: from localhost.localdomain (ip5b43d796.dynamic.kabel-deutschland.de. [91.67.215.150])
        by smtp.gmail.com with ESMTPSA id g67sm2906294wmd.38.2019.01.28.21.22.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jan 2019 21:22:02 -0800 (PST)
From:   Sebastian Staudt <koraktor@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Sebastian Staudt <koraktor@gmail.com>
Subject: [PATCH v3 2/3] Setup working tree in describe
Date:   Tue, 29 Jan 2019 06:18:58 +0100
Message-Id: <20190129051859.12830-2-koraktor@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129051859.12830-1-koraktor@gmail.com>
References: <20190129051859.12830-1-koraktor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This ensures the given working tree is used for --dirty.

The implementation of --broken uses diff-index which calls
setup_work_tree() itself.

Signed-off-by: Sebastian Staudt <koraktor@gmail.com>
---
 builtin/describe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/describe.c b/builtin/describe.c
index cc118448ee..b5b7abdc8f 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -629,6 +629,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			struct argv_array args = ARGV_ARRAY_INIT;
 			int fd, result;
 
+			setup_work_tree();
 			read_cache();
 			refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED,
 				      NULL, NULL, NULL);
-- 
2.20.1

