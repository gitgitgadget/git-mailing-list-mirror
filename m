Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6952CC43461
	for <git@archiver.kernel.org>; Fri, 14 May 2021 12:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 497FE6145B
	for <git@archiver.kernel.org>; Fri, 14 May 2021 12:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbhENMQL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 08:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbhENMP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 08:15:58 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6858C06174A
        for <git@vger.kernel.org>; Fri, 14 May 2021 05:14:45 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id j75so28218944oih.10
        for <git@vger.kernel.org>; Fri, 14 May 2021 05:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ztBaJ2CE2139tz9IYPibSrKG5Xg32re2wYcBYtNISgs=;
        b=lAYAwtoJOiQmk3SBJsQlo9z4ZhA0kcAhjNhrr6s1Uo2dhypFXisZL+joY/CayuC2hz
         3B+Y55oCuawy3lrqeEOoSVASgnfQkCNqyWAwq/luRxAACy3g8jv3XR43iRKv+Zkqis6k
         FHTAWQ9qf2QqMnCt7n7YgUlYumkynzYuV09nvh9si2LSswcQqfBJvYQJPTBjdfGXjpni
         rNkHYVpk3YGehhwwwJmGOroaXZrscwQuDuZsvnKUWCHlU0R0pRQXCxk61LyA6dK39gYE
         Q7PpjH3jKcgqGhAj3Rd0j0UoUCnA81LAXELhbaVVcv8tc7AikWHxmok+D4zkE8LcU/Pc
         fs7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ztBaJ2CE2139tz9IYPibSrKG5Xg32re2wYcBYtNISgs=;
        b=sKhwD8x1b9wBJ3gTNwuipMPoKv3SvTEc9QMmN7OLMpViTs6cvb9pYhjS35GeMtwMeJ
         +qJqwtlUK29SPs8nKCT3IyYC+gS/n3fO+aHOGHL1DvGIrO5pix2yCbrJLpl0OJWhCga8
         6eG3R9ptQqMiueHNeVECXDDX195yauD9y/NJ+EE1ARANKuufFi9TjFn25rLJnKtnkeLl
         87l8A2KK55ny/NxWWGFLiobVRNbSRDh1Wv7Gzdy4mxITE1svtjkzktCrOyZL4Oa+g6SV
         haKlYA6M7X1QJ7ZcdcxV8c2/tKgY666ymOO3cSSSb+v5m5J8c2M1C2hDI47U2f15ZroY
         E68g==
X-Gm-Message-State: AOAM530DT6JxdyFfk91TOsAyC6RzDoH1jgB3rl7CaoIcOiKVJs/ArKhN
        J/l4mvRkyBVUCSX8zXBDiO1aC7MNSNUP4g==
X-Google-Smtp-Source: ABdhPJwC4wg7RZT2E30L2R03h9BHim+HVF5lofgAxxfE9ujNz60geis11tng2oI6B3z6P8woytI7zQ==
X-Received: by 2002:aca:aa08:: with SMTP id t8mr6566118oie.66.1620994484953;
        Fri, 14 May 2021 05:14:44 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id s24sm1255155ooh.28.2021.05.14.05.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 05:14:44 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 05/11] doc: asciidoctor: add linkgit macros in man pages
Date:   Fri, 14 May 2021 07:14:29 -0500
Message-Id: <20210514121435.504423-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210514121435.504423-1-felipe.contreras@gmail.com>
References: <20210514121435.504423-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fixes the doc-diff:

-       Please see git-commit(1) for alternative ways to add content to a
-       commit.
+       Please see  for alternative ways to add content to a commit.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index d906a00803..ad68f7b0bb 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -15,6 +15,8 @@ module Git
           "#{target}(#{attrs[1]})</ulink>"
         elsif parent.document.basebackend? 'html'
           %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>)
+        elsif parent.document.basebackend? 'manpage'
+          "\e\\fB%s\e\\fR(%s)" % [target, attrs[1]]
         elsif parent.document.basebackend? 'docbook'
           "<citerefentry>\n" \
             "<refentrytitle>#{target}</refentrytitle>" \
-- 
2.31.1

