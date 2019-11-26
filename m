Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914B5C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AAB62075C
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tw3VCaE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfKZBSX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:18:23 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38825 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfKZBSX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 20:18:23 -0500
Received: by mail-pl1-f193.google.com with SMTP id o8so2988704pls.5
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 17:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N6fKgQgEvJL8D6EyU1tI4ExWrDmNqbq0vn2FWS4Ii9c=;
        b=Tw3VCaE3JqAXJMzSg4GG9rjSTcMEM5UDhvvnN8Gns7xYdbLcNiEavI/vwk3p8lyTiw
         oaRhsvJP/vYLoF/E0Gqhtw37OqLCzNX2t+eShqfE7jzpfPHeXG/kEXV8cIcs7KGiAzMg
         FNqXwtA9IvoWKQho3jpaxW8nwOhzcFfRq/qVia+H7ognViEeEzjtjkvL27aZdPyss53k
         rNCii1nVzi0G2IcMynO/T6F22A8oQmgUMRamRszRDZbiU+uF0nPda33sgxokjXpNGCDi
         RKmopYplnL6AjI7a8R6daLKwTdVoOLPzXV+MU1/52jjTxaJ6HN5k81ntsk4qip0a4bAG
         9rSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N6fKgQgEvJL8D6EyU1tI4ExWrDmNqbq0vn2FWS4Ii9c=;
        b=Ty/8K9JUqTNLyaAf5IdwtH95nMI/8jScsVJnfq9WBc6n/Dc7P+ok5ZxStNPXO3+uHp
         4yegEBGJE8P6Ti/rSA6uD5Zac3WVyFtcZS3zD+BFnQ1xjgGNZzEJLbZ6FURabn5G2W3Y
         gFRO3ZO8b6l99cBGSXTTRnaZ9ntA3td/gRYEPnvSq5FsRvtTpoplEOFUQixWz7fbQz+4
         Kn1JhTf6TjRflh/Y0jacWnsBL4YypYd0Sfppu2IGlNlggUSkvsgy8xjUKCd6xuDi9d7Y
         Mf/iWfPqSU4c/HO/nvIaPftedXwiFFJwHH4lUCyrY7DkUKmXjtZHblco36nATqxJoyy1
         M67w==
X-Gm-Message-State: APjAAAWGOsuHTYdXMWKJud10NFIHCHanfTv8nMqf5pAWKJ/7kttCquQ7
        RfIT5eQJ27awxriW6pNOQswy4qVX
X-Google-Smtp-Source: APXvYqzo6MREl9Dp43ZCx4+dXD5DOmwXxmbmLa+HvOEM3nVTB+aDQTJumvAiZ53n0JZmkPvmEUmlHw==
X-Received: by 2002:a17:90a:7781:: with SMTP id v1mr2776747pjk.93.1574731100759;
        Mon, 25 Nov 2019 17:18:20 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id w5sm10193335pfd.31.2019.11.25.17.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 17:18:20 -0800 (PST)
Date:   Mon, 25 Nov 2019 17:18:18 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 14/27] t5703: simplify one-time-sed generation logic
Message-ID: <291caf9bc11574b8f2ce8dcbaeb5d369c597a8c8.1574731022.git.liu.denton@gmail.com>
References: <cover.1574449072.git.liu.denton@gmail.com>
 <cover.1574731022.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574731022.git.liu.denton@gmail.com>
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
2.24.0.504.g3cd56eb17d

