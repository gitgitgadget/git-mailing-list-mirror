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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDBEC432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442932071B
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqz2JWq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfKVTAU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:00:20 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:42351 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfKVTAU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 14:00:20 -0500
Received: by mail-pj1-f68.google.com with SMTP id y21so3400076pjn.9
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 11:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E4n+fqHnj9Cv3lupVIQz8ESenxndxXEgSZ4wUo04KFA=;
        b=fqz2JWq67jT97EI+27WXOsGqB9ibCRJDp6jB3VYPucd7kosVpXe6WSkSiaWRO9b9du
         JhuM5t/n1zYakCj63IQvi0SAd3JehDr1igASjmlTbVtRqzUwXh2KLT7Qq7uQmsKEG8PG
         8xhe/wYXdfvrgh8Xh9HYSfaunz9KwfNsBrjWKjK7E0u7PoZ8nWCLMf9Rgfjb0bKyj10X
         aOqrzlBi29/00tS9BOPCjhJq1R3RELBma4ky7HtBLSNWcEWSQnSRWB45K0xlSaO6XOI3
         64swdh7ormQak5MbcDw0rk1AtmkCMI23S83CLue7ms0wltq+xs1AwCi/4wAi91kyBycf
         jDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E4n+fqHnj9Cv3lupVIQz8ESenxndxXEgSZ4wUo04KFA=;
        b=SCJxhAoAhltIiYzWPdNuZdwWB44lDllDDyzzwuJk48pFod/MF8vFYl3v5FxaNuKkrC
         cHllO5/o+ArqOoojy19SpaCg/3GDp+I3ToVazmx189CfM9QhjwoQXhKhaPkj/L446pxd
         hB5Ssu/0rj4SR3wcM70entoGqZeneWMU2akTKWT8vvMXW4bo0xmBbYzbOXX4o+jkAV2o
         i8kpLM3e8s3RwoI6ZZJ3mjKRn+TPS+M8Lt1brnsbXZYhCitDgV/8hirAbegxCqOXJ5nY
         9TrKBZB1bWQ0mAOAe28aV5Ow298Z/UCydDJyZXX8K1KoteUcW87YmR9EAgfH5h+/qY/E
         gxrw==
X-Gm-Message-State: APjAAAVxKdhEPs+Sgkjigp4qKifghlBkZhn8g8h5r2GDcqM7wkgHlNki
        0RGpVJkgbcBqLm8pLV8uFd12EK5b
X-Google-Smtp-Source: APXvYqwnMbVNuBwI97aWtZhZmgYdIeY+wu8lGdBWvRVVHn76jIjpae5TyD4An6dsoCun2BLtXNmPIQ==
X-Received: by 2002:a17:902:9a92:: with SMTP id w18mr15684404plp.91.1574449218686;
        Fri, 22 Nov 2019 11:00:18 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id i10sm7727982pgd.73.2019.11.22.11.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 11:00:18 -0800 (PST)
Date:   Fri, 22 Nov 2019 11:00:16 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 14/22] t5703: simplify one-time-sed generation logic
Message-ID: <f7e8ae79fa4c0798e2419244756dc2465dcd0d28.1574449072.git.liu.denton@gmail.com>
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

In inconsistency(), we had two `git rev-parse` invocations in the
upstream of a pipe within a command substitution. In case this
invocation ever failed, its exit code would be swallowed up and we would
not know about it.

Pull the command substitutions out into variable assignments so that
their return codes are not lost.

Drop the pipe into `tr` because the $(...) substitution already takes
care of stripping out newlines, so the `tr` invocations in the code are
superfluous.

Finally, given the way the tests actually employ "one-time-sed" via
$(cat one-time-sed) in t/lib-httpd/apply-one-time-sed.sh, convert the
`printf` into an `echo`. This makes it consistent with the final "server
loses a ref - ref in want" test, which does use `echo` rather than
`printf`.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5703-upload-pack-ref-in-want.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index 3a2c143c6d..88338c4e09 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -312,10 +312,9 @@ inconsistency () {
 	# repository appears to change during negotiation, for example, when
 	# different servers in a load-balancing arrangement serve (stateless)
 	# RPCs during a single negotiation.
-	printf "s/%s/%s/" \
-	       $(git -C "$REPO" rev-parse $1 | tr -d "\n") \
-	       $(git -C "$REPO" rev-parse $2 | tr -d "\n") \
-	       >"$HTTPD_ROOT_PATH/one-time-sed"
+	oid1=$(git -C "$REPO" rev-parse $1) &&
+	oid2=$(git -C "$REPO" rev-parse $2) &&
+	echo "s/$oid1/$oid2/" >"$HTTPD_ROOT_PATH/one-time-sed"
 }
 
 test_expect_success 'server is initially ahead - no ref in want' '
-- 
2.24.0.497.g17aadd8971

