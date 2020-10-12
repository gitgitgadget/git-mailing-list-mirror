Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C639C433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 22:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 452D22078E
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 22:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C+xzlrKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388649AbgJLWVC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 18:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388218AbgJLWVC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 18:21:02 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B3CC0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 15:21:02 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a200so15006620pfa.10
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 15:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=89cvwtHc8RYAxAv0TyxWR5LeztXozLvuOXyKHWNe7f8=;
        b=C+xzlrKMk9S4XOjLi1OsXxv2oYEg2uZOjUQqclcBqWtAuPQbPH71tv541smBIfqOfc
         nT3ef5TR7m7CcPDZ8PQQwjmBHJ4iQtbJ6EFlGHlNe+FIB3vi6siq/Zt2ictr7hwPnPYb
         05Vg5k+K3BlBZWrZu1YKGdSW+AxiUZAAjb/d5YjLFH7WU5UP6Rgv5agd28oTVMn2Q1oG
         xohNOAIWuvSwAZLKKmb7DrCt7fry9+TPfJtAus3xZU7T4gQtv5ZiHo/g/Rvp5i7I1Ti8
         izFM7R2la79JcQbtj555e7K1U6KcBt+t98R4x8ACjZcG5sGSsmJIrlubYVDh+LWu6KSS
         JMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=89cvwtHc8RYAxAv0TyxWR5LeztXozLvuOXyKHWNe7f8=;
        b=etiiV9W6V4Dbbzeyys+VQC9qO+v+NiHONpuaR8cXDNM2PhefEz7wozJTYYoGB6AwG1
         vjpBzz6mOXjylM2lX1whMV3TrYPyyCZ4fyNAerpSbQiSHFT9G3PAghguPEpLKmgndcO3
         xWNGkc0a/YO4wa3B4AHPYyXh+J78lA3d7/4xNt+7aUC/jC6BfO1KtKP42wCqJNhMzzAw
         JsRxbuhjdlBQpaHtGrChC01IUfI1PFNwTV4a5UBWfshQtozFkH/vjCjvbPCXXX52x6io
         xYAP+nArR1/qIk2DEE/yKsMEgzDIHnuvCb1/8MJi76ZQJbAxVAVIhF8TLsiUe0CBvH3I
         GdXA==
X-Gm-Message-State: AOAM533XLlo3IZEPeS+Tfgbvqqi5GTtDSN3eVTyPARWzlXaeANkVrkQ8
        SD8AiyC3tsBfOOKuC0RA0Z9oV0cy+o07dMCRAi2Qb/mUu2Vhkw==
X-Google-Smtp-Source: ABdhPJwG/s5Y4ugRPgpsi0vlxQYeDBGVkt9KP2Z93YYvad/hL0MPcneA3KeB3og3LLv0le2VvCjHDFZXwXWBfD0PHDk=
X-Received: by 2002:aa7:874a:0:b029:153:3ed1:917e with SMTP id
 g10-20020aa7874a0000b02901533ed1917emr24643140pfo.7.1602541261273; Mon, 12
 Oct 2020 15:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201012184806.166251-1-smcallis@google.com> <20201012201940.229694-1-smcallis@google.com>
 <xmqqy2kbmalb.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqy2kbmalb.fsf@gitster.c.googlers.com>
From:   Sean McAllister <smcallis@google.com>
Date:   Mon, 12 Oct 2020 16:20:49 -0600
Message-ID: <CAM4o00e4wYOHkn38H8UwqboRMSzAs4QCvTN6Ef6PuUnYfwOoXg@mail.gmail.com>
Subject: Re: [PATCH] remote-curl: add testing for intelligent retry for HTTP
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, masayasuzuki@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Sean McAllister <smcallis@google.com> writes:
>
> > +# generate a random 12 digit string
> > +gen_nonce() {
> > +    test_copy_bytes 12 < /dev/urandom | tr -dc A-Za-z0-9
> > +}
>
> What is the randomness requirement of this application?  IOW, what
> breaks if we just change this to "echo 0123456789ab"?
>
> Or "date | git hash-object --stdin" for that matter?
>
> We'd want to make our tests more predictiable, not less.

The randomness requirement is just that I need nonces to be unique
during a single run of the HTTP server
as they uniquefy the files I put on disk to make the HTTP hack-ily
stateful.  I'd be fine with your date/hash-object
solution, but I don't know that it will help make the tests more predictable.

