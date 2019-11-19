Return-Path: <SRS0=OLpm=ZL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411DEC432C3
	for <git@archiver.kernel.org>; Tue, 19 Nov 2019 23:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1628F2240C
	for <git@archiver.kernel.org>; Tue, 19 Nov 2019 23:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2KkivDj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfKSXze (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 18:55:34 -0500
Received: from mail-pf1-f172.google.com ([209.85.210.172]:40514 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfKSXze (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 18:55:34 -0500
Received: by mail-pf1-f172.google.com with SMTP id r4so13222060pfl.7
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 15:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+w/14371ojJSlzrJwFa5ys59seWwf5/OiHSdka8XtAE=;
        b=q2KkivDjilylzCwJLHv7P5LDOOd7G5Q8aGYSnkFkFChExSqgAjbaZ7KoteQXkXUN7p
         +NuaAlDV8eMF9mq4yf4VRbWCCd6tGQslNTxdCzPV+Gqf33N/+tdi1o1eqjVDlg0K56Q5
         KNPV6H7bQnDqoBFJOsSPNUbcJH29WN9W4pw6w0LWZpaSESqa6YHQ0kqddhenyFm1wD1v
         dGOyh7XBHk2xvDWs2XnZDmlJXK4F9q35IWrWwuRRxX2WIuDAp3UYlpRKqMY3PsJR+S+5
         qzC9HQrKMqR0dJQZ2yg52hms3mTkcnVHtO3d+mSRzNyUiAFU8rVA7x7NI29alfoYOxsn
         wbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+w/14371ojJSlzrJwFa5ys59seWwf5/OiHSdka8XtAE=;
        b=MXGCOEmsh7isjK9A11Hl4+40zz1IsFX08F7KG8EUp/wfhytksAoi+hiesIrMmQeWp2
         5KGpVB0P4ITFFgAs+hlLDiSRIujOD8NVnXOwsuS29WjIUHJGSDxVaKMKz0lRUFZp2he1
         +Je6UTFA6gi/6ubkRxpAVDEiMVmX5TMsnAsJ2gRhhHM2DCaB77V+SMWnvxe/N9sR0ZLD
         IF5oXTBQFnLK4QEdbri7UMl584DEwmZ/tM9UjumxwPYj0AmWRyUwrpdNTMYjs9x75mmY
         znjfGZreq2LUIkPLbCBXJ+ra6Ga7BCtdAhXqdmGNKXc9r2RafBphBedLL8vNKEMwA5Q9
         SNFA==
X-Gm-Message-State: APjAAAVr9KDTTVRRu5ssnCw9fPzw25Z8OHVF3B47FXCT7we0z4fAZxck
        wjpHkfwxeEsLn6LrsyhIXmIdWKzu
X-Google-Smtp-Source: APXvYqx6OXOXBbFNGLCKb9b+MjxcnCatn+avOs+WF4RMnykwreWFL4LE1qUFJXeLG+4mLIt5g/vsHg==
X-Received: by 2002:a62:ed16:: with SMTP id u22mr393752pfh.28.1574207732126;
        Tue, 19 Nov 2019 15:55:32 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id l74sm4757076pje.29.2019.11.19.15.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 15:55:31 -0800 (PST)
Date:   Tue, 19 Nov 2019 15:55:29 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/8] argv-array: add space after `while`
Message-ID: <fd78742570bbeaa4096eb0cce24fe33054aed176.1574207673.git.liu.denton@gmail.com>
References: <cover.1574125554.git.liu.denton@gmail.com>
 <cover.1574207673.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574207673.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 argv-array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/argv-array.c b/argv-array.c
index f352ea9357..61ef8c0dfd 100644
--- a/argv-array.c
+++ b/argv-array.c
@@ -46,7 +46,7 @@ void argv_array_pushl(struct argv_array *array, ...)
 	const char *arg;
 
 	va_start(ap, array);
-	while((arg = va_arg(ap, const char *)))
+	while ((arg = va_arg(ap, const char *)))
 		argv_array_push(array, arg);
 	va_end(ap);
 }
-- 
2.24.0.420.g9ac4901264

