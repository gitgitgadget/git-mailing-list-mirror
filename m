Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EF5C4332F
	for <git@archiver.kernel.org>; Sat, 17 Dec 2022 00:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiLQAdG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 19:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLQAdF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 19:33:05 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7AA18B1C
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 16:33:04 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id m4so3877646pls.4
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 16:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LqhkDSHzqRglY2Q/gN6RUAJeyXAt+nkJ9Bn8qUwiZzc=;
        b=etPHFxys8GOm26hcjp5ew1YFjeN9E2GWyqndyKKvWHGDgSedI3aHXkqWQDV7oTT22K
         QeU0rHdRruf18Qd5Jzz7eQagXNJ5/P/VSDG9jKkJBT4lEsO9NH4i290b1AaXZYaewAvC
         ioxil3XKU6HmXa4pRwpJRq7drLpa/RvLM6q/GvoYc9X7+0bV+0zCKSPknyBWR2m2qnbs
         faDD1JTdzeia85jILzZ84m53wzWx0c5BJz9raEz4PTqOJpD/9E95tLPLcljRhmDbCsIY
         moafJ4+SCFSVarm44D4s3iTMEOoYaFgwUhpWS/23hASzmb8hiYV2WDFU5KOYr+IR/0gF
         Zf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LqhkDSHzqRglY2Q/gN6RUAJeyXAt+nkJ9Bn8qUwiZzc=;
        b=uJvRxwcFCJvo4lh2mNBuhv8zToarq1gg/FsD+4zP3bGeyg3ou64I1+NA3449ONe8x0
         90QmOL3PnXGGNnLUEid1q89cwMWKlya85YhXHuhdTG0aYdzQm9fV2vY/trqdmZJzdK0f
         uS87Y4otrkqwcFXA6XanxcBk0iBsuZurcR/3V6mxT8dViDPuZmBh36oJXI6yHYpp2aAS
         gvjfEN+WwrWxRx818Bch7wJEs8gqlWbnGTkEimc6rIlwzhD6PrqlWBm2WfDGHDGFs00f
         1ues7XKtnPI17ZfLijk/B+HWT2VL9O9tsAmQX42bJelfQtcL8SAYbfNx3skvKe4KtNES
         /Tbw==
X-Gm-Message-State: ANoB5pnXJMV+Ems2qLi7zwsvWo0E0GDm4bOwdPHPmyw9EzoHKa6AJzHw
        aUfpma91TIKMEvW8PEZ4FAY=
X-Google-Smtp-Source: AA0mqf4xBZtAKFtcwmuiwz1YaYMeF4v4Iyr1eYFf7jFeafZB0gD5ICSAkvULnEDo7Yr/XHy+iPWYGw==
X-Received: by 2002:a17:90a:1987:b0:221:4b19:4d8 with SMTP id 7-20020a17090a198700b002214b1904d8mr25052994pji.6.1671237183705;
        Fri, 16 Dec 2022 16:33:03 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id e13-20020a17090a728d00b0021894e92f82sm1829270pjg.36.2022.12.16.16.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 16:33:03 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org, toon@iotcl.com
Subject: Re: [PATCH v3 2/2] attr: add flag `-r|--revisions` to work with
 revisions
References: <20221216093552.3171319-1-karthik.188@gmail.com>
        <20221216093552.3171319-3-karthik.188@gmail.com>
Date:   Sat, 17 Dec 2022 09:33:03 +0900
In-Reply-To: <20221216093552.3171319-3-karthik.188@gmail.com> (Karthik Nayak's
        message of "Fri, 16 Dec 2022 10:35:52 +0100")
Message-ID: <xmqqcz8ikgxs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/attr.c b/attr.c
> index 42ad6de8c7..99883024ec 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -11,8 +11,13 @@
>  #include "exec-cmd.h"
>  #include "attr.h"
>  #include "dir.h"
> +#include "git-compat-util.h"

Unneeded.  cf. Documentation/CodingGuidelines

 - The first #include in C files, except in platform specific compat/
   implementations, must be either "git-compat-util.h", "cache.h" or
   "builtin.h".  You do not have to include more than one of these.

and this file already begins with including "cache.h".

By the way,

    $ make
    $ cd t
    $ sh t0003-attributes.sh -i -x
    Initialized empty Git repository in /home/gitster/w/git.git/t/trash directory.t0003-attributes/.git/
    expecting success of 0003.1 'open-quoted pathname': 
            echo "\"a test=a" >.gitattributes &&
            attr_check a unspecified

    ++ echo '"a test=a'
    ++ attr_check a unspecified
    ++ attr_check_basic a unspecified
    ++ path=a
    ++ expect=unspecified
    ++ git_opts=
    ++ git check-attr test -- a
    t0003-attributes.sh: line 9: 1508946 Segmentation fault      git $git_opts check-attr test -- "$path" > actual 2> err
    error: last command exited with $?=139
    not ok 1 - open-quoted pathname
    #	
    #		echo "\"a test=a" >.gitattributes &&
    #		attr_check a unspecified
    #	
    1..1
    $ exit

there seems to be something fishy in this patch.

