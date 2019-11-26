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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6332FC432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BFD82068F
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="is7wgEma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfKZBSr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:18:47 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39265 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfKZBSr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 20:18:47 -0500
Received: by mail-pg1-f194.google.com with SMTP id b137so5800525pga.6
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 17:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1JomHC6LB2LqdeWqVL7bdOCmbQ9QjDWk8FVTfc3HdNU=;
        b=is7wgEmaFVVXS+8FcF7HIlBgcHRMT/stU/c0ElCEJ/vAAuAaewi16RpCsyFgA+e9xO
         7uVeoB9mdIoolm02lrM0BU5hN3YbmzsqKNDEcoRNHo7vjgYnXRkYGS0fJbk++tP3T5of
         OLiejQWWAAtwFvd635lPc+7DY+Au/h+QZbOh+j9ojrvCwzB35AX7mFZknCb5FNK8gbHK
         Hg6p1ZDEOIznHsIlCpgocCAON5hfEu1bu7I8dzwhE7xLAAmGAuJZ1zSRhyslQxDICeJr
         fbbZfLCKv/05h1qrfsm7W3uADYjn5VEkAxSHx4AFXg9fi7sLWuV3i+cuMYznKQJi583k
         p12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1JomHC6LB2LqdeWqVL7bdOCmbQ9QjDWk8FVTfc3HdNU=;
        b=D9Zocyc65PEl9mk9KkNVuyzQrstWXWdbL4Q9TftxQ3M/9Bxm21Sl0TLzZdKBs/OxlH
         8TgpALypTGqu9psaceerKtQBqBgGyQgB2E5+xKJgi7qRRloUz689fw4kuwHw5uAdJIOW
         fE6hj4xePaA5n78jENJgc9l9Ref/Yw3tnoGyOzg7U6ew9WTdHX+PWQ4a/GjBjwa5ATF0
         g7K/PY4lRySfUucEwJA1MvaXE6a0yzPOXSnu2Ewl65A8gb6B8XnSHH1TIc/+pFADuB+E
         vdaAwCOACmXhLql+3AUBEfe4y4iAUQ4wefZN6TxZ0WhPp+iAiWzprIGk3GhU6l38oH77
         0ZHg==
X-Gm-Message-State: APjAAAU7QLHPnhKeW2O61zVh8uNmPrN3bx0DdTSV3irk4FL57cW4Jbzx
        e7m4UlmZtF+w2xAjMJQGIl6UH4JY
X-Google-Smtp-Source: APXvYqzrFqAKWMstbHRi4oxnDo+R9yo+cT41pEn4lYzwv/jUECuYfSsue2x28oEUFXzKiBV9oeCNmw==
X-Received: by 2002:a63:ec4e:: with SMTP id r14mr36478212pgj.235.1574731125956;
        Mon, 25 Nov 2019 17:18:45 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id b7sm617739pjo.3.2019.11.25.17.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 17:18:45 -0800 (PST)
Date:   Mon, 25 Nov 2019 17:18:43 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 25/27] t7700: replace egrep with grep
Message-ID: <4f02c00bd1cb2e23e5ab7d84dcd42c76e9b076ac.1574731022.git.liu.denton@gmail.com>
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

The egrep expressions in this test suite were of the form `^$variable`.
Although egrep works just fine, it's overkill since we're not using any
extended regex. Replace egrep invocations with grep so that we aren't
swatting flies with a sledgehammer.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7700-repack.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 5bbed02fe5..2493cc4e9b 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -30,7 +30,7 @@ test_has_duplicate_object () {
 		idx=$(basename $p)
 		test "pack-$packsha1.idx" = "$idx" && continue
 		git verify-pack -v $p >packlist || return $?
-		if egrep "^$objsha1" packlist
+		if grep "^$objsha1" packlist
 		then
 			found_duplicate_object=true
 			echo "DUPLICATE OBJECT FOUND"
@@ -135,7 +135,7 @@ test_expect_success 'packed unreachable obs in alternate ODB are not loosened' '
 	rm -f .git/objects/pack/* &&
 	mv pack-* .git/objects/pack/ &&
 	test 0 = $(git verify-pack -v -- .git/objects/pack/*.idx |
-		egrep "^$csha1 " | sort | uniq | wc -l) &&
+		grep "^$csha1 " | sort | uniq | wc -l) &&
 	echo >.git/objects/info/alternates &&
 	test_must_fail git show $csha1
 '
@@ -152,7 +152,7 @@ test_expect_success 'local packed unreachable obs that exist in alternate ODB ar
 	rm -f .git/objects/pack/* &&
 	mv pack-* .git/objects/pack/ &&
 	test 0 = $(git verify-pack -v -- .git/objects/pack/*.idx |
-		egrep "^$csha1 " | sort | uniq | wc -l) &&
+		grep "^$csha1 " | sort | uniq | wc -l) &&
 	echo >.git/objects/info/alternates &&
 	test_must_fail git show $csha1
 '
-- 
2.24.0.504.g3cd56eb17d

