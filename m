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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FC9C433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 12:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AA816143D
	for <git@archiver.kernel.org>; Fri, 14 May 2021 12:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbhENMP7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 08:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbhENMPy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 08:15:54 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93125C06174A
        for <git@vger.kernel.org>; Fri, 14 May 2021 05:14:42 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id v22so23384730oic.2
        for <git@vger.kernel.org>; Fri, 14 May 2021 05:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ebGpCx1yduU1NUxD3tFKf56pKmMHI5To+Bw+tdyWl74=;
        b=NYr7iW/cONwLGiyZSQtR/JE/aaz7Kt8pQ6zOCX3xL5GhJgnjFbK7M0ePp7bI31dA61
         luTbMUTedf0V9VHJS1map5wZj09yV1ltEplWW9j+KsAzQYNWYzPQCkfb5QMwxmTV+4O5
         LRO2Xu8NGnUGlhbRF98l5hj8ZPXsZGaKXOGtdMFRN+Mx6IT0ZSfZuG25pI7vV7OG3zXH
         I2vpgQvlBXb9YhWv4AhdHfX4IVZ+3v1YxXCEoM0m8RFPqikc1iTDj5SjOYV/RgaCHLbw
         guDEv5qlajLudbTpwJ29oo0gwnYXRDF0bkt2fl0HnQKIClo75MFUQEr81skPnvi1V/cR
         fXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ebGpCx1yduU1NUxD3tFKf56pKmMHI5To+Bw+tdyWl74=;
        b=CN0tcS+IIIUf+IazysmDgrfqdMBgq5Fk7jrSJ5Hkoo67RvRYkwgrHKQYeUIp7Srv/L
         loVsvKf7KRZyEazAXumYUEz5dDaDBfhGjwNxIhhZDYALIFmMrQr6fhRE/f0jr8YQ3oXw
         v0hyHorz4qmzOZr2x8U+LrTaM4ZDAPXeE3AoOcFNXvwd67VmtayaJHELSE5lnslIAI7/
         yF8f6+igUDQnGdT8yxMeX/CRYdrRVcU5MzVzsZHIE6HNaR3nkbDbT9sTIv+5n0MoFAZj
         39zZsl9mtKbUCodnDceSTi07XoFT/JtRlpJuoWB1u90cXzr5xWNUElEACUcySHhmVLNU
         NkaA==
X-Gm-Message-State: AOAM530jsKCiZ/WNIRvuVfwkVlWGhm24HtaFzgXw819NxsyZgRQ4HJGU
        j5OqWFkPXx7WMv6fjqXtvmrI1prWg3mhIQ==
X-Google-Smtp-Source: ABdhPJxtCSRND19hpeSZoH6ad4l6rxTXbD6RYKhux8+GGHvlmdQ0a/NREerweZw2oEFsDd9kppYiVg==
X-Received: by 2002:aca:df55:: with SMTP id w82mr6582558oig.25.1620994481771;
        Fri, 14 May 2021 05:14:41 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id q1sm1322689otc.21.2021.05.14.05.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 05:14:41 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 03/11] doc: doc-diff: set docdate manually
Date:   Fri, 14 May 2021 07:14:27 -0500
Message-Id: <20210514121435.504423-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210514121435.504423-1-felipe.contreras@gmail.com>
References: <20210514121435.504423-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to minimize the differences in the footer.

Asciidoc automatically generates a date with format '%Y-%m-%d', while
asciidoctor '%F'.

I personally prefer the latter, so only modify it for diff purposes.

Fixes tons of these:

-Git omitted                       01/01/1970                        GIT-ADD(1)
+Git omitted                       1970-01-01                        GIT-ADD(1)

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/doc-diff | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/doc-diff b/Documentation/doc-diff
index ecd88b0524..aae5fc1933 100755
--- a/Documentation/doc-diff
+++ b/Documentation/doc-diff
@@ -111,7 +111,7 @@ construct_makemanflags () {
 		echo USE_ASCIIDOCTOR=
 	elif test "$1" = "-asciidoctor"
 	then
-		echo USE_ASCIIDOCTOR=YesPlease
+		echo USE_ASCIIDOCTOR=YesPlease ASCIIDOC_EXTRA='-adocdate="01/01/1970"'
 	fi
 }
 
-- 
2.31.1

