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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E32C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146AD20855
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNLodLP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfKUAqQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:46:16 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41652 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfKUAqP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 19:46:15 -0500
Received: by mail-pl1-f196.google.com with SMTP id t8so602743plr.8
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 16:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kPN6wbfa2cOPsVoueDW9dYx8F74JthtMgapVm9xbTvs=;
        b=oNLodLP1IZiKhXoAfd+8CUjx80KFl+RU9550dW4Nk101FYTVLnernzI6ksLeCMAEcc
         N2ra1oGOose/0Vub5JLdYt+uW2dEgTIJvNtBtwp+tbhJGV72trDRf5I7J68LcWFD+XKa
         0vUH4n5XNyyDCP6a/ARtbBm8LT1aN72GZa+MhLKv0ZR3IWuNvRqUp8FEsgrlIvAwJE06
         Ot6H+JczNiENRuNEY70Hk0NVGbpUPrCP9GaDGVtcxjO+BHudUTsg0d3Tp3dlBcTVgBYj
         +7Z5PsjQVTYFpNpzMjNRzePE6DPikS3MzQoghVZK5Q8kPNj0IVfLfTQDNTdWEK45oxLh
         syOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kPN6wbfa2cOPsVoueDW9dYx8F74JthtMgapVm9xbTvs=;
        b=IRTcDMKTTLCjpV7wMpVCV61WcSgnCUYTbV00YCrTHEhKZQRhBVr2NjInr/BKzEZHHu
         oj1wEPaL4tUwc+51wm6sDNQBCDcpD6DznEoJQ4soQveHmAnETDmVz10i8RtYJVhDnoMv
         fSIDuAiApJFDfir0oaddctUP6k/aKd2WesXRiA6PQQ0mPlw9ERR1TxJKdJnUZ3U0oCEd
         pb/edfMLGybQYpfCVP902458bam/kLxqPp70B4JHolQpMGEJL+1n3leQD4H9B4NbAy+s
         zas/9wnq4k7yLXoWQta5BEPdyiMCKNd6GloenEC4avcSRernI6fXeXjsQSFIXZAz8VPs
         WMIA==
X-Gm-Message-State: APjAAAUuez3/fjFNA+med9Zx0maiTnVWFWSMzcMVTOND51ToG6hLPWEV
        b6JXIAzMhlPGYMzH7PWaSqw4C0Fi
X-Google-Smtp-Source: APXvYqzPFMtogT0hPgBKyUEBK947IqhN3G6h8iYge7Mf7QT6Vi9bcIoh+CKjKzdlCmyrHokWzSnygQ==
X-Received: by 2002:a17:90a:a63:: with SMTP id o90mr7584499pjo.81.1574297174585;
        Wed, 20 Nov 2019 16:46:14 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id m13sm395774pga.70.2019.11.20.16.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 16:46:14 -0800 (PST)
Date:   Wed, 20 Nov 2019 16:46:12 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 11/21] t5317: stop losing return codes of git commands
Message-ID: <04beafae8e4cec1cee3a82bef81e6010267ae1ff.1574296987.git.liu.denton@gmail.com>
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

Currently, there are two ways where the return codes of git commands are
lost. The first way is when a command is in the upstream of a pipe. In a
pipe, only the return code of the last command is used. Thus, all other
commands will have their return codes masked. Rewrite pipes so that
there are no git commands upstream.

The other way is when a command is in a non-assignment command
substitution. The return code will be lost in favour of the surrounding
command's. Rewrite instances of this such that git commands output to a
file and surrounding commands only call command substitutions with
non-git commands.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5317-pack-objects-filter-objects.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index 2d2f5d0229..a8bbad74e2 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -72,7 +72,8 @@ test_expect_success 'get an error for missing tree object' '
 	echo foo >r5/foo &&
 	git -C r5 add foo &&
 	git -C r5 commit -m "foo" &&
-	del=$(git -C r5 rev-parse HEAD^{tree} | sed "s|..|&/|") &&
+	git -C r5 rev-parse HEAD^{tree} >tree &&
+	del=$(sed "s|..|&/|" tree) &&
 	rm r5/.git/objects/$del &&
 	test_must_fail git -C r5 pack-objects --revs --stdout 2>bad_tree <<-EOF &&
 	HEAD
@@ -230,10 +231,9 @@ test_expect_success 'verify explicitly specifying oversized blob in input' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r2 pack-objects --revs --stdout --filter=blob:limit=1k >filter.pack <<-EOF &&
-	HEAD
-	$(git -C r2 rev-parse HEAD:large.10000)
-	EOF
+	echo HEAD >objects &&
+	git -C r2 rev-parse HEAD:large.10000 >>objects &&
+	git -C r2 pack-objects --revs --stdout --filter=blob:limit=1k <objects >filter.pack &&
 	git -C r2 index-pack ../filter.pack &&
 
 	git -C r2 verify-pack -v ../filter.pack >verify_result &&
@@ -377,7 +377,8 @@ test_expect_success 'verify sparse:oid=OID' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	oid=$(git -C r4 ls-files -s pattern | awk -f print_2.awk) &&
+	git -C r4 ls-files -s pattern >staged &&
+	oid=$(awk -f print_2.awk staged) &&
 	git -C r4 pack-objects --revs --stdout --filter=sparse:oid=$oid >filter.pack <<-EOF &&
 	HEAD
 	EOF
-- 
2.24.0.450.g7a9a4598a9

