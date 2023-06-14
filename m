Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88AAEB64D7
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 00:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241013AbjFNAQE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jun 2023 20:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjFNAQD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2023 20:16:03 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA151B8
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 17:16:02 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56536dd5f79so2083457b3.3
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 17:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686701761; x=1689293761;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bs/gmtZnWlnu70YMdAacjvyQa+TXVacgB7uoGWtKvBA=;
        b=bfOHcitRSbLJflm87+ZHquLxoqGO0SEFy9VTJhs0VCwWvpvv2n3v4qk+5L3jxRJnx8
         RV+YX3mRVSPAK6IZ9qy3zKOqCabn0zJaikZ+9HRxnHZfBZ73Nf/Qy1wQ34Dyc1F71Yht
         onq2K7pX/u8LY/IQOMxj18eNKp/rnmNS2OL4+OhrmtbdkOlk7IuRbaVsuKizH3h7vOGc
         xBr2HH6yxW/Pu2PnuYZ6Txkb1AYWgOrQpWBpLlJx8+o7rdPeScwHx6pcYiIoBRzgthqk
         LVX3t1SL77bRo+WifS6/Vf7+W8PCAJmxM9wOfr6KgS0J8HbmK6d9bx84sVzpGqDQ/aSt
         dx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686701761; x=1689293761;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bs/gmtZnWlnu70YMdAacjvyQa+TXVacgB7uoGWtKvBA=;
        b=gPdcgeLvuHwoUec6IWZnRKExP2ccsOvL1P72lknKvoR9EtaV+SngrJ8WSkzK/EYSm3
         xzvOpRZCrjLWLR92roPYooZAeGQs2TOz9YR90wWvoiusRgpNl7IiZBjg2Iqhk1Kzxzz9
         40gEs3E+ibo200UjsUK4bFdTB3onzIRSkbjVaE4+PE14YdYTTWFghRt0d92W7/bcU5rg
         opMG+qVkJkrRxZl+vEHOptRJAArgldoeiHNBMuLxXav5+44rXwkKneZ/1kawuFawD7Cv
         P9ybm5/MCvJEfY82/Ta199lnCsBHqhlfhm32FEQJHxPZTRMBFQobMO5AjJoouxnJDNN2
         kNBA==
X-Gm-Message-State: AC+VfDz2Bb8ifHPcWJRsSkp3XkoimYdq9d1uiquqa8/U1mNlYC/fVy4L
        llU2U7wWqF+zhpaPEVz9aT0cch5oN60W6d4TNoN7ozft86P8cDiEV1GA72rY8JE76r74kERd3ww
        BT59vEeAlvp4+p8C0mq0wYkuzq5ci4Md+OojiuZYOkAZciMl1ne/uM7b+TpyaLxuiWwWalCT87V
        8R
X-Google-Smtp-Source: ACHHUZ5T3uiecRt59UuTZfjlq6itC2OnypQ1/pdvUs4yeWx7Mi495ykhNEfHHDzYnFFWEmScbGCNhJLWnLyzsZjpc0N6
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:5e39:4d58:c992:1db0])
 (user=jonathantanmy job=sendgmr) by 2002:a25:664a:0:b0:bd7:6810:6666 with
 SMTP id z10-20020a25664a000000b00bd768106666mr336968ybm.5.1686701761459; Tue,
 13 Jun 2023 17:16:01 -0700 (PDT)
Date:   Tue, 13 Jun 2023 17:15:58 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230614001558.277755-1-jonathantanmy@google.com>
Subject: [PATCH v2] CodingGuidelines: use octal escapes, not hex
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sunshine@sunshineco.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the shell-scripting section of CodingGuidelines to suggest octal
escape sequences (e.g. "\302\242") over hexadecimal (e.g. "\xc2\xa2")
since the latter can be a source of portability problems.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
I've used Eric's suggestion for the commit message and limited the scope
of the documentation change to printf.

Version 1 was here:
https://lore.kernel.org/git/20230613172927.19019-1-jonathantanmy@google.com/
---
 Documentation/CodingGuidelines | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 003393ed16..30ac7d2d3f 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -188,6 +188,10 @@ For shell scripts specifically (not exhaustive):
    hopefully nobody starts using "local" before they are reimplemented
    in C ;-)
 
+ - Use octal escape sequences (e.g. "\302\242"), not hexadecimal (e.g.
+   "\xc2\xa2"), since the latter is not portable across commands like
+   "printf".
+
 
 For C programs:
 
-- 
2.41.0.162.gfafddb0af9-goog

