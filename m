Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E993FC433FE
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 22:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239441AbiCJWOc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 17:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiCJWOb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 17:14:31 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B61A2F2D
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 14:13:29 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 3so11907637lfr.7
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 14:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i59GOH+kiiOEiEfFuBN5S8gstI6mt+buhjVnJe9bwg8=;
        b=ElXCfor0XY9qYZ+k1cHXTtlfCHaWomfxEuU/wPzE0/KekukbKZIl9k8IX8zkKchw8t
         Q4FH7PSfe9yzl+S5yKvGnJ7lrWmsvNHXSg3L0rlm2/I49PE8gHpJpnlLK8oLYX09be/+
         Ut0ubPQ4OBEzz0bzq1QJqGLrhYwHXbj5RyQyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i59GOH+kiiOEiEfFuBN5S8gstI6mt+buhjVnJe9bwg8=;
        b=B1bDv4zUiTmO0SQk3bUjx9FkdlLyCxkNQ+/AIOhxQDzUgQMXVaUiHKNY4KiIg9GTN7
         jJZnY4NPDaT3sY5F47TbBOfXmrEGJNumW0wmR6+z76VoX0pRtJ8t8wiqQur7tncUQxuN
         yCN83UDltUstl3qjFEeR5yza0BQszj3vcXTMvTj0s19DfLk7eYrPdlM4kKnQh0dp0Ji7
         9FOylLZltZERbvGrp0rpJEC5j18eCB5q6PliUMMBSmbmLcontYxd8uXf60KpyuwJaiwa
         GP7n0pL82qPjKGIuAFUE18oBUYbJdZ8GX7NoVMfo7RQvVzKDmlkKZXIGkj3ivrBbWRBc
         SbzA==
X-Gm-Message-State: AOAM5310Qeo8Y7qzvBX1psq+CbTs8X0HAAYt46j2OdzowHiRxSAbsluL
        1d8/PC70KqXg0NtRPlD5+PYd70khzZNI+/P3
X-Google-Smtp-Source: ABdhPJw2SB+6Ohets2ZtsptIT2XP/Etzuk7eQPkqfwMK8iHAS6Y60xizhWjSP80AlWeoOyhawaHTLg==
X-Received: by 2002:a05:6512:114c:b0:443:4d18:86c0 with SMTP id m12-20020a056512114c00b004434d1886c0mr4326549lfg.226.1646950407328;
        Thu, 10 Mar 2022 14:13:27 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id bq42-20020a056512152a00b00447431cc768sm1200029lfb.170.2022.03.10.14.13.26
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 14:13:26 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id 3so11907542lfr.7
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 14:13:26 -0800 (PST)
X-Received: by 2002:a05:6512:e8a:b0:443:7b8c:579a with SMTP id
 bi10-20020a0565120e8a00b004437b8c579amr4192320lfb.687.1646950406494; Thu, 10
 Mar 2022 14:13:26 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgh8emJn-+FtxN=m_SCPiP6cGKHU-5ozzV9tWBMxn+xcA@mail.gmail.com>
 <xmqqo82dd0qv.fsf@gitster.g> <CAHk-=wg+n_-btzoyMqnDYsJxFYAyUh0Kb=TkpS8RiD_h3G=_cA@mail.gmail.com>
 <xmqqfsnpcxdm.fsf@gitster.g>
In-Reply-To: <xmqqfsnpcxdm.fsf@gitster.g>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Mar 2022 14:13:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=whRbuJJ1LzYN9F48JaS7EjuP3FkppHJXi1wAO_qLJQ2xw@mail.gmail.com>
Message-ID: <CAHk-=whRbuJJ1LzYN9F48JaS7EjuP3FkppHJXi1wAO_qLJQ2xw@mail.gmail.com>
Subject: Re: RFC: Using '--no-output-indicator-old' to only show new state
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List Mailing <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000f1611105d9e48582"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000f1611105d9e48582
Content-Type: text/plain; charset="UTF-8"

