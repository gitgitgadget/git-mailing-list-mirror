Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2276B201CF
	for <e@80x24.org>; Thu, 18 May 2017 19:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932481AbdERTjF (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 15:39:05 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:33653 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757665AbdERTiB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 15:38:01 -0400
Received: by mail-pg0-f51.google.com with SMTP id u187so27327806pgb.0
        for <git@vger.kernel.org>; Thu, 18 May 2017 12:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+KRcSE4JLGBxtEvfmA6UUQyYgBD1inKBQ/lNJQxOuuU=;
        b=Fcmjh2Tevavtop2KpQ5bYCU7AEwK8DO82s8KeC5tP7wXLt0eo6oyUepb/vJbKawiVj
         hcr36fgHAdXuK20AZpzT1FM457LEDtb+/dWvYdiU6h+SijH3azRHMV1KUp6LaCeVHd4C
         TTpPDWJ/AR3XzOu+a2T7nEK0lxucsyeb25RlbowtLaAren/fi9CWJP4WH0ocA/PDrKXh
         oiqOw72m5sdQrtgcEd6R2QBgUKUzSxfIJOAV8VoGMHL4YRLydMiKwVFYyHIX6kHF6mht
         j7vbGT7upslTZXYgyUvexxsyc72oWtP3udzzWQRkmXw9pPHVRVeAzUICRGeqf2aRyYJb
         k7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+KRcSE4JLGBxtEvfmA6UUQyYgBD1inKBQ/lNJQxOuuU=;
        b=mMn5XDX91wwUw+kblahXnrl6mGdziXEuHjo7a0Mej1d8lqp4iLpogTgbNF9dzO65sW
         agzl0Kv22000IVub78JcnnHsJSSZF3v7aLhL/11VNTu2w3MWmkhobt40+e+slJN5RQHt
         0PRH8ig3UHJts4gohtEaJKTh6CsKRll9jjRLxRa2/9lrXrhHGJAOGn2EnTJzRgfSTRjz
         E+5JSZWc3o13KLJ+PdPzaQRUe4OrjztRjdxxecmhNFjMZ/tJG8IurkfynrKnpmlQgQMq
         Xilxdvwk8t/4rKsshHTU05iXack2L6o8PszFtEbV7CppjarpJ5F/mqz5dO7mby3WL1Bd
         lQjA==
X-Gm-Message-State: AODbwcDrjMjr+zFgSPDH0YgIf9Pi2fIBRpamVy4D/0QzC4LATloWUV4W
        ae6rBnRtw/yaJIg/
X-Received: by 10.98.106.199 with SMTP id f190mr6377980pfc.142.1495136280964;
        Thu, 18 May 2017 12:38:00 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:7013:588c:5765:703d])
        by smtp.gmail.com with ESMTPSA id 128sm9832639pgi.49.2017.05.18.12.38.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 May 2017 12:38:00 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net
Subject: [PATCHv3 05/20] diff.c: emit_line_0 can handle no color setting
Date:   Thu, 18 May 2017 12:37:31 -0700
Message-Id: <20170518193746.486-6-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170518193746.486-1-sbeller@google.com>
References: <20170517025857.32320-1-sbeller@google.com>
 <20170518193746.486-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In later patches we may pass lines that are not colored to the central
function emit_line_0, so we need to emit the color only when it is
non-NULL.

We could have chosen to pass "" instead of NULL, but that would be more
work.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 73e55b0c10..6c1886d495 100644
--- a/diff.c
+++ b/diff.c
@@ -532,11 +532,13 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
 		len--;
 
 	if (len || sign) {
-		fputs(set, file);
+		if (set)
+			fputs(set, file);
 		if (sign)
 			fputc(sign, file);
 		fwrite(line, len, 1, file);
-		fputs(reset, file);
+		if (reset)
+			fputs(reset, file);
 	}
 	if (has_trailing_carriage_return)
 		fputc('\r', file);
-- 
2.13.0.18.g7d86cc8ba0

