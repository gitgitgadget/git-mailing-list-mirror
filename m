Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D25C19F2A
	for <git@archiver.kernel.org>; Sat, 30 Jul 2022 20:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbiG3UWN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jul 2022 16:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiG3UWL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jul 2022 16:22:11 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FDF13DCB
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 13:22:10 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id fy29so13839482ejc.12
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 13:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Kd3Ksz7NhX309xAXCHw6GoI8P5f/cF64Rzop4NVMsjk=;
        b=D4b/SJvy2uQKhIPD23kciNEbx5gZJPiHOTpjD2T8/dT14a7dAoXwYWGZJ2BHlUJmi2
         Q/0D6PytcLECAiejWvUWwe2TQoMpqgN8ZdfoBFWQUT4inziseKJwaqVY+Fb92hbyhhdQ
         4VBza2mDlzUVjcJXSK7xy0I+XOQHGqOpTSrxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Kd3Ksz7NhX309xAXCHw6GoI8P5f/cF64Rzop4NVMsjk=;
        b=QbUgskSN7f3JE9xuPyX74UAITwp4dBXhAZaGqfI28tYaceFimPfnUZ1CxlAnUmfrBU
         dEeJdNx3hWMRJO2uzWV/LPjilIRn0EfwoJTgBY6wPlzjQ7F5fTGvEx05dhk5legwgimc
         kCz7/e4PCmME+2qe5NrQJQ0aLjLMTewy/yYUe9P0ZnQaPfVTELbWVvNNUP40C98lOifI
         QtYUEorB9v9N0DWI7mI+QJMq8BxqVsEEZx+RSS9PYwgh0KPCGNoJ+2airak3tIkzgU+z
         T26UfMbHZobG5EZutB8tQlzhBJHTAALK9HwsxQLWgfWFc/iIzQFIdwfwT74QXVZ50Zln
         y1HQ==
X-Gm-Message-State: AJIora/bnvG/xgCRVozf8P3CbuqU611BoAbwJD9YlLgD2AcpPeYyMhKI
        LKIYI0iB8E4eM6PhpjVuRrnjsyTtpFAYrsO0
X-Google-Smtp-Source: AGRyM1tAoHh5pAazpDgAnedVu6Vkh9LDb/HX2s/LO+NkGw+ktDFfqkZRaCoahReTpjcU9IJsYtLk4w==
X-Received: by 2002:a17:907:7fa7:b0:72e:f88c:db16 with SMTP id qk39-20020a1709077fa700b0072ef88cdb16mr7184127ejc.366.1659212528150;
        Sat, 30 Jul 2022 13:22:08 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id k10-20020a05640212ca00b0043a7c24a669sm4302791edx.91.2022.07.30.13.22.07
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Jul 2022 13:22:07 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id bn9so9637017wrb.9
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 13:22:07 -0700 (PDT)
X-Received: by 2002:a05:6000:1a88:b0:21d:aa97:cb16 with SMTP id
 f8-20020a0560001a8800b0021daa97cb16mr6006929wry.97.1659212527017; Sat, 30 Jul
 2022 13:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh9f0EmsNFgoxUa8BzVej06+7MbLr-MLBjDjtj_=Pf90A@mail.gmail.com>
In-Reply-To: <CAHk-=wh9f0EmsNFgoxUa8BzVej06+7MbLr-MLBjDjtj_=Pf90A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 Jul 2022 13:21:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg9LaHeg0UmZ90gLOaBpO-5fhoaH22iNNm=1eror95pFg@mail.gmail.com>
Message-ID: <CAHk-=wg9LaHeg0UmZ90gLOaBpO-5fhoaH22iNNm=1eror95pFg@mail.gmail.com>
Subject: Re: "git symbolic-ref" doesn't do a very good job
To:     Junio Hamano C <gitster@pobox.com>
Cc:     Git List Mailing <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000048165005e50b854b"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--00000000000048165005e50b854b
Content-Type: text/plain; charset="UTF-8"

