Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01604C433DB
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 11:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4D7F61938
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 11:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhC1LvV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 07:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhC1LvU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 07:51:20 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A73C061762
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 04:51:20 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id v10so7608749pgs.12
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 04:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2GV3vN0Jusoktw3WS6JoFbnGF90X6ycgUyEnzABsYVA=;
        b=cENczZFNPe/uL9KVWRtG6rdS9Of/o+cqGxZXlksHUKkmjQEW/LzAqx5jxSUMWtc3fy
         xV6zhFN7kWB33aMvAOrMb5lf+0Xc+5EDLpwPrQYbcPOtGQD2R8GzeYN3OsoNdsL19qwu
         VUs3WXz9VJf31eGTQzNM61fGtpbqqo7yD9DpvAYKeruiUhwgfft8xoiRP2WM2wmIc57F
         jZEk8nF4ccyVHp8kUoFYJjrDwAYljoxFhA4uckcONgAQ0pwnUfqrIksOISkQUT2QG8SN
         +sYMsrBW32ha9KrXUaWVINyAbbOLd1vuJQVqYYFzBukaf9QaMV6uV7xxHwxQV8xm5WEx
         SeCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2GV3vN0Jusoktw3WS6JoFbnGF90X6ycgUyEnzABsYVA=;
        b=oFgpsCtWXHZdXKM2ecbnx1z5ghNzdqm/ZvUT0+MIg0848bwmbmX6BQZN+TKv7RxNLV
         7Qfj72jBmSePoKYsFRKr9LHCYx+T7O5Ic5eUn8FO5wItPHTgCBBrhRyf1KvnFOV1e5Mz
         0A58fPy505ftKysVdyRMpS9s2+RKhr25K2NCNm8viL2GcQSETEYi9wbSxkYAfnp7H+gp
         21MdZThEVemkb8uVFWSHpgBnYRxcHjXoVJT1+LuZYfkQTDg8RDMxkdP4XJ7OUHGboL3G
         8W2QFhbCsNhTg565LZi572OHZ4Ge9axmDDaGP9gM8rltZJQ4U1WdNvaIcmygyD+uIfjW
         WBWw==
X-Gm-Message-State: AOAM533RwthO5fJ2By93jEQTPhFTrCPaPZVxz3QkJYyC0PCz4ZjCp8VH
        fbzDcA+c3vdAz1AGYPVForihn5JMS4sNdg==
X-Google-Smtp-Source: ABdhPJwoe+AtTdQkyTTsmUu15qT3bbe4vkfRCr3gf1WCcE1vV+IYAawE/+0ysyVdl2WH+HhvTuTNIQ==
X-Received: by 2002:aa7:8f04:0:b029:1f7:d71b:6a51 with SMTP id x4-20020aa78f040000b02901f7d71b6a51mr20798455pfr.4.1616932279496;
        Sun, 28 Mar 2021 04:51:19 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.121.20])
        by smtp.gmail.com with ESMTPSA id g3sm12771636pfk.186.2021.03.28.04.51.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Mar 2021 04:51:19 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [GSOC][PATCH] userdiff: add support for Scheme
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <xmqq5z1cqki7.fsf@gitster.g>
Date:   Sun, 28 Mar 2021 17:21:16 +0530
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EBC020E6-BE8B-4332-8225-A988CB7CFA69@gmail.com>
References: <20210327173938.59391-1-raykar.ath@gmail.com>
 <xmqq5z1cqki7.fsf@gitster.g>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28-Mar-2021, at 04:20, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Atharva Raykar <raykar.ath@gmail.com> writes:
