Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE71C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41EE20855
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWsstoea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfKUAqU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:46:20 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43730 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfKUAqU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 19:46:20 -0500
Received: by mail-pg1-f195.google.com with SMTP id b1so624211pgq.10
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 16:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cCukM/qqHp6pAdjJkqDbpJr5cLBk0Ly2mjf3/B05iLo=;
        b=JWsstoeaDIp1CluEbC0etL5VQBRm5mScFDvT1IbFYUHSNXP6/XEdQvhiv1Hj73s4TJ
         2NqxNhQCT9JZOY2w7sWwnsi77iejPVSoISjNc1U+4ll2acGvaLhlxbW8K3dGmUCE7bpt
         7NuE7w3Imw0WHVPdIQz/pOw3V7C1/DBVONdy+yxFOEP18ZAoZ68zFHP8be6Ym7SbpSUV
         ctLmKivwaIhZ+ZNnSdwR+6/Mc2gOti491psW27r0f5lA7cbFD8DGn3xzg4MfBKqcdwxs
         5tO/0vU+gQ0C2YkNDhxJcM/7LtXmduiN/CE3vYZfuvgiO+HEreM2LTR/lzPVjlXXQNN4
         kGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cCukM/qqHp6pAdjJkqDbpJr5cLBk0Ly2mjf3/B05iLo=;
        b=GG8BaArR6WoJ1aQKsgRWQ18zjpE7Tlv6lFlFi2zdmz6jDGq00trOIwicC+N1eAit0n
         DADNf/DPOUt7XLro2sSpG5wQ4YUAMHa+XHjRIfm6PJ1GccBGhlOuk58vmNbHQAhLDaQW
         fEMtGkU+EHCj+v5fdq4foKTrbz+9iCSbUIPfDJfv9S6PxiUH0nblWaRjnBRICDYoCLc1
         5ADpo40HhlgF8r1xAdWjogR/UZFezhuMGkb3JBUW1imr04u+v7bIDBLnQHkedUT6ubQ9
         c0y1PdAQB+o9fppUwLibPl5B5YbrU/01b354/5SxjAQVV7kIGGDDf1hGHrAtDhi7Yp2I
         rt2w==
X-Gm-Message-State: APjAAAVyq0SDODLjxemePDdSObhAHUXpEZLqKF+/5LARE4sV7DZff2FC
        o5FsGLv9cXDWNSoRA2Yk4pnVz/t6
X-Google-Smtp-Source: APXvYqw53FE2jT4915iG3ntj+95KM6SkpokB/zKyoAfZnnmP3GDzfH+071RK3hxUIrKDSN+h1j1pcw==
X-Received: by 2002:aa7:93ce:: with SMTP id y14mr6558915pff.138.1574297179155;
        Wed, 20 Nov 2019 16:46:19 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id e8sm393767pgj.80.2019.11.20.16.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 16:46:18 -0800 (PST)
Date:   Wed, 20 Nov 2019 16:46:17 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 13/21] t5703: simplify one-time-sed generation logic
Message-ID: <d5fb60be6bdd5e885c6f830c8c44ba250350538b.1574296987.git.liu.denton@gmail.com>
References: <cover.1573779465.git.liu.denton@gmail.com>
 <cover.1574296987.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574296987.git.liu.denton@gmail.com>
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

Drop the pipe into tr because command substitutions should already strip
leading and trailing whitespace, including newlines.

Finally, convert the printf into an echo because it isn't necessary
anymore.

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
2.24.0.450.g7a9a4598a9