>
> > diff --git a/t/lib-httpd/error-ntime.sh b/t/lib-httpd/error-ntime.sh
> > new file mode 100755
> > index 0000000000..e4f91ab816
> > --- /dev/null
> > +++ b/t/lib-httpd/error-ntime.sh
> > @@ -0,0 +1,79 @@
> > +#!/bin/sh
> > +
> > +# Script to simulate a transient error code with Retry-After header set.
> > +#
> > +# PATH_INFO must be of the form /<nonce>/<times>/<retcode>/<retry-after>/<path>
> > +#   (eg: /dc724af1/3/429/10/some/url)
> > +#
> > +# The <nonce> value uniquely identifies the URL, since we're simulating
> > +# a stateful operation using a stateless protocol, we need a way to "namespace"
> > +# URLs so that they don't step on each other.
> > +#
> > +# The first <times> times this endpoint is called, it will return the given
> > +# <retcode>, and if the <retry-after> is non-negative, it will set the
> > +# Retry-After head to that value.
> > +#
> > +# Subsequent calls will return a 302 redirect to <path>.
> > +#
> > +# Supported error codes are 429,502,503, and 504
> > +
> > +print_status() {
> > +      if [ "$1" -eq "302" ]; then printf "Status: 302 Found\n"
> > +    elif [ "$1" -eq "429" ]; then printf "Status: 429 Too Many Requests\n"
> > +    elif [ "$1" -eq "502" ]; then printf "Status: 502 Bad Gateway\n"
> > +    elif [ "$1" -eq "503" ]; then printf "Status: 503 Service Unavailable\n"
> > +    elif [ "$1" -eq "504" ]; then printf "Status: 504 Gateway Timeout\n"
> > +    else
> > +        printf "Status: 500 Internal Server Error\n"
> > +    fi
> > +    printf "Content-Type: text/plain\n"
>
> Style????? (I won't repeat this comment for the rest of this script)
>
> I briefly wondered "oh, are t/lib-httpd/* scripts excempt from the
> coding guidelines?" but a quick look at them tells me that that is
> not the case.
>

I mistakenly thought the Makefile in t/ was linting these as well.
I've gone back through and fixed formatting issues and removed
non-posix constructs.

> > +}
> > +
> > +# read in path split into cmoponents
> > +IFS='/'
> > +tokens=($PATH_INFO)
> > +
> > +# break out code/retry parts of path
> > +nonce=${tokens[1]}
> > +times=${tokens[2]}
> > +code=${tokens[3]}
> > +retry=${tokens[4]}
>
> You said /bin/sh upfront.  Don't use non-POSIX shell arrays.
>
> > +
> > +# get redirect path
> > +cnt=0
> > +path=""
> > +for ((ii=0; ii < ${#PATH_INFO}; ii++)); do
> > +    if [ "${PATH_INFO:${ii}:1}" == "/" ]; then
> > +        let cnt=${cnt}+1
> > +    fi
> > +    if [ "${cnt}" -eq 5 ]; then
> > +        path="${PATH_INFO:${ii}}"
> > +        break
> > +    fi
> > +done
> > +
> > +# leave a cookie for this request/retry count
> > +state_file="request_${REMOTE_ADDR}_${nonce}_${times}_${code}_${retry}"
> > +
> > +if [ ! -f "$state_file" ]; then
> > +    echo 0 > "$state_file"
> > +fi
> > +
> > +
> > +read cnt < "$state_file"
> > +if [ "$cnt" -lt "$times" ]; then
> > +    let cnt=cnt+1
> > +    echo "$cnt" > "$state_file"
> > +
> > +    # return error
> > +    print_status "$code"
> > +    if [ "$retry" -ge "0" ]; then
> > +        printf "Retry-After: %s\n" "$retry"
> > +    fi
> > +else
> > +    # redirect
> > +    print_status 302
> > +    printf "Location: %s?%s\n" "$path" "${QUERY_STRING}"
> > +fi
> > +
> > +echo
> > diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> > index 7df3c5373a..71d4307001 100755
> > --- a/t/t5601-clone.sh
> > +++ b/t/t5601-clone.sh
> > @@ -756,6 +756,15 @@ test_expect_success 'partial clone using HTTP' '
> >       partial_clone "$HTTPD_DOCUMENT_ROOT_PATH/server" "$HTTPD_URL/smart/server"
> >  '
> >
> > +test_expect_success 'partial clone using HTTP with redirect' '
> > +    _NONCE=`gen_nonce` && export _NONCE &&
> > +    curl "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server" > /dev/null &&
> > +    curl "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server" > /dev/null &&
> > +    curl "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server" > /dev/null &&
>
> These lines are not indented with HT?
>
> Don't redirect test output to /dev/null, which is done by test_expect_success
> for us.  >/dev/null makes it less useful to run the test under "-v" option.
>

Fixed in v2.

> > +     partial_clone "$HTTPD_DOCUMENT_ROOT_PATH/server" "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server"
> > +'
> > +
> > +
> >  # DO NOT add non-httpd-specific tests here, because the last part of this
> >  # test script is only executed when httpd is available and enabled.
