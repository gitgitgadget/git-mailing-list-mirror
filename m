Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC588C761A6
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 19:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjC3TUn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 15:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbjC3TUC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 15:20:02 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA7811167
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 12:19:36 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l7so18216168pjg.5
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 12:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680203976;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Vng7dFAy/Yeyt9O3zuKOkWYM59K6oefFo9/Jjl4hEM=;
        b=nwnoNmqRyT7uPgDUf1J8VJDMMgSsB7AX1smct+cv+Ng1iU9wmZAywSorEY0A4iFI90
         9XzKdsXQvgUD9FG6YDrZ7mmWT/iidbgISK/bAEFjM9+z5g3LxEnGF0qB3qMDh25oGdU+
         XYrwkCM9/NVdH8Dx9YZjVKvSLLyV7wj7fUnOO7PL/vZKoE7Z5YxqOL3tYCk8xWNpLtoC
         bDw3F6rNlErJ/DhjrRH6Oy4b7c3+pL9uF1Axh4ceuGiBmKdBhdkdZZlBopZW1VeN6LjN
         wOr0GRfLGe9ukpduMOtIvml9KxQj1vjBFik6q2C5VmL3l1nrncMUMan3eenaJQF9RANR
         Mg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680203976;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5Vng7dFAy/Yeyt9O3zuKOkWYM59K6oefFo9/Jjl4hEM=;
        b=A2dI2Vm5joRavS3rhaTZUcj2xlppqmECGEDniyBZzDdnGEL3qNSqCVDZZaVBfe59tV
         ZnVvUH3W5YBhXCGiCg+WBtfct0GFykqDuvImMMqyZKiyZzlhTj1aR07UM81cKjXvPoWc
         8zhIl12+VowGaXBeIMcRS8yT982MaXr8iHNAFJcBIxUyl4jpXtkX2soCwis4kKBafULz
         WXmeHZv8FMsZPnIW/JzRmaFDqtBiGp2Z8DHpZSm49UkEi8BGEe7Czvs0wLKNLn+Kf5ew
         XzOIpVUO0IuUP1MJgW5rYxJstoNxYmbtRp21m/SsoJeR1fU/nBS71/4FetTFBOFgx9Jg
         cn1w==
X-Gm-Message-State: AO0yUKWZsUHHtkN3vxWzXjnfmXY9s+yUpa3SQ0Y4gixOxru2LHQvghau
        2ay89LGu8JoMpHJrhcnft6Y=
X-Google-Smtp-Source: AK7set+fcXVKn/cAe1wyJq7LUHvjPTFJ/cE+diRgBDETFwfa3pbva5cRxkuOMUIDY9F5OP1dypxWIQ==
X-Received: by 2002:a05:6a20:a89c:b0:d6:f3dd:5a88 with SMTP id ca28-20020a056a20a89c00b000d6f3dd5a88mr21269985pzb.5.1680203975736;
        Thu, 30 Mar 2023 12:19:35 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id u20-20020aa78494000000b0062dd6c69519sm230217pfn.115.2023.03.30.12.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 12:19:35 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "Johannes Schindelin [ ]" <Johannes.Schindelin@gmx.de>,
        "Johannes Sixt [ ]" <j6t@kdbg.org>,
        "Harshil Jani [ ]" <harshiljani2002@gmail.com>,
        Jakub =?utf-8?B?QmVy?= =?utf-8?B?ZcW8YcWEc2tp?= 
        <kuba@berezanscy.pl>, Karsten Blees <blees@dcon.de>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Javier Roucher Iglesias 
        <Javier.Roucher-Iglesias@ensimag.imag.fr>,
        M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH v2] credential/wincred: store password_expiry_utc
References: <pull.1477.git.git.1679729956620.gitgitgadget@gmail.com>
        <pull.1477.v2.git.git.1680200278780.gitgitgadget@gmail.com>
Date:   Thu, 30 Mar 2023 12:19:35 -0700
In-Reply-To: <pull.1477.v2.git.git.1680200278780.gitgitgadget@gmail.com>
        (M. Hickford via GitGitGadget's message of "Thu, 30 Mar 2023 18:17:58
        +0000")
Message-ID: <xmqqo7oahws8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"M Hickford via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: M Hickford <mirth.hickford@gmail.com>
>
> This attribute is important when storing OAuth credentials which may
> expire after as little as one hour. See
> https://github.com/git/git/commit/d208bfdfef97a1e8fb746763b5057e0ad91e283b

Readers do not have to visit GitHub at all, and proposed log message
shouldn't force them to.  Refer to an existing commit in this
project like so instead:

    ... as one hour.  d208bfdf (credential: new attribute
    password_expiry_utc, 2023-02-18) added support for this
    attribute in general so that individual credential backend like
    wincred can use it.

>     Help wanted from a Windows user to test. I tried testing on Linux with
>     Wine after cross-compiling [1] but Wine has incomplete support for
>     wincred.h [2]. To test:

I cannot be one to help testing but ...

> @@ -292,7 +313,7 @@ int main(int argc, char *argv[])
>  	    "usage: git credential-wincred <get|store|erase>\n";
>  
>  	if (!argv[1])
> -		die(usage);
> +		die("%s", usage);

... this is a nice one.  Logically it may belong to a separate
topic, but it is small and obvious enough that it is OK to do as a
"while at it" clean-up.
