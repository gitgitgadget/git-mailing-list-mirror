Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8DCC433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 12:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 535A46101B
	for <git@archiver.kernel.org>; Thu, 13 May 2021 12:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbhEMMMt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 08:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbhEMMKj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 08:10:39 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6ED4C06138D
        for <git@vger.kernel.org>; Thu, 13 May 2021 05:09:27 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id c20so4127972ejm.3
        for <git@vger.kernel.org>; Thu, 13 May 2021 05:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=oZrWHFnuzhrI5EX7efgscUbstR/krHCeuW3uPN3ti98=;
        b=p0t1BxpFkb9L1NQJAwvcJi8UXYUEbqHd5oe7w7JsRHIsSNTODAIsm8Q5Jl2uLd0KcH
         MhurOhmVCEFp0g0+ZLxcJaO7t3wZjs8S+X1chqzsu27XyEVI8dbqcaKA0c4cLjp0cNra
         5AkbZSypxLaCYEW3Jtz22j/hnBfI0JG8KdaW57nJ1L2j/GY0enLOYXsYDlRHf/RAwn9l
         8sHN9PIBbJEy7mOj1RvyqalNKFHUC6BXKbJQOkdcr4YnizkzxxbIDRBkgsFKLPFmqb/z
         WAI0KcVfic0rdqlwtiSDP01IN7ehFddo10YBBUA7PEyXErOZKg/WJrG+0ymLFzxWTVc3
         B0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=oZrWHFnuzhrI5EX7efgscUbstR/krHCeuW3uPN3ti98=;
        b=KsS2feP7YFajVo2w6vfrwJm5a8JAKTYA4JfJbKIjnCkBiXbOJ/5b1n8o8soZLxEWQd
         ElK8DPtzGVSJu4pLLpF66gufKvwiCJhsJlrOvVXJD8x8KXZoGAovL5RS5+/7YREabWH4
         JwZ8BsCjgpLImJvatJl8yj7fqpoTDdTCTk6DkkeQ4p7PvDl0e8/+bdjTy/wVry+LKp9O
         gaosYfJOibkodYomDUYtYvZq+X3vq9SxqDAqksgMrAX8vXSg5GKgEFMEaEB4TT7n+hrP
         gXxZZfie492LpTX/UPWnNdloLSBRtNzHNcL6lSg6+5nc8JCewoBCg/hT1RhPe6IOZM21
         yX+w==
X-Gm-Message-State: AOAM531LO2dmGkRZYAxMqtNrDD1O5Mkzc8tHCirby+gJ9Cv2g8JsvmrB
        UalnBTRd2zkGZOSA/18GBHO6Uwtybvwc0Q==
X-Google-Smtp-Source: ABdhPJwpH4v0IO6dJDRqAWEICBoBlDhMfeDV75qDu+Ve0k+gRNVcenTnnNzxauUxofCVLw7Qtp2Olw==
X-Received: by 2002:a17:906:33da:: with SMTP id w26mr44079148eja.472.1620907766014;
        Thu, 13 May 2021 05:09:26 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id h13sm2117150edb.65.2021.05.13.05.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 05:09:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v6 11/11] test-lib: split up and deprecate
 test_create_repo()
Date:   Thu, 13 May 2021 14:05:36 +0200
References: <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
 <cover-00.11-00000000000-20210510T141055Z-avarab@gmail.com>
 <patch-11.11-217c5aed491-20210510T141055Z-avarab@gmail.com>
 <609ccaf67710b_3293208be@natae.notmuch>
 <87pmxvrs73.fsf@evledraar.gmail.com>
 <609ce1fd6b614_5a8208e3@natae.notmuch>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <609ce1fd6b614_5a8208e3@natae.notmuch>
Message-ID: <87eeeasumj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 13 2021, Felipe Contreras wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Thu, May 13 2021, Felipe Contreras wrote:
>>=20
>> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> >> --- a/t/test-lib-functions.sh
>> >> +++ b/t/test-lib-functions.sh
>> >> @@ -1243,21 +1243,10 @@ test_atexit () {
>> >>  		} && (exit \"\$eval_ret\"); eval_ret=3D\$?; $test_atexit_cleanup"
>> >>  }
>> >>=20=20
>> >> -# Most tests can use the created repository, but some may need to cr=
eate more.
>> >> +# Deprecated wrapper for "git init", use "git init" directly instead
>> >>  # Usage: test_create_repo <directory>
>> >>  test_create_repo () {
>> >
>> > If this is deprecated why not add a warning?
>> >
>> >   echo "warning: test_create_repo is deprecated in favor of git init" =
>&2
>>=20
>> Because like test_i18ncmp, test_i18ngrep or whatever this is in the
>> state of "don't use this for new code", but annoying everyone who runs
>> the test suite with loads of this output under -v would be too
>> distracting.
>>=20
>> The attention of the developer community is much better spent on one
>> person doing a s/test_create_repo/git init/ patch than having everyone
>> see this warning until somebody does that.
>
> Then it's not really deprecated; it's merely disfavored.
>
> To deprecate means to express disapproval of. If we are not going to
> express disapproval (i.e. annoy the users of the test suite), then it's
> not really deprecated. You can't eat your cake and have it too.
>
> I agree we shouldn't throw a warning right now, but at some point in the
> future we should, *then* it will be deprecated.

I don't feel strongly about either term, as long as it's consistent.

I do think that "deprecated" is consistent in the way I'm using it
within the git project. If you grep various things we've "deprecated" we
usually just do so by noting so in the docs. In this case the docs are
the comments in test-lib.sh.

We do also have things like git rebase --preserve-merges which emit a
warning, but we use "deprecated" for both. By contrast we don't have a
single git for "git grep -i disfavor".

Anyway, for now I'd prefer to just have this land as-is and sort out
such minor things later, given the v6 and having two other topics
waiting on this...