On Sat, Jul 30, 2022 at 12:53 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And "git symbolic-ref" is perfectly happy to take complete garbage
> input. There seems to be no advantage over using that silly "echo"
> model.

Side note: it looks like that patch may break a test.

And that test most definitely *should* be broken.

t3200-branch.sh does

      git symbolic-ref refs/heads/dangling-symref nowhere

which really depends on that whole "git symbolic-ref does no sanity
checking at all".

In fact, it seems to depend particularly on the fact that for non-HEAD
refs, it does even *less* sanity checking, and doesn't even check that
the ref starts with a "refs/"

There is also t4202-log, which wants to test that "git log" reacts
well to a bad ref. But now that "git symbolic-ref" refuses to create
such a bad ref, that test fails.

Anyway, here's a slightly updated patch that just fixes that test that
depended on not just a dangling symref, but an *invalid* dangling
symref. And it changes t4202-log to use "echo" to create the bad ref
instead. Which is what the previous test did too, to create the bogus
hash.

Again - this is such a low-level plumbing thing that maybe nobody
cares, but it just struck me as a bad idea to have these kinds of
maintenance commands that can be used to just mess up your repository.
And if you have a bare repo, this really does look like the command
that *should* be used to change HEAD, since it's not about "git
checkout"

                  Linus

--00000000000048165005e50b854b
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l68cacj40>
X-Attachment-Id: f_l68cacj40

