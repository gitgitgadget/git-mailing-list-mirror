Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25CAC433E1
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 17:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91C9220675
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 17:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pXb+PtoE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgGGRlI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 13:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbgGGRlI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 13:41:08 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD30C08C5DC
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 10:41:08 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k6so46141125wrn.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 10:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8/QOL2CY+p1TjyeFrdFEZbE80qydYNU4SiBXwcS64jE=;
        b=pXb+PtoEcjKG5UCccX4XZyKVNckf5D4sPGXSLegr3U1DLdRCbiRaOZEpk15PZBmaH1
         gQM5+sVT/ez/4Ah5CW/BY2jPae4S1GqXX5k30kvEFLS/O6qFkRRlGmnGs6dbMU4tCOzk
         qdBVJjemOJOCuUWte9fdMu152iiGhNnE1Tz1QfqKCDBXi3wdQzOwDYqRz9q2yBaifoPJ
         swX42F59JhjapVnvQVLcBq9NOKLpG8Tgdi5VK0Rbg/mKNHtVVNkGExKavv5j5eVK4Igm
         nFT2LDlH/MsX7S4K2n+QsEyUjis3giis9O0p3sCJ4FbePeMAfhpp09qoGL6uLahjSYxH
         55UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8/QOL2CY+p1TjyeFrdFEZbE80qydYNU4SiBXwcS64jE=;
        b=sh+t/kmv9wRAHatQe//0wGDe6rRx+bDMYgq/Vfq+G2vxM0+e62zPHv40z3Jmn6X3c1
         gTIzXCpVPPSHKo1Y+pvFn5fc45gHeQIAxF2hX+i+2UJcyB+8CEOuD7jWWMxMs/tdLPZ5
         ZGE1k9Qpvl4r8pk5tKF1Of3k/lrGnsKCyH6GBWH5ghCNxLleJxlO9RZaz+wB5x8836yG
         fOi63MU+LM+T1r+G+IRZCHtNWtDzENKM72r55pPxWSKbUh7OjJCcMxCs6ToIWPo64jfo
         oeSRty1ju6tWjWWpFs9u1HcIYZgC1fJbM7tkw8L+uUtQ8V69Z14xrlHyB7ltoZsputK2
         e8Cw==
X-Gm-Message-State: AOAM531Wji3iwhod6X7Wxo2tnaLjc7l1JOTzBVX7zQdyappgUQTmD1Jb
        4armabItUCXp9wdyh6YXMbTdXYf1D9U=
X-Google-Smtp-Source: ABdhPJxEKraBVDTsLUodULaVQfNR9eKyLYdqlszxY3S2P5X+idSBDILlkHTX0cCGCcKQi3vl3qWdfQ==
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr54929931wro.396.1594143666552;
        Tue, 07 Jul 2020 10:41:06 -0700 (PDT)
Received: from localhost.localdomain ([185.228.230.97])
        by smtp.gmail.com with ESMTPSA id c194sm1977405wme.8.2020.07.07.10.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 10:41:06 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 2/4] Documentation: clarify 'complete message'
Date:   Tue,  7 Jul 2020 19:40:47 +0200
Message-Id: <20200707174049.21714-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.460.g66f3a24dd5
In-Reply-To: <20200707174049.21714-1-chriscool@tuxfamily.org>
References: <20200707174049.21714-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In Documentation/git-for-each-ref.txt let's clarify what
we mean by "complete message".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-for-each-ref.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 2db9779d54..788258c3ad 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -232,8 +232,9 @@ Fields that have name-email-date tuple as its value (`author`,
 `committer`, and `tagger`) can be suffixed with `name`, `email`,
 and `date` to extract the named component.
 
-The complete message of a commit or tag object is `contents`. This
-field can also be used in the following ways:
+The complete message (subject, body, trailers and signature) of a
+commit or tag object is `contents`. This field can also be used in the
+following ways:
 
 contents:subject::
 	The "subject" of the commit or tag message.  It's actually the
-- 
2.27.0.460.g66f3a24dd5

