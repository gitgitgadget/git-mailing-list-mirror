Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36ED8EB64DB
	for <git@archiver.kernel.org>; Tue, 13 Jun 2023 17:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbjFMRar (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jun 2023 13:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240069AbjFMRaH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2023 13:30:07 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE04E2108
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 10:29:39 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bacfa4ef059so8306334276.2
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 10:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686677372; x=1689269372;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bc8y5NJo2P22XMs+B+NrrQg2ZFzjiAsz3ThDOBe4wqE=;
        b=3qGIXHiqm9k+rSuBHEbLk5e83ObvHJibVikr769SHS+7XkeKZiGkaYREe4IR5rLMJJ
         F81KzTdUzXj5FIloH+nPAMhX3SOIz7F5bmiq+3El5Ne0t2KQ5u0JfbCHaPzj1z/edXKl
         Xn9aA/RONb3pMbtLpOzL+mzK+8bHx+3JKmafkrGpRtgjHHpAFb5Za87vCfwnMY+v1SZe
         0lw+5AMy2Y+tYGfKN1PTIIyvyTyp2QFp5aeAU0geC1qARRUwcIjUou0g46XsJGSSiU/w
         XQN6nGN8brV/2pVp65tVXZ7IFVt5r1/orHNUqBIwfUOCMQEKRVVqB7Rs90IGmSye80ni
         p6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686677372; x=1689269372;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bc8y5NJo2P22XMs+B+NrrQg2ZFzjiAsz3ThDOBe4wqE=;
        b=QXUEKk2StrjJAeikGbayGptcJZ/8wyoMkkXfLpQE09DDTrc9quxoLkYLD5j0okX299
         IqWfHUYf+VQozjTPELdfnIrmaqBfDatgQY1kJjj4m9Xzqga8ECIwRrLW93GBKVjJ+7oZ
         U3XBjrqJ8nU1l4KYNqcDkwJyeCAXtLQDdZANxi9Y2Hrkg0knfE3hE4AjvX1psUldjT0s
         pec8X3gMKyTu0dXnYakG5LyNe4JYOhZD/OL3F7dYsDpgYU1e3lY9WKUyxcs3SMKnYk08
         h43fO7+U8DHcsCAazuA9CRIFHEIdejK/TUsacSfHYBWtGbXn/SY7Jye3Y4+8THcjBnPg
         Rk9Q==
X-Gm-Message-State: AC+VfDy/rBxxy8eJnIdmkTgk53+j8KZseywpA69t6oheR/hsZO1LSDJO
        AeE5p0fkqmNdx6IOb5cuKnZPJAGQDeHOKbmo4Z8MSSLnehmaZVm7ar1QpvPx5/+KLyqLnDtd5TG
        T91raF2NJ1C+7QPNkiZb7CGSPnuJPZKJxv25Y2ni2cPOmP+i3GPVr74pZgsedAY/sMUCr57zxqd
        Ht
X-Google-Smtp-Source: ACHHUZ7dv3bRkH71SEnGhsCO9ZxYGA9kui9F8VMKEJmGRTXIYApzxM3JnMZ755gOtCAmiI+Uy7DiJ+Ibr2XHzN11uvQe
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:5e39:4d58:c992:1db0])
 (user=jonathantanmy job=sendgmr) by 2002:a25:854e:0:b0:ba8:929a:2073 with
 SMTP id f14-20020a25854e000000b00ba8929a2073mr1048115ybn.1.1686677372597;
 Tue, 13 Jun 2023 10:29:32 -0700 (PDT)
Date:   Tue, 13 Jun 2023 10:29:26 -0700
In-Reply-To: <20230613171634.15985-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20230613171634.15985-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230613172927.19019-1-jonathantanmy@google.com>
Subject: [PATCH] CodingGuidelines: use octal escapes, not hex
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hexadecimal escapes in shell scripts are not portable across shells (in
particular, "dash" does not support them). Write in the CodingGuidelines
document that we should be using octal escapes instead.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/CodingGuidelines | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 003393ed16..1c54abd7c5 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -188,6 +188,9 @@ For shell scripts specifically (not exhaustive):
    hopefully nobody starts using "local" before they are reimplemented
    in C ;-)
 
+ - Use octal escape sequences (e.g. "\302\242"), not hexadecimal (e.g.
+   "\xc2\xa2"), as the latter is not portable.
+
 
 For C programs:
 
-- 
2.41.0.162.gfafddb0af9-goog