IGJ1aWx0aW4vc3ltYm9saWMtcmVmLmMgfCAyICsrCiB0L3QzMjAwLWJyYW5jaC5zaCAgICAgIHwg
NCArKy0tCiB0L3Q0MjAyLWxvZy5zaCAgICAgICAgIHwgMiArLQogMyBmaWxlcyBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYnVpbHRpbi9zeW1i
b2xpYy1yZWYuYyBiL2J1aWx0aW4vc3ltYm9saWMtcmVmLmMKaW5kZXggZTU0N2EwOGQ2Yy4uNTM1
NGNmYjRmMSAxMDA2NDQKLS0tIGEvYnVpbHRpbi9zeW1ib2xpYy1yZWYuYworKysgYi9idWlsdGlu
L3N5bWJvbGljLXJlZi5jCkBAIC03MSw2ICs3MSw4IEBAIGludCBjbWRfc3ltYm9saWNfcmVmKGlu
dCBhcmdjLCBjb25zdCBjaGFyICoqYXJndiwgY29uc3QgY2hhciAqcHJlZml4KQogCQlpZiAoIXN0
cmNtcChhcmd2WzBdLCAiSEVBRCIpICYmCiAJCSAgICAhc3RhcnRzX3dpdGgoYXJndlsxXSwgInJl
ZnMvIikpCiAJCQlkaWUoIlJlZnVzaW5nIHRvIHBvaW50IEhFQUQgb3V0c2lkZSBvZiByZWZzLyIp
OworCQlpZiAoY2hlY2tfcmVmbmFtZV9mb3JtYXQoYXJndlsxXSwgMCkgPCAwKQorCQkJZGllKCJS
ZWZ1c2luZyB0byBzZXQgJyVzJyB0byBpbnZhbGlkIHJlZiAnJXMnIiwgYXJndlswXSwgYXJndlsx
XSk7CiAJCXJldCA9ICEhY3JlYXRlX3N5bXJlZihhcmd2WzBdLCBhcmd2WzFdLCBtc2cpOwogCQli
cmVhazsKIAlkZWZhdWx0OgpkaWZmIC0tZ2l0IGEvdC90MzIwMC1icmFuY2guc2ggYi90L3QzMjAw
LWJyYW5jaC5zaAppbmRleCA5NzIzYzI4MjdjLi5iMTk0YzFiMDliIDEwMDc1NQotLS0gYS90L3Qz
MjAwLWJyYW5jaC5zaAorKysgYi90L3QzMjAwLWJyYW5jaC5zaApAQCAtNzIzLDkgKzcyMyw5IEBA
IHRlc3RfZXhwZWN0X3N1Y2Nlc3MgJ2RlbGV0aW5nIGEgc3ltcmVmJyAnCiAnCiAKIHRlc3RfZXhw
ZWN0X3N1Y2Nlc3MgJ2RlbGV0aW5nIGEgZGFuZ2xpbmcgc3ltcmVmJyAnCi0JZ2l0IHN5bWJvbGlj
LXJlZiByZWZzL2hlYWRzL2RhbmdsaW5nLXN5bXJlZiBub3doZXJlICYmCisJZ2l0IHN5bWJvbGlj
LXJlZiByZWZzL2hlYWRzL2RhbmdsaW5nLXN5bXJlZiByZWZzL2hlYWRzL25vd2hlcmUgJiYKIAl0
ZXN0X3BhdGhfaXNfZmlsZSAuZ2l0L3JlZnMvaGVhZHMvZGFuZ2xpbmctc3ltcmVmICYmCi0JZWNo
byAiRGVsZXRlZCBicmFuY2ggZGFuZ2xpbmctc3ltcmVmICh3YXMgbm93aGVyZSkuIiA+ZXhwZWN0
ICYmCisJZWNobyAiRGVsZXRlZCBicmFuY2ggZGFuZ2xpbmctc3ltcmVmICh3YXMgcmVmcy9oZWFk
cy9ub3doZXJlKS4iID5leHBlY3QgJiYKIAlnaXQgYnJhbmNoIC1kIGRhbmdsaW5nLXN5bXJlZiA+
YWN0dWFsICYmCiAJdGVzdF9wYXRoX2lzX21pc3NpbmcgLmdpdC9yZWZzL2hlYWRzL2RhbmdsaW5n
LXN5bXJlZiAmJgogCXRlc3RfY21wIGV4cGVjdCBhY3R1YWwKZGlmZiAtLWdpdCBhL3QvdDQyMDIt
bG9nLnNoIGIvdC90NDIwMi1sb2cuc2gKaW5kZXggNmU2NjM1MjU1OC4uNDI3YjA2NDQyZCAxMDA3
NTUKLS0tIGEvdC90NDIwMi1sb2cuc2gKKysrIGIvdC90NDIwMi1sb2cuc2gKQEAgLTIxMTQsNyAr
MjExNCw3IEBAIHRlc3RfZXhwZWN0X3N1Y2Nlc3MgUkVGRklMRVMgJ2xvZyBkaWFnbm9zZXMgYm9n
dXMgSEVBRCBoYXNoJyAnCiAKIHRlc3RfZXhwZWN0X3N1Y2Nlc3MgJ2xvZyBkaWFnbm9zZXMgYm9n
dXMgSEVBRCBzeW1yZWYnICcKIAlnaXQgaW5pdCBlbXB0eSAmJgotCWdpdCAtLWdpdC1kaXIgZW1w
dHkvLmdpdCBzeW1ib2xpYy1yZWYgSEVBRCByZWZzL2hlYWRzL2ludmFsaWQubG9jayAmJgorCWVj
aG8gInJlZjogcmVmcy9oZWFkcy9pbnZhbGlkLmxvY2siID4gZW1wdHkvLmdpdC9IRUFEICYmCiAJ
dGVzdF9tdXN0X2ZhaWwgZ2l0IC1DIGVtcHR5IGxvZyAyPnN0ZGVyciAmJgogCXRlc3RfaTE4bmdy
ZXAgYnJva2VuIHN0ZGVyciAmJgogCXRlc3RfbXVzdF9mYWlsIGdpdCAtQyBlbXB0eSBsb2cgLS1k
ZWZhdWx0IHRvdGFsbHktYm9ndXMgMj5zdGRlcnIgJiYK
--00000000000048165005e50b854b--
