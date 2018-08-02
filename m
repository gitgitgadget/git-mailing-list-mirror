Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 247641F597
	for <e@80x24.org>; Thu,  2 Aug 2018 09:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbeHBLW7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 07:22:59 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:38337 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbeHBLW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 07:22:59 -0400
Received: by mail-io0-f195.google.com with SMTP id v26-v6so1264217iog.5
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 02:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zSkxzAz5TX8pvA1NeQW7l324fMRh8UNMscxEVd7ZvrI=;
        b=tlD0S7Wcs5bCdfLFuKtQabKlVJ3EBi/J+I8UQqjyfUky1mHke3q+sKlwCZ9M0AqV0X
         BRkWHIi7ktpQB/2iGaidEidCBiti6m1ayVtuDvlfxjoAgom7LhubTWfBplavYpPfW2Ne
         ouo+fkJXmoYXvGG9Sr3Rp/WGrRCeZ3HcbEm4dGM1SWP8XWlq8NlA1aoJXDVuIwwDywAr
         kDmIzZQSn/nEq4+cN0Ca9F8z/YS/r1RLIuocwbM6Uw/vmW5d7iw4bfah3Zo4NzPlvpVB
         15/e/4mTWUA45d1xbrFl+E7wICABsEnqXQbCf7Qn9JAuMzCRRg088225IZ1LaJxAKeF/
         Czog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=zSkxzAz5TX8pvA1NeQW7l324fMRh8UNMscxEVd7ZvrI=;
        b=midcUt7vsKHGVCYc4Qp/VtkDOAYsYgYMbb+8hQXnxql91iemJcZFumwV+ZCUWHAkpo
         wo1Hn5yHJtJd/10H3XHF2PvLAwQ1gjRYTCEC9CykUT1+gTAEnMGUJCtnwDC61apB/ZG+
         VgAkv3Q9UntpHPtWrRkWjdrhATmoLuv0rtVzOHiHoJ3bjyGYryWDYQ/RzK+GPW+oN4mi
         7Y7LYh7f7NJKiEKdRuL4kjr5Ow9s6voTuqezm9H6KH7F9lKjTp0yVT6GY6pgeMoOudsX
         mRnvwIyskETHJ7X6fjpeJZtseq47LZ29R3uqFCOlCoIWt5Zia1blFW7xJXSQF8WJ5KQX
         5jFA==
X-Gm-Message-State: AOUpUlEIjmtIfWUVJuj4SHaHmhGCUq3dRbkUdQDRVeUTW7ueUM08noF6
        PLiHr2Jcg7BsP+0XNHR8e3T+PVP9
X-Google-Smtp-Source: AA+uWPzZrWjQr0NtAYOCu+BinMpI24SDop/w71zpPSS+b97+Ch+s0LzKEjGgLV/5+UKdN0PalondaQ==
X-Received: by 2002:a6b:e913:: with SMTP id u19-v6mr1401936iof.38.1533202359868;
        Thu, 02 Aug 2018 02:32:39 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id 74-v6sm662379itx.41.2018.08.02.02.32.38
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 02 Aug 2018 02:32:38 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] color: protect against out-of-bounds array access/assignment
Date:   Thu,  2 Aug 2018 05:32:08 -0400
Message-Id: <20180802093208.27420-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.599.g4ce2a8faa4.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

want_color_fd() is designed to work only with standard input, output,
and error file descriptors, and stores information about each descriptor
in an array. However, it doesn't verify that the passed-in descriptor
lives within that set, which, with a buggy caller, could lead to
access/assignment outside the array bounds.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Just something I noticed while studying this code in relation to a patch
review.

 color.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/color.c b/color.c
index b1c24c69de..b0be9ce505 100644
--- a/color.c
+++ b/color.c
@@ -343,6 +343,9 @@ int want_color_fd(int fd, int var)
 
 	static int want_auto[3] = { -1, -1, -1 };
 
+	if (fd < 0 || fd >= ARRAY_SIZE(want_auto))
+	    BUG("file descriptor out of range: %d", fd);
+
 	if (var < 0)
 		var = git_use_color_default;
 
-- 
2.18.0.599.g4ce2a8faa4.dirty