On Thu, Mar 10, 2022 at 1:26 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> I often use -W and the above would give us a natural extension, but
> I agree that is a bit too dense and totally unintuitive.  As we use
> parse-options for patch output formatting options, my pick would be
> "--new-only" vs "--old-only" (

I was "ok, that's really easy" and did

+               OPT_ALIAS(0, "new-only", "no-output-indicator-old"),
+               OPT_ALIAS(0, "old-only", "no-output-indicator-new"),

but sadly the parse-options alias code isn't quite smart enough.

Doing it with an explicit callback obviously works, but the "unique
abbreviations" part doesn't actually work for me. I think it's due to
PARSE_OPT_KEEP_UNKNOWN making the abbreviated options not work, but I
don't know tha option parsing code well enough.

Here's the stupid patch that "works" but doesn't allow the shortened
version. Maybe somebody can point out what silly thing I did wrong.

               Linus

--000000000000f1611105d9e48582
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l0ljq36i0>
X-Attachment-Id: f_l0ljq36i0

IGRpZmYuYyB8IDE5ICsrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZGlmZi5jIGIvZGlmZi5jCmluZGV4IDg5NTk1MWI4NDku
LmNmMTY4ZTcyN2QgMTAwNjQ0Ci0tLSBhL2RpZmYuYworKysgYi9kaWZmLmMKQEAgLTUwMDAsNiAr
NTAwMCwxNyBAQCBzdGF0aWMgaW50IGRpZmZfb3B0X2NoYXIoY29uc3Qgc3RydWN0IG9wdGlvbiAq
b3B0LAogCXJldHVybiAwOwogfQogCitzdGF0aWMgaW50IGRpZmZfb3B0X25vX2NoYXIoY29uc3Qg
c3RydWN0IG9wdGlvbiAqb3B0LAorCQkJIGNvbnN0IGNoYXIgKmFyZywgaW50IHVuc2V0KQorewor
CWNoYXIgKnZhbHVlID0gb3B0LT52YWx1ZTsKKworCUJVR19PTl9PUFRfTkVHKHVuc2V0KTsKKwlC
VUdfT05fT1BUX0FSRyhhcmcpOworCSp2YWx1ZSA9IDA7CisJcmV0dXJuIDA7Cit9CisKIHN0YXRp
YyBpbnQgZGlmZl9vcHRfY29sb3JfbW92ZWQoY29uc3Qgc3RydWN0IG9wdGlvbiAqb3B0LAogCQkJ
CWNvbnN0IGNoYXIgKmFyZywgaW50IHVuc2V0KQogewpAQCAtNTQ5Myw2ICs1NTA0LDE0IEBAIHN0
YXRpYyB2b2lkIHByZXBfcGFyc2Vfb3B0aW9ucyhzdHJ1Y3QgZGlmZl9vcHRpb25zICpvcHRpb25z
KQogCQkJICAgICAgIE5fKCI8Y2hhcj4iKSwKIAkJCSAgICAgICBOXygic3BlY2lmeSB0aGUgY2hh
cmFjdGVyIHRvIGluZGljYXRlIGEgY29udGV4dCBpbnN0ZWFkIG9mICcgJyIpLAogCQkJICAgICAg
IFBBUlNFX09QVF9OT05FRywgZGlmZl9vcHRfY2hhciksCisJCU9QVF9DQUxMQkFDS19GKDAsICJu
ZXctb25seSIsCisJCQkgICAgICAgJm9wdGlvbnMtPm91dHB1dF9pbmRpY2F0b3JzW09VVFBVVF9J
TkRJQ0FUT1JfT0xEXSwgTlVMTCwKKwkJCSAgICAgICBOXygic2hvdyBvbmx5IG5ldyBsaW5lcyBp
biBkaWZmIiksCisJCQkgICAgICAgUEFSU0VfT1BUX05PTkVHIHwgUEFSU0VfT1BUX05PQVJHLCBk
aWZmX29wdF9ub19jaGFyKSwKKwkJT1BUX0NBTExCQUNLX0YoMCwgIm9sZC1vbmx5IiwKKwkJCSAg
ICAgICAmb3B0aW9ucy0+b3V0cHV0X2luZGljYXRvcnNbT1VUUFVUX0lORElDQVRPUl9ORVddLCBO
VUxMLAorCQkJICAgICAgIE5fKCJzaG93IG9ubHkgb2xkIGxpbmVzIGluIGRpZmYiKSwKKwkJCSAg
ICAgICBQQVJTRV9PUFRfTk9ORUcgfCBQQVJTRV9PUFRfTk9BUkcsIGRpZmZfb3B0X25vX2NoYXIp
LAogCiAJCU9QVF9HUk9VUChOXygiRGlmZiByZW5hbWUgb3B0aW9ucyIpKSwKIAkJT1BUX0NBTExC
QUNLX0YoJ0InLCAiYnJlYWstcmV3cml0ZXMiLCAmb3B0aW9ucy0+YnJlYWtfb3B0LCBOXygiPG4+
Wy88bT5dIiksCg==
--000000000000f1611105d9e48582--
