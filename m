Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFB5C77B61
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 14:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjDGOlX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 10:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjDGOlW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 10:41:22 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE481739
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 07:41:20 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-942e6555947so178118766b.2
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 07:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680878479; x=1683470479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddZVnB8dMRGtqtr8qMd6Ee4EzPDfP0G9teoe0xI4JIo=;
        b=FXcgZNcwV/RlSbQW4y9Q7myvbeVby5s18QGaVm5qHN4gKuSvw8Q5IA5ke7zT0/+ywT
         TSDbYgqaZBIopFdAEFmH5mBm0YwtA2QwZW5FD7uf5pE44/95hkCpmUQMW+GeQBdAiG6n
         kZfXiNPTANlHghqHV6pdtYIrJ4Yb59PTXc7UFBJbJkevB7yZr2GSVnB2twr7t/l3QII6
         diPAyEN3aUrIt1e5JjI/P1xsQ0RKPC3Mg7ucgfcuSFKSwIWcbzu1Ow+iv3lQHHXCj+xm
         zKils2g2njDhiw93fDwr5hdnWU6W5UBA3NiTZfqJsswjhGZzkFZ/NfCNUItfFa7ynv7+
         VfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680878479; x=1683470479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddZVnB8dMRGtqtr8qMd6Ee4EzPDfP0G9teoe0xI4JIo=;
        b=Ne+waVydhpPrPhRHb5MfESe+W8cpT70+7OAgQhb6ofOOFTHAOqapdTC3PmseqRKUCq
         4FebWJFKDxZu2uChJUZS0wav41i3mjhDUIvHKYr9+2HgMvtftSy9uCeNQ+OXebkMnB/E
         thl86XzMD0mepHUwUzSvWkyyIoSy5qUE7w9vnNMiDS7Gcem4/l5s3a/zduI/330c4NWh
         cjFwpu5sS/197bQHCzYvVVKvVg0QkE9Kw0r9OEtHsL0EcppnqFUYefZKX9ANx30uZCHv
         qi3Bp1ZfI52VNjNY5CPQDI1Ut88Ojt1wyw7kYl4QW2Xzog3xEXytqYoTXAaJTQbjGXd0
         x6zQ==
X-Gm-Message-State: AAQBX9cdPTkGABixjG0eTwEy7GvXBeDZF4A5sjBiyTKVscLTOAUv6Y23
        mqI74kVj/WiqsN/vwpi0QNW6rUI37YWBTWWdxEA=
X-Google-Smtp-Source: AKy350app7i6sYhHrDAFrG/QH5ZTlkBDrOTp3KkswIhLz8bWwF+YR+Q5zJ8llhrJFTuJUYN7gX8N2/h54Umn2FOKU5E=
X-Received: by 2002:a50:a457:0:b0:4fb:2593:844 with SMTP id
 v23-20020a50a457000000b004fb25930844mr1502406edb.2.1680878479027; Fri, 07 Apr
 2023 07:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAPig+cSNmws2b7f7aRA2C56kvQYG3w_g+KhYdqhtmf+XhtAMhQ@mail.gmail.com>
 <b45bf46f-580a-870c-5293-10ecdf2e56d3@aueb.gr> <b8b3777b-ee6e-d90e-3365-5cb9c9d129fe@web.de>
 <c4728fac-bea9-3794-077e-c978d99f46bf@web.de> <xmqq5yad7wv3.fsf@gitster.g>
 <bc6e89c9-d886-c519-85b3-fbc3f4eb5528@web.de> <7327ac06-d5da-ec53-543e-78e7729e78bb@web.de>
In-Reply-To: <7327ac06-d5da-ec53-543e-78e7729e78bb@web.de>
From:   "D. Ben Knoble" <ben.knoble@gmail.com>
Date:   Fri, 7 Apr 2023 10:41:07 -0400
Message-ID: <CALnO6CDgs+of5KCRRwpmzEoHcqZ4udbHVhNrd63q4fFh_5TwHg@mail.gmail.com>
Subject: Re: [PATCH] userdiff: support regexec(3) with multi-byte support
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Diomidis Spinellis <dds@aueb.gr>,
        Eric Sunshine <sunshine@sunshineco.com>,
        demerphq <demerphq@gmail.com>,
        Mario Grgic <mario_grgic@hotmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 6, 2023 at 4:19=E2=80=AFPM Ren=C3=A9 Scharfe <l.s.r@web.de> wro=
te:
>
> Since 1819ad327b (grep: fix multibyte regex handling under macOS,
> 2022-08-26) we use the system library for all regular expression
> matching on macOS, not just for git grep.  It supports multi-byte
> strings and rejects invalid multi-byte characters.
>
> This broke all built-in userdiff word regexes in UTF-8 locales because
> they all include such invalid bytes in expressions that are intended to
> match multi-byte characters without explicit support for that from the
> regex engine.
>
> "|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+" is added to all built-in word
> regexes to match a single non-space or multi-byte character.  The \xNN
> characters are invalid if interpreted as UTF-8 because they have their
> high bit set, which indicates they are part of a multi-byte character,
> but they are surrounded by single-byte characters.
>
> Replace that expression with "|[^[:space:]]" if the regex engine
> supports multi-byte matching, as there is no need to have an explicit
> range for multi-byte characters then.  Check for that capability at
> runtime, because it depends on the locale and thus on environment
> variables.  Construct the full replacement expression at build time
> and just switch it in if necessary to avoid string manipulation and
> allocations at runtime.
>
> Additionally the word regex for tex contains the expression
> "[a-zA-Z0-9\x80-\xff]+" with a similarly invalid range.  The best
> replacement with only valid characters that I can come up with is
> "([a-zA-Z0-9]|[^\x01-\x7f])+".  Unlike the original it matches NUL
> characters, though.  Assuming that tex files usually don't contain NUL
> this should be acceptable.
>
> Reported-by: D. Ben Knoble <ben.knoble@gmail.com>
> Reported-by: Eric Sunshine <sunshine@sunshineco.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>

I tested the patch locally on top of ae73b2c8f1 and it solved my
problem. Seems like there's still some further discussion, though.
