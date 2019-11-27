Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D76FC432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 02:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E1D520722
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 02:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0e1soR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfK0CJS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 21:09:18 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:44067 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfK0CJS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 21:09:18 -0500
Received: by mail-pj1-f65.google.com with SMTP id w8so9178513pjh.11
        for <git@vger.kernel.org>; Tue, 26 Nov 2019 18:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NPUPRFNgA55bR53Me1Y5XvKcvI1X3geLvm8Cel38M74=;
        b=i0e1soR+pUUeEue0AKAqtkIQEt/dGfECt5vdh/4pgAV6zz2hqxyUF7bGYfW3zIA/hD
         Gt4yD2S0zTb2m7lFskBzoGtDUP8LS5gVKMaLGbKmdrwKsu5rHvPhhQz55PsRGeaDhYH0
         3haW435q+oP65YBdUjiyas9QhdAr1IJWbHrBrGKUlakqyjhC+rfb4F/wteRxx8x1+goM
         SKbUD9MtEP4slscR9I4BcYluzW/thZEmnD1SqxsQKcslTtVcPBUvTsMGtJtADRK+yJE9
         TXSCExedN+CUkSXPnb3WDTaCX6eVw5Xr7gnGbEVL8Cjp9QlfgNlfBtD4b4jtIcKStG0U
         EF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NPUPRFNgA55bR53Me1Y5XvKcvI1X3geLvm8Cel38M74=;
        b=glSHnblKH+ZAgsSIN3CrQu1RcsIFURh7A0ENVhCxkcS0Gvi0/MFc0VQ53Ckad36fmD
         l34wUif3RzEwiof/qp+9mln3t3VDmJFEWrqgsafvFKkuMWOexlrwg06r7RasiC2LPXh+
         mPNUzvRciQGYnmtwMMRa2cUKU9059W+Fo7s67IsLOFtxylMS3rhuL80xYP4XJOt+qldx
         sjIYB4aVEeDUlFGRGL0/yWG8YEvMFFLgzMzuLJhegOqP32QlXBTj4C6qYq0kfUoUutTy
         jHLfvycxQFhSEoK5iquf9XcG79cUOQZb8rL69p7h8UM2CHBfmETFEOth9Abn8488Mv4h
         eEaQ==
X-Gm-Message-State: APjAAAXbB1awIdaBVPkcMHmqwS2O2kksfYOsBRxEqPKPFJkKGBSLCX+O
        Rj/vpVUpKL9cxT7jopkcjnK5tMzr
X-Google-Smtp-Source: APXvYqxZlgWq33b4hqI9cW0PGkCkRsBHwV8XsxgLugLpUjYL02vSRhSgFOiRVzEPH3rS8xRgZ2j/rA==
X-Received: by 2002:a17:90a:3be4:: with SMTP id e91mr3025816pjc.56.1574820557314;
        Tue, 26 Nov 2019 18:09:17 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id a9sm1868908pfo.106.2019.11.26.18.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 18:09:16 -0800 (PST)
Date:   Tue, 26 Nov 2019 18:09:14 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Christian Biesinger <cbiesinger@google.com>
Subject: [PATCH 2/5] format-patch: fix indentation
Message-ID: <46fd4113aad5bd6c9925304eca35c808274982ba.1574820308.git.liu.denton@gmail.com>
References: <CAPTJ0XEcMJEwPBEL4akncJ_A5XwyQyKL95fpf2tC0rNXJK65Og@mail.gmail.com>
 <cover.1574820308.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574820308.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index a26f223ab4..9c44682f61 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1350,7 +1350,7 @@ static int header_callback(const struct option *opt, const char *arg, int unset)
 		string_list_clear(&extra_to, 0);
 		string_list_clear(&extra_cc, 0);
 	} else {
-	    add_header(arg);
+		add_header(arg);
 	}
 	return 0;
 }
-- 
2.24.0.504.g3cd56eb17d

