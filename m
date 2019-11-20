Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9971DC432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 21:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64763208A1
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 21:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3uyG4bT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbfKTVSa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 16:18:30 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40474 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfKTVSa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 16:18:30 -0500
Received: by mail-pf1-f195.google.com with SMTP id r4so387833pfl.7
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 13:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ds7eK+ykzv9/kr4YgQx3mS7idfg5M+8E1GxpzD8u8kM=;
        b=R3uyG4bTzqyNjgoVkoy1Zqf6YMj4gzvTNgT0bgl8E8qn58Q2nJhjuc3nrJ9dhmPRHd
         pGsOAodTcCY7hO9bEJrMj/Ng65PlHv17KFstO7H5ulnbdJ9qqjJG5ncOFX+UhkGRkz0J
         ffKd9VA/+4PvJfTDNyFAJuhqHNNRGI3QMabgQOYbOI4ecXOTsQnZz80jQZAd5VQ8IjXx
         bJ8ynwPJ0N8jq2OB5eXogfJB2acvQpksEkF9ll4pIGt+EO/8PILrJTFUj8FYNzPVKaKE
         t8wwDrjpUcJJdb3KeGGtbJ4TOMBRSEQpZNKxkuzuIdco7GZ+WfUMFqcEXVqqs1IHLDVs
         gsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ds7eK+ykzv9/kr4YgQx3mS7idfg5M+8E1GxpzD8u8kM=;
        b=A1ZjbzuoO3jjYS/igjf0rvssmnZ2Lv44LoMrieRM4/hP9bg3OVxFefa6pKUaZgGBsg
         rLm0X9fNYIYos8cJuU+1put7Sglv1/WBPty+zm7qXFy2pYN2Y6lDkIZxF7AIXPMOL2Kh
         WeRxYVD3PRUr5WcJfzNATZ0pb3acBEmHSq3SMVcUAEnqXYU7G0TnaGr53FifkdT7gS+2
         GNd1jWklvvRXaST8x2Tn7wKZOI573Gpm8HDJ8HSf09jYXk8EPHUFYC3Osq1Xzf9rj7mI
         cYLnwwJHp5BELKOCjrOWrgXuNrUC882Q8KrmJaM6kOo4wIxbTLWr7CT87hW0xesdDoS9
         9JRA==
X-Gm-Message-State: APjAAAUWxVrzBpRcHH5P5r/qKk5rSwexK/zOSrmRJCAg+FhxvcZ6nidL
        No4Ew9es/27oxECcPGxD8PxaAX0g
X-Google-Smtp-Source: APXvYqwBOjCNpiKUL+BzxtP6CHBerybfiSdsn1E71aqXPagLs2/kws22QiHycVzNVf2H49OFheQ3EQ==
X-Received: by 2002:a63:1626:: with SMTP id w38mr5632582pgl.323.1574284708756;
        Wed, 20 Nov 2019 13:18:28 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id 13sm149599pgu.53.2019.11.20.13.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 13:18:28 -0800 (PST)
Date:   Wed, 20 Nov 2019 13:18:26 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 01/10] argv-array: add space after `while`
Message-ID: <fd78742570bbeaa4096eb0cce24fe33054aed176.1574284470.git.liu.denton@gmail.com>
References: <cover.1574207673.git.liu.denton@gmail.com>
 <cover.1574284470.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574284470.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 argv-array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/argv-array.c b/argv-array.c
index f352ea9357..61ef8c0dfd 100644
--- a/argv-array.c
+++ b/argv-array.c
@@ -46,7 +46,7 @@ void argv_array_pushl(struct argv_array *array, ...)
 	const char *arg;
 
 	va_start(ap, array);
-	while((arg = va_arg(ap, const char *)))
+	while ((arg = va_arg(ap, const char *)))
 		argv_array_push(array, arg);
 	va_end(ap);
 }
-- 
2.24.0.450.g7a9a4598a9

