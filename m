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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C81C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A9F2068F
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjyZmcjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfKZBSQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:18:16 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33043 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfKZBSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 20:18:16 -0500
Received: by mail-pg1-f196.google.com with SMTP id 6so3571767pgk.0
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 17:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hPjOtMuhVEA7iflpjkkJ1vyj/H80ZOpy/zTnsTLGS+g=;
        b=KjyZmcjlw9Uk6GIJNxL1/QTDgHhFjz+NQuC6PYNkwMKZqt7EAzVTeQCvp/hkpAKMX9
         c5Pf9PcQKwOi1l1whaLfwn3Fp6CYC3Rdd69gEtnKf54qGvQ/co9NcmPstq9f3jmaqI/Q
         p1/mmIClLkhkJqkSRuFvxjelX/8CW5vB7TG6L0HCVieFILXcfIGzpOnpQ9+eQobqrnAe
         ukZMmu5c7hF0PisOASLH1g0iEI6pYNx9DOMqriW6Gz2Wl89Ck8wg510XBG0xz1Ppma3x
         YAtkcsc3jxpynfx4i1nODI7DxGrnAOH9YGym3LC9/rK8jvTVFWKdHcCo8Uypmpfw3nb0
         IkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hPjOtMuhVEA7iflpjkkJ1vyj/H80ZOpy/zTnsTLGS+g=;
        b=gZKqO5p3eJkiY8KdLSQHV2liSshsFdGQ+lmej8hO7AJC3TYzIcBzHBkxt6OYwmCgq7
         eGhe+OgUDv6KDVEeQzQY6aZ6He2S/1W4CDgSIbtcSlnPkNwue6VvfwpZbhJywBdBMo1q
         unLsqhcyzOwOEl8XtCtsYFx0ezTK0wgDdxWcbVNBooyu5SEYc0XVEGn/P7ivnFyGA0e5
         rAGyjfpS3Ao8zSIm4Qlypg2RQbCYuMrfGhBO1MNZH9lC6WPRxObU9edXnFV2qdy8VGrx
         oX/01X4vfcL0u/cSCdO/pLJsf0uNYkukem6dqt9giCX8Jb2qvbX1FRVHTPiLb9lRklum
         JWuw==
X-Gm-Message-State: APjAAAWbQLt8jQqVJlsPw040Nrh8HiH26+bDEBlmJMqp3UPpW8++u0eq
        iU2Luyy/o+T7r2mt6h1WdbIxzD42
X-Google-Smtp-Source: APXvYqxUI1xSa8a4O277D0Bja9w9MqEoOJ+3GKHMu7b4fAUTDnTHJDh0MDgDNv7eDwj+U33Yu6Xtew==
X-Received: by 2002:a65:66c7:: with SMTP id c7mr35298192pgw.407.1574731095487;
        Mon, 25 Nov 2019 17:18:15 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id g7sm9598527pgr.52.2019.11.25.17.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 17:18:14 -0800 (PST)
Date:   Mon, 25 Nov 2019 17:18:13 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 12/27] t5317: stop losing return codes of git commands
Message-ID: <1e08c2b68ba041f5bc94695481ddbd106e9bb4f4.1574731022.git.liu.denton@gmail.com>
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
2.24.0.504.g3cd56eb17d

