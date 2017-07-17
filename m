Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B201D20357
	for <e@80x24.org>; Mon, 17 Jul 2017 19:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751406AbdGQTHM (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 15:07:12 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34686 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751311AbdGQTHL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 15:07:11 -0400
Received: by mail-pf0-f194.google.com with SMTP id o88so2377862pfk.1
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 12:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lSY97hhqOzI7L7goZTsC/VSPJU1NlthZLJmUO/g+jko=;
        b=BAcYO1A5eWAtgPOw/do/Zf7Lj35C66FvN7eUsEoZMrzEPh1BYWq9H22gBxY9F2EwCN
         nsHsbiLhwW/cSeDUqyGFwlgRLSbOHaEKavWo9z91C3Nz4HMya7seAGWSVeYvhhMorIho
         qS51j51PSJgh/hBJKjoQkrlWQjRuOh6xPJlt9qUw+f4DAqPqjm2p0LVGwwzNfXeIkjq7
         toQ/EG1YE5cbe9R9szqDCw5F5YqQDi2hTSAhWT19loOc2yov/1gypB5RLFT074FapPkL
         FFB0OAE8g4NWTBHtbTg5Cev1tJiF1dXXjvBxgF5tuILpmQQ6U6RTXzQYsLtO3PjDsB9L
         xEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lSY97hhqOzI7L7goZTsC/VSPJU1NlthZLJmUO/g+jko=;
        b=nm7MCj7nWOa1alZYgj7RldiYOXj/uDtrG9vu0lUbWf3IXcEMkFnrQVwtXnLYRoEQjn
         vltCnI4ZxOT+//HWjKktMpWlqayQG1B7hiS/t2Sl0n3/2vipcdKWhc2yKvnTwBcSiJkh
         Psxf9hyuSd8sv6BlLyPcUdCn+HKHHKjNnktfnOgF9+4KowVONfZMXe8EK5YRfdCgmLax
         YNedaZFA+0uwvGsuoiWF0X9Bj5/jMivhUiiLIQe6Sp4XeXsZSfumy9f3cIk26TlqvopY
         PDqVgL+Kns70Rr3+jGky/cFPGnFDO7rs9EVTS7pOjh64+eR1puz6yuZS8KZK5A4HxtOD
         DAYQ==
X-Gm-Message-State: AIVw111x38JsXtOjdgEzjWgKncR1V6eWbxmZhGNrg3+bg4P95AyX8f0y
        MKJlFxKUwprgkw==
X-Received: by 10.99.94.65 with SMTP id s62mr10228353pgb.187.1500318430736;
        Mon, 17 Jul 2017 12:07:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:480d:579b:4a3b:27f3])
        by smtp.gmail.com with ESMTPSA id e11sm9104pgn.23.2017.07.17.12.07.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 17 Jul 2017 12:07:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Purdea <andrei@purdea.ro>
Cc:     git@vger.kernel.org, bmwill@google.com, peff@peff.net,
        christian.couder@gmail.co
Subject: Re: [PATCH/RFC] diff/read-cache: don't assume empty files will filter to empty
References: <CA+mMEgf1Pg0bbGesCFr6sY60PxR=ewKPqnkG1M3fO2qurqR=1g@mail.gmail.com>
Date:   Mon, 17 Jul 2017 12:07:08 -0700
In-Reply-To: <CA+mMEgf1Pg0bbGesCFr6sY60PxR=ewKPqnkG1M3fO2qurqR=1g@mail.gmail.com>
        (Andrei Purdea's message of "Mon, 17 Jul 2017 03:55:07 +0300")
Message-ID: <xmqqpocyhogz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Purdea <andrei@purdea.ro> writes:

> diff --git a/read-cache.c b/read-cache.c
> index 2121b6e7b..ca306993c 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -262,9 +262,8 @@ static int ce_match_stat_basic(const struct
> cache_entry *ce, struct stat *st)
>   changed |= match_stat_data(&ce->ce_stat_data, st);
>
>   /* Racily smudged entry? */
> - if (!ce->ce_stat_data.sd_size) {
> - if (!is_empty_blob_sha1(ce->oid.hash))
> - changed |= DATA_CHANGED;
> + if (ce->ce_stat_data.sd_size == (unsigned int)-1) {
> + changed |= DATA_CHANGED;
>   }
>
>   return changed;
> @@ -2028,7 +2027,7 @@ static void ce_smudge_racily_clean_entry(struct
> cache_entry *ce)
>   * file, and never calls us, so the cached size information
>   * for "frotz" stays 6 which does not match the filesystem.
>   */
> - ce->ce_stat_data.sd_size = 0;
> + ce->ce_stat_data.sd_size = (unsigned int)-1;
>   }
>  }

This is not a good idea.  A change like this will break existing
installations where a zeroed size is understood as "not verified as
clean".

Is it infeasible to fix your clean-smudge filter pair to clean
and/or smudge zero-sized payload to empty?  After all, it does not
help offloading the storing of blob that is known to be empty and
read another emptiness from the network or whatever external service
when the end result is known to be zero bytes anyway, no?

