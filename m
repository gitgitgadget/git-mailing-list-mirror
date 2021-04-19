Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939DFC433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 23:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 676A36113C
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 23:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhDSXPM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 19:15:12 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55429 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhDSXPL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 19:15:11 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C836313072C;
        Mon, 19 Apr 2021 19:14:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LA7Uwf7DWSNWTKimd/MQbxKOJs4=; b=q77Xrh
        Ei/gYkXnRZJgYjNgCLCv6hYJUaM1mOV63Ij7Ft3WVoAdwOrMo1McZChJEwyyw37G
        cZqOZeSYWy3l39JEGYbGSBtuGUYY7YLYYtJ/bubsTqBd3ZWHe4R+1DxXDOWJx8vP
        iwxwEhuPw2OD+HlXyXHQjPGzL1xF+U5DRj1zw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZmPBQVAAgMSHNow5nVduKMqn8H78FKOh
        IVVEtjCQSZJv5CefNxR0wAH7bGb78Y8e3mlbkiIjaHiNgo8oCBZuPL99RWHbBnCO
        6MUsIH51kw61BAzJfrFb4TWgdtgKFgApSS93wbAbbEmmQsVGxTk1P95rPdzron0r
        XGUTf2atRMw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BFC6F13072B;
        Mon, 19 Apr 2021 19:14:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 08CD813072A;
        Mon, 19 Apr 2021 19:14:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: What's cooking (draft for #4's issue this month)
References: <xmqqmtu1zn3o.fsf@gitster.g> <xmqqim4owixg.fsf@gitster.g>
        <YHeKFILFySGRo2Dc@camp.crustytoothpaste.net>
        <xmqqr1jcrr3c.fsf@gitster.g>
        <YHzmjhLy2QjDefXy@camp.crustytoothpaste.net>
Date:   Mon, 19 Apr 2021 16:14:36 -0700
In-Reply-To: <YHzmjhLy2QjDefXy@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Mon, 19 Apr 2021 02:10:22 +0000")
Message-ID: <xmqq5z0h989v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03163900-A165-11EB-A9C6-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I'm still working on a full reroll for the series including performance
> measurements (since this took me much longer than I expected it would),
> but I wanted to include a patch for the segfault below to keep things
> tidy in the mean time.  I should point out that this doesn't appear to
> crash when running the testsuite in SHA-256 mode for reasons I'm not
> sure about, which explains why I didn't see it originally.

Thanks; will apply and keep it with the latest round for now.  

>
> ---- %< ----
> From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
> From: "brian m. carlson" <sandals@crustytoothpaste.net>
> Date: Sun, 18 Apr 2021 22:56:04 +0000
> Subject: [PATCH] http-push: set algorithm when reading object ID
>
> In most places in the codebase, we use oidread to properly read an
> object ID into a struct object_id.  However, in the HTTP code, we end up
> needing to parse a loose object path with a slash in it, so we can't do
> that.  Let's instead explicitly set the algorithm in this function so we
> can rely on it in the future.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  http-push.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/http-push.c b/http-push.c
> index b60d5fcc85..5675cd7708 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -1022,6 +1022,8 @@ static void remote_ls(const char *path, int flags,
>  /* extract hex from sharded "xx/x{38}" filename */
>  static int get_oid_hex_from_objpath(const char *path, struct object_id *oid)
>  {
> +	oid->algo = hash_algo_by_ptr(the_hash_algo);
> +
>  	if (strlen(path) != the_hash_algo->hexsz + 1)
>  		return -1;
>  
> ---- %< ----
