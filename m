Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28A7C433F5
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 19:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiJETu6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 15:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiJETu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 15:50:56 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067EF80F7E
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 12:50:55 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id w191so7308245pfc.5
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 12:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gsnyo76ByuCEpcZAHN+vbyoPAdWNcObe+yAbihFPkJI=;
        b=TwktiBzyutze4cc1Sl9pkbVk7A3+9zpFlo1BJqgxjCr4aOF0idixuasRXuLezi/KSp
         N0jIwT/Y7IgGnlknX1XBT4jgjpBhEbtrnA5M9hy7ViY+XgnAKXrv/q3X6bAOjcFxroDm
         /bAVRu8XaypMht61LB9/Q3YziIOv8q7xGIyQl8ZT8ENY8q0LaN/YLm+TLwe5xeSWp1zs
         tB8a7WOxDVNEPtDl0splTm8uBp7rrlaOZSlpQsGBmrTyi7qqYhphnYAozo2YE1DlVIxm
         EBKLLhMqut/144cAfzHZYzCTe2z67mZC1Ujl/9A2WfpcSJ2zX85Ro0FS7Z2ZhQ3cNq3n
         ypNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gsnyo76ByuCEpcZAHN+vbyoPAdWNcObe+yAbihFPkJI=;
        b=zFc837dTlNok36A5EQXOt8MDcqwfMAJjrrD1Z5ngVTdNQ81F8K0/h7tkdXSKO+jVIu
         ajXdOhGG7NJFNW4QYYJ0CK8eu9jHLw4kj0QIA1/sPY+BihqJv2oYjYhbEYPfA38rIvqa
         0ThE/+Ug3ukaX3tz3a6PhbOddPkbnvCziNlLu18VjUPFctUjotCQ8u/vCTurn/6hIdIV
         Rar4znQb2Ibw15X+CZKkdf7q9Sgq/f8v98Aw5rn2h5lqnYrZ7lEMD7DclLbE57iEj2GK
         x8/uQkFAaPiMIAFHSLzFHX0PJLnAUi/z055dio1rJ3iqv70EBoVYFpBaHHjNuiKkeTLn
         oETA==
X-Gm-Message-State: ACrzQf3E5iPXQ3v2LuhwlXYPQARPZoBXNCCWrPf2RYw+iMoV0jZRma4V
        lPc+h9AmdVVhGSRvd/2m7b6vmSfsEiA=
X-Google-Smtp-Source: AMsMyM5/kvZWaYM1hgdCBYVe4z9cgAGSPyaalAYIlWP1XUxJri+JRGaN19JRhnE4ScsTI2Fn77IHNQ==
X-Received: by 2002:a63:2215:0:b0:43b:e00f:7c7b with SMTP id i21-20020a632215000000b0043be00f7c7bmr1210852pgi.511.1664999454456;
        Wed, 05 Oct 2022 12:50:54 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id v6-20020a17090ad58600b001fba4716f11sm1483057pju.22.2022.10.05.12.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 12:50:53 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] t/lib-httpd: pass LANG to Apache
References: <3b370f7b-df84-0629-d334-aa9dfbca1c05@web.de>
Date:   Wed, 05 Oct 2022 12:50:53 -0700
In-Reply-To: <3b370f7b-df84-0629-d334-aa9dfbca1c05@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 4 Oct 2022 19:42:39 +0200")
Message-ID: <xmqqtu4inj6q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> t5411 starts a web server with no explicit language setting, so it uses
> the system default.  Ten of its tests expect it to return error messages
> containing the prefix "fatal: ", emitted by die().  This prefix can be
> localized since a1fd2cf8cd (i18n: mark message helpers prefix for
> translation, 2022-06-21), however.  As a result these ten tests break
> for me on a system with LANG="de_DE.UTF-8" because the web server sends
> localized messages with "Schwerwiegend: " instead of "fatal: ".
>
> Fix these tests by passing LANG to the web server, which is set to "C"
> by t/test-lib.sh, to get untranslated messages on both sides.

It is a good thing to do, but we seem to be extra conservative and
set both LC_ALL=C LANG=C (presumably by following the habit acquired
back when locale support were being introduced to various systems
with different degree, which way predates Git itself) and export
them in the main part of the test framework.

Shouldn't we be doing the same here?

> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  t/lib-httpd/apache.conf | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
> index 497b9b9d92..1e2295a7cb 100644
> --- a/t/lib-httpd/apache.conf
> +++ b/t/lib-httpd/apache.conf
> @@ -80,6 +80,7 @@ PassEnv LSAN_OPTIONS
>  PassEnv GIT_TRACE
>  PassEnv GIT_CONFIG_NOSYSTEM
>  PassEnv GIT_TEST_SIDEBAND_ALL
> +PassEnv LANG
>
>  Alias /dumb/ www/
>  Alias /auth/dumb/ www/auth/dumb/
> --
> 2.37.3
