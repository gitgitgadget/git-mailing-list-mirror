Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F234C433E0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 22:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05FAB20780
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 22:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8dk5N1C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgGAWKL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 18:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgGAWKK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 18:10:10 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F747C08C5C1
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 15:10:10 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id u8so11226068pje.4
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 15:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pSh5vL5bHpHFczJ7Ncz/AHSmDjL1nU1xMH8Yl9AYBsc=;
        b=T8dk5N1CH96jvGd6t8uI/3PsGMgSi9tPEP8mqW3xF8ZEBLwr9Fin0zuR3/X/ncOiNm
         ORXmB6M9ey35dIadGnB0jaTSFL/pCgbsthrQ/y/p0apwET4Og+Rm7qW9uxcyKF8p1eVZ
         /Wc+jd7lD635RSEr8h/VfqdgV9p4tbDRFODKB01Uw+/aqElcCBw6PExC5W//sImgQTUW
         4TSUcCOiBlZ2AIBDVGMfeQsiQsLXX8cgC6Y97VHRgwvuIHUg78uTB1sJ7DnMOZ+q0Z9N
         kaL0HDfkbJ2POXlcM54cjRutntaVZvSgRP6V7S6U7JeVS5zJj5wnY4TB3wU5NYEZWO1W
         qNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pSh5vL5bHpHFczJ7Ncz/AHSmDjL1nU1xMH8Yl9AYBsc=;
        b=SZQvpTmlxT9x3PRESCi1GfE+rhLokgtoSlCde/6PlgWmU/QKer0eSHMDSmsx2yyd2a
         PvtNdh3OTIccquFmwih8kJeK0qdR5FKR2c5FerM5QOmEOUZqvMdtksBzXl9rAmpICbu7
         tXsOUUQ+UHBhpq4GFlKTfy6xdttuDJJBBoxrmToRzwNEOx1+5DrzCeqjfEmmmsF3Bvdc
         KJrvKeLJiT1Ohcn/1whr8twCFcCzaoDOKUMcNm4SvDLRVgeJvsaTR9E5BT2y/fohZE8s
         bN7W5z7M/D6HR6p0MxDqtA47AFbhgrTgTk9N/JYQH9hEj58/66BK/Yds0Ex2hefbXNO4
         HmPg==
X-Gm-Message-State: AOAM532iHWYa8wpIX4Q2LiNgM25QxHIdWIDjEhoKwYbw4QehlITxOXD5
        SB9VOtd3bPtNj0ffKnGL2VE=
X-Google-Smtp-Source: ABdhPJz+WJaD2/MyFYFtDt3yZxb6FozEXFkHplLR+fNACy/7a/UcwwvhZ441akuUM5xkcj/9tE+SjA==
X-Received: by 2002:a17:90a:c28c:: with SMTP id f12mr30083937pjt.224.1593641409911;
        Wed, 01 Jul 2020 15:10:09 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id h6sm6698945pfo.123.2020.07.01.15.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 15:10:08 -0700 (PDT)
Date:   Wed, 1 Jul 2020 15:10:07 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] send-email: restore --in-reply-to superseding behavior
Message-ID: <20200701221007.GA49195@Carlos-MBP>
References: <xmqqo8p85eud.fsf@gitster.c.googlers.com>
 <20200629141104.2522011-1-aquini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629141104.2522011-1-aquini@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 29, 2020 at 10:11:04AM -0400, Rafael Aquini wrote:
> 
> This patch fixes the aformentioned issue, by bringing --in-reply-to's old
> overriding behavior back.
> 
> Fixes: 256be1d3f0 (send-email: avoid duplicate In-Reply-To/References, 2018-04-17)

the following test case could be squashed on top to make the regression more
visible IMHO (it at least pass when applied on top of v2.17.1 and also
ra/send-email-in-reply-to-from-command-line-wins)

--- 8< ---
 t/t9001-send-email.sh | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 90f61c3400..ec261085ec 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -42,7 +42,8 @@ clean_fake_sendmail () {
 }
 
 test_expect_success $PREREQ 'Extract patches' '
-	patches=$(git format-patch -s --cc="One <one@example.com>" --cc=two@example.com -n HEAD^1)
+	patches=$(git format-patch -s --cc="One <one@example.com>" --cc=two@example.com -n HEAD^1) &&
+	threaded_patches=$(git format-patch -o threaded -s --in-reply-to="format" HEAD^1)
 '
 
 # Test no confirm early to ensure remaining tests will not hang
@@ -1219,6 +1220,17 @@ test_expect_success $PREREQ 'threading but no chain-reply-to' '
 	grep "In-Reply-To: " stdout
 '
 
+test_expect_success $PREREQ 'override in-reply-to if no threading' '
+	git send-email \
+		--dry-run \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--no-thread \
+		--in-reply-to="override" \
+		$threaded_patches >stdout &&
+	grep "In-Reply-To: <override>" stdout
+'
+
 test_expect_success $PREREQ 'sendemail.to works' '
 	git config --replace-all sendemail.to "Somebody <somebody@ex.com>" &&
 	git send-email \

base-commit: 096547052491426a29e040a5bd94d7f8a4cab8ac
--- >8 ---

> diff --git a/git-send-email.perl b/git-send-email.perl
> index dc95656f75..36c47bae1d 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1699,10 +1699,14 @@ sub process_file {
>  				$xfer_encoding = $1 if not defined $xfer_encoding;
>  			}
>  			elsif (/^In-Reply-To: (.*)/i) {
> -				$in_reply_to = $1;
> +				if (!$initial_in_reply_to || $thread) {
> +					$in_reply_to = $1;
> +				}
>  			}
>  			elsif (/^References: (.*)/i) {
> -				$references = $1;
> +				if (!$initial_in_reply_to || $thread) {
> +					$references = $1;
> +				}
>  			}
>  			elsif (!/^Date:\s/i && /^[-A-Za-z]+:\s+\S/) {
>  				push @xh, $_;

in both cases, doing `!defined $initial_in_reply_to` might seem like a
more consistent option.

Carlo
