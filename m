Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47688C43460
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 04:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 207226144B
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 04:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbhD2EDn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 00:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbhD2EDl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 00:03:41 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F74C06138D
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 21:02:08 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id c8-20020a9d78480000b0290289e9d1b7bcso46254532otm.4
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 21:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=krKU+g9eLbDLyhp25niFZWrR7+MHcwEJNrv6aGWEuJw=;
        b=lC76c7FViOnAn18mUV2uPKRtADnfGMOIfVsF9nv9faxEd6a+dKgLK6OUL2yvBvgWZb
         5Jq8eznTf1xS0lu8eLufAOEfDQ+AQbQHzlNIM20syQUxwl7AafAWohJZ2debt87j4fe6
         Sgw9CAXFL1/yvGVitVIy54Ey/VIEsHMllEo5EM+aJIH3pnVCu5PY1oiPbONdNisVYaT/
         x8CmvombdJvGEKnoFYN9dhVNbcJ7Zl+QJfccrcu8+N7dTbskS3Vugr26rkEsZMONXpRL
         N5Nn9wJv+PVWjl/dH/QSPj9A7VT2nIQA/vwJrBC1GLrWcLpU+YHtzza18I1UAyXRpFs1
         jy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=krKU+g9eLbDLyhp25niFZWrR7+MHcwEJNrv6aGWEuJw=;
        b=ep+brU9nu5fxPUE1ZtFdzjc8JmComWGp6txQn6ORCArGUORpSNJaux2udSKEMDqz6S
         bmkYLxtPeSrf0rcDi7ZVC9BMAWg+4aCEqBBlcq1CmAnMjtUbQEYXbtCwDIe2NlB9dlbv
         1wEdcErt3sOFgNhioiy81NcaCkuhvIcIT80ClCjX1s/iuGxYKKQYoKaMO421Mo0wDWTB
         Qgeocacao0m4rFWgUp967FA+enlt3anLNi6edSSf37ajKv9dRIfqZxOq4yPpdSnKsLs8
         08+ZIESMw4QSM2wDnSxsUlaFyeokoP3UtenPGEjxbqx/hM5DeJ2i3Iqw3dU37SQmR/nG
         hlFA==
X-Gm-Message-State: AOAM531sAIWGbix8eKlg323DWytzgZB2DuQOUPnUTbLvvgkFqG4Npoww
        qd0kxzgRN0eJHCW+2ERQmZQ=
X-Google-Smtp-Source: ABdhPJzI10kzEoGjkPKmJoIhLq/usqOCJdDrrKQL4YC6txnHK5ETT0ocFSc/um+QLUbuTml9lZjo9w==
X-Received: by 2002:a9d:2f04:: with SMTP id h4mr26700520otb.364.1619668928196;
        Wed, 28 Apr 2021 21:02:08 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id x24sm418192otk.16.2021.04.28.21.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 21:02:07 -0700 (PDT)
Date:   Wed, 28 Apr 2021 23:02:06 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <608a2fbe5e70e_ac4020821@natae.notmuch>
In-Reply-To: <patch-2.4-3a570321770-20210423T072824Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210421T144921Z-avarab@gmail.com>
 <cover-0.4-00000000000-20210423T072824Z-avarab@gmail.com>
 <patch-2.4-3a570321770-20210423T072824Z-avarab@gmail.com>
Subject: RE: [PATCH v3 2/4] Revert and amend "test-lib-functions: assert
 correct parameter count"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 2914b398470..0adb9fd124d 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -756,41 +756,43 @@ test_external_without_stderr () {
>  }
>  =

>  # debugging-friendly alternatives to "test [-f|-d|-e]"
> -# The commands test the existence or non-existence of $1
> +# The commands test the existence or non-existence of
> +# a given argument.
> +#
> +# The pattern of using "$@" to "test" instead of "$1" is not a bug. We=

> +# are counting on "test" to error on too many arguments if more than
> +# one is given. Checking "$#" explicitly would lead to overly verbose
> +# -x output.

I would consider adding an extra line. In my mind a comment without a
line is for the next function, one with a line is for the section.

  # function comment
  function_1 ()

Versus:

  # section comment

  function_1 ()
  function_2 ()

But I agree with the other comments that it's better inside the
function. It's an implementation detail.

While I think git tries to follow the self-documenting code style,
sometimes it's better to just write the comment.

>  test_path_is_file () {
> -	test "$#" -ne 1 && BUG "1 param"
> -	if ! test -f "$1"
> +	if ! test -f "$@"

  if ! test -f "$@" # Rely on test to ensure 1 param

>  	then
> -		echo "File $1 doesn't exist"
> -		false
> +		echo "File $* doesn't exist"
> +		return 1
>  	fi
>  }

And yes, I would add that comment to every instance where this trick is
used. That way people reading the second or third function don't have to
scratch their heads, or miraculously read a comment far above.

Cheers.

-- =

Felipe Contreras=
