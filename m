Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F61BC4741F
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 07:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B4452223E
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 07:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sLz0nCsP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgIWH2L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 03:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgIWH2J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 03:28:09 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A5AC0613D2
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 00:28:08 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q9so5996536wmj.2
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 00:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2I9Y2hRuXgRqT6FgB1KECR88tDHWd7i0V/IscrZ+zbo=;
        b=sLz0nCsPem/YCBhwUd2QgL+uKuK21ZaXjB9xRqVg2qoQIUNoqbdeqqvihvpcsXSuTA
         Bm+qgTg3eryNfNcII3YPwbujMI2zYmZHHixabBXFYeuRHZYXCGG8U0udxnb4YWxiZUy1
         ZswMxlHTjYyUEWXHxF4DzKiSwgUp/yFBgdz7RMe6BokTe22RJpEbCZI/4oq4XhQHRExY
         j0sU6FIzcdFq2cMzOjsXeiuPOhart8GSu+VQkSLWGzjUcx/SYVv+R3RAUkO59wbFTbQB
         Ojw8LX1GkF1vP6WJ2gHooeVXo+kFhDqRPrhV8OIALbZlz01vV624K3GUS///0Qkltxrx
         sxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2I9Y2hRuXgRqT6FgB1KECR88tDHWd7i0V/IscrZ+zbo=;
        b=uQK+pA2W+WPh2Iu4DreB827xC1TmNf+96VPW6/XTDgvvcKLtTUAw90NMYVWa6eeZY+
         N4c+EACtK3IeOOg54iUwGl8CjOrouyBwisEDN5yDV3f66pzqq4MEICG5rjiygzT/BQiX
         PA3OFInfvnY6JwNhMnYRBs5By9X8txiepIF9NVWHfVB4mn2/L2q51ENmkGectH9up26H
         0bQLe88kiam/qHU5q3UbriA7yfSf7ElIATVgxt6VEB6ecxrJ06ROMPnJY39Pw4LSkPJ7
         JS1uR7kNcMx9LTkvElciFH44DQzVhKhLwLPPT7PBbZbO5Q7+F80Z7M3RklvGFpZLeLeo
         wByw==
X-Gm-Message-State: AOAM531byRGeZCv7RnNPidBr5XQNsZ5B/R2xA1H3V5rBFJCBGvSVQaEP
        09AHVd8afw2OMLsPdyaGgkcfd0wC1C4=
X-Google-Smtp-Source: ABdhPJwjQH/0c75LVir/TlVcpjrdvkJFhHSco2V5b3LCPukwJso6lJVJjsn7oRu+uxEMraWEEN1tng==
X-Received: by 2002:a1c:2d86:: with SMTP id t128mr5135410wmt.189.1600846087354;
        Wed, 23 Sep 2020 00:28:07 -0700 (PDT)
Received: from localhost.localdomain ([178.237.235.60])
        by smtp.gmail.com with ESMTPSA id j14sm30046838wrr.66.2020.09.23.00.28.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Sep 2020 00:28:06 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v8 5/6] bisect: call 'clear_commit_marks_all()' in 'bisect_next_all()'
Date:   Wed, 23 Sep 2020 09:27:39 +0200
Message-Id: <20200923072740.20772-6-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200923072740.20772-1-mirucam@gmail.com>
References: <20200923072740.20772-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As there can be other revision walks after bisect_next_all(),
let's add a call to a function to clear all the marks at the
end of bisect_next_all().

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 bisect.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bisect.c b/bisect.c
index d42a3a3767..c6aba2b9f2 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1082,6 +1082,8 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 		  "Bisecting: %d revisions left to test after this %s\n",
 		  nr), nr, steps_msg);
 	free(steps_msg);
+	/* Clean up objects used, as they will be reused. */
+	clear_commit_marks_all(ALL_REV_FLAGS);
 
 	return bisect_checkout(bisect_rev, no_checkout);
 }
-- 
2.25.0

