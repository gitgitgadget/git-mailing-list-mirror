Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E991FA373D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 22:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbiJYWm2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 18:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiJYWm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 18:42:26 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E40DB741
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 15:42:26 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d24so12282233pls.4
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 15:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEFiXeGVxeypL9NEkDGMGuctTCiRBMCwjjSRE7B3tNM=;
        b=I+AePEeF20pP7Px6qnHUiT+Y5epHzKpy0oqfvVUFboWljIeuCXpvjYNq4jrAJGLlsL
         FbXtefdtgvs8DoU+1Rwt+ScHDfm6VhYl8n1jAdpvuBdtOQL9TlSNgoPeK1nUw2kf5c7s
         d5yVp1i8Yu9X5NLqWR3Ptn2cEUJ3SDEKwQCNL8kWcFy+AfV3sNesBtnwAQzajSAH76iA
         vQm1JmKDbGtxc/HTpu3kwwhw3PTLnLefCenNjnLp1ntwcpPGV3HB4H1hbWB6AyG9Jt7S
         T+8+FcoVrwQC9pEWalIQuXAZlAd0RsjpyEQiHeRbd0/o07C7Pf/MM0bZKwITPO0+uBuz
         8yKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PEFiXeGVxeypL9NEkDGMGuctTCiRBMCwjjSRE7B3tNM=;
        b=MQzW7zNzTx/mL8KQ0HIFC0Kb8GdoDTCxbs+YEEsa8xyAPfUcIoYoccgjZlpLMiChPT
         ZzltEd1+f5BfXO4/5GUqtRqTSw1MW4t7g4aMpWotC2E0ONQ0vSJd2hh0iCw/6BC6MWew
         v0W23MTSWO+HRIuKo7c4bD7CnHc/C3vtQWp8s9Sl3UuhUdJzQiI800SKH+aTaWBta2mc
         WdnkA7xKfVE+R+oKBLMj72j2oh4xuua+aKgu8bcl9s6e/rtixgF4egzpr3KNqV6EsL/M
         ExBTbTyL49j8GkIAWt2+2+Clm5ZkFJQiYU5StexOjr43sXmMaQW7uLL1LRQtn910cSQI
         Cl6g==
X-Gm-Message-State: ACrzQf0Ja7GkJKOxiBSGKePp1WE8jOb8arcZAGDknXUQZ3nOMrbn6pyI
        maDBqXz126pXvtR/WwOHuL6yhqsMwjo=
X-Google-Smtp-Source: AMsMyM7hYnOP0lT1Lnqu1l79ueIGYd5KdCj8ArFYRRRE+0i/SmJHqP+y5Ek4xsSkSpwz6/IuSSoHQA==
X-Received: by 2002:a17:90b:17d0:b0:213:2ef2:6bb1 with SMTP id me16-20020a17090b17d000b002132ef26bb1mr623630pjb.125.1666737745242;
        Tue, 25 Oct 2022 15:42:25 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id z17-20020aa79491000000b0056232682a7esm1878251pfk.2.2022.10.25.15.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 15:42:24 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>
Subject: [PATCH v3 0/4] document fsck error message ids
Date:   Tue, 25 Oct 2022 15:42:20 -0700
Message-Id: <20221025224224.2352979-1-gitster@pobox.com>
X-Mailer: git-send-email 2.38.1-359-g84c4c6d5a5
In-Reply-To: <pull.1369.v2.git.git.1666667864.gitgitgadget@gmail.com>
References: <pull.1369.v2.git.git.1666667864.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git fsck" reports various anomalies it finds in the form of message
tokens, like `badDate`, in its error message, and allows most of
them to be tweaked for their severity levels via configuration
varialbes, like `fsck.badDate`.  We however do not have them
centrally documented anywhere, other than the header file itself
(and the header file does not have explanation on what they mean).

This is John's work, with a bit of help from me.

 * Patches 1 and 2 remove fsck error message IDs from fsck.h that
   are not used in today's code.

 * In patch 3, "git fsck --help" gains a section that lists all the
   fsck error message ids with explanation.  "git config --help"
   gains a reference to the section.

 * While we worked on patch 3, we made many small mistakes (like
   spelling the tokens with incorrect camelCasing, or failing to
   list a few messages), which revealed the need of automated tool
   to catch them.  Patch 4 adds to "make check-docs" a mechanism to
   verify the documentation covers what is defined in fsck.h
   correctly.

Possible future directions that are left outside the scope of this
topic are:

 * "git config --help" may want to include the same list inline
   instead of having a reference to "git fsck --help".

 * Instead of the lint-docs support, we may want to auto-generate
   the documentation from fsck.h.


John Cai (2):
  fsck: remove the unused BAD_TAG_OBJECT
  fsck: document msg-id

Junio C Hamano (2):
  fsck: remove the unused MISSING_TREE_OBJECT
  Documentation: add lint-fsck-msgids

 Documentation/Makefile              |  11 ++
 Documentation/config/fsck.txt       |   4 +
 Documentation/fsck-msgids.txt       | 161 ++++++++++++++++++++++++++++
 Documentation/git-fsck.txt          |  12 +++
 Documentation/lint-fsck-msgids.perl |  70 ++++++++++++
 fsck.h                              |   8 +-
 6 files changed, 264 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/fsck-msgids.txt
 create mode 100755 Documentation/lint-fsck-msgids.perl

-- 
2.38.1-359-g84c4c6d5a5

