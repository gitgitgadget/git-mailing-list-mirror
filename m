Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFB8C5ACD6
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 15:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4029C2076E
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 15:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgCRPvs convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 18 Mar 2020 11:51:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40412 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgCRPvs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 11:51:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id f3so24096053wrw.7
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 08:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=onKsj85i8vwA2/KcOaePZ+cYp7Jqb1BoeIUcU0PiwOc=;
        b=Ljj8wfuRj1UJiuj1TEshz/Bz0/KV57lTU6blZLkyp8uaTixYgXNs0log4Z4LGigZPC
         3Y9gBzBiPmegTsD5xkxgKQIvb5laAMljs6GHvIFfhRmNm1ipXAlwStZ48C2yiqFv/ViH
         NRzeIAl2zYTd9Q0JWuPn7xp1Ef4uQBTZmoY7IgJ0MoS/Ql09wIP5hst6yw0KnngOhyxf
         YmQWUtdQBv42xeIVJpfqAA+ygnvUir/hR6tcVXOpWwtl06E+DTWHv8wjRifzis1xHlQq
         Gca3Mn34Re4Xv2X+qpM2KH7Rhd/5uJeDaEFKsNBK+lkOKFLedXu5CnO4yJW+NLZhheD4
         MAFA==
X-Gm-Message-State: ANhLgQ04SpsJ8Lp7fUJChzszKUYVoiY+mjBHzYJW5YYNEK7fFQUXBuqr
        I0bPVkzVTiSmTH03LfDx33lFdbVxKsWF1Ml8cWynUGiR
X-Google-Smtp-Source: ADFU+vudoxIBLgN5669qklIGykkdXvQxZqBrpPyt5ieIvBwPCdpUhbD92XW4hEodf9TmR0ISrhR058OtCqjRFre/nfE=
X-Received: by 2002:adf:ecc7:: with SMTP id s7mr6439169wro.386.1584546705159;
 Wed, 18 Mar 2020 08:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584516715.git.congdanhqx@gmail.com> <c1c007190683d7ab49e854a66a4832b5ace72b51.1584516715.git.congdanhqx@gmail.com>
In-Reply-To: <c1c007190683d7ab49e854a66a4832b5ace72b51.1584516715.git.congdanhqx@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 18 Mar 2020 11:51:34 -0400
Message-ID: <CAPig+cSqu7-2eTj9S4nMn+MUmXye92idH=XYiDEewpyf4zhpJA@mail.gmail.com>
Subject: Re: [PATCH 1/3] configure: respect --without-curl flags
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 18, 2020 at 3:38 AM Đoàn Trần Công Danh
<congdanhqx@gmail.com> wrote:
> diff --git a/configure.ac b/configure.ac
> @@ -592,6 +592,9 @@ fi
>  # Define NO_CURL if you do not have libcurl installed.  git-http-pull and
>  # git-http-push are not built, and you cannot use http:// and https://
>  # transports.
>
> +# Respect --without-curl
> +if test "x$NO_CURL" != "xYesPlease"; then
> ...
>  if test -z "$NO_CURL"; then

I realize that GIT_PARSE_WITH() will either clear NO_CURL or set it to
literal "YesPlease", but the comment(s) in this file describing
NO_CURL say only to _define_ it to build without curl support. So, I'm
wondering if it would make more sense to take a looser view about the
value of NO_CURL. The existing check of NO_CURL doesn't bother looking
for a specific value, but instead just tests whether it has a value or
not. Perhaps the new check can be modeled after that one.

Also, I think you can reduce the scope of this change quite a bit by
merely wrapping the AC_CHECK_LIB() invocation. So, either:

    ...
    if test -z "$NO_CURL"; then
    GIT_STASH_FLAGS($CURLDIR)

    AC_CHECK_LIB([curl], [curl_global_init],
    [NO_CURL=],
    [NO_CURL=YesPlease])

    GIT_UNSTASH_FLAGS($CURLDIR)
    fi

    GIT_CONF_SUBST([NO_CURL])
    ...

or even:

    ...
    if test -z "$NO_CURL"; then
    AC_CHECK_LIB([curl], [curl_global_init],
    [NO_CURL=],
    [NO_CURL=YesPlease])
    fi
    ...

Same comments applies to the other patches, as well.
