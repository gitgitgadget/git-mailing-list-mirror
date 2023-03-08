Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65A6C64EC4
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 10:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjCHKFa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 05:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjCHKFY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 05:05:24 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7C7B5AA5
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 02:05:11 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-536be69eadfso295906397b3.1
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 02:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678269910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eq4O8yez78eAH3Dle5ySLk8DzKaZtEQUZapyoEgofcc=;
        b=gYXHquR9/7TkHiPKMXrl5vl9hNPhVKSUKMAx4Qm3/TrpmoOheMG22A7qLCNZhpB+cG
         cpCTW5tRWiUphjVmZhyp2zs9O9aGZ+56Rjg8Hkk7fycU6fixouDTNIiBuQRjP9hc3G0c
         dvy4l7DAt7O4lHnOsaz4wzc2Bva1wBKchykKC/AjbO1Qr+frlDlLM0ycQ3oOfsPydUbd
         7jkYSTyCq8HPsLyL4C41LjeYIVxqxffJ6roY1S8WE0Fmx9upUi7tNASfwo9+TZZwbotK
         ofl5dn0Nk5M3bztidStay0PZUc9ZdOZaWylMvoXZDVBqVBei1UzhspoYDhMJ78+w9W+E
         /7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678269910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eq4O8yez78eAH3Dle5ySLk8DzKaZtEQUZapyoEgofcc=;
        b=1pdvipqovOjVBdxZj5W/GZORTdPRYWOLbmYuRPrB0iDjxKjo0/kLMA4s5dLBBcmskO
         rpA6E5Z1RPY8NpNz7yTIkTeE7ybiHDXT2jDblWW25NZPkgZXpM2Vj9UXhiDa4inNBqXv
         5PG6BTH0oN5NFPGF+GjF/h2+RMcg1XZfVOHmd+ldnWCH1MKArjQd+jgfsW+9lkuG2bI8
         0yYG2diUmE3t4bsOcS8TaJDw5kf9BUJ7GSKQn1fBkOG0rkK40rHlAzKsf0QbFzD8qlIx
         dwVsg7k4iORCey6VqB2dUZm5Q0cykJWlhG7iZDxaH9iuzC0q91Q/8cQ2CYrLWaYatRU6
         FfSQ==
X-Gm-Message-State: AO0yUKXNRCxI72wbZLd4TlPHvBAYdxtbVV0x8YwoKwwiYQw831FnuS34
        418y5B6K/XCsa0OWGQFhHNB81sDASy7S7jMFeSRyucC8mLw=
X-Google-Smtp-Source: AK7set86XNNd2q8ZA7bi9+Rbboz8v5bkquAxRFtJ0z6u042CDunJ/kMCbfcK1bzpghzvkXCtqi1eVMIyrIkHMuCRZQM=
X-Received: by 2002:a81:b288:0:b0:52e:ee55:a81e with SMTP id
 q130-20020a81b288000000b0052eee55a81emr11273545ywh.7.1678269910136; Wed, 08
 Mar 2023 02:05:10 -0800 (PST)
MIME-Version: 1.0
References: <20230308090536.2562917-1-felipe.contreras@gmail.com>
 <230308.86bkl3zjp3.gmgdl@evledraar.gmail.com> <20230308092621.M321240@dcvr>
In-Reply-To: <20230308092621.M321240@dcvr>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 8 Mar 2023 04:04:59 -0600
Message-ID: <CAMP44s34bvRP1n3L57sK450ZfLUeVQKVtXDXrE75qM46xaCgcw@mail.gmail.com>
Subject: Re: [PATCH] test: simplify counts aggregation
To:     Eric Wong <e@80x24.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Fabian Stelzer <fs@gigacodes.de>,
        Brandon Casey <drafnel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 8, 2023 at 3:26=E2=80=AFAM Eric Wong <e@80x24.org> wrote:
>
> > On Wed, Mar 08 2023, Felipe Contreras wrote:
> > > +++ b/t/Makefile
> > > +   '$(SHELL_PATH_SQ)' ./aggregate-results.sh '$(TEST_RESULTS_DIRECTO=
RY_SQ)/t*-*.counts'
>
> > > +++ b/t/aggregate-results.sh
> > >
> > > -while read file
> > > +for file in $1
>
> Reading aggregate-results.sh alone looks wrong; but your patch is
> correct overall because of how it's invoked from the Makefile.
> I think that's too subtle...

Yeap, it's the first time I read it, I don't actually use it, and it's
broken for my use case:

    testnum=3D$(expr "$file" : 'test-results/\(t[0-9]*\)-')

That doesn't work when TEST_OUTPUT_DIRECTORY is set (which I always
have); should be ".*test-results".

I don't actually care how many thousands of tests have been run, the
only functionality that might be useful to me is the number of fixed
tests (namely that it's higher than 0). Maybe a summary-results.sh
might make more sense.

Cheers.

--=20
Felipe Contreras
