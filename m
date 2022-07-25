Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478CBC43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 21:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbiGYVCo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 17:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbiGYVCl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 17:02:41 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3976623BC6
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 14:02:40 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id w8-20020a05600c014800b003a32e89bc4eso7060828wmm.5
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 14:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GCXm/jKcGM2UbQ/aljrYGSUkbCEi2vzjitGYM7eB+E0=;
        b=bFVW2gt2yXCHLqF+d1vens3qDo+nPJ8GkhMraaqHAHRpbEkzQNoI+KnGJqEUcWCROM
         DerkijOwCQs80jwbmY30UNRH3RX6yhx0xAynEqg01mvgtQJT4sYWsrGFSDgIqsxzzWnP
         6ZVYjzR/qJlcbFeGVY4sAH83OUd7gI2z/uFfi7s7NJGsNJiiTfxT+0mSYK/6wmeIwTsL
         OxS1pXLur0W1sTfOFUnvf892VOl3/HYHAAdd79Ky0ikXfhTAe4AanlWRCpEZihIL0gB9
         Kpw9YTlort4N8colKWrY21yZEwAICIItL47c2whqAzb0GFc5/tVvydxK0cETo+PFpluZ
         drfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GCXm/jKcGM2UbQ/aljrYGSUkbCEi2vzjitGYM7eB+E0=;
        b=df5PgSBf8ndUfTZMslCwyrKIHVdEJ3YTSfYoVBP+RxNwrlcmEEM+L77VrFGIsb5r2/
         tCaglR14zCwCUqQcgeVbI6rTbFd0GtgvmpXZ9JBhyaThnhc29cqPgXofJx9wGElHAQkK
         6y4oYocolRjC3GIj9jRV9h3BB9suGzYnnhIy7aE08Ou1WXjA91xZ7rXUoGQckCFo0Ypa
         zWw/0c3E9AIZjLu1idZDYP9axzTlIiafu2SBerfkchyRitgyRg3EcmBaVGNUwXEujbnm
         LR6ytfO/uva8KiPBl7XCc4EyxN4S1oZV+Lz0oie8+k9LKuvhf6YcnMFhKqYpzCNxGvTP
         7oQg==
X-Gm-Message-State: AJIora83HLZDvH8Ho6BYDVhEypkLyDDfnk+mS3rfcCuaq2cIEQUk+jnh
        hYfa/7DRUqLmipGI4O1sLKg=
X-Google-Smtp-Source: AGRyM1s1ApTlxyu0cXFTu270cg972j1JhW9iHPTeMtG+30bVEwaCKlBWlqyghfqjckkbkwllN6TwnA==
X-Received: by 2002:a05:600c:5006:b0:3a3:2dcd:8730 with SMTP id n6-20020a05600c500600b003a32dcd8730mr18097733wmr.99.1658782958767;
        Mon, 25 Jul 2022 14:02:38 -0700 (PDT)
Received: from localhost (94-21-23-94.pool.digikabel.hu. [94.21.23.94])
        by smtp.gmail.com with ESMTPSA id d16-20020adff2d0000000b0021b9585276dsm12962837wrp.101.2022.07.25.14.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:02:38 -0700 (PDT)
Date:   Mon, 25 Jul 2022 23:02:36 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 09/20] parse-options: add support for parsing subcommands
Message-ID: <20220725210236.GC2543@szeder.dev>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220725123857.2773963-10-szeder.dev@gmail.com>
 <220725.86a68xp7az.gmgdl@evledraar.gmail.com>
 <20220725192947.GB2543@szeder.dev>
 <220725.86wnc1nf6c.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220725.86wnc1nf6c.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 25, 2022 at 09:41:52PM +0200, Ævar Arnfjörð Bjarmason wrote:
> >> > +		error("'cmd' is mandatory");
> >> > +		usage_with_options(usage, test_flag_options);
> >> 
> >> nit: I think you want usage_msg_optf() or usage_msg_opt().
> >
> > Maybe... but I don't know what they do ;)  Though I remember removing
> > a couple of similar error() and usage_with_options() pairs from the
> > builtin commands.
> 
> It's just helpers for "usage_with_options, except with a message, e.g.:
> 
> 	$ ./git cat-file a b c
> 	fatal: only two arguments allowed in <type> <object> mode, not 3
> 
> 	usage: git cat-file <type> <object>

I've looked them up in the meantime.  The problem is that they both
output the given message with a "fatal:" prefix, but option parsing
related errors are usually prefixed with "error:".

