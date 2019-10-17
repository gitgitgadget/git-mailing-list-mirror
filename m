Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C76D91F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 23:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441758AbfJQXRF (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 19:17:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40705 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441747AbfJQXRE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 19:17:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id e13so2220713pga.7
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 16:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YktZpmrJifjA99PNTOVnRtSLaAx+iks0dLQmMQ/JKCw=;
        b=I2joNaIkMu4d2CRABco8FtbjyIjZ5K6TlX5UT9hNVn+6hTls84rZpKRwg8kL7mzjfB
         92hI5IKEYb3khxZt51Lurstn4kSUQnqT7K+iw4LuMrGut6rWgOfFHGZxfgDp3pnRwEeV
         IaBNUaNY+VIM3yXDoQuBCL8gdpw7SPtgwPa6KZ6R1LFTr+QV/XeO36wHSBIV5IyjdOIq
         mvUGmHKsUEao2HOnYdip9OBASXKQfHq1njuSp8lnjE2+h/fjmU/PpTvTzVmNIRJ3wA/X
         RrNWJ6vOKW2MmlVJ1wB+Ne+2zAcP1zKujzs0rRa1BA3f03CvsbWElEX9gThl7xzraab1
         QHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YktZpmrJifjA99PNTOVnRtSLaAx+iks0dLQmMQ/JKCw=;
        b=dBqaD1SRaaLgo9pXcuB/jZZKyAc3VhFPJdcC3yxPQx/m8tr7Ik7Bccv1MMvTD4BKSv
         ACMhebqaTMnpWcpy0Gp4YoieS99C40lJaE9GpJiC43lsMFgFtebwj8LS39wMF2TO1QSa
         GGhDI9nEsIXoTsmydtr3hlZDjdmI2rRqjGPfAulLg0TI4UfoXOORFudmjm+dI3cVgR1L
         0l++79A2ph5qSR0zpQxxi6xKVRAHLBT3VRZNdpzxbqgmnXmDNSuE27maSvWmQzeyeNz9
         Zpcy79yb2mEumCd45jgWR+fvcqe+eNITsDpCCwKR3Gtv5kiQZwwQ8FEwHT5SMRei9KE4
         t4aQ==
X-Gm-Message-State: APjAAAW8GKFcqRjmCzDMxH+9GiOI+RiTqkuDDklsfXPcJOChqQle4CjE
        VzVo0zkPLEKdwv7xO3M29fgHquFf
X-Google-Smtp-Source: APXvYqxgSjyzieP53zGEl7YJZVf8BV3tlWjJgtrj87Z0SWz4sBNFKq8tUQNPnWPLwBwVX50NnZGLMA==
X-Received: by 2002:a17:90a:741:: with SMTP id s1mr7462457pje.113.1571354223252;
        Thu, 17 Oct 2019 16:17:03 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id i74sm5215338pfe.28.2019.10.17.16.17.02
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 16:17:02 -0700 (PDT)
Date:   Thu, 17 Oct 2019 16:17:01 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 03/12] t5520: let sed open its own input
Message-ID: <5f2078c84ce9a95ef868c34f1e8afb4335f5fa38.1571354136.git.liu.denton@gmail.com>
References: <cover.1571354136.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571354136.git.liu.denton@gmail.com>
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
2.23.0.897.g0a19638b1e

