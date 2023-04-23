Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2B4C77B76
	for <git@archiver.kernel.org>; Sun, 23 Apr 2023 02:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjDWCiS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 22:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjDWCiR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 22:38:17 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5DB2100
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 19:38:15 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-b983027d0faso4017820276.0
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 19:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682217494; x=1684809494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wSaw5o2lWMwhqdj3Nmya7kRKyTTHpuXk/0oa2BZxHB4=;
        b=CF6zQWcTzUNqVK3sl9pppJrQ8yZJduU5ndFw9c0ih0ltcuMH8CtgXYq+ojVYrWVUWk
         AgKgp+P4Jcys/BZwQwrJucVu3pUO1p+w19185nh2Srxq1NKIw5+o2Ygrx97lYIwLZIlw
         WCwGagcSUeQ7+6WYh2to98EP4KtUF+U43z3IDnYDShmq60gJk7oozkK6u+M/1kq6prk5
         YHSJAul4MOunULXVWExZppX68DzXyM/X4/Djt6vv9qVh/r3SIFnmKDz8exHqh6ak+YXt
         RdilySrRBJ4rGnYZTu8e007Z8za16rvN8yWjVekYAVEactsSNzyySd4M4TWxMRbT9msW
         lbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682217494; x=1684809494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSaw5o2lWMwhqdj3Nmya7kRKyTTHpuXk/0oa2BZxHB4=;
        b=BrfGdbYMjfQEF2/cJb5+txrelroNc+J2x/ngEaqo6qlyUZeHkTom707XDPJcjX5rGv
         NAG/biTpsoptwJ17psNDZUOh5VffTCV2WVWT+SR6F5j+xkzYqlpf2V1GFy/Ydzr4pH5P
         IWajEZKuKmhNHbs6a42t58Z2J8H6f/q7H1yI3IS5t561DraVNApLU+9ZQAC1/2WhTK/A
         s/isbvsBro4Ka+8MFQ8j0mc9VPlMd9i7H7llm/N0vWWkh5npUq1WS1H6POVVkmNczHpi
         xcSvvRPQk6BPlme2rKih85gj6lfXmaAbO0uM53lAOunAjKzKThlxJClV256xnBzGPLKw
         MDkg==
X-Gm-Message-State: AAQBX9fkCsqp1pm+rh72VItLYi/X/3IT5Oi6zez81tfLmltqUvwfYec0
        JGcU0jixx6XSNGGBYQhX5twoKg==
X-Google-Smtp-Source: AKy350YJcwm3aozIagj2vTungat6xcALV39rWE88pcjJNy0nlC/zZcD0iXqqx9xEoZrxkABXcDztOQ==
X-Received: by 2002:a25:d897:0:b0:b8f:32a9:902 with SMTP id p145-20020a25d897000000b00b8f32a90902mr6040048ybg.30.1682217494632;
        Sat, 22 Apr 2023 19:38:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t1-20020a0dea01000000b00545a08184fesm1985395ywe.142.2023.04.22.19.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 19:38:14 -0700 (PDT)
Date:   Sat, 22 Apr 2023 22:38:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/6] string-list: introduce
 `string_list_split_in_place_multi()`t
Message-ID: <ZESaFXMcP6mhtBOv@nand.local>
References: <cover.1681428696.git.me@ttaylorr.com>
 <cover.1681845518.git.me@ttaylorr.com>
 <6658b231a906dde6acbe7ce156da693ef7dc40e6.1681845518.git.me@ttaylorr.com>
 <20230422111213.GB2969939@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230422111213.GB2969939@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 22, 2023 at 07:12:13AM -0400, Jeff King wrote:
> On Tue, Apr 18, 2023 at 03:18:43PM -0400, Taylor Blau wrote:
>
> > Introduce a variant of the `string_list_split_in_place()` function that
> > takes a string of accepted delimiters.
> >
> > By contrast to its cousin `string_list_split_in_place()` which splits
> > the given string at every instance of the single character `delim`, the
> > `_multi` variant splits the given string any any character appearing in
> > the string `delim`.
> >
> > Like `strtok()`, the `_multi` variant skips past sequential delimiting
> > characters. For example:
> >
> >     string_list_split_in_place(&xs, xstrdup("foo::bar::baz"), ":", -1);
> >
> > would place in `xs` the elements "foo", "bar", and "baz".
>
> I have mixed feelings on this.

Hmm. I implemented it this way partially after reading your suggestion
in [1], but also to allow using `string_list_split_in_place()` as a
strict replacement for strtok().

And I agree that for the existing users of strtok(), which are all in the
test helpers, this probably doesn't matter much either way. Though I
feel like since we are banning strtok() over the whole tree, that we
should provide a suitable replacement at the time we ban strtok(), not
at the time somebody needs to rely on its non-empty fields behavior.

[1]: https://lore.kernel.org/git/20230418102320.GB508219@coredump.intra.peff.net/

> Obviously one solution is to add the "runs" option to all variants. But
> I'd be hesitant to burden existing callers. So I'd propose one of:
>
>   1. Make your _1() function public, with a name like _with_options() or
>      something (though the function name is sadly already quite long).
>      Leave string_list_split_in_place() as a wrapper that behaves as
>      now, and have the few new callers use the with_options() variant.

I think that in general I'd prefer (2) to avoid polluting the list of
declarations in string-list.h, but in this case I think that in this
case it is the right thing to do.

Thanks,
Taylor
