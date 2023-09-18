Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0F5CD37B0
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 16:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjIRQkJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 12:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjIRQju (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 12:39:50 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BA52446C
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 09:35:55 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d852b28ec3bso602251276.2
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 09:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1695054954; x=1695659754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Iuc5K9iZMQxsFdXo242r4tM8Ky5cKBwP2EQR8dsJ6as=;
        b=Jad/JkYPSOxPQf3y6gaAny3TVat1x9q2XAb9h8gQMtOEQlCdWGuBp5g7xEe0S9Uu9P
         TYWqrDybeDQIfB1P173C8shEgjcdzOocb50L7+PpN9lJG6PJVvOIK8rJUthxVDcBZW9F
         NylhKGdiO6zJA9A2U/E1Fn6DOEqhVk7v6NeHzeW2t7SWml6EtZgikcBoaZJT9qa6cwCJ
         i8EnVfzzrNqdqACQB9wx46Rodoc+G0t/cO6uLvGY6MhlvvyYoK7BsorS5Ryut/UnkZRF
         XU8jNnyStCM+WQqZxrE4QLHqQ81kmFMAeZFrBPJUI6O7gEt4VPf7wM19LKcvN2QXbzh9
         MbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695054954; x=1695659754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iuc5K9iZMQxsFdXo242r4tM8Ky5cKBwP2EQR8dsJ6as=;
        b=MSytwVUtSX+feUNBdyUjc/R3Odyzbdlme5PZanzK7C/XwmxZ9+25rJ1VqlYlz4+VjS
         33+9hxUQZYFfB5xhqxBpggus6VyLrQQWYfhmafR5C2xFzTWNqcxdDZ63upCVrlu9Zjo4
         j7iBBGgplcSHLPg4F1793latd2mFnKKrgTiBJDGK+u+TX1xXtzDfM9tGMonx9BpjT2MI
         BRdnFGt+3OaEt0ONfxZm3/+G0f+/iyH7/VsFML+bo7KEX7tTdMTrAu61sjIR8iBtTeq1
         dfobaJgbjVcTFgSNS4Jf8TXrQ85FTu4S0O26+x+i8GlHc9YCCqUuXVk1/TdJ9DQs4Cn0
         9cIw==
X-Gm-Message-State: AOJu0YxTJveLWxxa6fOik6rd/fv+dttsgpM47oaBznz3UH/HySNJo2d9
        w1612N0QaBjQG7K2LtT0U+nfF0nqst8bM847w1UmKg==
X-Google-Smtp-Source: AGHT+IFLbXvDS6PQfWTJiqUeSTnGa50dRDn4O1fUXjFr3f+fpnnDid8n6GVoi9udR7UM/jJPentZnQ==
X-Received: by 2002:a25:a505:0:b0:d72:a54d:4b7 with SMTP id h5-20020a25a505000000b00d72a54d04b7mr8544166ybi.1.1695054954438;
        Mon, 18 Sep 2023 09:35:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w6-20020a25ef46000000b00d0b0bbe574asm2255599ybm.44.2023.09.18.09.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 09:35:54 -0700 (PDT)
Date:   Mon, 18 Sep 2023 12:35:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] git-send-email.perl: avoid printing undef when validating
 addresses
Message-ID: <545729b619308c6f3397b9aa1747f26ddc58f461.1695054945.git.me@ttaylorr.com>
References: <ZQhI5fMhDE82awpE@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZQhI5fMhDE82awpE@debian.me>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When validating email addresses with `extract_valid_address_or_die()`,
we print out a helpful error message when the given input does not
contain a valid email address.

However, the pre-image of this patch looks something like:

    my $address = shift;
    $address = extract_valid_address($address):
    die sprintf(__("..."), $address) if !$address;

which fails when given a bogus email address by trying to use $address
(which is undef) in a sprintf() expansion, like so:

    $ git.compile send-email --to="pi <pi@pi>" /tmp/x/*.patch --force
    Use of uninitialized value $address in sprintf at /home/ttaylorr/src/git/git-send-email line 1175.
    error: unable to extract a valid address from:

This regression dates back to e431225569 (git-send-email: remove invalid
addresses earlier, 2012-11-22), but became more noticeable in a8022c5f7b
(send-email: expose header information to git-send-email's
sendemail-validate hook, 2023-04-19), which validates SMTP headers in
the sendemail-validate hook.

Avoid trying to format an undef by storing the given and cleaned address
separately. After applying this fix, the error contains the invalid
email address, and the warning disappears:

    $ git.compile send-email --to="pi <pi@pi>" /tmp/x/*.patch --force
    error: unable to extract a valid address from: pi <pi@pi>

Reported-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 git-send-email.perl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 897cea6564..288ea1ae80 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1166,10 +1166,10 @@ sub extract_valid_address {
 
 sub extract_valid_address_or_die {
 	my $address = shift;
-	$address = extract_valid_address($address);
+	my $valid_address = extract_valid_address($address);
 	die sprintf(__("error: unable to extract a valid address from: %s\n"), $address)
-		if !$address;
-	return $address;
+		if !$valid_address;
+	return $valid_address;
 }
 
 sub validate_address {
-- 
2.42.0.217.g5402a90ddb
