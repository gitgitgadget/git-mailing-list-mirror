Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE4DF1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 13:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbeJVVhN (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 17:37:13 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34232 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbeJVVhN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 17:37:13 -0400
Received: by mail-qt1-f195.google.com with SMTP id z2-v6so509904qts.1
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 06:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BwA1zeHtMNa6iurSJejVnqAejMz98T3eur2W/53zJX8=;
        b=unVR7BlaBEWG4LBpsbUdfI1RTosfqRhTn4nIjix+VUPGugNwSEdE8uCheY8z4fwi4k
         2gjOdDFnHLZLskxS3T+mLcOcxNVVVz7y5JX+nIWPN2luwzi5yVW/XRXSuvcKTpXlgFod
         8H1O04LQbCDRTst0TwjachX7Ktx2Zw7+P5tJ6gtmY1GX5lT03mR7ZO0x9ifdZ+VBoOyc
         iCFUycJEUhuQSQ1KxQSJ8F5ZxNIjgOdIrkYel2X+fQE3x6lihmK001HYhXy93TOM44uc
         bhAWzt6gy9K1o/NCLY1RaIKfUxrJCfcbO/KBgEje4qUyda472Qhq6BFobfne6ZnUEqix
         rhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BwA1zeHtMNa6iurSJejVnqAejMz98T3eur2W/53zJX8=;
        b=Ss+JjdKy2vj4Qdw3kszL/LY3jNH0ZSlzkRTFhLoP54nG6L1OaEPwkK8uXch5pYtg7L
         WaanvjYdtoerxzX9IdogANreNCuadmwDj+PchSlY/8KNXXSfC5Ddfq39EPCEU9SCIz76
         Q8Tu5EgwvGmkt0WKKbjZ1PeWEYEhYs/BFqGlJeJjqtso4fUKsXLcGzJ91Pf2hR3t6Ta1
         imStGAfRWQDtXUrd7HLAxPzww7nmjiXtbM2f/tK/Goym1KZ09axJ5BvQ3daNDZvM/lXP
         2VxzHn+4xSv2vEjVExNjmMQMkTsDVX0td5WZrQNu4pI7ty/hZRLWmxss29tc+dLPi3WC
         rMQA==
X-Gm-Message-State: AGRZ1gI4WYsN1S34rPSi4TIer1dGz4cKrd2/5wYtoLJ7nHfgLlFnvzFy
        O5eEBNzvt1IyJwjQTiASjATLip/OO9E=
X-Google-Smtp-Source: AJdET5eHs0M5zD0GC2VnfvOBYZNVcEwbsnS0QhJPH6atkflSVuDkuovAvgRLqx+M7xgNePSz3QjsFw==
X-Received: by 2002:a0c:a3e4:: with SMTP id v91mr1648571qvv.247.1540214318491;
        Mon, 22 Oct 2018 06:18:38 -0700 (PDT)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id n39-v6sm746052qtn.36.2018.10.22.06.18.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 06:18:37 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, peartben@gmail.com,
        peff@peff.net, sunshine@sunshineco.com
Subject: [PATCH v3 0/3] speed up git reset
Date:   Mon, 22 Oct 2018 09:18:25 -0400
Message-Id: <20181022131828.21348-1-peartben@gmail.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <20181017164021.15204-1-peartben@gmail.com>
References: <20181017164021.15204-1-peartben@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

Reworded the documentation for git-reset per review feedback.

Base Ref: 
Web-Diff: https://github.com/benpeart/git/commit/1228898917
Checkout: git fetch https://github.com/benpeart/git reset-refresh-index-v3 && git checkout 1228898917


### Interdiff (v2..v3):

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 1d697d9962..51a427a34a 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -95,7 +95,9 @@ OPTIONS
 
 -q::
 --quiet::
-	Be quiet, only report errors.
+--no-quiet::
+	Be quiet, only report errors. The default behavior respects the
+	`reset.quiet` config option, or `--no-quiet` if that is not set.
 
 
 EXAMPLES


### Patches

Ben Peart (3):
  reset: don't compute unstaged changes after reset when --quiet
  reset: add new reset.quiet config setting
  reset: warn when refresh_index() takes more than 2 seconds

 Documentation/config.txt    |  3 +++
 Documentation/git-reset.txt |  4 +++-
 builtin/reset.c             | 15 ++++++++++++++-
 3 files changed, 20 insertions(+), 2 deletions(-)


base-commit: ca63497355222acefcca02b9cbb540a4768f3286
-- 
2.18.0.windows.1


