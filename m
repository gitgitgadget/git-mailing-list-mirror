Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FB871F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 00:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfKLANw (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 19:13:52 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44910 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfKLANv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 19:13:51 -0500
Received: by mail-pf1-f194.google.com with SMTP id q26so11927692pfn.11
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 16:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nfAMB1glDUrQIgKd9m5b8vTRJ6+ViA1X+vKhax9Hgrk=;
        b=HXV2SvmeZKTcvS1cf4Ho5jx0+2BkKhEjyanOq1qMHmtFuR1C8KmHqF8gmfpNK92cyF
         xC04H+FgkxMKtXkXV4y9XqZTAZG+Q4XP3FP3CBIs/3yhwde2l8vQsXSEcCQXl0n6hIFZ
         ybLWMmo11u8Xo70ugGY0sgIqRTfEiHtAkF8JAFc5goGaDfLBT3Occn1oM3fMbJqSciE9
         rlV9CV70T6vVspJMk+/yOLPGnH0jTVCtRidetN4Npl/HiqZnwsNenTPmsTWfr72Qny2E
         kKkGNHl8xULWd4w4/p6U7FaUbR5P0JAJmzeyt2Uv6cuyZ1oUdegA3b3q5m7pXE84uxeg
         +RHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nfAMB1glDUrQIgKd9m5b8vTRJ6+ViA1X+vKhax9Hgrk=;
        b=khT5mH8/ptKIBAi3PoQF38RInPdcLA/gH8uIsrsvg6XsMaJVebjaMdE2J8nS9X8DnF
         GY//hGLwgguYPhGW8hcPP7iAWT5xHgre8XyYdOyhYeqZorWEZVS1hbgUuEjo51upuodS
         nrqZ24H8DIfVmQbb3rOGgJe7bpqDlwjeRr8z5ZCZbPXqI5ssetyXRmAsnTWh2xCAvQr6
         K7AgK0KqDsf2lOxJJv180GsIrjgZrfnRVxekYwFD5DzDpkaCEc4lHvDQd/h6TQT+qC06
         L5RBZv+f8M59AnRdZUulogZ5KT6fcVwZ+rH8SP1QejM0xArbOqwmcbHDhSqdQcXJGoXR
         ThFw==
X-Gm-Message-State: APjAAAXWY9vp0ORyvMHpmaVDl/HZWIA/xkTPqlvAPIrKTrqowmWqOvr/
        AJxvE2T4wzPLZMai1bseOD+TpFcg
X-Google-Smtp-Source: APXvYqyUoAONozz+hoPgYFp0wZnJQXRc8WzhQf8ByJ5PrMbEf7qfOdhJXdaUUwPc6JfNkcZPCMhllw==
X-Received: by 2002:a63:6581:: with SMTP id z123mr31918390pgb.367.1573517630516;
        Mon, 11 Nov 2019 16:13:50 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id u24sm1646517pfh.48.2019.11.11.16.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 16:13:50 -0800 (PST)
Date:   Mon, 11 Nov 2019 16:13:48 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 04/14] t5520: let sed open its own input
Message-ID: <d2fbae6ade04c6e30071cfc207f712ef5e5c7f67.1573517561.git.liu.denton@gmail.com>
References: <cover.1573152598.git.liu.denton@gmail.com>
 <cover.1573517561.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573517561.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We were using a redirection operator to feed input into sed. However,
since sed is capable of opening its own files, make sed open its own
files instead of redirecting input into it.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index a3de2e19b6..55560ce3cd 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -5,7 +5,7 @@ test_description='pulling into void'
 . ./test-lib.sh
 
 modify () {
-	sed -e "$1" <"$2" >"$2.x" &&
+	sed -e "$1" "$2" >"$2.x" &&
 	mv "$2.x" "$2"
 }
 
-- 
2.24.0.300.g722ba42680

