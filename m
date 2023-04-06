Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92648C77B6C
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 08:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbjDFIjK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 04:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235550AbjDFIjG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 04:39:06 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C830C7A8B
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 01:38:58 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id t10so147332118edd.12
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 01:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680770337;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7nj6lShTEvYqydEKX2tOxyEA5pb382cptQm/N5/c1yo=;
        b=VrFSJKYeWtu+HAEk5djFWGbjjFuFkZyd+NkzW4nCgRcPw9hG9YR/ovYZBxuyEjbg8g
         PM5Gq8CfR9myxbEQiHnjo8HSUlBNB++lY19UcjIVHz87kMpqtieIYdKmc+7+enYD09nz
         O4E5ajY78bexHoEXVyBw47t4LQ/1o+Oa0TyuNfvn0+GEbmzZoochkYmEEeQET/oVPdFU
         9XtcDooA4uUZHpdQkQZm3WKXU8TBBqJiwtfvPFP7RlnpTbT+wzsOjjOG17nMbJkeQzLU
         B71e2ejQQsPuRsvB2GHPSkVf4jmjunIUY5PwUdiam26DruHsjIY0a9GzM/l9zfIGTab3
         ci6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680770337;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nj6lShTEvYqydEKX2tOxyEA5pb382cptQm/N5/c1yo=;
        b=HIxlllAyLayGCtk0MxuK8qYraHMesoFw5/IFaEFQJRr+OvQUTXesrTlHL7QMWz/u+B
         xmJ6bk2etfX2i6Y0iz45whG3AT+Pg9zc0fMBh8iPE1J3tn3KQlMB85Zu4t3t7dEbptuI
         hn2d+CmCVPkk2/hUWjuIZ73KqcY2JDEG4atjaiqYyTthrn3CX/DLoF1EAzJEV+LHP3xx
         z0Y+lEpvpRsU2JrkHeMj1pZt7HXDx45q7I2/J1cIgKpaM0diRFOxBRhMoO7PpKz8aaLD
         fhnyASR+N6HN3Op+IE6WWb3SblUOnWlzCXMYpruLRsUzCyKDg56eqRSmPJiRMQJKda60
         mMpg==
X-Gm-Message-State: AAQBX9ds2ufJ2EK30YMVWSxtWP1PtyAlkOv9HV/F3DOZ/0xHHZCsT+8y
        IZh+hIR4vaUV9c+0Q2tEVqOn7RMv6kY=
X-Google-Smtp-Source: AKy350YQfrAIhoqlpCUrdo6TlRom18TRaUNZdSLOuArzFjjEgVMkONRZytwgRVLLlZxNGiAib6nakg==
X-Received: by 2002:a17:906:edc5:b0:7e0:eed0:8beb with SMTP id sb5-20020a170906edc500b007e0eed08bebmr6231644ejb.41.1680770336919;
        Thu, 06 Apr 2023 01:38:56 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id f13-20020a170906c08d00b0092f289b6fdbsm497132ejz.181.2023.04.06.01.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 01:38:56 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pkL8x-005Oz8-3D;
        Thu, 06 Apr 2023 10:38:56 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/6] t1300: don't create unused files
Date:   Thu, 06 Apr 2023 10:38:00 +0200
References: <20230401212858.266508-1-rybak.a.v@gmail.com>
 <20230403223338.468025-1-rybak.a.v@gmail.com>
 <20230403223338.468025-4-rybak.a.v@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230403223338.468025-4-rybak.a.v@gmail.com>
Message-ID: <230406.86pm8htnfk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 04 2023, Andrei Rybak wrote:

> Three tests in t1300-config.sh check that "git config --get" barfs when
> syntax errors are present in the config file.  The tests redirect
> standard output and standard error of "git config --get" to files,
> "actual" and "error" correspondingly.  They assert presence of an error
> message in file "error".  However, these tests don't use file "actual"
> for assertions.
>
> Don't redirect standard output of "git config --get" to file "actual" in
> t1300-config.sh to avoid creating unnecessary files.
>
> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> ---
>  t/t1300-config.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index d566729d74..8ac4531c1b 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -1575,7 +1575,7 @@ test_expect_success 'barf on syntax error' '
>  	[section]
>  	key garbage
>  	EOF
> -	test_must_fail git config --get section.key >actual 2>error &&
> +	test_must_fail git config --get section.key 2>error &&
>  	test_i18ngrep " line 3 " error
>  '
>  
> @@ -1585,7 +1585,7 @@ test_expect_success 'barf on incomplete section header' '
>  	[section
>  	key = value
>  	EOF
> -	test_must_fail git config --get section.key >actual 2>error &&
> +	test_must_fail git config --get section.key 2>error &&
>  	test_i18ngrep " line 2 " error
>  '
>  
> @@ -1595,7 +1595,7 @@ test_expect_success 'barf on incomplete string' '
>  	[section]
>  	key = "value string
>  	EOF
> -	test_must_fail git config --get section.key >actual 2>error &&
> +	test_must_fail git config --get section.key 2>error &&
>  	test_i18ngrep " line 3 " error
>  '

Ditto my comment on 1/6, shouldn't we instead be doing e.g.:
	
	diff --git a/t/t1300-config.sh b/t/t1300-config.sh
	index 2575279ab84..df2070c2f09 100755
	--- a/t/t1300-config.sh
	+++ b/t/t1300-config.sh
	@@ -1575,7 +1575,8 @@ test_expect_success 'barf on syntax error' '
	 	[section]
	 	key garbage
	 	EOF
	-	test_must_fail git config --get section.key >actual 2>error &&
	+	test_must_fail git config --get section.key >out 2>error &&
	+	test_must_be_empty out &&
	 	test_i18ngrep " line 3 " error
	 '
	 
I.e. before this we had no coverage on the error being the only output,
but seemingly by mistake. Let's just assert that, rather than dropping
the redirection entirely, no?
