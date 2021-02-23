Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D8EC433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 06:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFCA864DB1
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 06:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhBWGkK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 01:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbhBWGj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 01:39:56 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B305C06174A
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 22:39:16 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id p5so4365415plo.4
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 22:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BoIVEpGi1b9IT4DvjNVdrL2yaad4djDwjNhEWZRR+pc=;
        b=JHJm7r3LG5IzgDnGdS5LWojCmTP41QDtn3MOJ5iyZgebMewMnk5Afb9fFf63JsVCTP
         PJKDqZpyCvEWIH/XmjzcehcgeDdXhmcAed5WAWNVxHX4x+K1UCSpjChypvgxAr4xpGTE
         CuB7HJBb72qqdrdekQK70tDwcBX3qFKUaZjkARi7KT8QI+DcdSs86npUU3sxHmZT3QQZ
         ojxB5ICKZ8aDDw31KXDdQyzW2PgjIO2gztEW+lJjDJ/gpksXY5wl1k+rlPKN8j1+uLWZ
         IBawD7mUNw2+qRvkdFbr3APErgXvwug/lfhRPdHTxc+K//kmVLjp6T+bASFo2nikxiEy
         FWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BoIVEpGi1b9IT4DvjNVdrL2yaad4djDwjNhEWZRR+pc=;
        b=uHknglENUdvsgcg3cAQ8Vjm1LXS/oapzhEDwDdeCnniiMqrHaolSy/UIKMHo9zDDc6
         4DOzfD+qJJc9e8mPlgRIOM25VP3f0KJxTQZikLbdYoEbL3sHKO8jRubfqYrrRdC3ZlGl
         tNyO4ZNkofb7Jt6+4FRUy5DWKAVe3PfAiXHxe22RxSnKgtOBGLnQJBRXKqljDVwuW3iJ
         yDu1WoVWQn6sww0YifAx2up4ds8NppG4/AG/DrosygRVFhdkrC90HMeMwmeZ8o6gZw6B
         ORLnUkg8pYDW8Q7bQx1a/Q82D8VeR2Hj03BKT2Cm0llb+dMTbweVw5IVKJmLgCgkrwjY
         qEBQ==
X-Gm-Message-State: AOAM532f6a4MrNTHYF7eiEsneA7auvUaETonEzGlPlIve9YDfti/stBJ
        HuLExRWmZEFw9DGdvu3RLdCgHJTTrhk=
X-Google-Smtp-Source: ABdhPJyFdCd1QjhYsThMoThGZIK2rLNf4kgMdx7NwmMwXCH3yRVbrbqzUElCC/eRaIUFjg7BGPb6bw==
X-Received: by 2002:a17:902:c9cb:b029:e4:182f:5d1e with SMTP id q11-20020a170902c9cbb02900e4182f5d1emr1455895pld.28.1614062355631;
        Mon, 22 Feb 2021 22:39:15 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id j1sm21355055pfr.78.2021.02.22.22.39.14
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 22:39:15 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/3] i18n.txt: camel case and monospace "i18n.commitEncoding"
Date:   Mon, 22 Feb 2021 22:39:06 -0800
Message-Id: <cc48b125166a241ef5f24138fd161223ab35e361.1614062288.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01
In-Reply-To: <cover.1614062288.git.liu.denton@gmail.com>
References: <cover.1614062288.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 95791be750 (doc: camelCase the i18n config variables to improve
readability, 2017-07-17), the other i18n config variables were
camel cased. However, this one instance was missed.

Camel case and monospace "i18n.commitEncoding" so that it matches the
surrounding text.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/i18n.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/i18n.txt b/Documentation/i18n.txt
index 7e36e5b55b..6c6baeeeb7 100644
--- a/Documentation/i18n.txt
+++ b/Documentation/i18n.txt
@@ -38,7 +38,7 @@ mind.
   a warning if the commit log message given to it does not look
   like a valid UTF-8 string, unless you explicitly say your
   project uses a legacy encoding.  The way to say this is to
-  have i18n.commitencoding in `.git/config` file, like this:
+  have `i18n.commitEncoding` in `.git/config` file, like this:
 +
 ------------
 [i18n]
-- 
2.30.0.478.g8a0d178c01

