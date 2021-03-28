Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8F8C433C1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 12:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78CE661969
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 12:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhC1Mpw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 08:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhC1MpK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 08:45:10 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427F0C061762
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 05:45:10 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id e14so3104745plj.2
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 05:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VX1ZlbH7ygQfBIeqALBi6bourtgEPqHryIUM33YuFdg=;
        b=qYoYF7QRayux0P5g8zNUyJj9NJa0mL9hRkqdDaSFBM/q31vWrw6zCzqs+4xkTY3uhR
         tDqte5oKf4F8G4Ry+iyw7ib+pT0Jh+H3CFT6GOghtljt59wObbhPSY4HUQHA6FVcaY76
         aeUJJn9og4c9dd0RRntlgzW1ZR9u36Y1uahmc5/z4GBKbyhMktUuXelshJvWnYK6ITja
         V1H5X3ADqfNxMPde+harhkC+67kYvOBw5delH54Y6XaUWt3aOH3zLsvFJ6EsBWQLkmfz
         eiTjOjCWsk6K+uA8VWvvBDAqc4KcBBH9vWzV36w7UCErgBt8f6zkOtaILwehf2wL8Cia
         m+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VX1ZlbH7ygQfBIeqALBi6bourtgEPqHryIUM33YuFdg=;
        b=HPQWwIzfClOihwXPITaxQ1SwiE2z6MBP4SmHbhP3cMHgNP9mpLP+JCmV8XldWgPuM9
         vPrJErK8aGfUHJzvgZ8sxIcqBgTc9pGgwCNzXOjKeb6MVzRspzyM29euIVSKVVjGLnKN
         APyCrHuniQBCCpElAu7+z2VAeLVy9UyzjcP6Gm1kyvD/WhPwvoJCKH9FTj8GyMatuwN+
         0oc3xUuYlJEnKum30BRFlEKjeJUb+XsWlpPpX8UZKu1JiYtsJMmCDDpPOFVMtn/cr7hX
         26/X9kp3PCB+h3wnF+lEzktSq8veJuJRTH+RAXJQMMBZ9hRcM1JpgcFlXhsAJi2gJ1uV
         9MCA==
X-Gm-Message-State: AOAM532h+nFWF/+pCHkAy1SLjRlWgBaH6G4ouzbZZ3l1JzjAVGE1gzV8
        Re0DaOU7j0mPKaS5O8eC6aY=
X-Google-Smtp-Source: ABdhPJwq2M7pb7FZz7fjuN3dMjPLD1373K5awmFbjJ94Dmo3zNMit+JJRrHfrOUBNjbAcUdSeo+kMQ==
X-Received: by 2002:a17:902:cf83:b029:e7:3751:f308 with SMTP id l3-20020a170902cf83b02900e73751f308mr7055762ply.17.1616935509796;
        Sun, 28 Mar 2021 05:45:09 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.121.20])
        by smtp.gmail.com with ESMTPSA id z8sm13334155pjd.0.2021.03.28.05.45.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Mar 2021 05:45:09 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [GSOC][PATCH] userdiff: add support for Scheme
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <xmqq1rc0qjn1.fsf@gitster.g>
Date:   Sun, 28 Mar 2021 18:15:06 +0530
Cc:     git@vger.kernel.org, j6t@kdbg.org, avarab@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <166B3835-32C3-4CE6-9799-C187284E5756@gmail.com>
References: <20210327173938.59391-1-raykar.ath@gmail.com>
 <xmqq5z1cqki7.fsf@gitster.g> <xmqq1rc0qjn1.fsf@gitster.g>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28-Mar-2021, at 04:39, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Junio C Hamano <gitster@pobox.com> writes:
>=20
>> Atharva Raykar <raykar.ath@gmail.com> writes:
>> ...
>>> +           (ChangeMe 'suite-name tests)))))))
>>> \ No newline at end of file
>>=20
>> Is there a good reason to leave the final line incomplete?  ...
>> I am also trying to figure out what you wanted to achieve ...
>=20
> Taking all of them together, here is what I hope you may agree as
> its improved version.  The only differences from what you posted are
> corrections to all the "\ No newline at end of file" and the =
simplification
> of the pattern (remove "a dot" from the alternative and add \t next
> to SP).  Without changes, the new tests still pass so ... ;-)
>=20
>    diff --git c/userdiff.c w/userdiff.c
>    index 5fd0eb31ec..685fe712aa 100644
>    --- c/userdiff.c
>    +++ w/userdiff.c
>    @@ -193,12 +193,8 @@ PATTERNS("rust",
>             =
"|[-+*\\/<>%&^|=3D!:]=3D|<<=3D?|>>=3D?|&&|\\|\\||->|=3D>|\\.{2}=3D|\\.{3}|=
::"),
>     PATTERNS("scheme",
>             "^[\t ]*(\\(define-?.*)$",
>    -	 /*
>    -	  * Scheme allows symbol names to have any character,
>    -	  * as long as it is not a form of a parenthesis.
>    -	  * The spaces must be escaped.
>    -	  */
>    -	 "(\\.|[^][)(\\}\\{ ])+"),
>    +	 /* whitespace separated tokens, but parentheses also can =
delimit words */
>    +	 "([^][)(\\}\\{ \t])+"),
>     PATTERNS("bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ =
\t\"@',\\#}{~%]*).*$",
>             "[=3D{}\"]|[^=3D{}\" \t]+"),
>     PATTERNS("tex", =
"^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",

Thanks for these. I will eventually send another patch with the =
whitespaces corrected,
and try to see if there is a better way to handle backslashes, other =
than the regex I
suggested. I will also be writing another test case to check that case =
properly.

I will also incorporate the other changes suggested by Johannes and =
=C3=86var as well,
My regex was not supposed to capture forms like `defined-thing`. And =
there are a
few rough edges with some of my test cases, which I will correct as well =
in the next
patch. It is also worth spending some more time and see if there is any =
other form other
than definitions that a Scheme programmer other than myself may be =
interested in. I will
consult a few Scheme communities and mailing lists and see what more =
experienced
programmers have to say.=
