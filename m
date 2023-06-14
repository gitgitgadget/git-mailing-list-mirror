Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CA2EB64D7
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 01:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236549AbjFNBKx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jun 2023 21:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjFNBKv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2023 21:10:51 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E611BE3
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 18:10:50 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-652a6bf4e6aso4819238b3a.2
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 18:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686705050; x=1689297050;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kxglRIHY/RG5KxH2l53ZILFIW11wAOD+xljy2eMx5y0=;
        b=ESFJCK3fLSijIIHpBdRzABW4CYVv8o4hfB8C7bVQH93MBilWThWn+OF+//fZa/sdWr
         F4c6LmKiYkJG3U39mxObCJ4oN7ndplMUFMom4CsW46gwndCItYs6UNIYuVWo1Kf20sVk
         4dHcH3hG5vsY3F/jkP5UrgQL5ms1m3sNj9z14MqnDMRbNUa3E//PU6c6zJ49oPA0Xb6F
         nlgO9Q4p/gHJiVCc7Da9mVLF9LVtsLqFByoAVzg6ICIv38VRT2+LaTbH1flKd80qZ6fG
         LKdqSgVKK/mF/J+KHiuyglqRLlgZH1EODAnkrKpXPFskqXAo3dRTU6FsFFKOhUt0TP90
         hc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686705050; x=1689297050;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kxglRIHY/RG5KxH2l53ZILFIW11wAOD+xljy2eMx5y0=;
        b=FEbN3/2dKKC6FLH+Py4qTHIEzXpqMqQ7+xDgNnSg8M5ZQU9cNNUDZnktMrgAG/w2LT
         uZT9Bl94mDMgqV0Lb/XK6+sbPGlmMXgfuVY67E8TaFcch2xSqGeedcQ1EGMOYg5qhoql
         Ker0G9A2djbwY40G10K0ayyV+Y1iV2m2ayc/1SgdgMiyyXwo/NlBruvzr7kREOIthyuy
         GU97HED8b/BN/rdO8+bV//EwSuGa8TQiU3hAXKd4loGZyXvBabRpdZdSv85H2PgM3Gow
         uGXMWAgJQ8Jjo4YxWDDl4kdcuiW8DfkPZGHCt5QFMKYYKMLo6MAlICxEOJDuSBhf4f/K
         xghw==
X-Gm-Message-State: AC+VfDzVadI81yQGNvCT6tsa43gG2dC8+PyDsoY+R2tGr9M4qjqse9Rb
        ZcZ6vIGIZQAcGecF3nBz+kc=
X-Google-Smtp-Source: ACHHUZ44y9Oo6VUiB8ntRzDRQ1sHSDepjJ6OzNBYqUA5jDNS5WmhhbaYaqyrgvbkupShqPFd59gPAg==
X-Received: by 2002:a05:6a00:1828:b0:651:3e9d:2a05 with SMTP id y40-20020a056a00182800b006513e9d2a05mr475714pfa.19.1686705050072;
        Tue, 13 Jun 2023 18:10:50 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id q23-20020a62ae17000000b0062e0c39977csm9231880pff.139.2023.06.13.18.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 18:10:49 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH] notes: do not access before the beginning of an array
References: <cover.1682671758.git.dyroneteng@gmail.com>
        <ed930ef4f795f30792bc14d9c1939484e4976db8.1682671758.git.dyroneteng@gmail.com>
        <xmqqh6ra26vq.fsf@gitster.g>
Date:   Tue, 13 Jun 2023 18:10:49 -0700
In-Reply-To: <xmqqh6ra26vq.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        13 Jun 2023 18:02:33 -0700")
Message-ID: <xmqqbkhi26hy.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The check to see if the last byte of the separator string is a LF
makes sense *only* when the separator string is known to be non
empty.  This has been breaking the asan/ubsan job at CI.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This time with a proposed log message with sign-off.

 builtin/notes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 6eede30597..785b1922ad 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -239,7 +239,7 @@ static void write_note_data(struct note_data *d, struct object_id *oid)
 
 static void append_separator(struct strbuf *message)
 {
-	if (separator[strlen(separator) - 1] == '\n')
+	if (*separator && separator[strlen(separator) - 1] == '\n')
 		strbuf_addstr(message, separator);
 	else
 		strbuf_addf(message, "%s%s", separator, "\n");
-- 
2.41.0-28-gd7d8841f67

