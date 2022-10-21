Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEACC38A2D
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 22:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiJUW01 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 18:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiJUW0H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 18:26:07 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4B8233987
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 15:26:00 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id y80so3506862iof.3
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 15:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iqe77xsVoSYKACIEl4ZI0FSatz/GG7p2xIG+FFeF39E=;
        b=pRWwpTF8xm01Cyehlay9AIIi2iJzq3N63McwCzOXgpot73XpCBJu1/5wLeWHnEVrrf
         he9YfWkUzrNeEr0Ovm99zpgIfUEp28KvoSUIryR6fTDJZe4K3MwHVLsnA2cp69zqAQCB
         FEOZhJA7I783xupp97Zq0irIm8eTQETeHm6zBTmgvXi+1QbZaAM1duV9NDW4DS49lLR3
         4oy1rrT3QFU/LKx324R9PlQmAalu/T2Sp9ArbeJt9PTsSWAjdjv6N+dZ4FtALosJca8K
         +UpPgL9rSKy3jgwQGvMXAJCTI9U0HmK5lPkgR4pA/Ypry0D2i2gA9A78DqpgLiL5meYb
         GNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqe77xsVoSYKACIEl4ZI0FSatz/GG7p2xIG+FFeF39E=;
        b=ZQJe8R9Xb6agW3b1F1MylLPHGbfxANgDdDMp/iRt5DD2EGT8CHx8+LplkyLOQCBJg4
         6+XtyXjuaim5Lk9tVhHzKbsT8n1PmZVIT9R2zXbm3pk6epz9csHrIELoTCM+l7yiLbpx
         j+yKS7HUMDx1+9pwLC/MrNd1QjmK6RIUYlHJc8enR8FP6g8PQilfJfaoXJxChNvVaYbW
         mT8Df8gP2JrxmWpc+tE7ql4URuZWyuu9a8bKMw8WR6TQee0gE2KkqEmus63lJLjFcemE
         w+dFUGjBz45BaqPJ6xajs9YDEfAXOF6zbv83QAIrmCcklrFSrxUPU4h6Tg858pEohS3e
         UyPw==
X-Gm-Message-State: ACrzQf1qH9CWmxG6khjvfr3umoMCs2rgMYBW2OKiikuYARPQEtWNjlW2
        AYaoFGCSMaNrjUL7PFpF15IUuAG6T4VK2IeJ
X-Google-Smtp-Source: AMsMyM6SPG3kQnM5abmjP8ceUS6tBNqVzgILphbiBBgA+KcVIhUXz9J7dI+Xuyy1gFXEpxOEJY7yDQ==
X-Received: by 2002:a02:cf05:0:b0:363:a207:c3ff with SMTP id q5-20020a02cf05000000b00363a207c3ffmr16387999jar.178.1666391147653;
        Fri, 21 Oct 2022 15:25:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i16-20020a92c950000000b002e949936411sm4449125ilq.26.2022.10.21.15.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 15:25:47 -0700 (PDT)
Date:   Fri, 21 Oct 2022 18:25:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     jacob@initialcommit.io, peff@peff.net, gitster@pobox.com,
        avarab@gmail.com
Subject: [PATCH v3 3/7] shortlog: extract `--group` fragment for translation
Message-ID: <cf84f829aae4cc12732246c5b71d4fa40e0f24db.1666391136.git.me@ttaylorr.com>
References: <cover.1665448437.git.me@ttaylorr.com>
 <cover.1666391136.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1666391136.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The subsequent commit will add another unhandled case in
`read_from_stdin()` which will want to use the same message as with
`--group=trailer`.

Extract the "--group=trailer" part from this message so the same
translation key can be used for both cases.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/shortlog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 18f0800c82..d0645769d7 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -132,7 +132,7 @@ static void read_from_stdin(struct shortlog *log)
 		match = committer_match;
 		break;
 	case SHORTLOG_GROUP_TRAILER:
-		die(_("using --group=trailer with stdin is not supported"));
+		die(_("using %s with stdin is not supported"), "--group=trailer");
 	default:
 		BUG("unhandled shortlog group");
 	}
-- 
2.38.0.16.g393fd4c6db

