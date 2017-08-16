Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67D0C1F667
	for <e@80x24.org>; Wed, 16 Aug 2017 17:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752226AbdHPR7L (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 13:59:11 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36633 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751841AbdHPR7J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 13:59:09 -0400
Received: by mail-lf0-f65.google.com with SMTP id t128so2959330lff.3
        for <git@vger.kernel.org>; Wed, 16 Aug 2017 10:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=LUc59hODwzgARKEp6B6vWJMCO0FwUZK0B1rVw567sIk=;
        b=faCuoGm0j/+N0weDjXU4/wbBIZxjiLZwHB93/NW8KvDr54pwqePp14B9IS2aSbP3W8
         tNmor+CuC0rs8cyv9dyqpguElm4iGTTrRNZIDhht9vWpSXR1am+nYvd0soBf2yUFZ8Sh
         sLoVMrIeLa+hXJrs6a0mKbEfFpxePOKsPW5+MyS6eSoWhG4D9TxeTzdAnCz6cyY5nSvt
         NHQbYF+grXh++fW3vnNP/cAvGaC5m6ca/cZHKWUIAglBF7SnEE5YE6EiOLNlBZsMO5Bl
         v8YScWpNzbLc5na2gF2LyrPQrt4RWhb/kSu9bkeKbdVJauZhocPcs0Anf/EXynenTQ+/
         fPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=LUc59hODwzgARKEp6B6vWJMCO0FwUZK0B1rVw567sIk=;
        b=ja+dk3weBdBu0Gqw2Gz1qHzdgNthXI/N+hubMfdjjIXN2f95FRF+WOEMOpCC9nf4Yh
         OFHOR5dFBNiS9AG100BguRXqzPsB1nor7a87keGlAaOceqihr9AweiK02DCwloazS3Mt
         n+JuntbJcleRpaRVIrlLfySYjQGYlfjNHKiOKUeQm5W8DXjDc+PLcdcFI7A/MpQoAY85
         RA8Aiqi3dbmHicheP6PKYUl6s95YHsR5HJuASOQML33x7qggJHMZpfd9zkE3ZnenqC1h
         +Jc/a48FJmQSckhVJuQWzz80Lgq5q9MV4a+m98QTYnlJwBPxCC3cIb5rTIxIFcW5ndDP
         nwPA==
X-Gm-Message-State: AHYfb5jQ+BFY3eyf5Ktn+AyPtgOw/uUdNYpWc6W21AHxmkqjty2r9OtD
        rzkLZvGeaA7/e9EmBd8=
X-Received: by 10.25.42.92 with SMTP id f89mr1002428lfl.227.1502906348004;
        Wed, 16 Aug 2017 10:59:08 -0700 (PDT)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id c64sm361245lfc.4.2017.08.16.10.59.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Aug 2017 10:59:07 -0700 (PDT)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     Patryk Obara <patryk.obara@gmail.com>
Subject: [PATCH v2 1/4] sha1_file: fix hardcoded size in null_sha1
Date:   Wed, 16 Aug 2017 19:58:22 +0200
Message-Id: <bc6dc9fd13dfb6539af994c662eebf2474e731fb.1502905085.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1502905085.git.patryk.obara@gmail.com>
References: <cover.1502796628.git.patryk.obara@gmail.com>
 <cover.1502905085.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1502905085.git.patryk.obara@gmail.com>
References: <cover.1502905085.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This prevents compilation error if GIT_MAX_RAWSZ is different than 20.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 sha1_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index b60ae15..f5b5bec 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -32,7 +32,7 @@
 #define SZ_FMT PRIuMAX
 static inline uintmax_t sz_fmt(size_t s) { return s; }
 
-const unsigned char null_sha1[20];
+const unsigned char null_sha1[GIT_MAX_RAWSZ];
 const struct object_id null_oid;
 const struct object_id empty_tree_oid = {
 	EMPTY_TREE_SHA1_BIN_LITERAL
-- 
2.9.5

