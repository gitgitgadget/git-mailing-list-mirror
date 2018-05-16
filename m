Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81AE31F406
	for <e@80x24.org>; Wed, 16 May 2018 22:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752336AbeEPW7o (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:59:44 -0400
Received: from mail-yb0-f201.google.com ([209.85.213.201]:46449 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752318AbeEPW7m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:59:42 -0400
Received: by mail-yb0-f201.google.com with SMTP id h199-v6so1258975ybg.13
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=pBpXJA0BpA5FzoP7pKkacABLppEWe2bVPMqkHZZWEos=;
        b=cWGCFkuMCUWOpOd/kNepm2eszDlR99nVmFNPG1S1HQKi187nKUjaoyiY9LCMVIFK00
         uDdQo2rGmevxVRRBENq3yxAbhD3TcDn+QnTLHWZYfIbVC7J/oA6z7SlHoLIs+K2xf7k4
         UHp1eQRao2L1kI/Xc+m/29Sp2NXV2SUE5RtVErCdjiCqqQeYg0P8SjDmlBsKReBlkn9c
         WrKlz4sXch9LM815Wvn5K+5MsZs+Cag1t5nQ52IXwkGEcw3OH0srB2fKm7PH2DTMCqsm
         MbJoe+LOK8OqyaTkJeAbdD9ilU7LE3uicTFhjfxOL7dGuqmwRFrRb/r/Yb8iGuN+E9f2
         QCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=pBpXJA0BpA5FzoP7pKkacABLppEWe2bVPMqkHZZWEos=;
        b=FUNX4/5NiKbXg6a7ytlaSo8vB4cDyIfE7PrjUgtc3RBNQ2AO6a1jcQH2kICdVu7ReL
         Yt7KspwiTBz6QAkWktAsOdakLC2gqogqLfZG3SSBaIr/tC4qDvzmixXtWxtiQPysof2X
         Cq0dzxZywLDqcLkhgg03IhRARlCFtzOqNNHIxXvEXR1UfiV/hnZTYCAJLlyqhGTXh/Dk
         dEY3I1azxEUeY3+wUdJvii5YWKG5wLHNu+bVuiq+GE9/wJpDYcNLMFhngpCUw8xZ3GKN
         EKamLosJhNQpbwE/H1AqKUFsVzm9cuvBN/DUmGa3hq0LbjYMW/qsLrIvs16hky7t3vnh
         wdEQ==
X-Gm-Message-State: ALKqPwc7uXRaklnD9K6eL26UVmUWYi5dwmk2Z6DdPW3kioChnvfqXI86
        NY9MqXfbL6RQYIC8TrGDESRfZ8CFb7lXcDczXucrPL5W+5vtbb5Vrf2t0/nEjqusL+tAQhbyia3
        +LwJ4x2lxeN8OTWGO1mrPHBwvCCtPTcBGpceBuuakBHLuZOB+cjhCv3PpPA==
X-Google-Smtp-Source: AB8JxZpZHTUr5WjWczVEoV0dh1WPzrXUNTVw5Br66LjJPTge+yXnCsC636dGFbBe3vAxiRD029P865orCuc=
MIME-Version: 1.0
X-Received: by 2002:a25:cf07:: with SMTP id f7-v6mr964262ybg.76.1526511582132;
 Wed, 16 May 2018 15:59:42 -0700 (PDT)
Date:   Wed, 16 May 2018 15:58:14 -0700
In-Reply-To: <20180516225823.235426-1-bmwill@google.com>
Message-Id: <20180516225823.235426-28-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com> <20180516225823.235426-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH v2 27/36] remote: convert match_explicit_refs to take a struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        sbeller@google.com, bmwill@google.com
Cc:     avarab@gmail.com, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'match_explicit_refs()' to take a 'struct refspec' as a
parameter instead of a list of 'struct refspec_item'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 remote.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/remote.c b/remote.c
index 9eb79ea19..84dda3fd0 100644
--- a/remote.c
+++ b/remote.c
@@ -1073,12 +1073,11 @@ static int match_explicit(struct ref *src, struct ref *dst,
 }
 
 static int match_explicit_refs(struct ref *src, struct ref *dst,
-			       struct ref ***dst_tail, struct refspec_item *rs,
-			       int rs_nr)
+			       struct ref ***dst_tail, struct refspec *rs)
 {
 	int i, errs;
-	for (i = errs = 0; i < rs_nr; i++)
-		errs += match_explicit(src, dst, dst_tail, &rs[i]);
+	for (i = errs = 0; i < rs->nr; i++)
+		errs += match_explicit(src, dst, dst_tail, &rs->items[i]);
 	return errs;
 }
 
@@ -1302,7 +1301,7 @@ int match_push_refs(struct ref *src, struct ref **dst,
 		refspec = default_refspec;
 	}
 	refspec_appendn(&rs, refspec, nr_refspec);
-	errs = match_explicit_refs(src, *dst, &dst_tail, rs.items, rs.nr);
+	errs = match_explicit_refs(src, *dst, &dst_tail, &rs);
 
 	/* pick the remainder */
 	for (ref = src; ref; ref = ref->next) {
-- 
2.17.0.441.gb46fe60e1d-goog

