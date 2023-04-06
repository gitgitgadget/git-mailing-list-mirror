Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA59C7618D
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 08:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbjDFIs0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 04:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235582AbjDFIsU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 04:48:20 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479BD59CD
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 01:48:19 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id er13so106518600edb.9
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 01:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680770897;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lFWQbKQhkpV7kNM/J9PFTnn7nlaMZ9kG2ATxgJjqaks=;
        b=hw26f9K8Y7jTs3X73UiTFm53uLZcZseWhzn6HLjo5w2LEnTLO+s6kOEajxyrjvbEfM
         4C56v+8oWOPeHW7Jh5F4EweAEDCJYbC2rjNUBcKYPL3owG4tyMDG5Bf4bwxeq7DL0kwc
         MpFR3IKdYClg19fWGB2HHIZHWOVHVZHHTcEDAYQAhEwQTsF7Hc4/4blb0+Y3DbMkf0yJ
         4nrPUBuMR6sCLVyXhJniQrOl6f6uGDnw0ZKaZ8Dy/jww+k1/Tnl1KW4T+4R25zi0jAL5
         vwn0DY0yuX3KDkrhpCbPBrnUSXCDC7AB0zONhNshZeOARFXROJpcdMricX6W3KIe0NEg
         kP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680770897;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFWQbKQhkpV7kNM/J9PFTnn7nlaMZ9kG2ATxgJjqaks=;
        b=rZdLdXbtvyC5zedEDbAjxoB4YbtzNlU7UJpwGwY1ryxaK51YidguAX9c7KZ5Jyb3SG
         nGk6zQIj1wwtIx6gf7GnZqZtloAcufBLM8OGhAdLEtjn9rygAleIOMMNsViPfvvFDIyr
         hmeJs3vDPFdohSKQOHDK2xpdBKNfxFHB4THk/XVgdwjsTUZQXISRqhqwaMzBzHTW/Cln
         SpTSsbFaQykkrJdJBt0iG899n3uEVVrr6fAXrmiZOqbKBADx7kqpuATIxBQ0TPzWMUgJ
         FmvGeLDjJeYd5F4pDOXJ6IixGJFXlAka3TFXZ+4sIpHlxOAU6fbmz1OfdaLUP7+R/7/k
         YVXg==
X-Gm-Message-State: AAQBX9dv+W919IetsDVYBeK91xzhcdk3hNFPcdKloiGI5xDVxKmAABVY
        PecPPC9QO85l1vYGDJWkkwD1zpzSa1o=
X-Google-Smtp-Source: AKy350aeFadpTn8eZX0O85L6DeRJiE45lU6p6nvK12x+C8Cf2XrDugzYWhU2jmkOXXY2hrIuLuWCUw==
X-Received: by 2002:a17:906:4913:b0:93b:1cc5:4a1 with SMTP id b19-20020a170906491300b0093b1cc504a1mr6312947ejq.40.1680770897416;
        Thu, 06 Apr 2023 01:48:17 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id gn20-20020a1709070d1400b00946e6dd887csm504545ejc.126.2023.04.06.01.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 01:48:17 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pkLI0-005PL2-25;
        Thu, 06 Apr 2023 10:48:16 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/6] t1502: don't create unused files
Date:   Thu, 06 Apr 2023 10:47:43 +0200
References: <20230401212858.266508-1-rybak.a.v@gmail.com>
 <20230403223338.468025-1-rybak.a.v@gmail.com>
 <20230403223338.468025-6-rybak.a.v@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230403223338.468025-6-rybak.a.v@gmail.com>
Message-ID: <230406.86cz4htmzz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 04 2023, Andrei Rybak wrote:

> Three tests in file t1502-rev-parse-parseopt.sh use three redirections
> with invocation of "git rev-parse --parseopt --".  All three tests
> redirect standard output to file "out" and file "spec" to standard
> input.  Two of the tests redirect standard output a second time to file
> "actual", and the third test redirects standard error to file "err".
> These tests check contents of files "actual" and "err", but don't use
> the files named "out" for assertions.  The two tests that redirect to
> standard output twice might also be confusing to the reader.
>
> Don't redirect standard output of "git rev-parse" to file "out" in
> t1502-rev-parse-parseopt.sh to avoid creating unnecessary files.
>
> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> ---
>  t/t1502-rev-parse-parseopt.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
> index de1d48f3ba..dd811b7fb4 100755
> --- a/t/t1502-rev-parse-parseopt.sh
> +++ b/t/t1502-rev-parse-parseopt.sh
> @@ -302,14 +302,14 @@ test_expect_success 'test --parseopt help output: "wrapped" options normal "or:"
>  	|EOF
>  	END_EXPECT
>  
> -	test_must_fail git rev-parse --parseopt -- -h >out <spec >actual &&
> +	test_must_fail git rev-parse --parseopt -- -h <spec >actual &&
>  	test_cmp expect actual
>  '
>  
>  test_expect_success 'test --parseopt invalid opt-spec' '
>  	test_write_lines x -- "=, x" >spec &&
>  	echo "fatal: missing opt-spec before option flags" >expect &&
> -	test_must_fail git rev-parse --parseopt -- >out <spec 2>err &&
> +	test_must_fail git rev-parse --parseopt -- <spec 2>err &&
>  	test_cmp expect err
>  '
>  
> @@ -339,7 +339,7 @@ test_expect_success 'test --parseopt help output: multi-line blurb after empty l
>  	|EOF
>  	END_EXPECT
>  
> -	test_must_fail git rev-parse --parseopt -- -h >out <spec >actual &&
> +	test_must_fail git rev-parse --parseopt -- -h <spec >actual &&
>  	test_cmp expect actual
>  '

Ditto earlier comments: When we fail, we should assert what we emitted
on stdout, surely this should also be a "test_must_be_empty out".

(I didn't test that, but if that fails wes hould be testing whatever it
is that we emit here, surely..)