>=20
>> diff --git a/t/t4018/scheme-define-syntax =
b/t/t4018/scheme-define-syntax
>> new file mode 100644
>> index 0000000000..603b99cea4
>> --- /dev/null
>> +++ b/t/t4018/scheme-define-syntax
>> @@ -0,0 +1,8 @@
>> +(define-syntax define-test-suite RIGHT
>> +  (syntax-rules ()
>> +    ((_ suite-name (name test) ChangeMe ...)
>> +     (define suite-name
>> +       (let ((tests
>> +              `((name . ,test) ...)))
>> +         (lambda ()
>> +           (ChangeMe 'suite-name tests)))))))
>> \ No newline at end of file
>=20
> Is there a good reason to leave the final line incomplete?  If there
> isn't, complete it (applies to other newly-created files in the =
patch).

Will do.

>> diff --git a/userdiff.c b/userdiff.c
>> index 3f81a2261c..c51a8c98ba 100644
>> --- a/userdiff.c
>> +++ b/userdiff.c
>> @@ -191,6 +191,14 @@ PATTERNS("rust",
>> 	 "[a-zA-Z_][a-zA-Z0-9_]*"
>> 	 "|[0-9][0-9_a-fA-Fiosuxz]*(\\.([0-9]*[eE][+-]?)?[0-9_fF]*)?"
>> 	 =
"|[-+*\\/<>%&^|=3D!:]=3D|<<=3D?|>>=3D?|&&|\\|\\||->|=3D>|\\.{2}=3D|\\.{3}|=
::"),
>> +PATTERNS("scheme",
>> +         "^[\t ]*(\\(define-?.*)$",
>=20
> Didn't "git diff HEAD" before committing (or "git show") highlighted
> these whitespace errors?
>=20
> .git/rebase-apply/patch:183: indent with spaces.
>         "^[\t ]*(\\(define-?.*)$",
> .git/rebase-apply/patch:184: trailing whitespace, indent with spaces.
>         /*=20
> .git/rebase-apply/patch:185: indent with spaces.
>          * Scheme allows symbol names to have any character,
> .git/rebase-apply/patch:186: indent with spaces.
>          * as long as it is not a form of a parenthesis.
> .git/rebase-apply/patch:187: indent with spaces.
>          * The spaces must be escaped.
> warning: squelched 2 whitespace errors
> warning: 7 lines applied after fixing whitespace errors.

It did highlight the spaces (which I accidentally overlooked), but I
didn=E2=80=99t receive these warnings. It shows up with the --check flag =
though.
I'll recheck my configuration. Thanks for pointing this out.

>=20
>> +         /*=20
>> +          * Scheme allows symbol names to have any character,
>> +          * as long as it is not a form of a parenthesis.
>> +          * The spaces must be escaped.
>> +          */
>> +         "(\\.|[^][)(\\}\\{ ])+"),
>=20
> One or more "dot or anything other than SP or parentheses"?  But
> a dot "." is neither a space or any {bra-ce} letter, so would the
> above be equivalent to
>=20
> 	"[^][()\\{\\} \t]+"
>=20
> I wonder...

A backslash is allowed in scheme identifiers, and I erroneously thought =
that
the first part handles the case for identifiers such as `component\new` =
or=20
`\"id-with-quotes\"`. (I tested it with a regex engine that behaves =
differently
than the one git is using, my bad.)

> I am also trying to figure out what you wanted to achieve by
> mentioning "The spaces must be escaped.".  Did you mean something
> like (string->symbol "a symbol with SP in it") is a symbol?  Even
> so, I cannot quite guess the significance of that fact wrt the
> regexp you added here?

I initially tried using identifiers like `space\ separated` and they
seemed to work in my REPL, but turns out space separated identifiers in
scheme do not work with backslashes, and it was working because of the =
way
my terminal handled escaping. Space separated identifiers are declared =
like
`|space separated|` and this too only seems to work with Racket, not
the other Scheme implementations. So I stand corrected here, and it's =
better
to drop this feature altogether.

But somehow, the regexp you suggested, ie:

	"[^][()\\{\\} \t]+"

does not handle the case of make\foo -> make\bar (it will only diff on =
foo).
I am not too sure why it treats backslashes as delimiters.

This seems to actually do what I was going for:

	"(\\\\|[^][)(\\}\\{ ])+"

> As we are trying to catch program identifiers (symbols in scheme)
> and numeric literals, treating any group of non-whitespace letters
> that is delimited by one or more whitespaces as a "word" would be a
> good first-order approximation, but in addition, as can be seen in
> an example like (a(b(c))), parentheses can also serve as such "word
> delimiters" in addition to whitespaces.  So the regexp given above
> makes sense to me from that angle, especially if you do not limit
> the whitespace to only SP, but include HT (\t) as well.  But was
> that how you came up with the regexp?

Yes, this is exactly what I was trying to express. All words should be
delimited by either whitespace or a parenthesis, and all other special
characters should be accepted as part of the word.=
