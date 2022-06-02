Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC06AC433EF
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 12:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbiFBM0A (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 08:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbiFBMZr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 08:25:47 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D314132A1F
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 05:25:46 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k16so6264522wrg.7
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 05:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3XWtRhtFL273UXa0MGijePi+vbWbLXE4pvSbgYoY8FA=;
        b=Kqa3JRgMuAkefKqW4UHl4sypFiiGvL9i54yI62O/Lm0/2qTfSGxLuG2NL5yjN7Dw17
         9zHa68Kracg0I7QelzMC/VPIro1IYnhHbIk2nuFgOgiq5wqCjDf/I4uAAkNc0+MM11Ig
         S/XEQ3dcLCKRAjZ8K918ms5KZTGZURWRdXYFvg0aUNaHMqoBd4Ag+LcC2uIPjHjA62w0
         VWRGS3MKRjgiAmmzi3D4XWSHTD6vvkwyk2AE7/Lg54DZsm5XdN+s41Os99KoNMB6IVla
         mQcxFKYBBGiTceYW0ZTOgP+QjFL51KLPb1++H0p6giYsWvIHqY5KaLjTh77P9+C5RD6R
         jJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3XWtRhtFL273UXa0MGijePi+vbWbLXE4pvSbgYoY8FA=;
        b=D44wd8YmobMiEHzBXAdfMKaooZikQ/SYNZjA7t3HL3Cgycfe4LGlPrRQPH8H4o3P/P
         v1xvNxuiYHZ/lzJ/Aibn3X/+yg4QX5wB/q1lxLQDgVbNcJWyNTzq1ivQwfdGVZV7mElf
         hC/E7w7QiZWxrotO+Y7cqTnH9jmUU+dWieJOJ6VnSm04WBn5CDK/obUixuiGcE97G5nH
         7EiCmFhWStEHDNtqC/kaes1LABRGcyKfW00qLkR/oJvt+GMRC6kajulk4n0ozbFgcWE4
         Z9rRzJsx806f9bIf8oiD7xPXbAqNxvQHfgD//8zJhDVyqxkLyDtYvvKoqnyDBQKzh3/e
         Bb2w==
X-Gm-Message-State: AOAM530nHncEHIrSE/VyEq0vbFmqwSuc3kTAzD3g1i5EXZsmpmHELaSM
        6bTIwR2ApZs/+/6u1x+r2wekss/VIoO16A==
X-Google-Smtp-Source: ABdhPJzFGuNUO4uNiLg3wucKMarKbw80UH+ghnYQ2c/lqtnKfsXPzSJjpEHv06tK7C6QUrHvAghbHA==
X-Received: by 2002:adf:e19a:0:b0:210:157c:7b3c with SMTP id az26-20020adfe19a000000b00210157c7b3cmr3433249wrb.121.1654172744806;
        Thu, 02 Jun 2022 05:25:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d4bc6000000b0020e615bab7bsm4305100wrt.7.2022.06.02.05.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 05:25:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/6] parse-options.c: use optbug() instead of BUG() "opts" check
Date:   Thu,  2 Jun 2022 14:25:35 +0200
Message-Id: <patch-v3-4.6-58eafa2e04a-20220602T122106Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1103.gb3ecdfb3e6a
In-Reply-To: <cover-v3-0.6-00000000000-20220602T122106Z-avarab@gmail.com>
References: <cover-v2-0.6-00000000000-20220531T164806Z-avarab@gmail.com> <cover-v3-0.6-00000000000-20220602T122106Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the assertions added in bf3ff338a25 (parse-options: stop
abusing 'callback' for lowlevel callbacks, 2019-01-27) to use optbug()
instead of BUG(). At this point we're looping over individual options,
so if we encounter any issues we'd like to report the offending option.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 parse-options.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 78b46ae9698..edf55d3ef5d 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -474,20 +474,21 @@ static void parse_options_check(const struct option *opts)
 			break;
 		case OPTION_CALLBACK:
 			if (!opts->callback && !opts->ll_callback)
-				BUG("OPTION_CALLBACK needs one callback");
-			if (opts->callback && opts->ll_callback)
-				BUG("OPTION_CALLBACK can't have two callbacks");
+				optbug(opts, "OPTION_CALLBACK needs one callback");
+			else if (opts->callback && opts->ll_callback)
+				optbug(opts, "OPTION_CALLBACK can't have two callbacks");
 			break;
 		case OPTION_LOWLEVEL_CALLBACK:
 			if (!opts->ll_callback)
-				BUG("OPTION_LOWLEVEL_CALLBACK needs a callback");
+				optbug(opts, "OPTION_LOWLEVEL_CALLBACK needs a callback");
 			if (opts->callback)
-				BUG("OPTION_LOWLEVEL_CALLBACK needs no high level callback");
+				optbug(opts, "OPTION_LOWLEVEL_CALLBACK needs no high level callback");
 			break;
 		case OPTION_ALIAS:
-			BUG("OPT_ALIAS() should not remain at this point. "
-			    "Are you using parse_options_step() directly?\n"
-			    "That case is not supported yet.");
+			optbug(opts, "OPT_ALIAS() should not remain at this point. "
+			       "Are you using parse_options_step() directly?\n"
+			       "That case is not supported yet.");
+			break;
 		default:
 			; /* ok. (usually accepts an argument) */
 		}
-- 
2.36.1.1103.gb3ecdfb3e6a

