Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D05C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 18:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813E52071F
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 18:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJqcq8Dr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfKVS7t (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 13:59:49 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42463 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfKVS7t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 13:59:49 -0500
Received: by mail-pg1-f195.google.com with SMTP id q17so3726860pgt.9
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 10:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w/bvruO08Q1D16tLNHIWXG/1S0VOIWmg7KuffVMpqaM=;
        b=lJqcq8DruM0h9rharDAWU2pdBpZA/P1oYL4JnAXe3SC72egctVMqRNNeP7rw66p9Y6
         MAB9aOtedCcrG5gIfl1oqH2Wj64SVArdeCsn2tyGvkcyQmXtMheNhngbCU0Go69ebcjo
         5pgSx1S42NsHb8zjsvsTcejT5/pxQTG5kA8kMVQiBK3tgXIXXFqG449r7u6z8gR1M+AL
         q7KkuN1utD6wJ6lIAo3kM3qxbTbkgynE7DwcAt+Hy+wIOdSWF2h7t2sztJ8iGVuIS+/k
         dAZ0sDI5um4XXAvAB73cw8wQuQx692a56ghDqh8KUZ/y1X3EM4hC7gERFfUqSB0JsNCc
         pzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w/bvruO08Q1D16tLNHIWXG/1S0VOIWmg7KuffVMpqaM=;
        b=rTOvYBRrpGvOs/gRNjOrzqkYcTcxAxMgzLmF+Gjho+dUvaT1G3IEU+NJ0RkxqjgofI
         VqIDiaOUz4NriCT03g26hBNM5jMPizLNc3H+5TIScLNu4z2s9GrI4Q420G3Fk1SqRKNc
         DsMbRHR9HYapNY/PqBBgsQ0jc3ll6/Kcun86B4P99LflCfFkI3zlsD2uCzRx1/gU6OFM
         S2NZcjvsQe4JUg+xp6A4dpsnhJTyUuO+2kwpNG6MyC9meXRb1zpRkN/i6QS/0qF6rM/c
         WD2S+auMPUPLps7HDtQ3jwEY+t5R36P2vMd9JgrnsU3s1Hf/1Bn3r8zKzMe9XyF/IwCa
         xP1A==
X-Gm-Message-State: APjAAAUWjpARHcGrQBID2qbV7fxkx0SuZtEmMJqqPTrCLtc3DZXBPVq+
        0ZyFQbpImReaWodTvWJW0rBZw2Zb
X-Google-Smtp-Source: APXvYqw0Ifjskvps9kuR8+n9iXHJVywh515Vw6foy+eQiYWuXfk9Bqg03bSjsQK10hgvt3pnnC+BvQ==
X-Received: by 2002:a63:d409:: with SMTP id a9mr16624189pgh.194.1574449187045;
        Fri, 22 Nov 2019 10:59:47 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id 82sm8373729pfa.115.2019.11.22.10.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 10:59:46 -0800 (PST)
Date:   Fri, 22 Nov 2019 10:59:44 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 01/22] lib-bash.sh: move `then` onto its own line
Message-ID: <9085cc00af10408d9425cfdff5a8b2c49008ae7b.1574449072.git.liu.denton@gmail.com>
References: <cover.1574296987.git.liu.denton@gmail.com>
 <cover.1574449072.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574449072.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code style for tests is to have statements on their own line if
possible. Move the `then` onto its own line so that it conforms with the
test style.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/lib-bash.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/lib-bash.sh b/t/lib-bash.sh
index 2be955fafb..b0b6060929 100644
--- a/t/lib-bash.sh
+++ b/t/lib-bash.sh
@@ -2,10 +2,12 @@
 # to run under Bash; primarily intended for tests of the completion
 # script.
 
-if test -n "$BASH" && test -z "$POSIXLY_CORRECT"; then
+if test -n "$BASH" && test -z "$POSIXLY_CORRECT"
+then
 	# we are in full-on bash mode
 	true
-elif type bash >/dev/null 2>&1; then
+elif type bash >/dev/null 2>&1
+then
 	# execute in full-on bash mode
 	unset POSIXLY_CORRECT
 	exec bash "$0" "$@"
-- 
2.24.0.497.g17aadd8971

