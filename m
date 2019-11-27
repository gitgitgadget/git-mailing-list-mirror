Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427C9C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 176382082D
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HN3fMeo/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfK0Txj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:53:39 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45881 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfK0Txj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 14:53:39 -0500
Received: by mail-pf1-f195.google.com with SMTP id z4so11613529pfn.12
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 11:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N6fKgQgEvJL8D6EyU1tI4ExWrDmNqbq0vn2FWS4Ii9c=;
        b=HN3fMeo/pwswSgt6BbhsW43IxbU7gEvEV/kdYPJCdJ+YwMCu5iqZNE6hRI1aLnGgUo
         G5Rf/Vae8eh24sQ0mEc2TIQOP1jXaVdf4c93V9UcyGyVVxGWN65GSdd+jfbgY62pFEWM
         EtC4k1kXjFVO8z1R23wzhK1WimXh0d3HmKwogTBgEbKiL0KIPB+aJd4lY0TI/tPrH5no
         Py+W4ABkCJtsNn4j8r95255b1e9tHjNuiC0pJI9Dg263UG1pDXjdFh/x4nKR3h2HKUTt
         VwPz12LaEDxgyV9iadovzXM/YlMEwXu5/lkJ5c2teelNomj2nBuJnNw4NfnyG5p5L/fA
         FAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N6fKgQgEvJL8D6EyU1tI4ExWrDmNqbq0vn2FWS4Ii9c=;
        b=ijRCGWZAU8E+UBQW6dWM0GuXfKCFKIeU2EqlgOROkwWQN2cnrlwkoXkkXD2IPhRcxI
         0+9N0MUM3WtfRnNJl61cYeOlwQ6PYt02HYTbLHOjJp976szld9IqeuXPg7IqhbOpqsMS
         1ZvbP21UHPFsVfU02wElGEeg91qX7wOOKydXbzU0pizZxc7T5KAXqxDHO487IiLuKV0Y
         /N31HJHg5G/opJIhSmnMJx4vsqeRacHhgdyONmdpFDEzXF8NAr3bt4xnLGU7IKTkxeGY
         f5aRfzqGbzciK4ntaAyNmd7yisCgyFEbE8LleEnn0VA778SpcI4JrTZXk9y8Igo0Qodh
         Nc/Q==
X-Gm-Message-State: APjAAAUw5aOY1PJOhe2sBIVzBHDUIeQynWXNoQQpZzLBkHcLyv4CzVe+
        L7ws2WpxaOWDuftiFhgDQOzhdA3F
X-Google-Smtp-Source: APXvYqzL2/5Bsqx0q5zaKM9DoXHo3hFEc/kvw9+JvhISGYTYzsF7mw2I+/24aiahQB0lqvJ4bxcasQ==
X-Received: by 2002:aa7:9a96:: with SMTP id w22mr50882017pfi.162.1574884418230;
        Wed, 27 Nov 2019 11:53:38 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id m7sm19149971pfb.153.2019.11.27.11.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 11:53:37 -0800 (PST)
Date:   Wed, 27 Nov 2019 11:53:36 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 14/26] t5703: simplify one-time-sed generation logic
Message-ID: <291caf9bc11574b8f2ce8dcbaeb5d369c597a8c8.1574884302.git.liu.denton@gmail.com>
References: <cover.1574731022.git.liu.denton@gmail.com>
 <cover.1574884302.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574884302.git.liu.denton@gmail.com>
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

