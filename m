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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00706C432C3
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2682071C
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1jbxTvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfKVTA3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:00:29 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41398 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfKVTA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 14:00:29 -0500
Received: by mail-pf1-f194.google.com with SMTP id p26so3886553pfq.8
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 11:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MqPgVI8/g6kMH+xxzJjgzBtWg9U7F2KTYKJ1jP20kRc=;
        b=L1jbxTvxLWTQIR/R5VYrElWf8k8SJOns8G5y92ANy7zd7bLIibzVb+IUF14b4X7CDJ
         cO5Q3W3N8eC1AKAf55hnJ5DfZt8ATf5c3blgpqJGnYPYQXb1XPpsv68uINX45qCOULkl
         EMuaIDbI3cRUwaD/umR0V81fG5B4Lxkgqa8aCYds8YppXo+/RXJsZjftJg7KvxPd9qZv
         C1hVGHfLZMhIAmPx6k/+wu7I2E3T2HN4+erFl/KQRYASsNJIu7R48ZWflhYOaFLFFQdm
         Sg0dA/M70oO607qyMoJ1wYYXfEbnclkpu3Bdxe22SzpwHHSIiZ5Xodkogq/MCvx4xLBE
         Xdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MqPgVI8/g6kMH+xxzJjgzBtWg9U7F2KTYKJ1jP20kRc=;
        b=aEherrc3uCPxDlvx7ESQpSmszt/gH3rwe4mcuIsSyzmt6U8djaVevraUGqBB7SxCC3
         5E8n8PtJH1zPGyvdy+GWXyYMF+py53NRg4VRg3YsN2gWSrmX3NbY80/KCdI385U1Qp2e
         CMtUxG/IaJMk1DYB3y0moGT9Gm7Z1bpkjweUZkVJprjn7yHiN1wDi0TwJSYGqTKQQsin
         Yc5lL7niZ1dyDCIKlu6WSRwJQFxU2xpbntTTn+v7RsMURiqv9Z7oxlOPVZskpZUbMlwe
         HogPvM0ym4eF26NhjZtx2BNithrE4Fs9+F2PqGybC2ag+Xa7AP1w7qoSXaDFr85hxvZK
         5SBA==
X-Gm-Message-State: APjAAAUaW5ZgBiORBXoQTDw6DzUKAUS9LS/7yIoixkgxYH9kr2+3ghZB
        ZPMyzeGB1kPMOB6VNfpxNfvROZdL
X-Google-Smtp-Source: APXvYqw0A2Cv6EjNXuSyEfkpAHL1cXIEqQdv3YDLhYgzlzAE3ioZnckFlU+/JhlwhJHyso0IKE1p3A==
X-Received: by 2002:a63:368c:: with SMTP id d134mr17240502pga.321.1574449228035;
        Fri, 22 Nov 2019 11:00:28 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id 13sm7601073pgu.53.2019.11.22.11.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 11:00:27 -0800 (PST)
Date:   Fri, 22 Nov 2019 11:00:25 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 18/22] t7700: drop redirections to /dev/null
Message-ID: <297f38389760a5682198b8fa0a1e6ceea9b9deac.1574449072.git.liu.denton@gmail.com>
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

Since output is silenced when running without `-v` and debugging output
is useful with `-v`, remove redirections to /dev/null as it is not
useful.

In one case where the output of stdout is consumed, redirect the output
of test_commit to stderr.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7700-repack.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 4e855bc21b..e1a689d6a9 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -5,7 +5,7 @@ test_description='git repack works correctly'
 . ./test-lib.sh
 
 commit_and_pack() {
-	test_commit "$@" >/dev/null &&
+	test_commit "$@" 1>&2 &&
 	SHA1=$(git pack-objects --all --unpacked --incremental .git/objects/pack/pack </dev/null) &&
 	echo pack-${SHA1}.pack
 }
@@ -19,7 +19,7 @@ test_expect_success 'objects in packs marked .keep are not repacked' '
 	# Create two packs
 	# The first pack will contain all of the objects except one
 	git rev-list --objects --all | grep -v file2 |
-		git pack-objects pack > /dev/null &&
+		git pack-objects pack &&
 	# The second pack will contain the excluded object
 	packsha1=$(git rev-list --objects --all | grep file2 |
 		git pack-objects pack) &&
@@ -235,7 +235,7 @@ test_expect_success 'incremental repack does not complain' '
 
 test_expect_success 'bitmaps can be disabled on bare repos' '
 	git -c repack.writeBitmaps=false -C bare.git repack -ad &&
-	bitmap=$(ls bare.git/objects/pack/*.bitmap 2>/dev/null || :) &&
+	bitmap=$(ls bare.git/objects/pack/*.bitmap || :) &&
 	test -z "$bitmap"
 '
 
-- 
2.24.0.497.g17aadd8971

