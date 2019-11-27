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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587E7C432C3
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 18:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E61E2070B
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 18:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ml+6WEKn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfK0SNp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 13:13:45 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37318 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfK0SNo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 13:13:44 -0500
Received: by mail-pg1-f193.google.com with SMTP id b10so11282016pgd.4
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 10:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NPUPRFNgA55bR53Me1Y5XvKcvI1X3geLvm8Cel38M74=;
        b=Ml+6WEKnvPoQ6pgOdQqvTgwpLTlonDBl+MHg+YoJmDL0EzlJ5oKQDwYTUHqwR1Jnro
         m3Um4VEDQTd0xE6330EO+kJ0wZxzvXFGAGt8i78H4/9bNaYAmuiiaPUP5DxwdQMYRoE0
         LO5G3T/0JFFqiovE+LClIu6gicNVQzyFmE1ktdm7qhBjXlCafjhRdojcUm6fKW9JXhS6
         HCv7CTI+buCck6oS6htV+zf7hOEzmtJGuGopr2Gi4Hw82lp/j+QU2+oMTNUL5w/iVTTp
         LE4EUv+sMqm7YVxtgj6dgHYq/kl4g6CGN4jcAkNrSyAR9RfOBTgnYXdfqjwl8KMyVHwV
         rmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NPUPRFNgA55bR53Me1Y5XvKcvI1X3geLvm8Cel38M74=;
        b=TuAuyG/uayNd1BJ0cPKF3sm5J/sb8s8OZXFYcScrNTzmt75ndMbLd/f4wsMYyczXF6
         m4nD+S4ij0x1LSRGk/CeLbo6YMB70vcFxkH4EIXhJepd5Zrb/2oZSUu4ctLMV4UTFrGr
         d7NLBFUnnm1GB8O3hO5prbuU32Qas+FSRj0RRrGH3nGoSJTnAl3UT+h8IRJ0xGjHF8c1
         G7JPk9G/yLggNFZ8ubu9TtkxlvZJYnoV8z68ODyd8gSuFO0sqPzmRz56BTItCvy8Wua4
         ubdQ2zrvRYw52VHweL8ncFn0O2fLiHESjJ0hT9NLN7OMOqlgT0StGaZsxmZosyUJh90T
         hjrg==
X-Gm-Message-State: APjAAAWtxfOgbaJejJFNcvDsycnMtz7bMfZEdlV+rSSnLHnNq4hwANDL
        SNxol4mjE6CseEcY/a355KAPhXuh
X-Google-Smtp-Source: APXvYqyG0RqUYb9mQaPLn2V8z+Vvb1YOBVqbuERVbGrGgsIu5d0GbWDZrE26H7TLzEyWvOMxHwQ41A==
X-Received: by 2002:aa7:9f08:: with SMTP id g8mr49682001pfr.59.1574878423942;
        Wed, 27 Nov 2019 10:13:43 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id e59sm8626724pjk.28.2019.11.27.10.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 10:13:43 -0800 (PST)
Date:   Wed, 27 Nov 2019 10:13:41 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Christian Biesinger <cbiesinger@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/5] format-patch: fix indentation
Message-ID: <d288d6c3a56fab339b2dfed59579c1acecda4559.1574878089.git.liu.denton@gmail.com>
References: <cover.1574820308.git.liu.denton@gmail.com>
 <cover.1574878089.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574878089.git.liu.denton@gmail.com>
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

