Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE6CC4321E
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 01:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiLABZP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 20:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiLABZN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 20:25:13 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBFA8C6A5
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 17:25:12 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id k79so448957pfd.7
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 17:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Z3F3u8Nx+/OYrV61KStyKbqRsXQU4nBQ49kpg9eous=;
        b=SNPTtfCO5VW4gJNiIb4j2woor4BJYmbKFvjpiRO85E49Jv4z6FEuhKp3WccFz1dm75
         D/TF70mexsDZZE2ENiuCxRQD2YnZvVnAgwQXShbY5Bl9M3OfJtcPM0RIT5LINnSJzB2r
         OqE+ygXrkUgy1owHqDz1kkBd8/Qj/xrdjyXblyFPpiml49uU59Mzpv+RrUWcwDvrvBTi
         3tgaOxU1m1Wv9CZJBv0vYCXkH00rBNfcyOTikvmCDgO3yGbo0iCCkKZyBnq2GoN32KQq
         CZ3+VOenFu6HK5q8p3AMon0/+TDQWLj0pexd4InwERMUh0N0cAp9csjCOniCkUhZfc97
         aRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Z3F3u8Nx+/OYrV61KStyKbqRsXQU4nBQ49kpg9eous=;
        b=0aWvLqN3xN2GwCgzEi63Pljbrsfr8HZhCiCPv8MyzkQDZrKzGHicCxADWkUs/AEpPX
         FXKwsxVJbAY68aK30A6G6y6/hvlufi1WaJXzg4S4ybFsrq9LQsNxODLmLMqao+MwVDrg
         rLw2UYpObk2qGUf6jT+EXAndtbtOxZCehVz0bJ7M9UPOgNUc+LNibtoyOL2NzRar6m2t
         pHwX0Rv80KD49jM71hKp7qmB7I7kisRSU1Esa8CQHPXTrELWJQUUa7/OJbgR/B3lnUdu
         USeuKtjUCUFLa2doCQ5s9XlWziCQhkgXbl2KH9a5sO3OoRmUOwOddmZCWC6Cm6ZFI6o+
         C2xA==
X-Gm-Message-State: ANoB5pk9tgnTTk6F3ZlkThjQjotirPoSOAhIJ0uBuyotPURfQyacNqvo
        tY1n9fJioB0BQOr4IK0n0lk=
X-Google-Smtp-Source: AA0mqf7KtWbHbyi9K4XP7hR5yFsnh0j3Lf/XUR8nsIHG3Y8/AJC5/uicsU8PxD5VHVmcePVY4XJf8A==
X-Received: by 2002:a63:110d:0:b0:46e:bcc1:28df with SMTP id g13-20020a63110d000000b0046ebcc128dfmr39407657pgl.187.1669857912263;
        Wed, 30 Nov 2022 17:25:12 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 13-20020a17090a190d00b00218cd71781csm1806186pjg.51.2022.11.30.17.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 17:25:11 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] diff: remove parseopts member of struct diff_options
References: <0620b4a6-b80a-d8a0-5a35-857b9fe0c986@web.de>
        <d226d3bc-fb15-58a4-f516-bda51a912228@web.de>
Date:   Thu, 01 Dec 2022 10:25:11 +0900
In-Reply-To: <d226d3bc-fb15-58a4-f516-bda51a912228@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Wed, 30 Nov 2022 19:04:53 +0100")
Message-ID: <xmqqcz93ud8o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> repo_diff_setup() builds the struct option array with git diff's command
> line options and stores a pointer to it in the parseopts member of
> struct diff_options.  The array is freed by diff_setup_done(), but not
> by release_revisions().  repo_init_revisions() calls repo_diff_setup(),
> thus calling repo_init_revisions() then release_revisions() leaks it.
>
> We could free the array in release_revisions() as well to plug that
> leak, but there is a better way: Only build it when needed.  Move the
> get_diff_parseopts() calls to the two places that use the array, free it
> after use and get rid of the parseopts member.
>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  diff.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)

I think this hunk is missing?

 diff.h | 1 -
 1 file changed, 1 deletion(-)

diff --git c/diff.h w/diff.h
index 5229f20486..6840499844 100644
--- c/diff.h
+++ w/diff.h
@@ -394,7 +394,6 @@ struct diff_options {
 	unsigned color_moved_ws_handling;
 
 	struct repository *repo;
-	struct option *parseopts;
 	struct strmap *additional_path_headers;
 
 	int no_free;
