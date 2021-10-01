Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA24CC433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 11:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D33C861A55
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 11:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354091AbhJALju (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 07:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354083AbhJALjr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 07:39:47 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B363C06177B
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 04:38:03 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id b22so6129777pls.1
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 04:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sUPzEwT9kBviiQ7JxwXCXWD5wduGAwbvTBLIw++i3SQ=;
        b=eFwLYBOkKx0ZpFmgsWLx2oezGyekwI/SUMaufyfdyOqBetTME7YCNfm4v7POjSeTr1
         wNpRW2ro+4/+d+a0XVl84LNvU13fzu0RSvx++w3MrBDJwlZD5rZxVj6+QB8WlRTF+tnm
         GuiZKF+TYWHznbJ29cS7AvqH/cPv6lMUVMBPShMGPZA9+utoyEd1Z/GJ5uEZ84DvqjBG
         4uTppuRSWgkwloFrOiQoI1Pq18VgL7vkx/6HjodEu55zB+wwcV61+jwRY+RjmOEODxFB
         gJMO41pqf6R2VFqHCN6zvkcOzgTG3wqUaezye6jg5GP/pi4NejYNR1mtSuqN1rSptLpw
         VYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sUPzEwT9kBviiQ7JxwXCXWD5wduGAwbvTBLIw++i3SQ=;
        b=jgykdFY6BLXXJms8WUIzZzjOl6os3UG9gQWvKSfnY1x2+khGZES4kYvISzV6atgq/F
         4nsaY0w5JMxshGRKtBmNtnnk09CcIY6TsgVVPP+Sy2eBuLUu+3Z2pp6/4pIovuvh2qJK
         bwSvMU6fqtjnPQ9wtsLg1xhkiVrOQSFB+RbRijphQlu21DKTGT54aC8q4J9lkQnk6Czb
         8+THPuG+Bz03Tzcvqs/s1Lty+gCfJi/80+Jequ8H87JPE+Tfa2gajXOWpWT0ZDQdeFmr
         v3+Agqjp3wn4k+akMSpV0ghXAEy3d4dM0dB41yzPDNkb1POg7lvPYqTebUgnSSjpZ1+M
         U0JA==
X-Gm-Message-State: AOAM5303lyz3ZbgjWEqjq9U4pyTHm8jkJggQKxoh0gCFOMTeUJx6JX0t
        OwacnJIq0YJUC0rBRHZbOR30oml8x9VgAA==
X-Google-Smtp-Source: ABdhPJx0jHotzAApWgY+oONHJGEUVmDvNswAaaQ7IQM3jEbh04otVcOpcuAVVM92nHu/KvZK4KMrPA==
X-Received: by 2002:a17:90a:9285:: with SMTP id n5mr12561889pjo.29.1633088282697;
        Fri, 01 Oct 2021 04:38:02 -0700 (PDT)
Received: from ubuntu.mate (subs02-180-214-232-87.three.co.id. [180.214.232.87])
        by smtp.gmail.com with ESMTPSA id e7sm6066461pfc.114.2021.10.01.04.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 04:38:02 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        "Dr . Matthias St . Pierre" <m.st.pierre@ncp-e.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v3 1/2] blame: Describe default output format
Date:   Fri,  1 Oct 2021 18:37:25 +0700
Message-Id: <20211001113725.13354-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211001113725.13354-1-bagasdotme@gmail.com>
References: <20211001113725.13354-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While there is descriptions for porcelain and incremental output
formats, the default format isn't described. Describe that format for
the sake of completeness.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/git-blame.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 3bf5d5d8b4..683f8ab0b0 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -93,6 +93,19 @@ include::blame-options.txt[]
 	is used for a caret to mark the boundary commit.
 
 
+THE DEFAULT FORMAT
+------------------
+
+When neither `--porcelain` nor `--incremental` option is specified,
+`git blame` will output annotation for each line with:
+
+- abbreviated object name for the commit the line came from;
+- author ident (by default author name and date unless `-s` or `-e` is
+specified); and
+- line number
+
+before the line contents.
+
 THE PORCELAIN FORMAT
 --------------------
 
-- 
An old man doll... just what I always wanted! - Clara

