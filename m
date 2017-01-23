Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBFED20A17
	for <e@80x24.org>; Mon, 23 Jan 2017 20:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751508AbdAWUfm (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 15:35:42 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35935 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751507AbdAWUfl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 15:35:41 -0500
Received: by mail-pf0-f175.google.com with SMTP id 189so43791990pfu.3
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 12:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i35Xm2TlDHR5fsKx6d+9+X3Hi2d37v6QsWkBfH0cppo=;
        b=SW32YcY0HVQM3VsJ20xX6Vcvhtw2w5fqonZSa30dToSw5pGD4d3JZvB03snOUMnVso
         NSTR9aVR5vK9S3KHivFPuTlxss4AqCEiZxFsAyvQWQ+3Z/NdC2VFn1pqqNnS7V9oKnOe
         sAUHhVOa0mXqOBoXlqwZJ94CNpCqNVvm5WMRsnNqYIVI3DYy+FOWVhnEhIeZXiLiQUfr
         RwZ8mvzhV1nRgwd9CBBXHKYKLaNcX2mWIh1DKMivGtvvO59Ii1myFyvtCjPWhkJBh9gP
         GuXHD9WzObqW4FhurwtyIjF0/1Sp/1We8RVLu0/H17UbC7aEgKcWsSELWbqMlU9UXP/v
         yasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i35Xm2TlDHR5fsKx6d+9+X3Hi2d37v6QsWkBfH0cppo=;
        b=IWySJS5ip11tcPQpQCPy9B4aMAQuag8b01ucJuYS/rVsDIGYxguBHYYUooncjhAwPb
         vvpHVdDfo7gXqY/9yth+Pvuk7zFHh+Y5YCLGOQgUh+U0wA0hNqWjt0PkVGdXYZs9rxaR
         185Bxoc3CvCdNpDBrpRwVX4TGc/w7/ubZ4EQbNRfgMqKn63pSpH4XU1Jgqj7NIHIssGf
         h6xUeNklYJ6oDzV746nK3LcfA544Se0LL4pnD4vOJau6fW/DPyM+nylVyErmHbXILr+T
         P7bKJiQWAQZtvsLuFrnwQR22Q/vtxP0MX7eHVspw+UwBxSlyXhUSHvVK9PF2WNWMfVaG
         v55g==
X-Gm-Message-State: AIkVDXKQn4VeCwHlcmn61joS4iwlPs/RT9h7lOfzUCvvqC0lU0xS/l7O9OAm5OdBiN/ClFdn
X-Received: by 10.84.210.107 with SMTP id z98mr46006779plh.171.1485203740250;
        Mon, 23 Jan 2017 12:35:40 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id z29sm39280832pgc.7.2017.01.23.12.35.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jan 2017 12:35:38 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 02/27] attr.c: use strchrnul() to scan for one line
Date:   Mon, 23 Jan 2017 12:35:00 -0800
Message-Id: <20170123203525.185058-3-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170123203525.185058-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
 <20170123203525.185058-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/attr.c b/attr.c
index 1fcf042b8..04d24334e 100644
--- a/attr.c
+++ b/attr.c
@@ -402,8 +402,8 @@ static struct attr_stack *read_attr_from_index(const char *path, int macro_ok)
 	for (sp = buf; *sp; ) {
 		char *ep;
 		int more;
-		for (ep = sp; *ep && *ep != '\n'; ep++)
-			;
+
+		ep = strchrnul(sp, '\n');
 		more = (*ep == '\n');
 		*ep = '\0';
 		handle_attr_line(res, sp, path, ++lineno, macro_ok);
-- 
2.11.0.483.g087da7b7c-goog

