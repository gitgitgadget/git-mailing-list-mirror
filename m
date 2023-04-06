Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025F1C76196
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 08:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbjDFInX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 04:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236103AbjDFInV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 04:43:21 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7F365A9
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 01:43:18 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ew6so147398570edb.7
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 01:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680770597;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2HYpHjkapDVgou/IT6WO4JGoti7R9Ay/8Ykr+Tc3aho=;
        b=OnFJWoHBemVVFH1lJ24HGgjaxrO6LtwxiEHFgla0955dCmH8wRvt3V3RVfiYNmg5fv
         wHnmvTJTslndN8i0H7a17X4+llBnDVlIqYc3lvmYPwZKIVR9fMyzvT3368aNL3GgFM6W
         NHy8Jfw33eI+ie1iV4XhfN2ei2BeEQsBzGkHEz3Qg8ST0WovNsccM2KHZs7cPSjjbxRg
         xro4BkFCEBf1UBTL2XiFBYxbxRKUihJn6t8PnDpu3DYTIzoNotPXrwJgwxjGgAR6JFfS
         TOv4ouSgY97jYSBVTmUx1GY9OJpO+SKC/fUjt0LmiolRFEJLVZuyay8LDBMdqda9/X88
         CmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680770597;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HYpHjkapDVgou/IT6WO4JGoti7R9Ay/8Ykr+Tc3aho=;
        b=23edJBPgg0295RXuZNpiiOLV2NL2U0ZCd/SDmXyQxi7ghA89IdHoNJ/yzmFj/6QFt7
         SKyyUR1KdB3V58FcHiqITNuT6plfAkRgbu5B9lQoqkCd0LNUIp1aRH96WFnFdbGZHWUx
         y2Go71ppJ8MQI1LAbqXYYO/XlZJ2ke3FRI8HFuMowy4vkEJF1kaRDIfMlJgBBJ1+oLfx
         Zf61AgGzH/rYqMH373dbf3bra4JatmUkK4Y25xDeiiONHgkAor7h7dRq3Ok3MVTkCroj
         KhTJVfKPWaW10o345GeUyJbyhPeLiLyt9eE4h04J4GmstGw/8ug9jXc2yLkCujuGJ1uZ
         YUMA==
X-Gm-Message-State: AAQBX9dMHVD6aKd3g5ufuvdUeUtbEl3r1FMKMitpIsegwJON9U5++EAl
        TIb55jFezO9dP9iHv46v1Ukzo/CJRZA=
X-Google-Smtp-Source: AKy350aHEVjlwYmjot2BJKtZSEhx+ye1I4JrF0HWMhLBY5gjer3qGy9QGDrLFQJ2kXlmNvZ8PGsXCQ==
X-Received: by 2002:a17:906:2319:b0:92e:efa:b9b4 with SMTP id l25-20020a170906231900b0092e0efab9b4mr6295808eja.22.1680770596829;
        Thu, 06 Apr 2023 01:43:16 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id n20-20020a170906725400b0093295ea18c4sm515598ejk.67.2023.04.06.01.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 01:43:16 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pkLD9-005P8d-2F;
        Thu, 06 Apr 2023 10:43:15 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/6] t1450: don't create unused files
Date:   Thu, 06 Apr 2023 10:41:24 +0200
References: <20230401212858.266508-1-rybak.a.v@gmail.com>
 <20230403223338.468025-1-rybak.a.v@gmail.com>
 <20230403223338.468025-5-rybak.a.v@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230403223338.468025-5-rybak.a.v@gmail.com>
Message-ID: <230406.86lej5tn8c.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 04 2023, Andrei Rybak wrote:

> Test 'fsck error and recovery on invalid object type' in file
> t1450-fsck.sh redirects output of a failing "git fsck" invocation to
> files "out" and "err" to assert presence of error messages in the output
> of the command.  Commit 31deb28f5e (fsck: don't hard die on invalid
> object types, 2021-10-01) changed the way assertions in this test are
> performed.  The test doesn't compare the whole standard error with
> prepared file "err.expect" and it doesn't assert that standard output is
> empty.

That's my commit, and thanks for catching this...

> Don't create unused files "err.expect" and "out" in test 'fsck error and
> recovery on invalid object type'.
>
> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> ---
>  t/t1450-fsck.sh | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> index bca46378b2..8c442adb1a 100755
> --- a/t/t1450-fsck.sh
> +++ b/t/t1450-fsck.sh
> @@ -989,10 +989,7 @@ test_expect_success 'fsck error and recovery on invalid object type' '
>  
>  		garbage_blob=$(git hash-object --stdin -w -t garbage --literally </dev/null) &&
>  
> -		cat >err.expect <<-\EOF &&
> -		fatal: invalid object type
> -		EOF
> -		test_must_fail git fsck >out 2>err &&
> +		test_must_fail git fsck 2>err &&
>  		grep -e "^error" -e "^fatal" err >errors &&
>  		test_line_count = 1 errors &&
>  		grep "$garbage_blob: object is of unknown type '"'"'garbage'"'"':" err

...but ditto my review on other patches, this just seems like a mistake
of mine, i.e. if I add the "test_must_be_empty out" the test passes.

So isn't the answer here that my 31deb28f5e had an unintentional
regression, and we should bring the assertion back? Its commit message
says nothing about wanting to stop asserting stdout.

Maybe there was a reason I'm missing for why I remved it, it's since
been paged out of my wetware, but looking at it briefly now it just
seems like an unintentional bug / loss of test coverage that we should
fix.
