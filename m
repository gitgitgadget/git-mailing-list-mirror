Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9A6C433DB
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 12:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD87722CA1
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 12:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbhAXMbG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 07:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbhAXMa5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 07:30:57 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46ADC061573
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 04:30:16 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ke15so13992783ejc.12
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 04:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=7HxufPcmjwQkeivqEbE7BS0CVHNSKsGPovh7tTdwttM=;
        b=EUbybqRjC/FBYALywxETB5cZyNAizO8cb9NWBFOzckCv3YXw7J3RV0sZ9RyJE5jnR3
         lS+nPOHxO1N6X50tp+acLEn6tPn090vzAIeAGy/5hXa0bs5QTSgWo6kWne5e9RbgoZr/
         Vj/lfCge8Bl7kPii1nvpZO3m7HCbwIXn3/gD7VJ6JjdpqUS+sCQWG2Soe4rtlQ8SJg0H
         QAqamhi1WIjZM7bKH42CKGpR0x5gRfcOYVNC6EqNIoLcH7x6/hNqsREwATotanBjiCcB
         JQfJ/11s6tP8f3vHDyRQVRM/IDkz4a8n/VHukLnzhwOO1XnzDjqrYg2w6SybVKMRxBf5
         4Zyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=7HxufPcmjwQkeivqEbE7BS0CVHNSKsGPovh7tTdwttM=;
        b=CEFU4qieprdN86xQvZNLJEOX3mCMaWY8q6dSHIWJ0Pta1aL1pKHsWZZXPwvmw+AZTs
         S8BsyYV92QPVCwLa0juQxjBqhrorWnufzOUu+xqY0w8YzJY/URHOXFTdlUnS3EU+5mUh
         F+1TvHbUDI/vw/D8V3caq35S2347pzIvBxMCbGSggP/xoN9CoBWzRBxxHIGVz8I35338
         t3F+ak2JRvKmyOYU8qYsF94zLXIHs81DLXMKZcI3LrDXqDeR2dbqVwDiXaFaj7CDZ4zB
         qPs1pcn+DVKEr07Wt/602UDRif1DTczv2vzu/vr3nudsi2gxB5fAfxPZvOwkTaFSqvZb
         cn0g==
X-Gm-Message-State: AOAM533+6jVJs3an46qSgiI9j98ow8QUdaItprl+/H4tSoDcfQ0HcgCR
        qDSj6Qx1xDOMLGKBscvQvG67hSF+bWu+QA==
X-Google-Smtp-Source: ABdhPJxOSEkFmJC9OsyIzzgkf+pnZy6qQFkS2k+SVHySut8RDuLBFk47zBnsqFoJPhQOEznzAcLUhw==
X-Received: by 2002:a17:906:90c3:: with SMTP id v3mr241899ejw.461.1611491415331;
        Sun, 24 Jan 2021 04:30:15 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id ke7sm6949364ejc.7.2021.01.24.04.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 04:30:14 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4] fetch-pack: print and use dangling .gitmodules
References: <20210115234300.350442-1-jonathantanmy@google.com>
 <cover.1611455251.git.jonathantanmy@google.com>
 <2d6d8c2671fe424c752994dcb5277d4d923e17a0.1611455251.git.jonathantanmy@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <2d6d8c2671fe424c752994dcb5277d4d923e17a0.1611455251.git.jonathantanmy@google.com>
Date:   Sun, 24 Jan 2021 13:30:14 +0100
Message-ID: <87czxu7c15.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jan 24 2021, Jonathan Tan wrote:
>  --fsck-objects::
> -	Die if the pack contains broken objects. For internal use only.
> +	For internal use only.
> ++
> +Die if the pack contains broken objects. If the pack contains a tree
> +pointing to a .gitmodules blob that does not exist, prints the hash of
> +that blob (for the caller to check) after the hash that goes into the
> +name of the pack/idx file (see "Notes").

[I should have waited a bit and sent one E-Mail]

Is this really generally usable as an IPC mechanism, what if we need
another set of OIDs we care about? Shouldn't it at least be hidden
behind some option so you don't get a deluge of output from index-pack
if you're not in this packfile-uri mode?

But, along with my other E-Mail...

> [...]
> +static void parse_gitmodules_oids(int fd, struct oidset *gitmodules_oids)
> +{
> +	int len = the_hash_algo->hexsz + 1; /* hash + NL */
> +
> +	do {
> +		char hex_hash[GIT_MAX_HEXSZ + 1];
> +		int read_len = read_in_full(fd, hex_hash, len);
> +		struct object_id oid;
> +		const char *end;
> +
> +		if (!read_len)
> +			return;
> +		if (read_len != len)
> +			die("invalid length read %d", read_len);
> +		if (parse_oid_hex(hex_hash, &oid, &end) || *end != '\n')
> +			die("invalid hash");
> +		oidset_insert(gitmodules_oids, &oid);
> +	} while (1);
> +}
> +

Doesn't this IPC mechanism already exist in the form of fsck.skipList?
See my 1f3299fda9 (fsck: make fsck_config() re-usable, 2021-01-05) on
"next". I.e. as noted in my just-sent-E-Mail you could probably just
re-use skiplist as-is.

Or if not it seems to me that this whole IPC mechanism would be better
done with a tempfile and passing it along like we already pass the
fsck.skipList between these processes.

I doubt it's going to be large enough to matter, we could just put it in
.git/ somewhere, like we put gc.log etc (but created with a mktemp()
name...).

Or if we want to keep the "print <list> | process" model we can refactor
the existing fsck IPC noted in 1f3299fda9 a bit, so e.g. you pass some
version of "lines prefixed with "fsck-skiplist: " go into list xyz via a
command-line option. And then existing option(s) and your potential new
list (which as noted, I think is probably redundant to the skiplist) can
use it.



