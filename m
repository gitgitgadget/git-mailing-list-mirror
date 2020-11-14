Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8322DC5519F
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 08:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46D21205CA
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 08:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEXUWMdL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgKNIno (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Nov 2020 03:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgKNIno (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Nov 2020 03:43:44 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38775C0613D1
        for <git@vger.kernel.org>; Sat, 14 Nov 2020 00:43:42 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a65so17549909wme.1
        for <git@vger.kernel.org>; Sat, 14 Nov 2020 00:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NfPcX6Rr4Tb9tu8iL/pCnVVH4icc31E1v7hWIEAOSfA=;
        b=lEXUWMdL3Xb6p5C/6mqFD8Qks4OUKd5OPsgBl9nX4ESGQ93Bs5zLZMT0s9KSMITuFE
         9ay5wXZdJoM85nrNDnCPrhZvIeZcUQ8WBgYc0aI15vfUxu1LULWNntcv9qR8wpCSlnEX
         KsMP64zAe0wkNKUa3a1hb2EmHRsu2AtRHEXHHRODzt4PUDinXFYbDMruvDBkihjwgZFG
         peTjBYqhz4uGCpfhW9bJfWG6HFepLjqGNipWsL0l9wH9Z+jjAOEy5HCO9IFpD3cghxH0
         PMqKRCG7hzmMbrFsmRI+L4JlB/Jb33RpDWt7rG0zRSMKQ5tDB9g4r5Yg3LEXnWDOXFSl
         oEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NfPcX6Rr4Tb9tu8iL/pCnVVH4icc31E1v7hWIEAOSfA=;
        b=P+fJMqdGERXti2W1hcV5+vJRRCbDVZs4DclLzCqRlHb7I16/VZzt59PhiMowQQ0q31
         wzVoE8MVHOFo8JgOlst6t3n2LIAFsTsR4UL+vBjfTOOwgQYdeJ/JTFDWsIxQTMnYp0tX
         xHw20WRqmgyetIzMI8HdnRNr3lqvr+6kxDQxDaUAe3hLOR1Qye9d1K5Bb5yTnKCa+hiC
         kr0kgCMEx03q2LQiqgpU4HbZ8syl9EYaSjy+hyXVQowkcG7IIe5qC74GRWt1KsArI9Ex
         vp7USLhN15ufeByzXYkxU/ZU1avK9HCU99jr81SdwtshInsVrifL9IR5Q0g1J2UQxuFR
         f+0w==
X-Gm-Message-State: AOAM533w5ujiIUWPjBDtfbcJOPpF+ub7VJjtIgt0WGX7DGIzDdnhmaaD
        PcMzi9WZ1pV9Sw9/bWw/bUGFqss+s/rsgA==
X-Google-Smtp-Source: ABdhPJxAEK2lIN1dKlcwMwRMZA+9wiZI3YQeg8jx8UQ6GNfKepXPOSLqWYaP/12py1tN5U4Chpa0mQ==
X-Received: by 2002:a1c:1dc1:: with SMTP id d184mr6092324wmd.169.1605343420653;
        Sat, 14 Nov 2020 00:43:40 -0800 (PST)
Received: from localhost.localdomain (pub212004089179.dh-hfc.datazug.ch. [212.4.89.179])
        by smtp.gmail.com with ESMTPSA id v67sm13385234wma.17.2020.11.14.00.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 00:43:39 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH] list-objects-filter-options: fix function name in BUG
Date:   Sat, 14 Nov 2020 09:43:26 +0100
Message-Id: <20201114084327.14891-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the function name we give in the BUG message. It's "config", not
"choice".

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 list-objects-filter-options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index defd3dfd10..d2d1c81caf 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -35,7 +35,7 @@ const char *list_object_filter_config_name(enum list_objects_filter_choice c)
 		/* not a real filter type; just the count of all filters */
 		break;
 	}
-	BUG("list_object_filter_choice_name: invalid argument '%d'", c);
+	BUG("list_object_filter_config_name: invalid argument '%d'", c);
 }
 
 /*
-- 
2.29.2.454.gaff20da3a2

