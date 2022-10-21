Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432AFC43217
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 03:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiJUDL5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 23:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiJUDLi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 23:11:38 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533B413C1EE
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 20:11:37 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id l3so958299ilg.13
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 20:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iqe77xsVoSYKACIEl4ZI0FSatz/GG7p2xIG+FFeF39E=;
        b=jp3sgf9MiQGt0kXZw/JW/SkmxUjJM4irz4eOVlgtyThMdh5kQnZzesH6LosL5yt+mt
         QiqPYTNMqUAf7SoMrv2MzCCBOUkRWdRB80XWfildWmdVS7K2jNZr3sE3RgjoH8KkZck0
         X5ykHYPfHkTBXhcEGVvTizkwYUNaA5VCu3lNnvxP3M39zFUuxD3GXiGcIpdKiJ9bZ85S
         KzWi9/dKYNkNu/1/bbuz0mKLCoLy6Dw+kXegv3bXTBvn0f4XEfj7h3vSOH3tHQizI9JR
         7nFbWYGR2y9pkZnEZbgPwQLKmtpzn5qPHyAbSa3jWSd2SbMCSLUmMIwFmc7I9iEmmKOk
         /+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqe77xsVoSYKACIEl4ZI0FSatz/GG7p2xIG+FFeF39E=;
        b=4ODCQL4yL98L0r/0XOVMp6SrHsM/CVxHC+TKejcYPJJBUynYsPiVpC5JvGAsYEp6OY
         9ipG671DKRAJTlgKRTjpvxWGYWf0rJ4vGrf38GEUAuo2NI/BQB09DoXd13UAjcgqoOy1
         kawK8oPP/OVzCM7gjUoM0qydT82lAZ8DJgommWCtqiaN2pKcbJjqszfhSLIClUxMnDQU
         35LlHR2BBIsbbWUUyeb9xcKR3ajadJeDW7EwhyuRkiLlzjrkkX+KKgvwX1re2gpRFkaO
         Nv9TS6T3HFG/cy8EYrNIUBaF00nfcFw0ePyqv/8Ef3HMjgai3vlefq092Xq9ByjXjRRN
         Ucow==
X-Gm-Message-State: ACrzQf2C4nyzep6Dg7PLgmBfuHDZcR+7HpCXOWsCyISQI305xzTB7ryd
        dFg6uN7IwgeuUJS4lhlaWdwpQYoFnryRUZv5
X-Google-Smtp-Source: AMsMyM7+TZNGZfTjcjtMTsKE/BhTqTei023AOu7l/pzwvWQnKXLRrGCJ4FuYIp58xZcvYsZs4VElMg==
X-Received: by 2002:a05:6e02:219c:b0:2f9:aef7:e018 with SMTP id j28-20020a056e02219c00b002f9aef7e018mr11614820ila.315.1666321896559;
        Thu, 20 Oct 2022 20:11:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j21-20020a056638053500b003633eb91999sm3736476jar.155.2022.10.20.20.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 20:11:36 -0700 (PDT)
Date:   Thu, 20 Oct 2022 23:11:35 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     jacob@initialcommit.io, peff@peff.net, gitster@pobox.com,
        avarab@gmail.com
Subject: [PATCH v2 3/6] shortlog: extract `--group` fragment for translation
Message-ID: <3665488fc95ee3b097f2e0e1e64d23d523c073fa.1666320509.git.me@ttaylorr.com>
References: <cover.1665448437.git.me@ttaylorr.com>
 <cover.1666320509.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1666320509.git.me@ttaylorr.com>
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

