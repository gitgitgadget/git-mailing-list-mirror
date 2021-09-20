Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89343C433FE
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CC9860F9D
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347688AbhIUCVe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236274AbhIUBuA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 21:50:00 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE250C06AB00
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 14:53:50 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id q205so1447026iod.8
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 14:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KsjSTEPJix3XMg0EU3lkTIhF3z+DGk9ibp5USWgyA1k=;
        b=Q8nNLPwyy5MLiaRKQzSVC51TTCNxeDZ1ZCS7PmQOJBWGy9jLZRVOmbD4zWaMWFtNhN
         PMrxCVZpdKjsqFbNfhdVgB/7ppMH1amRoAJjKEEMw+4aJokwPEp/GnNhxthn6fRXu8pi
         Hllo8EQ2XEWftCclprzkgWsPAMJrHtw1jIdxT36NJfzAT/6cpBfGrZ/R1IQvc1YzMnT5
         D066kw3oboH2HIbwRLMgxCx7Q/AHQftWoRT//VNhjzDqEyT4zMxJTjN31Ck7rBSFHPYy
         CvQD3WU5Iaaa2Zk4pWND0zfMNHbOvrDvX/A30pd273aZpDZwj9pkI39YZ5Xc+7dFSyjv
         Kx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KsjSTEPJix3XMg0EU3lkTIhF3z+DGk9ibp5USWgyA1k=;
        b=VIGvhQ62LHpNricxq/7BBA/iJ5txlSmYH7P3BhaWTpo1ESCc2JPiYXmAUbACxtLGMP
         MKML4HMXx9ivsJviHStz+Tei4KY6qAC5fr4yAaBD/DXT9g28fuvaMuVWLwBdGVcNvnJE
         hH+pPmCwf2da4VXPM3w++ZfrWTn8Hmy9Ln9YAwUjfj3inpWvfv7Du1t56ZPZ3DAg/BEn
         VHZoRYSyaVqvL0Yue07N6G6IUi/6vEIvoz1eLEjO53Y8dWbH4ScZnEgwT6iViA5vOqW0
         lyt6EGOIz11VOirxmMPKVB83VhIOWu5GEw1rxA535v89Ur2cpWmJ5ygWd4Y7veJJdPki
         rt0Q==
X-Gm-Message-State: AOAM531YJDvvvqJYvD0l205VuVSi4vJ9K1zsitAxgDLQpHpeYmrAZ2w+
        nrF7CEJjmDnv/vEWPYMJH8FYveDt+I5m6g==
X-Google-Smtp-Source: ABdhPJwdHwotDAjkSijSR6V6izt95FxlXchi4+rVLfM1Furdo2csOL8xrfj7a+lT7LKd2RoWZWBYpQ==
X-Received: by 2002:a02:1d09:: with SMTP id 9mr10502942jaj.146.1632174830177;
        Mon, 20 Sep 2021 14:53:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r78sm5465304iod.22.2021.09.20.14.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 14:53:49 -0700 (PDT)
Date:   Mon, 20 Sep 2021 17:53:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/5] wrapper.c: add x{un,}setenv(), and use xsetenv()
 in environment.c
Message-ID: <YUkC7RIDR7pQWsPh@nand.local>
References: <cover-v2-0.5-00000000000-20210916T182918Z-avarab@gmail.com>
 <cover-v3-0.5-00000000000-20210919T084703Z-avarab@gmail.com>
 <patch-v3-1.5-4b320edc933-20210919T084703Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v3-1.5-4b320edc933-20210919T084703Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 19, 2021 at 10:47:15AM +0200, Ævar Arnfjörð Bjarmason wrote:
> Add fatal wrappers for setenv() and unsetenv(). In d7ac12b25d3 (Add
> set_git_dir() function, 2007-08-01) we started checking its return
> value, and since 48988c4d0c3 (set_git_dir: die when setenv() fails,
> 2018-03-30) we've had set_git_dir_1() die if we couldn't set it.
>
> Let's provide a wrapper for both, this will be useful in many other
> places, a subsequent patch will make another use of xsetenv().

Makes sense.

> We could make these return "void" (as far as I can tell there's no
> other x*() wrappers that needed to make that decision before),
> i.e. our "return 0" is only to indicate that we didn't error, which we
> would have died on. Let's return "int" instead to be consistent with
> the C library function signatures, including for any future code that
> expects a pointer to a setenv()-like function.

This may be a little over-clever ;). It is cute, but returning an int
makes xsetenv a drop-in replacement for setenv. Which is nice, but it
makes it all too-easy to take code like:

  if (setenv(...) < 0)
    die(_("..."));

and replace it with

  if (xsetenv(...) < 0)

which makes the whole conditional redundant, since the wrappers are
guaranteed not to return an error.

In other words, I like the idea that s/setenv/x&/ causes a compile-time
error, and returning an int from these wrappers prevents that from
happening.

This may be a little too-theoretical, and you're certainly free to
disagree, just my $0.02.

> I think it would be OK skip the NULL check of the "name" here for the
> calls to die_errno(). Almost all of our setenv() callers are taking a
> constant string hardcoded in the source as the first argument, and for
> the rest we can probably assume they've done the NULL check
> themselves. Even if they didn't, modern C libraries are forgiving
> about it (e.g. glibc formatting it as "(null)"), on those that aren't,
> well, we were about to die anyway. But let's include the check anyway
> for good measure.

This I think is a good call. I agree in practice that most times we'd be
just fine to pass null to printf() (as we have seen from 88617d11f9
(multi-pack-index: fix potential segfault without sub-command,
2021-07-19) ;)). But there's no reason to rely on risky assumptions when
it's easy to avoid doing so.

> diff --git a/wrapper.c b/wrapper.c
> index 7c6586af321..95f989260cd 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -145,6 +145,21 @@ void *xcalloc(size_t nmemb, size_t size)
>  	return ret;
>  }
>
> +int xsetenv(const char *name, const char *value, int overwrite)
> +{
> +	if (setenv(name, value, overwrite))
> +		die_errno("setenv(%s, '%s', %d) failed", name ? name : "(null)",
> +			  value, overwrite);
> +	return 0;
> +}
> +
> +int xunsetenv(const char *name)
> +{
> +	if (!unsetenv(name))
> +		die_errno("unsetenv(%s) failed", name ? name : "(null)");
> +	return 0;
> +}
> +

For what it's worth, I find these new messages a little wordy. Maybe
we should just sticky "could not (un)set %s"?

Thanks,
Taylor
