Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B05BC433B4
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 11:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FB9E610CB
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 11:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbhDKL4Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 07:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbhDKL4P (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 07:56:15 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3F0C061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 04:55:59 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id g17so12854474ejp.8
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 04:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=eSuvAE19yBGrEoTg+ULBayUYgIZxFrMMvdpuIcb7wyY=;
        b=Tbl6PK9tOCE1pM/pCDtHXfToz3Xpc/LJ+ob5Z7HN7NHUovl2iptvInZMxPg/jZup/M
         mZiwh7L59A3e4D1GDl6pPw9ikuYaR2TvsYzD3VIXpKpHAfyav9UKzXfJjIwSNhEs7v+o
         YrSxlHqS1oA4Ye3HgBwQXOXKrEDFORwb2bojXIc3wajZGFz00LiXA6XBB03aaes798oR
         qqhDoBb6gSNSTVk7I7ZQfAmNUzW2K0xgfrG8olEsefpYSHjZ/Lm9eHCRZSvxMOkuZtEm
         O0Xpdzlfa0iyYaYzUHd/ILM+kZMvA7rK4kU55QzT0BiBIEqKakDAL1ysYRu6Cyf/xLY1
         B5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=eSuvAE19yBGrEoTg+ULBayUYgIZxFrMMvdpuIcb7wyY=;
        b=aI/JmiMQRrI5zkCMH6amnbwrD4rWiWXHQBKCI+lRFMlJ0qhCrvUCoLuI1/+4DnG4sr
         Thwz2TOvuDEvWBS8lj8CrQlrKwpmrcqom7jWqqnAWGprPYODcBWrnMj+6/chMxGwGl/6
         XGjqICROCQar5ZuCqyk8MLJFe8BknfBNrcd3UY6+JuIpGSd6V1sGhCj4eBB52WpwDIMu
         pP4/f68TKzZhV+4PG9gFhspO+6uOutNlAKCXSKAVWUEjj0JOvcL0BoyhAQ0NMuaNIWpK
         6nG5iyLwTz/rBuo6lIh3FnGwOL5KZXSi7WaSU/RfKI6PXv8isp6kdFGvYYCOVQJuipKm
         FH3A==
X-Gm-Message-State: AOAM5315j8QRZtwe/+sygit7NpZ8UGmejWktnFJKlvsgZDuvcSAOAmFw
        5hwZ0Nvgq15/DMP6WFWxB8E=
X-Google-Smtp-Source: ABdhPJzTDTM23lHtoYdLealKILxcOTWtfEAY4hBYOVFS03IcUs4O2GEszKTsCrX7ZN35eXsQPwtFsw==
X-Received: by 2002:a17:906:9bf9:: with SMTP id de57mr6885197ejc.209.1618142158022;
        Sun, 11 Apr 2021 04:55:58 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id k26sm3968385ejc.23.2021.04.11.04.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 04:55:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 03/15] cache: add an algo member to struct object_id
References: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
 <20210410152140.3525040-4-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210410152140.3525040-4-sandals@crustytoothpaste.net>
Date:   Sun, 11 Apr 2021 13:55:57 +0200
Message-ID: <87mtu5f31u.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Apr 10 2021, brian m. carlson wrote:

> Now that we're working with multiple hash algorithms in the same repo,
> it's best if we label each object ID with its algorithm so we can
> determine how to format a given object ID. Add a member called algo to
> struct object_id.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  hash.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hash.h b/hash.h
> index 3fb0c3d400..dafdcb3335 100644
> --- a/hash.h
> +++ b/hash.h
> @@ -181,6 +181,7 @@ static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
>  
>  struct object_id {
>  	unsigned char hash[GIT_MAX_RAWSZ];
> +	int algo;

Curiosity since I'm not as familiar as you with the multi-hash support
by far:

So struct object_id is GIT_MAX_RAWSZ, not two types of structs for
GIT_SHA1_RAWSZ and GIT_SHA256_RAWSZ. That pre-dates this series because
we'd like to not deal with two types of objects everywhere for SHA-1 and
SHA-256. Makes sense.

Before this series we'd memcmp them up to their actual length, but the
last GIT_MAX_RAWSZ-GIT_SHA1_RAWSZ would be uninitialized

Now we pad them out, so the last 96 bits of every SHA1 are 0000...;
Couldn't we also tell which hash an object is by memcmp-ing those last N
bits and see if they're all zero'd?

Feels a bit hackish, and we'd need to reconsider that method if we'd
ever support other same-length hashes.

But OTOH having these objects all padded out in memory to the same
length, but having to carry around a "what hash algo" is it yields the
arguably weird hack of having a per-hash NULL_OID, which has never been
an actual object of any hash type, but just a pseudo-object.

As another aside I had some local patches (just for playing around) to
implement SHA-256/160, i.e. a SHA-256-to-SHA-1-length that doesn't
officially exist. We'd store things as full-length SHA-256 internally,
but on anything that would format them (including plumbing output) we'd
emit the truncated version(s).

The idea was to support Git/SHA-256 when combined with legacy systems
who'd all need DB column changes to have different length hashes.

I abandoned it as insany sillyness after playing with it for about a
day, but it did reveal that much of the hash code now can assume
internal length == formatting length, which is why I'm 3 paragraphs into
this digression, i.e. maybe some of the code structure also makes having
a NULL_OID always be 256-bits when we want to format it as 160/256
painful...
