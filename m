Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92A6420229
	for <e@80x24.org>; Thu, 10 Nov 2016 20:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964971AbcKJUeq (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 15:34:46 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35149 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935886AbcKJUen (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 15:34:43 -0500
Received: by mail-pf0-f171.google.com with SMTP id i88so151077920pfk.2
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 12:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jFugTh/1ZxMkYzI4m82SR7jT+oEG/hlNqa+flzgGfxo=;
        b=S8mUiyf2DgRzkEFWLGyodx51iJCSCSHh4se9PTVhuP3ZvbR0K0tRkDF0MkpAPNNbKJ
         pJHKWhJgdof9ksOaeHHLX+TWJuvUUYdlNR5y+0lYX95bBJ7B3atxd92alxqeRAw7vMWB
         rzB2lcg1LlQtz/23Iq/WmD7o74WtZV+PvIGYfxEYDbnnmIR0lari9xP6G+QUMPZCAMf1
         aDIxXcfPrxcRCDHnegidugmJsOddRytCsUaKACQRxGYxAfzZPAngUF7J20YLs6La6jtn
         qhmsYQFNMUAADDXqf/yryvGYSY7ERrsWhwkcjGJnI3gH1KJysLegZmgqSIAI7FazyXUw
         zJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jFugTh/1ZxMkYzI4m82SR7jT+oEG/hlNqa+flzgGfxo=;
        b=PHZPhSXotUyNZD1Fxyw6y9pNyPOfRLVOnQg8kmAOhp2bjVnO9xLVSZcIOQ7t267/NM
         BWpQ7P2GTfoQAoQRMtxcLu6Ls8yPcu4E8q8Qun2VLZNKsf//u2iw+ydm2W1iSVhKUoy6
         D8SQ6FUi3/RGK1in9GuSo2ZAhp53C9VZKgWjpPpd9dazr4UqnNQGB51Y1MbxNjVWcTeD
         4vEdVhenJL5T2Pp4GSlYHpRPCUv7OsERJutyQV/HyMYMT9IwZlsk58adtnwJIBYtJ1GA
         M+FAXQf4e/hd5d0vHgDs8t1rFbiSbvKJeiQIZ43M1VFUe+S+24fNu3t2QIBzLICTC2sn
         oOvQ==
X-Gm-Message-State: ABUngvePtvar/Bmsf5sT7SmtIOBlHH2/fYmR4MZT/Nx2FsuS7U2exBXIMojiVyeL7SYlzISl
X-Received: by 10.98.74.142 with SMTP id c14mr13390014pfj.139.1478810077172;
        Thu, 10 Nov 2016 12:34:37 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:b504:dcf8:965a:7ab8])
        by smtp.gmail.com with ESMTPSA id z6sm9322145pay.31.2016.11.10.12.34.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Nov 2016 12:34:36 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com, pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 01/35] commit.c: use strchrnul() to scan for one line
Date:   Thu, 10 Nov 2016 12:33:54 -0800
Message-Id: <20161110203428.30512-2-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161110203428.30512-1-sbeller@google.com>
References: <20161110203428.30512-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index 856fd4a..41b2fdd 100644
--- a/commit.c
+++ b/commit.c
@@ -415,8 +415,7 @@ int find_commit_subject(const char *commit_buffer, const char **subject)
 		p++;
 	if (*p) {
 		p = skip_blank_lines(p + 2);
-		for (eol = p; *eol && *eol != '\n'; eol++)
-			; /* do nothing */
+		eol = strchrnul(p, '\n');
 	} else
 		eol = p;
 
-- 
2.10.1.469.g00a8914

