Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAE1E1F453
	for <e@80x24.org>; Tue, 23 Oct 2018 19:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbeJXD3O (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 23:29:14 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:44764 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbeJXD3O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 23:29:14 -0400
Received: by mail-vk1-f195.google.com with SMTP id x78-v6so616313vke.11
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 12:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=etkRInz0sFsmiAtPiCEVJLVjhBEJmqiLt93PnrwFriI=;
        b=gUemo+W20/NUZGmntUn9LbZOwbVIzYJz+Ruz49GWfsjBNRPP5A55HJHbmj2bvUViLq
         JNkPXT6gjLPgLphHLqSjyDMHJDcnrDOJwldy2qLgTTtEP2/4wVqQw/YdLlmlD6yiKJ4O
         SZNBvOJfL68KNKvij+b7iI17f+DxwWPpzVvhlWcETS3+PxJ21KrSu/ylp2Rq3toL2XaL
         pa34URc2XS7nCul7ir4T+1R6S4PQ02iRVzIPtAjW5oeUNBgyfqpg/72Zfq7df54TKPXw
         EFx/sbuurYuchFZ5UTnXzp4OBNfOKMb663VIjkN3eCLXHf/EqpVEFJZWzlR/vRWiFsE8
         PWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=etkRInz0sFsmiAtPiCEVJLVjhBEJmqiLt93PnrwFriI=;
        b=bbfrIhAbADF3Xt5wcmDt8YORaQpFcldOCjfQPYSqps4BBLgv5QnVdON7DeqMMglbRV
         NcM7rJWpvRdf8KUa5vCV4GuvgQwibjcCdsYU9Fo/YVPjnErC/NxA58mV4sTfqW2gJqsz
         K6C6KSepc/A1E74NBwRXzjUC0IuKJwBzPvGM+LY1lmnWVoAQn2uCRJWhU0NUt7daP+EE
         +0/2A6NUCKlNMoN/iqKZ3w67QMd48/JrEs5ojSgIo707T6GgY6H/wkThpmfQasIxa53N
         4TDmU5rPFpzeis0ysWi2UtZ3DTyVodfA/GPamm3oRYkgq65FVNVExW6tCz2jTYSaKFWZ
         Qjpw==
X-Gm-Message-State: ABuFfogqKhTOn8oXpWfcRpwLlVZsFC5ogTKw/WM3tI3doWaSTvw8DCJi
        o4GG/JLOhN1v0rw1buc0eft06X+vFm0=
X-Google-Smtp-Source: ACcGV631yUXGpdDDY8oVTfj1mQOoAo/VmpI4/Nt3yJ0OWYg1aN4jM+kNbKNqxxlajM4FmGS6fNI91Q==
X-Received: by 2002:a1f:b48:: with SMTP id 69-v6mr21660772vkl.54.1540321472960;
        Tue, 23 Oct 2018 12:04:32 -0700 (PDT)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id e79sm473284vsd.1.2018.10.23.12.04.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 12:04:32 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, peartben@gmail.com,
        peff@peff.net, sunshine@sunshineco.com
Subject: [PATCH v4 0/3] speed up git reset
Date:   Tue, 23 Oct 2018 15:04:20 -0400
Message-Id: <20181023190423.5772-1-peartben@gmail.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <20181017164021.15204-1-peartben@gmail.com>
References: <20181017164021.15204-1-peartben@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

Updated the wording in the documentation and commit messages to (hopefully)
make it clearer. Added the warning about 'reset --quiet' to the advice
system so that it can be turned off.

Base Ref: 
Web-Diff: https://github.com/benpeart/git/commit/8a2fef45d4
Checkout: git fetch https://github.com/benpeart/git reset-refresh-index-v4 && git checkout 8a2fef45d4


### Patches

Ben Peart (3):
  reset: don't compute unstaged changes after reset when --quiet
  reset: add new reset.quiet config setting
  reset: warn when refresh_index() takes more than 2 seconds

 Documentation/config.txt    |  7 +++++++
 Documentation/git-reset.txt |  5 ++++-
 advice.c                    |  2 ++
 advice.h                    |  1 +
 builtin/reset.c             | 15 ++++++++++++++-
 5 files changed, 28 insertions(+), 2 deletions(-)


base-commit: ca63497355222acefcca02b9cbb540a4768f3286
-- 
2.18.0.windows.1


